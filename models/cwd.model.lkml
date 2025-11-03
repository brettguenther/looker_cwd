connection: "default_bigquery_connection"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: cwd_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: cwd_default_datagroup

explore: claim {
  label: "Claims Analysis"

  # --- Join to the policy that this claim is against ---
  # This is a multi-step join: Claim -> Claim_Coverage -> Policy_Coverage_Detail -> Policy
  join: claim_coverage {
    type: inner
    relationship: one_to_one
    sql_on: ${claim.claim_identifier} = ${claim_coverage.claim_identifier} ;;
  }

  join: policy_coverage_detail {
    type: inner
    relationship: many_to_one
    sql_on: ${claim_coverage.policy_coverage_detail_identifier} = ${policy_coverage_detail.policy_coverage_detail_identifier} ;;
  }

  join: policy {
    type: inner
    relationship: many_to_one
    sql_on: ${policy_coverage_detail.policy_identifier} = ${policy.policy_identifier} ;;
  }

  # --- From the policy, get the Agent and Policy Holder ---
  # We use 'from:' to alias the 'agreement_party_role' view
  join: policy_holder_role {
    from: agreement_party_role
    type: left_outer
    relationship: many_to_one
    sql_on: ${policy.policy_identifier} = ${policy_holder_role.agreement_identifier}
      AND ${policy_holder_role.party_role_code} = 'PH' ;;
  }

  join: agent_role {
    from: agreement_party_role
    type: left_outer
    relationship: many_to_one
    sql_on: ${policy.policy_identifier} = ${agent_role.agreement_identifier}
      AND ${agent_role.party_role_code} = 'AG' ;;
  }

  # --- From the policy, get the Premium ---
  # Policy -> Policy_Coverage_Detail (already joined) -> Policy_Amount -> Premium
  join: policy_amount {
    type: left_outer
    relationship: one_to_many
    sql_on: ${policy_coverage_detail.policy_coverage_detail_identifier} = ${policy_amount.policy_coverage_detail_identifier} ;;
  }

  join: premium {
    type: left_outer
    relationship: one_to_one
    # This join filters the policy_amount table to only premium amounts
    sql_on: ${policy_amount.policy_amount_identifier} = ${premium.policy_amount_identifier} ;;
  }

  # --- Join to the claim's catastrophe ---
  join: catastrophe {
    type: left_outer
    relationship: many_to_one
    sql_on: ${claim.catastrophe_identifier} = ${catastrophe.catastrophe_identifier} ;;
  }

  # --- Join to the four financial 'loss' tables ---
  # This pattern replicates the SQL queries which join 'claim_amount' four times.
  # We use 'from:' to alias 'claim_amount' for each loss type.

  # 1. Loss Payment
  join: claim_amount_lp {
    from: claim_amount
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim.claim_identifier} = ${claim_amount_lp.claim_identifier} ;;
  }
  join: loss_payment {
    type: left_outer
    relationship: one_to_one
    sql_on: ${claim_amount_lp.claim_amount_identifier} = ${loss_payment.claim_amount_identifier} ;;
  }

  # 2. Loss Reserve
  join: claim_amount_lr {
    from: claim_amount
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim.claim_identifier} = ${claim_amount_lr.claim_identifier} ;;
  }
  join: loss_reserve {
    type: left_outer
    relationship: one_to_one
    sql_on: ${claim_amount_lr.claim_amount_identifier} = ${loss_reserve.claim_amount_identifier} ;;
  }

  # 3. Expense Payment
  join: claim_amount_ep {
    from: claim_amount
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim.claim_identifier} = ${claim_amount_ep.claim_identifier} ;;
  }
  join: expense_payment {
    type: left_outer
    relationship: one_to_one
    sql_on: ${claim_amount_ep.claim_amount_identifier} = ${expense_payment.claim_amount_identifier} ;;
  }

  # 4. Expense Reserve
  join: claim_amount_er {
    from: claim_amount
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim.claim_identifier} = ${claim_amount_er.claim_identifier} ;;
  }
  join: expense_reserve {
    type: left_outer
    relationship: one_to_one
    sql_on: ${claim_amount_er.claim_amount_identifier} = ${expense_reserve.claim_amount_identifier} ;;
  }
}

