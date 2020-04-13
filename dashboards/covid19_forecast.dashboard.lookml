- dashboard: covid19_forecast
  title: COVID19 Forecast
  layout: newspaper
  elements:
  - title: Predicted R (next 15 days)
    name: Predicted R (next 15 days)
    model: covid19_weather
    explore: v_forecast_sf
    type: looker_map
    fields: [v_forecast_sf.county, v_forecast_sf.R]
    sorts: [v_forecast_sf.R desc]
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
    reverse_map_value_colors: false
    defaults_version: 1
    listen:
      State: v_forecast_sf.state_name
    row: 3
    col: 0
    width: 12
    height: 12
  - title: 'Predicted #s of Positive Cases (next 15 days)'
    name: 'Predicted #s of Positive Cases (next 15 days)'
    model: covid19_weather
    explore: v_forecast_sf
    type: looker_map
    fields: [v_forecast_sf.prediction, v_forecast_sf.county]
    filters:
      v_forecast_sf.prediction: ">0"
    sorts: [v_forecast_sf.prediction desc]
    limit: 500
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light_no_labels
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
    reverse_map_value_colors: false
    defaults_version: 1
    listen:
      State: v_forecast_sf.state_name
    row: 3
    col: 12
    width: 12
    height: 12
  - name: ''
    type: text
    body_text: "**R Equation:** \n3.968 − 0.0383 \U0001d447\U0001d452\U0001d45a\U0001d45d\
      \U0001d452\U0001d45f\U0001d44e\U0001d461\U0001d462\U0001d45f\U0001d452 − 0.0224\
      \ \U0001d445\U0001d452\U0001d459\U0001d44e\U0001d461\U0001d456\U0001d463\U0001d452\
      \U0001d43b\U0001d462\U0001d45a\U0001d456\U0001d451\U0001d456\U0001d461\U0001d466\
      \n\n**Predicted Positive Cases:**\nR * Total Positive Cases (in the last 15\
      \ days)"
    row: 0
    col: 0
    width: 24
    height: 3
  filters:
  - name: State
    title: State
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: covid19_weather
    explore: v_forecast_sf
    listens_to_filters: []
    field: v_forecast_sf.state_name
