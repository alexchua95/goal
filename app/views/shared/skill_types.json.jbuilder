json.skill_types @skill_types do |skill_type|
  json.id skill_type.id.to_s
  json.(skill_type, :name)
end

