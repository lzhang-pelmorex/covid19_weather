view: covid_weather {
  derived_table: {
    sql: WITH weather AS (
  select
    date(w.DATE_VALID_STD) day,
    replace(lower(z.state_name),' ') state_name,
    z.state_id,
    avg(z.lat) lat,
    avg(z.lng) lng,
    median(w.AVG_TEMPERATURE_AIR_2M_F) temp,
    median(w.AVG_TEMPERATURE_FEELSLIKE_2M_F) feelslike,
    median(w.AVG_HUMIDITY_RELATIVE_2M_PCT) humidity
  from ONPOINT_WEATHER_DATA.POSTCODE.HISTORY_DAY w
    inner join ONPOINT_WEATHER_DATA.POSTCODE.uszips z on z.zip=w.POSTAL_CODE
  where DATE_VALID_STD >= '2020-01-01'
  group by day, state_name, state_id
),
covid19 AS (
  select
    date,
    replace(lower(STATE),' ') state_name,
    max(CASES_SINCE_PREV_DAY) positive,
    max(DEATHS_SINCE_PREV_DAY) death
  from "STARSCHEMA_COVID19"."PUBLIC"."NYT_US_COVID19"
  group by date, state_name
)
select distinct w.day, w.temp, w.feelslike, w.humidity, w.lat, w.lng, w.state_name, w.state_id,
    c.positive, c.death
from weather w
    left join covid19 c on c.state_name=w.state_name and c.date=w.day
order by state_name,day desc;;
  }

  dimension: day {
    type: date
    sql: ${TABLE}.day ;;
  }

  dimension: lat {
    type: number
    sql: ${TABLE}.LAT ;;
  }

  dimension: lng {
    type: number
    sql: ${TABLE}.LNG ;;
  }

  measure: total_death {
    type: number
    sql: sum(${TABLE}.DEATH) ;;
    value_format: "#,##0"
  }

  measure: total_positive {
    type: number
    sql: sum(${TABLE}.POSITIVE) ;;
    value_format: "#,##0"
  }

  measure: median_feelslike {
    type: number
    sql: median(${TABLE}.FEELSLIKE) ;;
  }

  measure: median_humidity {
    type: number
    sql: median(${TABLE}.HUMIDITY) ;;
  }

  dimension: state_id {
    type: string
    sql: ${TABLE}.STATE_ID ;;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.STATE_NAME ;;
  }

  measure: median_temperature {
    type: number
    sql: median(${TABLE}.TEMP) ;;
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
