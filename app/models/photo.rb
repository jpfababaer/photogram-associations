# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#

class Photo < ApplicationRecord
  validates(:poster, { :presence => true })

  # Association accessor methods to define:
  
  ## Direct associations

  #2 Photo#comments: returns rows from the comments table associated to this photo by the photo_id column. SEARCH like.rb
  has_many(:comments, class_name: "Comment", foreign_key: "photo_id")

  #4 Photo#likes: returns rows from the likes table associated to this photo by the photo_id column
  has_many(:likes, foreign_key:"photo_id")

  #5 Photo#poster: returns a row from the users table associated to this photo by the owner_id column
  belongs_to(:poster, class_name:"User", foreign_key:"owner_id")
  
  ## Indirect associations

  #8 Photo#fans: returns rows from the users table associated to this photo through its likes

  has_many(:fans, through: :likes, source: :fan)

  #9 Photo#commenters

  has_many(:commenters, through: :comments, source: :user)

  #10 Photo#fan_list

  def fan_list
    my_fans = self.fans

    array_of_usernames = Array.new

    my_fans.each do |a_user|
      array_of_usernames.push(a_user.username)
    end

    formatted_usernames = array_of_usernames.to_sentence

    return formatted_usernames
  end
end
