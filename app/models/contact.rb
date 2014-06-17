require 'csv'

class Contact < ActiveRecord::Base
  has_many :phones
  accepts_nested_attributes_for :phones

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phones, length: { is: 3 }

  CSV_COLUMNS = %w( firstname, lastname, email )

  def self.to_csv
    CSV.generate do |csv|
      csv << CSV_COLUMNS
      all.each do |con|
        csv << [con.firstname,con.lastname,con.email]
      end
    end
  end

  def self.by_letter(letter)
    where("lastname LIKE ?", "#{letter}%").order(:lastname)
  end

  def name
    [firstname, lastname].join(' ')
  end
end
