require 'redmine'

Redmine::Plugin.register :redmine_tree_view do
  name 'Redmine Tree View plugin'
  author 'Onur Kucuk'
  description 'Redmine plugin to display tree view of some components'
  version '0.5'
  url 'http://www.ozguryazilim.com.tr'
  author_url 'http://www.ozguryazilim.com.tr'
  requires_redmine :version_or_higher => '3.0.0'

  menu :top_menu, :projects_tree_view, {
    :controller => 'projects_tree_view',
    :action => 'index'
  }, :caption => :projects_tree_view_title

end

