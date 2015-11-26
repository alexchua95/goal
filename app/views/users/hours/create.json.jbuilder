json.id @hour.id.to_s
json.(@hour, :day, :open, :close)
json.edit_partial json.partial! partial: 'shared/hour.html.erb', locals: { hour: @hour }
json.new_partial json.partial! partial: 'shared/hour.html.erb', locals: { hour: Hour.new }
