module RedmineUserVisibilityRoleOption
  module Patches
    module RolePatch
      def self.prepended(base)
        base.class_eval do
          unloadable

          unless const_defined?(:USERS_VISIBILITY_OPTIONS) && self::USERS_VISIBILITY_OPTIONS.any? { |option| option[0] == 'all_all' }
            self::USERS_VISIBILITY_OPTIONS << ['all_all', :label_users_visibility_all_all]
          end
          _validators.clear

          _validate_callbacks.each do |callback|
            if callback.filter.is_a?(Symbol)
              skip_callback(:validate, callback.kind, callback.filter)
            else
              skip_callback(:validate, callback.kind, callback.filter, raise: false)
            end
          end
        end
      end
    end
  end
end

unless Role.included_modules.include?(RedmineUserVisibilityRoleOption::Patches::RolePatch)
  Role.prepend(RedmineUserVisibilityRoleOption::Patches::RolePatch)
end