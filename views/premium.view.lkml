view: premium {
  sql_table_name: `cwd_benchmark.Premium` ;;

  dimension: policy_amount_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Policy_Amount_Identifier ;;
  }
  measure: count {
    type: count
  }
}
