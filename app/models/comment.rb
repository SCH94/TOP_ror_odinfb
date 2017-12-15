class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  default_scope { order(created_at: :asc) }
  validates :body, presence: true

  delegate :name, to: :user, prefix: true

  def date_print
    created_at.localtime.strftime("%b %-d %Y at " + "%l:%M%p".lstrip)
  end
end
