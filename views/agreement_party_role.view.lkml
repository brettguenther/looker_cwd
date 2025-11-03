view: agreement_party_role {
  sql_table_name: `cwd_benchmark.Agreement_Party_Role` ;;

  dimension: agreement_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Agreement_Identifier ;;
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
  dimension: party_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Party_Identifier ;;
  }
  dimension: party_role_code {
    type: string
    sql: ${TABLE}.Party_Role_Code ;;
  }
  measure: count {
    type: count
  }
}
