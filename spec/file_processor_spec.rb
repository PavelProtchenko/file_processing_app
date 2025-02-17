# frozen_string_literal: true

require 'spec_helper'
require_relative '../app/file_processor'
require_relative '../app/services/app_logger_service'
require_relative '../app/services/image_preview_service'
require_relative '../app/services/pdf_extractor_service'

RSpec.describe FileProcessor do
  let(:logger) { double("Logger") }
  let(:file) { "test-file.pdf" }

  before do
    allow(AppLoggerService).to receive(:create).and_return(logger)
  end

  describe "#process" do
    context "when the command is 'preview'" do
      it "delegates to ImagePreview to create preview" do
        image_preview = double("ImagePreview", create_preview: nil)
        allow(ImagePreviewService).to receive(:new).and_return(image_preview)

        processor = FileProcessor.new(file, "preview")
        processor.process

        expect(ImagePreviewService).to have_received(:new).with(file, logger)
        expect(image_preview).to have_received(:create_preview)
      end
    end

    context "when the command is 'text'" do
      it "delegates to PDFExtractor to extract text" do
        pdf_extractor = double("PDFExtractor", extract_text: nil)
        allow(PDFExtractorService).to receive(:new).and_return(pdf_extractor)

        processor = FileProcessor.new(file, "text")
        processor.process

        expect(PDFExtractorService).to have_received(:new).with(file, logger)
        expect(pdf_extractor).to have_received(:extract_text)
      end
    end

    context "when the command is 'all'" do
      it "delegates to both ImagePreview and PDFExtractor" do
        image_preview = double("ImagePreview", create_preview: nil)
        pdf_extractor = double("PDFExtractor", extract_text: nil)

        allow(ImagePreviewService).to receive(:new).and_return(image_preview)
        allow(PDFExtractorService).to receive(:new).and_return(pdf_extractor)

        processor = FileProcessor.new(file, "all")
        processor.process

        expect(image_preview).to have_received(:create_preview)
        expect(pdf_extractor).to have_received(:extract_text)
      end
    end
  end
end
