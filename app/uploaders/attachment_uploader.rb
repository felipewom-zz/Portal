require 'carrierwave/processing/mime_types'
class AttachmentUploader < CarrierWave::Uploader::Base
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  include CarrierWave::MimeTypes

  process :set_content_type
  process :save_details_in_model

  def save_details_in_model
    model.content_type = file.content_type if file.content_type
    model.file_size = file.size
    model.file_name = file.filename
  end

  def store_dir
    "public/uploaders/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(zip rar pdf doc htm html docx xml xls xlsx ppt pps pptx txt jpg jpeg png)
  end

  def cache_dir
    '/tmp/portal_cto-cache'
  end
end