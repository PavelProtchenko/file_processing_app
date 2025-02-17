# frozen_string_literal: true

require 'logger'

class AppLoggerService
  def self.create
    Logger.new('app.log')
  end
end
