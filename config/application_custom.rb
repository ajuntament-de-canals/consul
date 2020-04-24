module Consul
  class Application < Rails::Application
    config.i18n.default_locale = :va
    config.i18n.available_locales = [:va, :es, :en]
  end
end
