class Api::V1::LinksController < ApplicationController
  before_action :set_link, only: %i[update destroy]
  before_action :set_bucket

  def create
    @link = Link.new(link_params)
    @link.bucket = @current_bucket

    if @link.save
      render json: @link
    else
      render json: { errors: @link.errors }, status: :unprocessable_entity
    end
  end

  def update
    @link.update_attributes(link_params)
    render json: @link
  end

  def destroy
    @link.destroy
    head :no_content
  end

  private

  def link_params
    params.require(:link).permit(:url, :comment, :name, :bucket_id)
  end

  def set_link
    @link = Link.find_by_slug!(params[:id])
    unless @link.is_editable_by_user(@current_user)
      render json: { errors: { link: ['not owned by user'] } },
             status: :forbidden
    end
  end

  def set_bucket
    @current_bucket = Bucket.find(link_params['bucket_id'])
  end
end
