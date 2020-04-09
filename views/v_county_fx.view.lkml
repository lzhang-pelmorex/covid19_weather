view: v_covid_fx {
  derived_table: {
    sql:WITH covid19_cleanup AS (
          select distinct date day, CASES_SINCE_PREV_DAY positive, DEATHS_SINCE_PREV_DAY death,
            case when f.fips is not null then f.fips else c.FIPS end fips
          from "STARSCHEMA_COVID19"."PUBLIC"."NYT_US_COVID19" c
            left join (select value fips from table(split_to_table('36061,36047,36081,36005,36085', ','))) f on lower(c.COUNTY)='new york city' and c.FIPS is null
        ),
        covid19 AS (
          select FIPS, sum(positive) positive, sum(death) death
          from (
            select c.day, c.FIPS, max(positive) positive, max(death) death
            from covid19_cleanup c
            group by c.FIPS, c.day
          )
          where day between dateadd(day,-15,CURRENT_DATE) and CURRENT_DATE
          group by FIPS
        ),
        weather AS (
          select distinct FIPS_CODE, (3.968-(0.0383*(AVG_TEMPERATURE_AIR_2M_F-32.0)*5/9)-0.0224*AVG_HUMIDITY_RELATIVE_2M_PCT) r
          from "ONPOINT_WEATHER_DATA"."COUNTY"."RAW_FORECAST_DAY"
          where TIME_INIT_UTC >= CURRENT_DATE
        )
        select w.FIPS_CODE, w.r, c.positive positive_last_15_d
        from weather w
            inner join covid19 c on c.FIPS=w.FIPS_CODE;;
  }

  dimension: fip_code {
    type: string
    sql: ${TABLE}.FIPS_CODE ;;
  }

  dimension: county {
    map_layer_name: us_counties_fips
    sql: ${TABLE}.FIPS_CODE ;;
  }

  measure: R {
    type: number
    sql: avg(${TABLE}.R) ;;
  }

  measure: positive {
    type: number
    sql: avg(${TABLE}.positive_last_15_d) ;;
    value_format: "#,##0.00"
    }

  measure: prediction {
    type: number
    sql: avg(${TABLE}.R) * avg(${TABLE}.positive_last_15_d) ;;
    value_format: "#,##0"
  }

}
