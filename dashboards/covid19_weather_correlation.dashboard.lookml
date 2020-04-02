- dashboard: covid19_weather_correlation
  title: COVID19 Weather Correlation
  layout: newspaper
  elements:
  - title: 'By #s of positive cases ratio (total cases/population)'
    name: 'By #s of positive cases ratio (total cases/population)'
    model: covid19_weather
    explore: covid_weather
    type: looker_geo_choropleth
    fields: [covid_weather.state, covid_weather.positive_ratio]
    sorts: [covid_weather.state]
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
    width: 9
    height: 6
  - title: Weather Correlation - Average Values Overtime
    name: Weather Correlation - Average Values Overtime
    model: covid19_weather
    explore: covid_weather
    type: looker_line
    fields: [covid_weather.day, covid_weather.total_positive, covid_weather.average_temperature,
      covid_weather.average_humidity]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: covid_weather.median_temperature,
            id: covid_weather.median_temperature, name: Median Temperature}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: '', orientation: left, series: [{axisId: covid_weather.median_humidity,
            id: covid_weather.median_humidity, name: Median Humidity}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: '', orientation: right, series: [{axisId: covid_weather.total_positive,
            id: covid_weather.total_positive, name: Total Positive}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    series_types:
      covid_weather.positive: column
      covid_weather.total_positive: column
    series_colors:
      covid_weather.positive: "#db7f2a"
      covid_weather.temp: "#A2BF39"
      covid_weather.humidity: "#62bad4"
      covid_weather.total_positive: "#ff7f00"
      covid_weather.average_humidity: "#62bad4"
    series_labels:
      covid_weather.temp: Temperature
      covid_weather.positive: Positive Cases
    defaults_version: 1
    listen:
      State: covid_weather.state_id
      Date_Range: covid_weather.day
    row: 0
    col: 9
    width: 15
    height: 12
  - title: 'By #s of positive cases'
    name: 'By #s of positive cases'
    model: covid19_weather
    explore: covid_weather
    type: looker_geo_choropleth
    fields: [covid_weather.total_positive, covid_weather.state]
    sorts: [covid_weather.total_positive desc]
    limit: 500
    map: usa
    map_projection: ''
    show_view_names: false
    quantize_colors: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    series_types: {}
    listen:
      State: covid_weather.state_id
      Date_Range: covid_weather.day
    row: 6
    col: 0
    width: 9
    height: 6
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
