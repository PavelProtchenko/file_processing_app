# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/services/image_preview_service'

RSpec.describe ImagePreviewService do
  let(:logger) { double("Logger") }
  let(:file) { "test-image.jpg" }
  let(:image_preview) { ImagePreviewService.new(file, logger) }

  describe "#create_preview" do
    context "when the file is an image" do
      it "creates an image preview" do
        image = double("MiniMagick::Image")
      
        allow(MiniMagick::Image).to receive(:open).with(file).and_return(image)
        allow(image).to receive(:resize)
        allow(image).to receive(:write)
        allow(logger).to receive(:info)
        allow(logger).to receive(:error)
      
        expect { image_preview.create_preview }.to_not raise_error        
        expect(logger).to have_received(:info).with("[ImagePreview]: Success! test-image.preview.png")
      end
    end

    context "when the file type is unsupported" do
      let(:file) { "test-file.txt" }

      it "logs an error" do
        allow(logger).to receive(:error)

        expect { image_preview.create_preview }.to_not raise_error
        expect(logger).to have_received(:error).with("[ImagePreview]: Unsupported file format for preview")
      end
    end
  end
end
