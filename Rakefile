require 'active_record'

namespace :db do
  db_config = {
    :adapter => 'sqlite3',
    :database => 'dbdemo.sqlite3'
  }

  task :connection do
    ActiveRecord::Base.establish_connection(db_config)
  end

  desc "Migrate tables for database"
  task :migrate => :connection do
    ActiveRecord::Migrator.migrate('db/migrate')
    puts "Database migrated."
  end

  desc "Drop the database"
  task :drop do
    sqlite_path = File.join(File.dirname(__FILE__), db_config[:database])
    File.delete(sqlite_path) if File.exist?(sqlite_path)
    puts "Database deleted."
  end
end
