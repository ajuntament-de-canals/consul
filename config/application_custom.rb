module Consul
  class Application < Rails::Application
    config.i18n.default_locale = :val
    config.i18n.available_locales = [:val, :es, :en]
  end
end
