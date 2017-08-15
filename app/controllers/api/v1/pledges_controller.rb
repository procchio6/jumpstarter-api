class Api::V1::PledgesController < ApplicationController
  before_action :set_pledge, only: [:show, :update, :destroy]

  def index
    @pledges = Pledge.all

    render json: @pledges
  end

  def show
    render json: @pledge
  end

  def create
    @pledge = Pledge.new(pledge_params)
    @pledge.user = current_user

    if @pledge.save
      render json: @pledge, status: :created
    else
      render json: @pledge.errors, status: :unprocessable_entity
    end
  end

  def update
    if @pledge.update(pledge_params)
      render json: @pledge
    else
      render json: @pledge.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @pledge.destroy
  end

  private

    def set_pledge
      @pledge = Pledge.find(params[:id])
    end

    def pledge_params
      params.require(:pledge).permit(:user_id, :project_id, :amount)
    end
end
