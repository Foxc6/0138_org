json.extract! @config_data

json.response do
  json.status  'success'
  json.message 'OK'
  json.data @config_data
end
