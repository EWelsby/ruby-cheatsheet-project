class ForumPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum_thread
  attr_accessible :content  # < what the update is limited to updating, user isn't taken from the form so it's safe
end

