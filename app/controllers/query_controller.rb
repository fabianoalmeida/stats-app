class QueryController < ApplicationController

  def index
    @query = Query.order_by rating: 'desc', sentence: 'asc'
  end

  def search
    if params[:sentence]
      QueryRatingWorker.perform_async(params[:sentence])
      redirect_to root_path, notice: "#{params[:sentence]} searched!" and return
    else
      redirect_to root_path
    end
  end

  def destroy_all
    if Query.all.count > 0
      Query.destroy_all
      redirect_to root_path, notice: "The statistics are clear!" and return
    else
      redirect_to root_path
    end
  end

  private
  def query_params
    params.require(:query).permit(:sentence)
  end
end
