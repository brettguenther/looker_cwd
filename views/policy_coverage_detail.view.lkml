view: policy_coverage_detail {
  sql_table_name: `cwd_benchmark.Policy_Coverage_Detail` ;;
  drill_fields: [policy_coverage_detail_identifier]

  dimension: policy_coverage_detail_identifier {
    primary_key: yes
    type: number
    sql: ${TABLE}.Policy_Coverage_Detail_Identifier ;;
  }
  dimension: coverage_description {
    type: string
    sql: ${TABLE}.Coverage_Description ;;
  }
  dimension: coverage_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Coverage_Identifier ;;
  }
  dimension: coverage_inclusion_exclusion_code {
    type: string
    sql: ${TABLE}.Coverage_Inclusion_Exclusion_Code ;;
  }
  dimension: coverage_part_code {
    type: string
    sql: ${TABLE}.Coverage_Part_Code ;;
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
  dimension: insurable_object_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Insurable_Object_Identifier ;;
  }
  dimension: policy_identifier {
    type: number
    value_format_name: id
    sql: ${TABLE}.Policy_Identifier ;;
  }
  measure: count {
    type: count
    drill_fields: [policy_coverage_detail_identifier]
  }
}
