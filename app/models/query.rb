class Query
  include Mongoid::Document
  field :sentence, type: String
  field :rating, type: Integer
  validates :sentence, presence: true, uniqueness: true
  validates :rating, presence: true
  before_validation :initialize_rating, if: :new_record?

  def increase_rating
    self.update_attribute :rating, self.rating + 1 if self.persisted?
  end

  protected
  def initialize_rating
    self.rating = 1
  end
end
