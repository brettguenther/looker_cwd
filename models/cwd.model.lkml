connection: "default_bigquery_connection"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: cwd_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: cwd_default_datagroup

explore: claim_coverage {}

explore: catastrophe {}

explore: claim_amount {}

explore: loss_payment {}

explore: agreement_party_role {}

explore: expense_payment {}

explore: claim {}

explore: expense_reserve {}

explore: loss_reserve {}

explore: policy_coverage_detail {}

explore: premium {}

explore: policy {}

explore: policy_amount {}

