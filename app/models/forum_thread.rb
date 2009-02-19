class ForumThread < ActiveRecord::Base
  has_many :forum_posts
  belongs_to :user
  attr_accessible :title  # < what the update is limited to updating, user isn't taken from the form so it's safe
end
