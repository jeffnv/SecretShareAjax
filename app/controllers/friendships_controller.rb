class FriendshipsController < ApplicationController
  before_filter :require_current_user!

  def create
    current_user.out_friendships.create!(in_friend_id: params[:user_id])

    head :ok
  end

  def destroy
    current_user.out_friendships.where(in_friend_id: params[:user_id]).first!.destroy

    head :ok
  end
end
