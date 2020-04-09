- dashboard: covid19_historical
  title: COVID19  Forecast (next 15 days)
  layout: newspaper
  elements:
  - title: Prediction by County
    name: Prediction by County
    model: covid19_weather
    explore: v_covid_fx
    type: looker_map
    fields: [v_covid_fx.county, v_covid_fx.prediction]
    sorts: [v_covid_fx.prediction desc]
    limit: 500
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
    listen: {}
    row: 0
    col: 12
    width: 12
    height: 12
  - title: Total R by County
    name: Total R by County
    model: covid19_weather
    explore: v_covid_fx
    type: looker_map
    fields: [v_covid_fx.county, v_covid_fx.R]
    sorts: [v_covid_fx.R desc]
    limit: 4000
    map_plot_mode: points
    heatmap_gridlines: true
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
    series_types: {}
    map: auto
    map_projection: ''
    quantize_colors: false
    defaults_version: 1
    listen: {}
    row: 3
    col: 0
    width: 12
    height: 12
