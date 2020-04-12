view: v_forecast_sf {
  derived_table: {
    sql:WITH weather AS (
  select FIPS_CODE fips,
        avg(AVG_TEMPERATURE_AIR_2M_F) temp,
        avg(AVG_HUMIDITY_RELATIVE_2M_PCT) relative_hum,
        (3.968-(0.0383*(avg(AVG_TEMPERATURE_AIR_2M_F)-32.0)*5/9)-0.0224*avg(AVG_HUMIDITY_RELATIVE_2M_PCT)) r
  from "ONPOINT_WEATHER_DATA"."COUNTY"."RAW_FORECAST_DAY"
  where DATE_VALID_STD >= CURRENT_DATE
  group by fips
),
covid19 AS (
  select FIPS, state_name, max(positive) positive, max(death) death
  from (
    select STATE state_name, CASES_SINCE_PREV_DAY positive, DEATHS_SINCE_PREV_DAY death, case when f.fips is not null then f.fips else c.FIPS end fips
    from  "STARSCHEMA_COVID19"."PUBLIC"."NYT_US_COVID19" c
      left join (select value fips from table(split_to_table('36061,36047,36081,36005,36085', ','))) f on lower(c.COUNTY)='new york city' and c.FIPS is null
    where date between dateadd(day,-15,CURRENT_DATE) and CURRENT_DATE
  )
  group by FIPS, state_name
)
select distinct w.temp, w.relative_hum, w.r,
    w.fips, c.state_name, c.positive, c.death,
    case when w.r is not null and c.positive is not null then w.r * c.positive else null end prediction
from weather w
    left join covid19 c using(fips);;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.state_name ;;
  }

  dimension: county {
    map_layer_name: us_counties_fips
    sql: ${TABLE}.fips ;;
  }

  measure: R {
    type: number
    sql: avg(${TABLE}.R) ;;
  }

  measure: positive {
    type: number
    sql: avg(${TABLE}.positive) ;;
    value_format: "#,##0.00"
    }

  measure: prediction {
    type: number
    sql: avg(${TABLE}.prediction);;
    value_format: "#,##0"
  }

}
