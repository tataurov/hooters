class GirlsController < ApplicationController
  def show
    @girl = Girl.find_by_id(params[:id])
  end
end