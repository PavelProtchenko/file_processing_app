# frozen_string_literal: true

require_relative 'services/image_preview_service'
require_relative 'services/pdf_extractor_service'
require_relative 'services/app_logger_service'

class FileProcessor
  def initialize(file, command = 'all')
    @file = file
    @command = command
    @logger = AppLoggerService.create
  end

  def process
    case @command
    when 'preview'
      process_preview
    when 'text'
      process_text
    when 'all'
      process_preview
      process_text
    else
      puts 'Invalid command!'
    end
  end

  private

  def process_preview
    image_preview = ImagePreviewService.new(@file, @logger)
    image_preview.create_preview
  end

  def process_text
    pdf_extractor = PDFExtractorService.new(@file, @logger)
    pdf_extractor.extract_text
  end
end
