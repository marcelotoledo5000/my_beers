# frozen_string_literal: true

module RequestSpecHelper
  def json(body = response.body)
    JSON.parse(body, symbolize_names: true)
  end
end
