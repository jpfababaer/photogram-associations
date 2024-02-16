# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  photo_id   :integer
#

class Comment < ApplicationRecord
  validates(:commenter, { :presence => true })

  # Association accessor methods to define:
  
  ## Direct associations

  #1 Comment#commenter: returns a row from the users table associated to this comment by the author_id column. When we say belongs_to = Class (Many, i.e. Comment) belongs_to Query table (One) -> Many-to-One.
  belongs_to(:commenter, class_name: "User", foreign_key: "author_id")

  #1 Flow: we want to the method "commenter" on a Comment instance to query "User" table with the "author_id" FK to know who made the comment.

  #2 Comment#photo: returns a row from the photos table associated to this comment by the photo_id column
  # belongs_to(:photo, class_name: "Photo", foreign_key: "photo_id") Solution for #2 and #9. We just need ONE of these lines!

  #9 A User can comment on Many Photos and A Photo can have Many Users comment on it. 
  belongs_to(:photo, class_name:"Photo", foreign_key:"photo_id")
  belongs_to(:user)

 
end
