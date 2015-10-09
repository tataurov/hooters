class GalleryItemImage < Image
  def image_params
    {
      small: '250x250>',
      main_image: '1024x1024>',
    }
  end
end