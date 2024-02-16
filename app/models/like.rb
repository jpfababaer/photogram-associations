# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  photo_id   :integer
#

class Like < ApplicationRecord
  validates(:fan, { :presence => true })
  validates(:photo, { :presence => true })
  validates(:photo_id, { 
    :uniqueness => { :scope => [:fan_id] }
  })

  # Association accessor methods to define:
  
  ## Direct associations

  #3 Like#fan: returns a row from the users table associated to this like by the fan_id column
  belongs_to(:fan, class_name: "User", foreign_key:"fan_id")

  #4 Like#photo: returns a row from the photo table associated to this like by the photo_id column
  belongs_to(:photo, foreign_key: "photo_id")
  
  #8 A User has Many liked Photos AND A Photo has Many fans. 

  # belongs_to(:photo) Check #4 above. It's basically the same code. We just need to make the association ONCE!
  # belongs_to(:fan, class_name:"User", foreign_key:"fan_id") Check #3 above. It's basically the same code. We just need to make the association ONCE! (even if it's solving a different rake grade problem)
 

end
