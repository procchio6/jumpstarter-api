class Project < ApplicationRecord
  include Filterable

  belongs_to :creator, class_name: :User, foreign_key: :user_id
  belongs_to :category
  has_many :pledges, dependent: :destroy
  has_many :backers, -> { distinct }, through: :pledges, source: :user
  has_many :comments, dependent: :destroy

  validates :name, :description, :funding_goal, :fund_by_date, presence: true
  validates :funding_goal, numericality: {greater_than_or_equal_to: 100}

  mount_base64_uploader :image, ImageUploader

  def self.by_category(category_id)
    where('category_id = ?', category_id)
  end

  def self.almost_funded
    active.joins(:pledges).group('projects.id')
      .having('SUM(amount)/projects.funding_goal >= 0.90 AND SUM(amount)/projects.funding_goal < 1')
  end

  def self.almost_over
    active.where("fund_by_date BETWEEN ? AND ?", Date.today, 2.days.from_now)
  end

  def self.active(*args)
    where("fund_by_date >= ?", Date.today)
  end

  def self.inactive(*args)
    where("fund_by_date < ?", Date.today)
  end

  def number_of_backers
    self.backers.count
  end

  def number_of_pledges
    self.pledges.count
  end

  def pledge_total
    self.pledges.sum(:amount)
  end

  def fully_funded?
    pledge_total > funding_goal
  end

  def percent_funded
    (pledge_total / funding_goal) * 100
  end

  def active?
    Date.today <= fund_by_date
  end

  def days_left
    if active?
      (fund_by_date - Date.today).to_i
    else
      0
    end
  end

end
