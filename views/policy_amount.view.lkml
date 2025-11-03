view: policy_amount {
  sql_table_name: `cwd_benchmark.Policy_Amount` ;;
  drill_fields: [policy_amount_identifier]

  dimension: policy_amount_identifier {
    primary_key: yes
    type: number
    sql: ${TABLE}.Policy_Amount_Identifier ;;
  }
  dimension: amount_type_code {
    type: string
    sql: ${TABLE}.Amount_Type_Code ;;
  }
  dimension_group: earning_begin {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.Earning_Begin_Date ;;
  }
  dimension_group: earning_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.Earning_End_Date ;;
  }
  dimension_group: effective {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.Effective_Date ;;
  }
  dimension: geographic_location_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Geographic_Location_Identifier ;;
  }
  dimension: insurable_object_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Insurable_Object_Identifier ;;
  }
  dimension: insurance_type_code {
    type: string
    sql: ${TABLE}.Insurance_Type_Code ;;
  }
  dimension: policy_amount {
    type: number
    sql: ${TABLE}.Policy_Amount ;;
  }
  dimension: policy_coverage_detail_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Policy_Coverage_Detail_Identifier ;;
  }
  dimension: policy_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Policy_Identifier ;;
  }
  measure: count {
    type: count
    drill_fields: [policy_amount_identifier]
  }
}
