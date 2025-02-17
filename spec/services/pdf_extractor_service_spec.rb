# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/services/pdf_extractor_service'

RSpec.describe PDFExtractorService do
  let(:logger) { double("Logger") }
  let(:file) { "test-file.pdf" }
  let(:pdf_extractor) { PDFExtractorService.new(file, logger) }

  describe "#extract_text" do
    context "when the file is a PDF" do
      it "extracts text and saves it to a text file" do
        allow(File).to receive(:write)

        pdf_reader = double("PDF::Reader")
        allow(PDF::Reader).to receive(:new).with(file).and_return(pdf_reader)
        allow(pdf_reader).to receive_message_chain(:pages, :map).and_return(["Sample text"])
        allow(logger).to receive(:info)

        expect { pdf_extractor.extract_text }.to_not raise_error
        expect(File).to have_received(:write).with("test-file.txt", "Sample text")
        expect(logger).to have_received(:info).with("[PDFExtractor]: Text extracted and saved to test-file.txt")
      end
    end

    context "when the file is not a PDF" do
      let(:file) { "test-image.jpg" }
      let(:image_extractor) { PDFExtractorService.new(file, logger) }

      it "logs an error" do
        allow(logger).to receive(:error)

        expect { image_extractor.extract_text }.to_not raise_error
        expect(logger).to have_received(:error).with("[PDFExtractor]: Text extraction is supported only for PDF files")
      end
    end
  end
end
