class Post < ApplicationRecord

  attr_reader :short_form
  acts_as_votable

  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  validate :less_than_10_minutes_ago, on: :after_create

  validates :message, presence: true,
    length: { minimum: 1 }


  def less_than_10_minutes_ago
    if created_at > 10.minutes.ago
      true
    else
      false
    end
  end

  def abbreviated
    short_form = self.message[0..140]
    if self.message.length > 140
      short_form += "..."
    else
      short_form
    end
  end
end
