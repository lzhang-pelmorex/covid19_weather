- dashboard: covid19__historical_correlation
  title: COVID19  Historical Correlation
  layout: newspaper
  elements:
  - title: Correlation by County
    name: Correlation by County
    model: covid19_weather
    explore: v_historical_correlation_sf
    type: looker_map
    fields: [v_historical_correlation_sf.county, v_historical_correlation_sf.correlation]
    sorts: [v_historical_correlation_sf.correlation desc]
    limit: 4000
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: true
    map_value_colors: []
    defaults_version: 1
    listen:
      State: v_historical_correlation_sf.state_name
    row: 0
    col: 12
    width: 12
    height: 12
  - title: Correlation Overtime
    name: Correlation Overtime
    model: covid19_weather
    explore: v_historical_sf
    type: looker_line
    fields: [v_historical_sf.day, v_historical_sf.R, v_historical_sf.positive_actual,
      v_historical_sf.positive_predicted]
    sorts: [v_historical_sf.day desc]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: v_historical_sf.positive,
            id: v_historical_sf.positive, name: Positive}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear},
      {label: !!null '', orientation: right, series: [{axisId: v_historical_sf.R,
            id: v_historical_sf.R, name: R}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types:
      v_historical_sf.R: area
    series_colors:
      v_historical_sf.positive: "#ff7f00"
      v_historical_sf.R: "#d0d0d0"
      v_historical_sf.positive_actual: "#ff7f00"
      v_historical_sf.positive_predicted: "#a9c574"
    series_labels:
      v_historical_sf.positive: "#s of Positive Cases"
      v_historical_sf.R: Calculated R
    defaults_version: 1
    listen:
      State: v_historical_sf.state_name
    row: 3
    col: 0
    width: 12
    height: 9
  - name: ''
    type: text
    title_text: ''
    body_text: "**R Equation:** \n3.968 − 0.0383 \U0001d447\U0001d452\U0001d45a\U0001d45d\
      \U0001d452\U0001d45f\U0001d44e\U0001d461\U0001d462\U0001d45f\U0001d452 − 0.0224\
      \ \U0001d445\U0001d452\U0001d459\U0001d44e\U0001d461\U0001d456\U0001d463\U0001d452\
      \U0001d43b\U0001d462\U0001d45a\U0001d456\U0001d451\U0001d456\U0001d461\U0001d466\
      \n\n**Predicted Positive Cases:**\nR * Total Positive Cases (in the last 15\
      \ days)"
    row: 0
    col: 0
    width: 12
    height: 3
  filters:
  - name: State
    title: State
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: covid19_weather
    explore: v_historical_sf
    listens_to_filters: []
    field: v_historical_sf.state_name
