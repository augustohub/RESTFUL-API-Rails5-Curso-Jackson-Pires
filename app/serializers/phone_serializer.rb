class PhoneSerializer < ActiveModel::Serializer
  attributes :id, :number

  # Associations
  belongs_to :contact do
    link(:related) { contact_phones_url(object.id) }
  end
end
