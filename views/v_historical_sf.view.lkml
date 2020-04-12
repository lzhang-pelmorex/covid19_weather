view: v_historical_sf {
  derived_table: {
    sql:WITH weather AS (
          select distinct DATE_VALID_STD day, FIPS_CODE fips, AVG_TEMPERATURE_AIR_2M_F temp, AVG_HUMIDITY_RELATIVE_2M_PCT relative_hum, (3.968-(0.0383*(AVG_TEMPERATURE_AIR_2M_F-32.0)*5/9)-0.0224*AVG_HUMIDITY_RELATIVE_2M_PCT) r
          from "ONPOINT_WEATHER_DATA"."COUNTY"."HISTORY_DAY"
          where DATE_VALID_STD >= '2020-01-01'
        ),
        covid19 AS (
          select day, FIPS, state_name, max(positive) positive, max(death) death
          from (
            select distinct date day, CASES_SINCE_PREV_DAY positive, DEATHS_SINCE_PREV_DAY death,
                case when f.fips is not null then f.fips else c.FIPS end fips, STATE state_name
            from  "STARSCHEMA_COVID19"."PUBLIC"."NYT_US_COVID19" c
              left join (select value fips from table(split_to_table('36061,36047,36081,36005,36085', ','))) f on lower(c.COUNTY)='new york city' and c.FIPS is null
          )
          group by day, FIPS, state_name
        ),
        covid19_last_15d as (
          select distinct w.day, w.fips, sum(p.positive) positive_predicted
          from weather w
              inner join covid19 p on p.fips=w.fips and p.day between dateadd(day,-15,w.day) and w.day
          group by w.day, w.fips
        )
        select distinct w.day, w.fips, c.state_name,
            w.r, c.positive positive_actual, p.positive_predicted
        from weather w
            inner join covid19 c using(day, fips)
            inner join covid19_last_15d p using(day, fips);;
  }

  dimension: day {
    type: date
    sql: ${TABLE}.day ;;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.state_name ;;
  }

  dimension: county {
    map_layer_name: us_counties_fips
    sql: ${TABLE}.FIPS ;;
  }

  measure: R {
    type: number
    sql: avg(${TABLE}.R);;
    value_format: "#,##0.00"
  }

  measure: positive_actual {
    type: number
    sql: sum(${TABLE}.positive_actual) ;;
    value_format: "#,##0"
  }

  measure: positive_predicted {
    type: number
    sql: sum(${TABLE}.positive_predicted) ;;
    value_format: "#,##0"
  }
}
