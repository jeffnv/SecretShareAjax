class SecretsController < ApplicationController
  before_filter :require_current_user!

  def new
    @secret = Secret.new
    @secret.recipient_id = params[:user_id]

    render :new
  end

  def create
    tag_ids = params[:secret].delete(:tag_ids)

    @secret = current_user.authored_secrets.new(params[:secret])

    tag_ids.each do |tag_id|
      @secret.secret_taggings.new(tag_id: tag_id)
    end

    if @secret.save
      redirect_to user_url(@secret.recipient_id)
    else
      render :new
    end
  end
end
