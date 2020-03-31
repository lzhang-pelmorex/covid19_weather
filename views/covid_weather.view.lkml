view: covid_weather {
  sql_table_name: `snowflake.covid_weather`;;

  dimension_group: day {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DAY ;;
  }

  measure: death {
    type: number
    sql: avg(${TABLE}.DEATH) ;;
  }

  measure: feelslike {
    type: number
    sql: avg(${TABLE}.FEELSLIKE) ;;
  }

  measure: humidity {
    type: number
    sql: avg(${TABLE}.HUMIDITY) ;;
  }

  dimension: lat {
    type: number
    sql: ${TABLE}.LAT ;;
  }

  dimension: lng {
    type: number
    sql: ${TABLE}.LNG ;;
  }

  measure: positive {
    type: number
    sql: avg(${TABLE}.POSITIVE) ;;
  }

  measure: positive_total {
    type: number
    sql: sum(${TABLE}.POSITIVE) ;;
  }

  dimension: state_id {
    type: string
    sql: ${TABLE}.STATE_ID ;;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.STATE_NAME ;;
  }

  measure: temp {
    type: number
    sql: avg(${TABLE}.TEMP) ;;
  }

  dimension: location {
    type: location
    sql_latitude:${TABLE}.lat ;;
    sql_longitude:${TABLE}.lng ;;
  }

  dimension: state {
    map_layer_name: us_states
    sql: ${TABLE}.state_id ;;
    drill_fields: [state_id, day_date]
  }
}
