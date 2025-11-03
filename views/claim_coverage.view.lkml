view: claim_coverage {
  sql_table_name: `cwd_benchmark.Claim_Coverage` ;;

  dimension: claim_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Claim_Identifier ;;
  }
  dimension_group: effective {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.Effective_Date ;;
  }
  dimension: policy_coverage_detail_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Policy_Coverage_Detail_Identifier ;;
  }
  measure: count {
    type: count
  }
}
