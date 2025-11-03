view: claim {
  sql_table_name: `cwd_benchmark.Claim` ;;
  drill_fields: [claim_identifier]

  dimension: claim_identifier {
    primary_key: yes
    type: number
    sql: ${TABLE}.Claim_Identifier ;;
  }
  dimension: catastrophe_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Catastrophe_Identifier ;;
  }
  dimension_group: claim_close {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.Claim_Close_Date ;;
  }
  dimension: claim_description {
    type: string
    sql: ${TABLE}.Claim_Description ;;
  }
  dimension_group: claim_open {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.Claim_Open_Date ;;
  }
  dimension_group: claim_reopen {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.Claim_Reopen_Date ;;
  }
  dimension_group: claim_reported {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.Claim_Reported_Date ;;
  }
  dimension: claim_status_code {
    type: string
    sql: ${TABLE}.Claim_Status_Code ;;
  }
  dimension_group: claims_made {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.Claims_Made_Date ;;
  }
  dimension: company_claim_number {
    type: string
    sql: ${TABLE}.Company_Claim_Number ;;
  }
  dimension: company_subclaim_number {
    type: string
    sql: ${TABLE}.Company_Subclaim_Number ;;
  }
  dimension_group: entry_into_claims_made_program {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.Entry_Into_Claims_Made_Program_Date ;;
  }
  dimension: insurable_object_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Insurable_Object_Identifier ;;
  }
  dimension: occurrence_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Occurrence_Identifier ;;
  }
  measure: count {
    type: count
    drill_fields: [claim_identifier]
  }
}
