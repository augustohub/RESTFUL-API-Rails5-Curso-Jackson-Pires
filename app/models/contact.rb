class Contact < ApplicationRecord

  # Validations
  validates_presence_of :kind
  #validates_presence_of :address

  # Kaminari
  paginates_per 5

  # Associations
  belongs_to :kind # , optional: true
  has_many :phones
  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address, update_only: true

  def as_json(options = {})
    h = super(options)
    h[:birthdate] = (I18n.l(birthdate) unless birthdate.blank?)
    h
  end

  # def author
  #   'Jackson Pires'
  # end
  #
  # def kind_description
  #   kind.description
  # end
  #
  # def as_json(_options = {})
  #   super(
  #     root: true,
  #     methods: %i[kind_description author]
  #   )
  # end
end
