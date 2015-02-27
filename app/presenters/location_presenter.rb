class LocationPresenter

  def initialize(location, template)
    @location = location
    @template = template
  end

  def h
    @template
  end

  def photo
    photo = @location.photo? ? @location.photo.thumb  : 'default.svg' 
    h.image_tag(photo)
  end

  def infowindow
    "stuff"
  end
  
end