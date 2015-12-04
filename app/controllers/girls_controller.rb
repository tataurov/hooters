class GirlsController < ApplicationController
  def index
    @girls = Girl.all
  end

  def show
    @girl = Girl.find_by_id(params[:id])
  end
end