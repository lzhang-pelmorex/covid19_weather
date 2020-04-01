- dashboard: covid19_weather
  title: covid19_weather_snowflake
  layout: newspaper
  elements:
  - title: 'Average #s of positive cases by state'
    name: 'Average #s of positive cases by state'
    model: covid19_weather
    explore: covid_weather
    type: looker_geo_choropleth
    fields: [covid_weather.state, covid_weather.positive_total]
    sorts: [covid_weather.positive_total desc]
    limit: 500
    map: usa
    map_projection: ''
    show_view_names: false
    quantize_colors: false
    colors: [darkorange]
    series_types: {}
    defaults_version: 1
    listen:
      State: covid_weather.state_id
      Date_Range: covid_weather.day
    row: 0
    col: 0
    width: 10
    height: 10
  - title: Weather Correlation
    name: Weather Correlation
    model: covid19_weather
    explore: covid_weather
    type: looker_line
    fields: [covid_weather.day, covid_weather.positive, covid_weather.temp, covid_weather.humidity]
    fill_fields: [covid_weather.day]
    sorts: [covid_weather.day desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: covid_weather.temp,
            id: covid_weather.temp, name: Temp}, {axisId: covid_weather.humidity,
            id: covid_weather.humidity, name: Humidity}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear},
      {label: !!null '', orientation: right, series: [{axisId: covid_weather.positive,
            id: covid_weather.positive, name: Positive}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types:
      covid_weather.positive: column
    series_colors:
      covid_weather.positive: "#db7f2a"
      covid_weather.temp: "#A2BF39"
      covid_weather.humidity: "#62bad4"
    series_labels:
      covid_weather.temp: Temperature
      covid_weather.positive: Positive Cases
    defaults_version: 1
    listen:
      State: covid_weather.state_id
      Date_Range: covid_weather.day
    row: 0
    col: 10
    width: 14
    height: 10
  filters:
  - name: State
    title: State
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: covid19_weather
    explore: covid_weather
    listens_to_filters: []
    field: covid_weather.state_id
  - name: Date_Range
    title: Date_Range
    type: date_filter
    default_value: 2020/01/01 to 2020/03/31
    allow_multiple_values: true
    required: false
