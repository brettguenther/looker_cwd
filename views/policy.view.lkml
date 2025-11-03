view: policy {
  sql_table_name: `cwd_benchmark.Policy` ;;
  drill_fields: [policy_identifier]

  dimension: policy_identifier {
    primary_key: yes
    type: number
    sql: ${TABLE}.Policy_Identifier ;;
  }
  dimension_group: effective {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.Effective_Date ;;
  }
  dimension_group: expiration {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.Expiration_Date ;;
  }
  dimension: geographic_location_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Geographic_Location_Identifier ;;
  }
  dimension: policy_number {
    type: string
    sql: ${TABLE}.Policy_Number ;;
  }
  dimension: status_code {
    type: string
    sql: ${TABLE}.Status_Code ;;
  }
  measure: count {
    type: count
    drill_fields: [policy_identifier]
  }
}
