class Image < ActiveRecord::Base
  IMAGE_CONTENT_TYPES = %w(image/jpeg image/jpg image/png).freeze

  belongs_to :imageable, :polymorphic => true, :touch => true

  has_attached_file :image, styles: lambda { |a| a.instance.image_params }

  validates_attachment :image, :presence => true,
                       :content_type => { :content_type => IMAGE_CONTENT_TYPES }

  def image_params
    {
      main_image: '600x600#'
    }
  end

  def download_from_url(url)
    self.image = URI.parse(url)
  end

  alias_method :url, :image
end
