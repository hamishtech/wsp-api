class Api::V1::BucketsController < ApplicationController
  before_action :set_bucket, only: %i[update destroy]
  before_action :set_space

  def create
    @bucket = Bucket.new(bucket_params)
    @bucket.space = @current_space

    if @bucket.save
      render json: @bucket
    else
      render json: { errors: @bucket.errors }, status: :unprocessable_entity
    end
  end

  def update
    @bucket.update_attributes(bucket_params)
    render json: @bucket
  end

  def destroy
    @bucket.destroy
    head :no_content
  end

  private

  def bucket_params
    params.require(:bucket).permit(:name, :icon, :space_id)
  end

  def set_bucket
    @bucket = Bucket.find_by_slug!(params[:id])
    unless @bucket.is_editable_by_user(@current_user)
      render json: { errors: { bucket: ['not owned by user'] } },
             status: :forbidden
    end
  end

  def set_space
    @current_space = Space.find(params['space_id'])
  end
end
