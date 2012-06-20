class BaseClient
  def initialize(config=YAML.load_file("config/settings.yml"))
    @config = config
  end
  def send_massage(message)
  end
end
