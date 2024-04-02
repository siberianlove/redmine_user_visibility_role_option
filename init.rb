require_dependency File.join(File.dirname(__FILE__), 'lib/redmine_user_visibility_role_option/patches/principal_patch')
require_dependency File.join(File.dirname(__FILE__), 'lib/redmine_user_visibility_role_option/patches/role_patch')

Redmine::Plugin.register :my_custom_changes do
  name 'Redmine User Visibility Role Option'
  author 'siberianlove'
  description 'TODO'
  version '0.0.1'
  url 'https://github.com/siberianlove/redmine_user_visibility_role_option'
end