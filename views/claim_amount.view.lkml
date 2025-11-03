view: claim_amount {
  sql_table_name: `cwd_benchmark.Claim_Amount` ;;
  drill_fields: [claim_amount_identifier]

  dimension: claim_amount_identifier {
    primary_key: yes
    type: number
    sql: ${TABLE}.Claim_Amount_Identifier ;;
  }
  dimension: amount_type_code {
    type: string
    sql: ${TABLE}.Amount_Type_Code ;;
  }
  dimension: claim_amount {
    type: number
    sql: ${TABLE}.Claim_Amount ;;
  }
  dimension: claim_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Claim_Identifier ;;
  }
  dimension: claim_offer_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Claim_Offer_Identifier ;;
  }
  dimension_group: event {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.Event_Date ;;
  }
  dimension: insurance_type_code {
    type: string
    sql: ${TABLE}.Insurance_Type_Code ;;
  }
  measure: count {
    type: count
    drill_fields: [claim_amount_identifier]
  }
}
