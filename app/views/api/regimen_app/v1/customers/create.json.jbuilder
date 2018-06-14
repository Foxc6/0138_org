json.extract! @data

json.response do
  json.status  @status
  json.message @message
  json.data @data if @data.present?
  json.customer_regimens @customer_regimens if @customer_regimens.present?
end

