# Class to manage separate connection to RDS database on heroku
# based on http://stackoverflow.com/questions/7677544/how-to-use-multiple-databases-for-one-rails-3-1-app-in-heroku

module ActiveRecord
  class RdsDb < ActiveRecord::Base
    self.abstract_class = true  
    
    class << self  
      def configuration
        {
          adapter:  'mysql2',
          encoding: 'utf8',
          database: ENV['RDS_DATABASE'],
          username: ENV['RDS_USERNAME'],
          password: ENV['RDS_PASSWORD'],
          host:     ENV['RDS_HOST'],
          port:     3306
        }.stringify_keys
      end
    end
    
    establish_connection(self.configuration)
  end
end
