json.id @hour.id.to_s
json.(@hour, :day, :open, :close)
json.partial json.partial! partial: 'shared/hour.html.erb', locals: { hour: Hour.new }
