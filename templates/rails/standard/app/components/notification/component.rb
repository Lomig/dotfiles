# frozen_string_literal: true

class Notification::Component < ViewComponent::Base
  def initialize(type:, data:)
    @data = hasherize(data)

    @icon_name = icon_name(type)
    @icon_color = icon_color(type)

    @data[:timeout] ||= 3
  end

  private

  def hasherize(data)
    return { title: data } unless data.is_a?(Hash)

    data
  end

  def icon_name(type)
    case type
    when 'success' then 'tasklist'
    when 'error'   then 'stop'
    when 'alert'   then 'report'
    else                'info'
    end
  end

  def icon_color(type)
    case type
    when 'success' then 'text-green-400'
    when 'error'   then 'text-red-800'
    when 'alert'   then 'text-red-400'
    else                'text-gray-400'
    end
  end
end
