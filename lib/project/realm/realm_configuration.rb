class RLMRealmConfiguration
  class << self
    alias :default :defaultConfiguration
  end

  alias :schema_version :schemaVersion

  def schema_version=(new_version)
    self.schemaVersion = new_version
  end

  def self.migrate_to_version(version, &block)
    config = self.default
    config.schema_version = version

    config.migrationBlock = block
    RLMRealmConfiguration.setDefaultConfiguration(config)
  end
end