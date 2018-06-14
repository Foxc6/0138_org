json.extract! @regimens

json.response do
  json.status  'success'
  json.message 'OK'
  json.data do
  json.array!(@regimens) do |regimen|
    json.name regimen.name
  end
  end
end
