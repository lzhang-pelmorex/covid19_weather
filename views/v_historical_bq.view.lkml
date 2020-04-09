view: v_historical_bq {
  derived_table: {
    sql:WITH weather AS (
          select DATE_VALID_STD day, FIPS_CODE fips, AVG_TEMPERATURE_AIR_2M_F temp, AVG_HUMIDITY_RELATIVE_2M_PCT relative_hum, (3.968-(0.0383*(AVG_TEMPERATURE_AIR_2M_F-32.0)*5/9)-0.0224*AVG_HUMIDITY_RELATIVE_2M_PCT) r
          from snowflake.ws_fx_county_day
          where DATE_VALID_STD >= '2020-01-01'
        ),
        covid19_cleanup AS (
          select distinct date day, CASES_SINCE_PREV_DAY positive, DEATHS_SINCE_PREV_DAY death, case when f.fips is not null then f.fips else c.FIPS end fips
          from snowflake.NYT_US_COVID19 c
            left join (select * from unnest([36061,36047,36081,36005,36085]) fips) f on lower(c.COUNTY)='new york city' and c.FIPS is null
        ),
        covid19 AS (
          select day, FIPS, max(positive) positive, max(death) death
          from covid19_cleanup
          group by day, FIPS
        )
        select distinct w.day, w.temp, w.relative_hum,
            case when is_nan(w.r) or w.r is null then 0 else w.r end as R,
            w.fips, c.positive, c.death
        from weather w
            left join covid19 c using(day, fips)
        order by day desc;;
  }

  dimension: day {
    type: date
    sql: ${TABLE}.day ;;
  }

  dimension: fip_code {
    type: string
    sql: ${TABLE}.FIPS ;;
  }

  dimension: county {
    map_layer_name: us_counties_fips
    sql: ${TABLE}.FIPS ;;
  }

  measure: temperature {
    type: number
    sql: avg(${TABLE}.temp) ;;
  }

  measure: relative_humidity {
    type: number
    sql: avg(${TABLE}.relative_hum) ;;
  }

  measure: R {
    type: number
    sql: avg(${TABLE}.R);;
  }

  measure: positive {
    type: number
    sql: sum(${TABLE}.positive) ;;
  }

}
