# based on riginal activerecord's database.rake
# https://github.com/rails/rails/blob/master/activerecord/lib/active_record/railties/databases.rake

# require 'rubygems'

def dotenv_enabled?
  ['development', 'test'].include?(Rails.env)
end

require 'active_record'
require 'dotenv/tasks' if dotenv_enabled?

[
  'lib/ar_mysql_tasks.rb',
  'lib/ar_database_tasks.rb',
  'lib/hash.rb',
  'lib/rds.rb'
].each { |f| require Rails.root.join(f) }


rds_namespace =namespace :rds do
  
  task :connect_to_rds do
    Dotenv.load(".env") if dotenv_enabled?
    ActiveRecord::Base.establish_connection(ActiveRecord::RdsDb.configuration)
    RDS_MIGRATION_PATH = 'db/rds_migrate'
    RDS_SCHEMA_FILE_PATH = 'db/rds_schema.rb'
  end
  
  task :connect_to_test_rds do
    Dotenv.load(".env.test") if dotenv_enabled?
    ActiveRecord::Base.establish_connection(ActiveRecord::RdsDb.configuration)
  end
    
  
  task :migrate => :connect_to_rds do    
    ActiveRecord::Migrator.migrate(RDS_MIGRATION_PATH)
    rds_namespace['schema:dump'].invoke
  end
  
  task :rollback => :connect_to_rds do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    ActiveRecord::Migrator.rollback(RDS_MIGRATION_PATH, step)
    rds_namespace['schema:dump'].invoke
  end
  
  desc 'Drops the database using DATABASE_URL or the current Rails.env (use db:drop:all to drop all databases)'
  task :drop => :connect_to_rds do
    begin
      ActiveRecord::Tasks::MySQLDatabaseTasks.new(ActiveRecord::Base.connection_config.stringify_keys).drop
    rescue Exception => error
      $stderr.puts error, *(error.backtrace)
      $stderr.puts "Couldn't drop RDS db"
    end
  end
  
  desc 'Create the database from DATABASE_URL or config/database.yml for the current Rails.env (use db:create:all to create all dbs in the config)'
  task :create => :connect_to_rds do
    ActiveRecord::Tasks::MySQLDatabaseTasks.new(ActiveRecord::Base.connection_config.stringify_keys).create
  end
  
  task :reset => ['rds:drop', 'rds:create', 'rds:migrate']
  
  namespace :schema do
    desc 'Load a rds_schema.rb file into the RDS db'
    task :load => :connect_to_rds do
      file = Rails.root.join(RDS_SCHEMA_FILE_PATH)
      if File.exists?(file)
        load(file)
      else
        abort %{#{file} doesn't exist yet. Run `rake db:migrate` to create it then try again. If you do not intend to use a database, you should instead alter #{Rails.root}/config/application.rb to limit the frameworks that will be loaded}
      end
    end
    
    desc 'Create a schema file'
    task :dump => :connect_to_rds do
      require 'active_record/schema_dumper'
      filename = Rails.root.join(RDS_SCHEMA_FILE_PATH)
      File.open(filename, "w:utf-8") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
      rds_namespace['schema:dump'].reenable
    end
  end
  
  namespace :migrate do
    desc 'Display status of migrations'
    task :status => :connect_to_rds do
      unless ActiveRecord::Base.connection.table_exists?(ActiveRecord::Migrator.schema_migrations_table_name)
        puts 'Schema migrations table does not exist yet.'
        next  # means "return" for rake task
      end
      db_list = ActiveRecord::Base.connection.select_values("SELECT version FROM #{ActiveRecord::Migrator.schema_migrations_table_name}")
      db_list.map! { |version| "%.3d" % version }
      file_list = []
      
      Dir.foreach() do |file|
        # match "20091231235959_some_name.rb" and "001_some_name.rb" pattern
        if match_data = /^(\d{3,})_(.+)\.rb$/.match(file)
          status = db_list.delete(match_data[1]) ? 'up' : 'down'
          file_list << [status, match_data[1], match_data[2].humanize]
        end
      end

      db_list.map! do |version|
        ['up', version, '********** NO FILE **********']
      end
      # output
      puts "\ndatabase: RDS\n\n"
      puts "#{'Status'.center(8)}  #{'Migration ID'.ljust(14)}  Migration Name"
      puts "-" * 50
      (db_list + file_list).sort_by {|migration| migration[1]}.each do |migration|
        puts "#{migration[0].center(8)}  #{migration[1].ljust(14)}  #{migration[2]}"
      end
      puts
    end
  end
  
  namespace :test do

    # desc "Recreate the test database from the current schema"
    task :load => [:connect_to_test_rds, 'rds:test:purge'] do
      case ActiveRecord::Base.schema_format
        when :ruby
          rds_namespace["test:load_schema"].invoke
        when :sql
          rds_namespace["test:load_structure"].invoke
      end
    end

    # desc "Recreate the test database from an existent schema.rb file"
    task :load_schema => [:connect_to_test_rds, 'rds:test:purge'] do
      ActiveRecord::Schema.verbose = false
      rds_namespace["schema:load"].invoke
    end

    # desc "Recreate the test database from an existent structure.sql file"
    task :load_structure => [:connect_to_test_rds, 'rds:test:purge'] do
      begin
        ActiveRecord::Tasks::DatabaseTasks.current_config(:config => ActiveRecord::Base.connection_config.stringify_keys)
        rds_namespace["structure:load"].invoke
      ensure
        ActiveRecord::Tasks::DatabaseTasks.current_config(:config => nil)
      end
    end

    # desc "Recreate the test database from a fresh schema"
    task :clone do
      case ActiveRecord::Base.schema_format
        when :ruby
          rds_namespace["test:clone_schema"].invoke
        when :sql
          rds_namespace["test:clone_structure"].invoke
      end
    end

    # desc "Recreate the test database from a fresh schema.rb file"
    task :clone_schema => ["rds:schema:dump", "rds:test:load_schema"]

    # desc "Recreate the test database from a fresh structure.sql file"
    task :clone_structure => [ "rds:structure:dump", "rds:test:load_structure" ]

    # desc "Empty the test database"
    task :purge => :connect_to_test_rds do
      ActiveRecord::Tasks::DatabaseTasks.purge(ActiveRecord::Base.connection_config.stringify_keys)
    end

    # desc 'Check for pending migrations and load the test schema'
    task :prepare => :connect_to_test_rds do
      rds_namespace['test:load'].invoke
    end
    
    desc 'create test rds database'
    task :create => :connect_to_test_rds do
      puts ActiveRecord::Base.connection_config
      ActiveRecord::Tasks::MySQLDatabaseTasks.new(ActiveRecord::Base.connection_config.stringify_keys).create
    end
  end

end
