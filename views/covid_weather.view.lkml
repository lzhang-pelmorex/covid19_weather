view: covid_weather {
  derived_table: {
    sql:WITH weather AS (
  select
    date(w.DATE_VALID_STD) day,
    FIPS_CODE,
    avg(w.AVG_TEMPERATURE_AIR_2M_F) temp,
    avg(w.AVG_TEMPERATURE_FEELSLIKE_2M_F) feelslike,
    avg(w.AVG_HUMIDITY_RELATIVE_2M_PCT) humidity
  from ONPOINT_WEATHER_DATA.COUNTY.HISTORY_DAY w
  where DATE_VALID_STD >= '2020-01-01'
  group by day, FIPS_CODE
),
covid19 AS (
  select date, c.FIPS, d.ISO3166_2 state_id,
    max(CASES_SINCE_PREV_DAY) positive,
    max(DEATHS_SINCE_PREV_DAY) death,
    max(TOTAL_POPULATION) population
  from "STARSCHEMA_COVID19"."PUBLIC"."NYT_US_COVID19" c
    inner join "STARSCHEMA_COVID19"."PUBLIC"."DEMOGRAPHICS" d USING(FIPS)
  group by date, c.FIPS, state_id
)
select distinct w.day, w.temp, w.feelslike, w.humidity, c.state_id, FIPS fip_code,
    c.positive, c.death, population
from weather w
    left join covid19 c on c.FIPS=w.FIPS_CODE and c.date=w.day
order by state_id,day desc;;
  }

  dimension: day {
    type: date
    sql: ${TABLE}.day ;;
  }

  dimension: state_id {
    type: string
    sql: ${TABLE}.STATE_ID ;;
  }

  dimension: state {
    map_layer_name: us_states
    sql: ${TABLE}.state_id ;;
    drill_fields: [county]
  }

  dimension: fip_code {
    type: string
    sql: ${TABLE}.fip_code ;;
  }

  dimension: county {
    map_layer_name: us_counties_fips
    sql: ${TABLE}.fip_code ;;
    drill_fields: [day]
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

  measure: population {
    type: number
    sql: sum(${TABLE}.population) ;;
    value_format: "#,##0"
    }

  measure: positive_ratio {
    type: number
    sql: sum(${TABLE}.POSITIVE)/sum(${TABLE}.population);;
    value_format: "0.00000\%"
  }

  measure: average_feelslike {
    type: number
    sql: avg(${TABLE}.FEELSLIKE) ;;
  }

  measure: average_humidity {
    type: number
    sql: avg(${TABLE}.HUMIDITY) ;;
  }

  measure: average_temperature {
    type: number
    sql: avg(${TABLE}.TEMP) ;;
  }

}
