json.universities @universities.each do |university|
  json.name university.name
  json.country university.country
  json.city university.city
  json.state university.city.state
end


