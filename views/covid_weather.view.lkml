view: covid_weather {
  derived_table: {
    sql: select date(w.DATE_VALID_STD) day,
    median(w.AVG_TEMPERATURE_AIR_2M_F) temp,
    median(w.AVG_TEMPERATURE_FEELSLIKE_2M_F) feelslike,
    median(w.AVG_HUMIDITY_RELATIVE_2M_PCT) humidity,
    sum(c.CASES_SINCE_PREV_DAY) positive, sum(c.DEATHS_SINCE_PREV_DAY) death,
    z.state_name, z.STATE_ID state_id,
    avg(z.lat) lat,
    avg(z.lng) lng
from ONPOINT_WEATHER_DATA.POSTCODE.HISTORY_DAY w
    inner join ONPOINT_WEATHER_DATA.POSTCODE.uszips z on z.zip=w.POSTAL_CODE
    left join "STARSCHEMA_COVID19"."PUBLIC"."NYT_US_COVID19" c on replace(lower(c.STATE),' ')=replace(lower(z.state_name),' ') and c.date=w.DATE_VALID_STD
where  w.DATE_VALID_STD >= '2020-01-01'
group by day, state_name, STATE_ID
order by state_name,day desc ;;
  }

  dimension: day {
    type: date
    sql: ${TABLE}.day ;;
  }

  measure: death {
    type: number
    sql: avg(${TABLE}.DEATH) ;;
    value_format: "0"
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
    value_format: "0"
  }

  measure: positive_total {
    type: number
    sql: sum(${TABLE}.POSITIVE) ;;
    value_format: "0"
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
    drill_fields: [day]
  }
}
