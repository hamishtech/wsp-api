class Api::V1::SpacesController < ApplicationController
  before_action :set_space, only: %i[update destroy]

  def index
    render json: @current_user.spaces
  end

  def create
    @space = Space.new(space_params)
    @space.user = @current_user

    if @space.save
      render json: @space
    else
      render json: { errors: @space.errors }, status: :unprocessable_entity
    end
  end

  def update
    @space.update(space_params)
    render json: @space
  end

  def destroy
    @space.destroy
    head :no_content
  end

  private

  def space_params
    params.require(:space).permit(:name, :icon)
  end

  def set_space
    @space = Space.find(params[:id])
    unless @space.is_editable_by_user?(@current_user)
      render json: { errors: { space: ['not owned by user'] } }, status: :forbidden
    end
  end
end
