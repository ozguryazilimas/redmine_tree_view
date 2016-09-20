module ProjectsTreeViewHelper

  def rtv_render_project_nested_lists(projects, &block)
    s = ''

    if projects.any?
      ancestors = []
      original_project = @project

      projects.sort_by(&:lft).each do |project|
        # set the project environment to please macros.
        @project = project
        toggle_class = "rtv_children_of_#{project.parent.id}" if project.parent
        display_style = 'style="display:none;"' if project.parent

        if (ancestors.empty? || project.is_descendant_of?(ancestors.last))
          s << "<ul class='projects #{ ancestors.empty? ? 'root' : nil} #{toggle_class}' #{display_style}>\n"
        else
          ancestors.pop
          s << "</li>"

          while (ancestors.any? && !project.is_descendant_of?(ancestors.last))
            ancestors.pop
            s << "</ul></li>\n"
          end
        end

        classes = (ancestors.empty? ? 'root' : 'child')
        s << "<li class='#{classes}'><div class='#{classes}'>"

        if project.children.any?
          s << "<span class='rtv_project_toggle rtv_closed' data-toggle-target='rtv_children_of_#{project.id}'></span>"
        else
          s << "<span class='rtv_project_no_children'></span>"
        end

        s << h(block_given? ? capture(project, &block) : project.name)
        s << "</div>\n"

        ancestors << project
      end

      s << ("</li></ul>\n" * ancestors.size)
      @project = original_project
    end

    s.html_safe
  end

  def rtv_render_project_hierarchy(projects)
    rtv_render_project_nested_lists(projects) do |project|
      s = link_to_project(project, {}, :class => "#{project.css_classes} #{User.current.member_of?(project) ? 'my-project' : nil}")

      if project.description.present?
        s << content_tag('div', textilizable(project.short_description, :project => project), :class => 'wiki description rtv_project_no_children')
      end

      s
    end
  end

end

