class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def login
    render json: {user_id:1, token:'test token'}
  end

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      created_jwt = issue_token({id: @user.id})

      render json: { id: @user.id, username: @user.username, token: created_jwt }, status: :created
    else
      render json: { errors: @user.errors.full_messages, status: :unprocessable_entity }
    end
  end

  def update
    if @user.update(user_params)
      render json: {
        user_id: @user
      }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:first_name, :last_name, :username, :email, :password)
    end
end
