# frozen_string_literal: true

module Rails
  module Generators
    class ComponentGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      argument :attributes, type: :array, default: [], banner: "attribute"
      class_option :sidecar, type: :boolean, default: false
      check_class_collision suffix: "Component"

      def create_component_file
        if options["sidecar"]
          template "component.rb", File.join("app/components", class_path, file_name, "component.rb")
        else
          template "component.rb", File.join("app/components", class_path, "#{file_name}_component.rb")
        end
      end

      hook_for :test_framework

      hook_for :template_engine do |instance, template_engine|
        instance.invoke template_engine, [instance.name]
      end

      private
      def sidecared
        return "::" if options["sidecar"]
        ""
      end

      def file_name
        @_file_name ||= super.sub(/_component\z/i, "")
      end

      def parent_class
        defined?(ApplicationComponent) ? "ApplicationComponent" : "ViewComponent::Base"
      end

      def initialize_signature
        return if attributes.blank?

        attributes.map { |attr| "#{attr.name}:" }.join(", ")
      end

      def initialize_body
        attributes.map { |attr| "@#{attr.name} = #{attr.name}" }.join("\n    ")
      end
    end
  end
end
