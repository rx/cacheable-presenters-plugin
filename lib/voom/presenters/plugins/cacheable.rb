require_relative 'cacheable/component'

module Voom
  module Presenters
    module Plugins
      module Cacheable

        class Settings
          extend Dry::Configurable
          setting :cache_func, defined?(Rails) ? Rails.cache.method(:fetch) : nil
        end

        module DSLComponents
          def cache(key_or_collection, **attrs, &block)
            self << Cacheable::Component.new(key_or_collection, parent: self, **attrs, &block)
          end
        end

        module WebClientComponents
          def render_cacheable(comp, render:, components:, index:)
            render_proc = Proc.new { render.call :erb, :'components/render', locals: { components: comp.components, scope: nil } }

            if cache_func = Settings.config.cache_func
              cache_func.call comp.cache_key, comp.attribs, &render_proc
            else
              render_proc.call
            end
          end
        end

      end
    end
  end
end
