json.extract! customer, :id, :email, :name, :custid, :dob, :active, :notes, :created_at, :updated_at
json.url customer_url(customer, format: :json)
