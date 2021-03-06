class User < ActiveRecord::Base
  # validate presence of username and password and username uniqueness
  validates_presence_of :username, :password

  validates :username, { uniqueness: {message: "That username is taken. Please enter another."}}

  # validate password confirmation
  validates :password, {confirmation: true}
  
  # both posts and comments belong to user, are destroyed when user is destroyed
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  # define Paperclip avatar sizes and validations 
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :default_url => "/images/:style/coffee_cup.jpg"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
    validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]
    do_not_validate_attachment_file_type :avatar
end
