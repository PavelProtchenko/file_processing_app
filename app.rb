# frozen_string_literal: true

require 'optparse'
require_relative 'app/file_processor'
require_relative 'app/services/app_logger_service'

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: ruby app.rb -f FILE -c COMMAND'

  opts.on('-fFILE', '--file=FILE', 'Input file') do |file|
    options[:file] = file
  end

  opts.on('-cCOMMAND', '--command=COMMAND', 'Command: preview, text, all') do |command|
    options[:command] = command
  end
end.parse!

command = options[:command] || 'all'
file = options[:file]

if file.nil?
  puts 'File option is required!'
  exit(1)
end

processor = FileProcessor.new(file, command)
processor.process
