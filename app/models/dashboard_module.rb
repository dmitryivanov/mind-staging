class DashboardModule < ActiveRecord::Base
  belongs_to :dashboard
  include DashboardModuleMethods
  attr_accessor :data, :dimension_value_name

  def data
    
    data = case module_type
      when 'bar_chart' then bar_chart_data
      when 'trend_chart' then trend_chart_data
    end
    
    return data
  end       

  def after_initialize
    self.data ||= []
  end
  
  %w(dimension metric date).each do |attribute|
    attr_accessor "#{attribute}_name".to_sym
    
    define_method "#{attribute}_name" do
      send(attribute).titleize unless send(attribute).blank?
    end
  end
  
  def dimension_value_name
    %w(dimension dimension_value table).each do |attribute|
      return dimension_value if send(attribute).blank?
    end
    
    table_class = table.classify.constantize
    dimension_value_association_name(table_class, dimension, dimension_value)
  end
  
  def as_json(options = {})
    # just in case someone says as_json(nil) and bypasses
    # our default...
    super((options || { }).merge({
        :methods => [:metric_name, :dimension_name, :dimension_value_name, :date_name, :data]
    }))
  end
  
  def bar_chart_data    
    
    return nil unless validate_chart_settings :dimension, :metric, :table
    
    data = bar_chart_values.map do |element|
      {
       "dimension1" => dimension_value_association_name(table_class, dimension, element[0]),
       "dim1_label" => dimension,
       "metric1" => element[1],
       "met1_label" => (metric == 'id' ? table : metric) 
      }    
    end
    
    return data
  end
  
  def trend_chart_data
    
    return nil unless validate_chart_settings :dimension, :metric, :table, :dimension_value, :date
          
    data = trend_chart_values.map do |element|
      {
       "dimension1" => '',
       #dimension_value_association_name(table_class, dimension, (element.send(dimension))),
       "dim1_label" => dimension,
       "metric1" => (calculation_type == 'count' ? element[1] : element.send(metric)),
       "met1_label" => metric,
       'date1' => (calculation_type == 'count' ? element[0] : prepared_date(date, element))
      }    
    end

    return data
  end
  
private

  def prepared_date(date, element)
    date_value = nil
    unless element.send(date).nil? 
      date_value = element.send(date).strftime("%Y-%m-%d")
    end
    
    return date_value
  end
  
  def trend_chart_values
    
    values = table_class
      .where(dimension.to_sym => dimension_value)
      .where("? IS NOT NULL", date)
      .limit(10)
      .order("#{date} ASC")
      
    if calculation_type == 'count'
      values = values.send(:count, metric, :group => "DATE(#{date})")
    end
      
    return values
  end
  
  def bar_chart_values    
    
    metric_type = table_class.columns.find{|c| c.name == metric}.type
  
    if metric_type == :string or metric == 'id'
      action_type = :count
    elsif metric_type == :integer
      action_type = :sum
    end
    
    values = table_class
      .limit(10)
      .order("#{action_type.to_s}_#{metric} DESC")
      .send(action_type, metric, :group => dimension)
  end
  
  def table_class
    return table.classify.constantize
  end
  
  def validate_chart_settings(*attributes)
    all_attributes_valid = true
    
    attributes.each do |attribute|
      all_attributes_valid = false if send(attribute).blank?
    end
    
    return all_attributes_valid
  end    

end
