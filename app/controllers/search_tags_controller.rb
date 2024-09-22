class SearchTagsController < ApplicationController
  def index
    tags = ActsAsTaggableOn::Tag.where("name LIKE ?", "%#{params[:q]}%").limit(5).pluck(:name)
    render json: tags
  end
end
