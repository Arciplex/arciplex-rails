class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :noteable, polymorphic: true
end
