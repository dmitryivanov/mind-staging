module DashboardModuleMethods
  def dimension_value_association_name(table_class, dimension, value)    
     name = value
     
     unless @association_class or @association_class == 'not found'

       # get all belongs_to associations for selected table
       associations = table_class.reflect_on_all_associations(:belongs_to)
       association_foreign_keys = associations.map(&:foreign_key)

       # get class of association of current dimension, if it's an association
       if association_foreign_keys.include?(dimension)
         @association_class = associations.find{|a| a.foreign_key == dimension}.name.to_s.classify.constantize
       else
         @association_class = 'not found' # indicate that association not found
       end 
     end

     if @association_class and @association_class != 'not found'      
       
       begin
         
         # TODO: checked the logs, this query gets called every time we need to
         # get association's name, even if we already retrieved it.
         # It has to be cached
         association = @association_class.find(value)
         if association.respond_to?(:name)
           name = association.name.titleize 
         elsif association.respond_to?(:title)
           name =  association.title.titleize
         end
       rescue ActiveRecord::RecordNotFound
         name = nil
       end      
     end

     return name.is_a?(String) ? name.titleize : name
   end
end