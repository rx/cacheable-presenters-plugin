require 'voom/presenters/dsl/components/base'
require 'voom/presenters/dsl/components/mixins/common'

module Voom
  module Presenters
    module Plugins
      module Cacheable

        class Component < DSL::Components::Base
          include DSL::Components::Mixins::Common

          attr_reader :cache_key, :components

          def initialize(key_or_collection, **attrs, &block)
            super(type: :cacheable, **attrs, &block)

            @components = []
            @cache_key = build_cache_key(key_or_collection)

            expand!
          end

          private

          def build_cache_key(key)
            if key.respond_to?(:map)
              key.map { |k| build_cache_key(k) }.join('-')
            elsif key.respond_to?(:cache_key)
              key.cache_key
            else
              key.to_s
            end
          end

        end

      end
    end
  end
end
