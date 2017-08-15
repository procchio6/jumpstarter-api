class Api::V1::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  def index
    @categories = Category.all.order(name: :ASC)

    render json: @categories
  end

  def projects
    render json: Project.where("category_id = ?", params[:id])
  end

  def show
    render json: @category
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end


    def category_params
      params.require(:category).permit(:name)
    end
end
