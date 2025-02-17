# frozen_string_literal: true

require 'mini_magick'
require 'open3'

class ImagePreviewService
  attr_reader :file, :logger

  def initialize(file, logger)
    @file = file
    @logger = logger
  end

  def create_preview
    begin
      if image_file?
        generate_image_preview
      elsif pdf_file?
        extract_images_from_pdf
      else
        logger.error('[ImagePreview]: Unsupported file format for preview')
      end
    rescue => e
      logger.error("[ImagePreview]: Error generating preview: #{e.message}")
    end
  end

  private

  def image_file?
    %w[jpg jpeg png gif bmp].include?(file.split('.').last.downcase)
  end

  def pdf_file?
    file.split('.').last.downcase == 'pdf'
  end

  def generate_image_preview
    image = MiniMagick::Image.open(file)
    preview_file = "#{file.split('.').first}.preview.png"
    image.resize '200x200'
    image.write(preview_file)
    logger.info("[ImagePreview]: Success! #{preview_file}")
  end

  def extract_images_from_pdf
    logger.info("[ImagePreview]: Extracting images from PDF #{file}")

    output_file_prefix = File.join(File.basename(file, '.pdf'))
    command = "pdfimages -j #{file} #{output_file_prefix}"
    stdout, stderr, status = Open3.capture3(command)

    if status.success?
      logger.info("[ImagePreview]: Successfully extracted images to #{output_directory}")
    else
      logger.error("[ImagePreview]: Failed to extract images from PDF: #{stderr}")
    end
  end
end
