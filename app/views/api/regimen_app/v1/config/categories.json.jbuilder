json.extract! @categories

json.response do
  json.status  'success'
  json.message 'OK'
  json.data @categories
end
