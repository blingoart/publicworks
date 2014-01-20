class Newsletter < ActiveRecord::Base

  attr_accessible :email

  validates :email,
            :presence => {:message => "Please enter your email address."},
            :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Please check your email address."}

  def is_unique?
    count = Newsletter.where(:email => email).count
    if count == 0
      true
    else
      false
    end
  end

end
