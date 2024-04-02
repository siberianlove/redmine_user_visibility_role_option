module RedmineUserVisibilityRoleOption
  module Patches
    module PrincipalPatch
      def self.prepended(base)
        base.singleton_class.prepend(ClassMethods)
      end

      module ClassMethods
        def visible(user = nil)
          if user.nil?
            all
          else
            view_all = false
            view_all_active = false

            if user.memberships.any?
              view_all = user.memberships.any? { |m| m.roles.any? { |r| r.users_visibility == 'all_all' } }
              view_all_active = user.memberships.any? { |m| m.roles.any? { |r| r.users_visibility == 'all' } }
            else
              view_all = user.builtin_role.users_visibility == 'all_all'
              view_all_active = user.builtin_role.users_visibility == 'all'
            end

            if view_all
              all
            elsif view_all_active
              active
            else
              # keeps existing logic for self and members of visible projects
            end
          end
        end
      end
    end
  end
end

unless Principal.included_modules.include?(RedmineUserVisibilityRoleOption::Patches::PrincipalPatch)
  Principal.prepend(RedmineUserVisibilityRoleOption::Patches::PrincipalPatch)
end