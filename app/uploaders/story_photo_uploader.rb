# encoding: utf-8

class StoryPhotoUploader < CarrierWave::Uploader::Base
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path(
      "fallback/" + [version_name, "default-user-pic.png"].compact.join('_'))
  end
end
