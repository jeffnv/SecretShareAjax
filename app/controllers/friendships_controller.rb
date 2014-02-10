class FriendshipsController < ApplicationController
  before_filter :require_current_user!

  def create
    current_user.out_friendships.create!(in_friend_id: params[:user_id])

    sleep(0.5)

    head :ok
  end

  def destroy
    current_user.out_friendships.where(in_friend_id: params[:user_id]).first!.destroy

    sleep(0.5)

    head :ok
  end
end
