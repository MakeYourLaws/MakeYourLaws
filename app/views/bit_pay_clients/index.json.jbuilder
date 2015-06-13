json.array!(@bit_pay_clients) do |bit_pay_client|
  json.extract! bit_pay_client, :id, :api_uri
  json.url bit_pay_client_url(bit_pay_client, format: :json)
end
