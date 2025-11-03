view: catastrophe {
  sql_table_name: `cwd_benchmark.Catastrophe` ;;
  drill_fields: [catastrophe_identifier]

  dimension: catastrophe_identifier {
    primary_key: yes
    type: number
    sql: ${TABLE}.Catastrophe_Identifier ;;
  }
  dimension: catastrophe_name {
    type: string
    sql: ${TABLE}.Catastrophe_Name ;;
  }
  dimension: catastrophe_type_code {
    type: string
    sql: ${TABLE}.Catastrophe_Type_Code ;;
  }
  dimension: company_catastrophe_code {
    type: string
    sql: ${TABLE}.Company_Catastrophe_Code ;;
  }
  dimension: industry_catastrophe_code {
    type: string
    sql: ${TABLE}.Industry_Catastrophe_Code ;;
  }
  measure: count {
    type: count
    drill_fields: [catastrophe_identifier, catastrophe_name]
  }
}