explore: policy {
  label: "Policy Analysis"

  # --- Join to the Agent and Policy Holder ---
  # We use 'from:' to alias the 'agreement_party_role' view
  join: policy_holder_role {
    from: agreement_party_role
    type: inner  # A policy must have a policy holder
    relationship: many_to_one
    sql_on: ${policy.policy_identifier} = ${policy_holder_role.agreement_identifier}
      AND ${policy_holder_role.party_role_code} = 'PH' ;;
  }

  join: agent_role {
    from: agreement_party_role
    type: inner  # A policy must have an agent
    relationship: many_to_one
    sql_on: ${policy.policy_identifier} = ${agent_role.agreement_identifier}
      AND ${agent_role.party_role_code} = 'AG' ;;
  }

  # --- Join to the Premium for this policy ---
  # Policy -> Policy_Coverage_Detail -> Policy_Amount -> Premium
  join: policy_coverage_detail {
    type: inner
    relationship: one_to_many
    sql_on: ${policy.policy_identifier} = ${policy_coverage_detail.policy_identifier} ;;
  }

  join: policy_amount {
    type: inner
    relationship: one_to_many
    sql_on: ${policy_coverage_detail.policy_coverage_detail_identifier} = ${policy_amount.policy_coverage_detail_identifier} ;;
  }

  join: premium {
    type: inner
    relationship: one_to_one
    # This join filters the policy_amount table to only premium amounts
    sql_on: ${policy_amount.policy_amount_identifier} = ${premium.policy_amount_identifier} ;;
  }

  # --- Join to claims (if any) ---
  # Use LEFT OUTER so we can see policies with no claims
  join: claim_coverage {
    type: left_outer
    relationship: one_to_many
    sql_on: ${policy_coverage_detail.policy_coverage_detail_identifier} = ${claim_coverage.policy_coverage_detail_identifier} ;;
  }

  join: claim {
    type: left_outer
    relationship: many_to_one
    sql_on: ${claim_coverage.claim_identifier} = ${claim.claim_identifier} ;;
  }

  # --- From the claim, join to catastrophe (if any) ---
  join: catastrophe {
    type: left_outer
    relationship: many_to_one
    sql_on: ${claim.catastrophe_identifier} = ${catastrophe.catastrophe_identifier} ;;
  }

  # --- From the claim, join to all financial 'loss' tables (if any) ---
  # This fans out from the claim join

  # 1. Loss Payment
  join: claim_amount_lp {
    from: claim_amount
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim.claim_identifier} = ${claim_amount_lp.claim_identifier} ;;
  }
  join: loss_payment {
    type: left_outer
    relationship: one_to_one
    sql_on: ${claim_amount_lp.claim_amount_identifier} = ${loss_payment.claim_amount_identifier} ;;
  }

  # 2. Loss Reserve
  join: claim_amount_lr {
    from: claim_amount
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim.claim_identifier} = ${claim_amount_lr.claim_identifier} ;;
  }
  join: loss_reserve {
    type: left_outer
    relationship: one_to_one
    sql_on: ${claim_amount_lr.claim_amount_identifier} = ${loss_reserve.claim_amount_identifier} ;;
  }

  # 3. Expense Payment
  join: claim_amount_ep {
    from: claim_amount
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim.claim_identifier} = ${claim_amount_ep.claim_identifier} ;;
  }
  join: expense_payment {
    type: left_outer
    relationship: one_to_one
    sql_on: ${claim_amount_ep.claim_amount_identifier} = ${expense_payment.claim_amount_identifier} ;;
  }

  # 4. Expense Reserve
  join: claim_amount_er {
    from: claim_amount
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim.claim_identifier} = ${claim_amount_er.claim_identifier} ;;
  }
  join: expense_reserve {
    type: left_outer
    relationship: one_to_one
    sql_on: ${claim_amount_er.claim_amount_identifier} = ${expense_reserve.claim_amount_identifier} ;;
  }
}


explore: claim_coverage {hidden:yes}

explore: catastrophe {hidden:yes}

explore: claim_amount {hidden:yes}

explore: loss_payment {hidden:yes}

explore: agreement_party_role {hidden:yes}

explore: expense_payment {hidden:yes}

explore: expense_reserve {hidden:yes}

explore: loss_reserve {hidden:yes}

explore: policy_coverage_detail {hidden:yes}

explore: premium {hidden:yes}

explore: policy_amount {hidden:yes}
