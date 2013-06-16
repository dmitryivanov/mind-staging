window.trend_chart = (width,height,data,container) ->
  vertical_padding = 30
  horizontal_padding = 30
  
  # TODO:
  # there's no need to pass metric and dimension labes in
  # data array, this can and should be done by backbone view
  
  # TODO:
  # why using metric1 and date1 instead of just metric and date var names?
  
  # shortcut to parse date from string with a given format
  parseDate = d3.time.format("%Y-%m-%d").parse
  
  
  # Calculating min and max values
  #
  # d3.extent(array[, accessor])
  # Returns the minimum and maximum value in the given array using natural order. 
  # This is equivalent to calling d3.min and d3.max simultaneously.
  
  # NOTE:
  # when using accessor function we don't need to map data 
  # objects to arrays by hand
  
  metric_extent = [0, d3.max(data, (d) ->
    d.metric1
  )]
  date_extent = d3.extent(data, (d) ->
    parseDate(d.date1)
  )
  
  # Creating scales
  #
  # Now me know mix and max values for both axis and can
  # create scales. In sort, scale maps values in domain to the values in range.
  # Domain is between min and max values we've just got, and range is 
  # usuallit between 0 (or margin value) and width/heigh of the chart
  
  
  # create linear scale for metric axis
  # https://github.com/mbostock/d3/wiki/Quantitative-Scales
  metric_scale = d3.scale.linear()
    .domain(metric_extent)
    .range([height-vertical_padding, vertical_padding]);

  
  # create time scale for date axis
  # https://github.com/mbostock/d3/wiki/Time-Scales
  date_scale = d3.time.scale()
    .domain(date_extent)
    .range([horizontal_padding, width-horizontal_padding])
      
      
  # Creating axes
  #
  # D3’s axis component displays reference lines for scales automatically. 
  # This lets you focus on displaying the data, while the axis component 
  # takes care of the tedious task of drawing axes and labeled ticks.
  # https://github.com/mbostock/d3/wiki/SVG-Axes

  metric_axis = d3.svg.axis()
    .scale(metric_scale)
    .orient("left")
    .tickSize(0)
  
  date_axis = d3.svg.axis()
    .scale(date_scale)
    .orient("bottom")
    .tickSize(0)
    .tickFormat(d3.time.format("%m.%d"))
    
    
  # Line generator for drawing curve
  #
  # https://github.com/mbostock/d3/wiki/SVG-Shapes#wiki-line
  line = d3.svg.line()
    .x( (d) ->
      return date_scale(parseDate(d.date1))
    )
    .y( (d) ->
      return metric_scale(d.metric1)
    )
    .interpolate("linear")

  # add canvas to document
  chart = d3.select(container)
    .append("svg")
    .attr("class","chart") 
    .attr("width", width)
    .attr("height", height)
  
  # add x axis   
  chart.append("g")
    .attr("transform", "translate(0,"+(height-vertical_padding)+")")  
    .call(date_axis)
    
  # add y axis   
  chart.append("g")
    .attr("transform", "translate("+horizontal_padding+ ",0)")  
    .call(metric_axis)
    
  # Append path to a chart
  chart.append('path')
    .attr('d', line(data))
    .attr('class', 'trend')
  