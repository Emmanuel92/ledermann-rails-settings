require 'rails/generators'
require 'rails/generators/migration'

module RailsSettings
  class ToJsonbGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    desc 'Update value attribute of string to jsonB'
    source_root File.expand_path('../templates', __FILE__)

    def create_migration_file
      migration_template 'migration.rb',
                         'db/migrate/rails_settings_migration_to_jsonb.rb'
    end

    def self.next_migration_number(dirname)
      if timestamped_migrations?
        Time.now.utc.strftime('%Y%m%d%H%M%S')
      else
        '%.3d' % (current_migration_number(dirname) + 1)
      end
    end

    def self.timestamped_migrations?
      (ActiveRecord::Base.respond_to?(:timestamped_migrations) && ActiveRecord::Base.timestamped_migrations) ||
      (ActiveRecord.respond_to?(:timestamped_migrations) && ActiveRecord.timestamped_migrations)
    end
  end
end
