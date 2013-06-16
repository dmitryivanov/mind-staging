window.bar_chart = (width,height,data,container) ->
  
  # set padding
  vertical_padding = 30
  horizontal_padding = 30
  dimension_labels_width = 100
  
  
  # map values to arrays
  dimension_values = data.map( (item, index) ->
    return item.dimension1
  )
  
  metric_values = data.map( (item, index) ->
    return item.metric1
  )
  
  # extent
  metric_extent = [0, d3.max(metric_values)]
  
  # scales
  metric_scale = d3.scale.linear()
    .domain(metric_extent)
    .range([0, width-dimension_labels_width-horizontal_padding]);
  
  # ordinal scale uses array of any unique values as domain, so
  # we just create range of unique ids for all dimensions
  dimension_scale = d3.scale.ordinal()
    .domain(d3.range(0, dimension_values.length))
    .rangeBands([vertical_padding, height-vertical_padding])
  
  # two helper functions to map dimension scale
  # values to  y coordinates of bars and text
  barY = (d, i) ->
    return dimension_scale(i)
    
  barTextY = (d, i) ->
    barY(d, i) + dimension_scale.rangeBand() / 2
  
  # axes
  # here we used mapped dimension values
  # to show as ticks on dimension axis
  dimension_axis = d3.svg.axis()
    .scale(dimension_scale)
    .orient("left")
    .tickValues(dimension_values)
    .tickSize(0)
    
  metric_axis = d3.svg.axis()
    .scale(metric_scale)
    .orient("top")
    .tickSize(0)
 
  # add canvas
  chart = d3.select(container).append("svg")
    .attr("class", "chart")
    .attr("width", width)
    .attr("height", height)
    
  # add y axis   
  chart.append("g")
    .attr("transform", "translate("+dimension_labels_width+",0)")  
    .call(dimension_axis)

  # add x axis   
  chart.append("g")
    .attr("transform", "translate("+dimension_labels_width+","+vertical_padding+")")  
    .attr("class", "rule")
    .call(metric_axis)
    

  # draw vertical lines
  chart.append('g')
    .attr("transform", "translate("+(dimension_labels_width)+","+vertical_padding+")")  
    .selectAll("line")
     .data(metric_scale.ticks(10))
   .enter().append("line")
     .attr("x1", metric_scale)
     .attr("x2", metric_scale)
     .attr("y1", 0)
     .attr("y2", height-vertical_padding*2)
     .style("stroke", "#ccc");
    
  #  draw bar chart rectangles
  chart.append("g")
    .attr("transform", "translate("+(dimension_labels_width)+",0)")  
    .selectAll("rect")
    .data(metric_values)
    .enter()
    .append("rect")
    .attr("y", barY)
    .attr("width", metric_scale)
    .attr("height", dimension_scale.rangeBand());
   
  # add labels inside of the bars
  chart.append("g")
    .attr("transform", "translate("+dimension_labels_width+",0)")  
    .selectAll("text")
      .data(metric_values)
      .enter().append("text")
      .attr("x", metric_scale)
      .attr("y", barTextY)
      .attr("dx", -3)
      .attr("dy", ".35em")
      .attr("text-anchor", "end")
      .attr("fill","white")
      .text(String);