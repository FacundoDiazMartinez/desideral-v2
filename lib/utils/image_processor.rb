module ImageProcessor
  extend ActiveSupport::Concern

  Rails.application.routes.default_url_options[:host] = Rails.application.credentials[:host]

  def to_url(attachment, only_path: true)
    Rails.application.routes.url_helpers.rails_representation_url(attachment)
  end

  class_methods do
    def has_image(name, size: [300, 300])
      has_one_attached name
      define_method "#{name}_url" do
        return nil unless send(name).attached?
        to_url(
          send(name)
            .variant(resize_to_limit: size)
            .processed, only_path: false,
        )
      end
    end

    def has_many_images(name, size: [300, 300])
      has_many_attached name
      define_method "#{name}_urls" do
        return nil unless send(name).attached?
        send(name).map { |image|
          to_url(image
            .variant(resize_to_limit: size)
            .processed, only_path: false)
        }
      end
    end
  end
end
