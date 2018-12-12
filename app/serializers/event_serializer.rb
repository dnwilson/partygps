class EventSerializer #< ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :name, :description, :start_date, :end_date, :flyer, :thumbnail

  belongs_to :venue #, serializer: VenueSerializer

  def start_date
    object.start_dt
  end

  def end_date
    object.end_dt
  end

  def flyer
    object.photo.url
  end

  def thumbnail
    object.photo.thumb.url
  end
end
