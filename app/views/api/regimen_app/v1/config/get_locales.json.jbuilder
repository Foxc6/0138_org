json.extract! @locales

json.response do
  json.status  'success'
  json.message 'OK'
  json.data do
  json.array!(@locales) do |locale|
    json.code locale.code
    json.name locale.name
    json.fb_locale locale.fb_locale
  end
  end
end
