class RailsSettingsMigrationToJsonb < ActiveRecord::Migration[5.0]
  def self.up
    RailsSettings::SettingObject.all.each do |setting|
      value =  setting.value ? YAML.safe_load(setting.value) : {}

      setting.update_columns(
        value: JSON.dump(value)
      )
    end
    change_column :settings, :value, 'jsonb USING value::json'
  end

  def self.down
    change_column :settings, :value, :text
    RailsSettings::SettingObject.all.each do |setting|
      value = JSON.load(setting.value)
      setting.update(value: YAML.dump(value))
    end
  end
end
