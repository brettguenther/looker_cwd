view: loss_reserve {
  sql_table_name: `cwd_benchmark.Loss_Reserve` ;;

  dimension: claim_amount_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Claim_Amount_Identifier ;;
  }
  measure: count {
    type: count
  }
}
