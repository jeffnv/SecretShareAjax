class Friendship < ActiveRecord::Base
  attr_accessible :in_friend_id, :out_friend_id

  validates :in_friend_id, :out_friend_id, :presence => true
  validates :out_friend_id, :uniqueness => { :scope => :in_friend_id }

  def self.can_friend?(u1_id, u2_id)
    return false if u1_id == u2_id

    !Friendship.exists?(out_friend_id: u1_id, in_friend_id: u2_id)
  end

  def self.can_unfriend?(u1_id, u2_id)
    return false if u1_id == u2_id

    Friendship.exists?(out_friend_id: u1_id, in_friend_id: u2_id)
  end
end
