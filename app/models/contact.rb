class Contact < ActiveRecord::Base

  has_many :phones

  validates_presence_of :firstname, :lastname, :email
  validates_uniqueness_of :email

  def self.by_letter(letter)
    where("lastname like ?", "%#{letter}%").order(:lastname)
  end

  def name
    "#{firstname} #{lastname}"
  end

end
