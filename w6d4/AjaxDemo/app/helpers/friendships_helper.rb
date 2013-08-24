module FriendshipsHelper
  def friend?(user, cur_user_friendships)
    cur_user_friendships.each do |friendship|
      return true if user.id == friendship.friend_id
    end

    return false
  end
end
