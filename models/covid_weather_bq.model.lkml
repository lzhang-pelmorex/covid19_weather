connection: "bigquery_wip"


# include all the views
include: "/views/v_historical_bq.view"
include: "/views/v_historical_correlation_bq.view"

# include all the dashboards
include: "/dashboards/**/*.dashboard"

datagroup: covid19_weather_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: covid19_weather_default_datagroup

explore: v_historical_bq {}
explore: v_historical_correlation_bq {}

# explore: ct_us_covid_tests {}

# explore: demographics {}

# explore: hs_bulk_data {}

# explore: jhu_covid_19 {}

# explore: kff_hcp_capacity {}

# explore: kff_us_icu_beds {}

# explore: kff_us_state_mitigations {}

# explore: metadata {}

# explore: nyt_us_covid19 {}

# explore: pcm_dps_covid19 {}

# explore: pcm_dps_covid19_details {}

# explore: us_policy_actions {}

# explore: who_situation_reports {}
