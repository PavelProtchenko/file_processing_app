# frozen_string_literal: true

require 'pdf-reader'

class PDFExtractorService
  attr_reader :file, :logger
  def initialize(file, logger)
    @file = file
    @logger = logger
  end

  def extract_text
    begin
      if pdf_file?
        extract_text_from_pdf
      else
        logger.error('[PDFExtractor]: Text extraction is supported only for PDF files')
      end
    rescue => e
      logger.error("[PDFExtractor]: Error extracting text: #{e.message}")
    end
  end

  private

  def pdf_file?
    file.split('.').last.downcase == 'pdf'
  end

  def extract_text_from_pdf
    reader = PDF::Reader.new(file)
    text = reader.pages.map(&:text).join("\n")
    text_file = "#{file.split('.').first}.txt"
    File.write(text_file, text)
    logger.info("[PDFExtractor]: Text extracted and saved to #{text_file}")
  end
end
