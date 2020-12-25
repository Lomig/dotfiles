# frozen_string_literal: true

## For side-car components only
## <%= component :component_name %> if no ambiguity between components
## <%= component "namespace1/namespace2/component_name" %> to target a specific component
module ViewComponentHelper
  def component(name, context: nil, **args, &block)
    return component_class_from_name(name).new(args).render_in(context, &block) if context

    render(component_class_from_name(name).new(args), &block)
  end

  private

  def component_class_from_name(name)
    namespace = name.to_s
                    .split('/')

    component_path =  if namespace.count == 1
                        component_path_from_name(namespace.first)
                      else
                        namespace
                      end

    "#{ namespace_to_string(component_path) }::Component".constantize
  end

  def namespace_to_string(component_path)
    component_path.map(&:classify)
                  .join("::")
  end

  def component_path_from_name(component_name)
    Dir.glob(File.join(Rails.root, 'app', 'components', '**', component_name))
       .first
       .split("/")
       .drop_while { |item| item != "components"  }[1..-1]
  end
end
