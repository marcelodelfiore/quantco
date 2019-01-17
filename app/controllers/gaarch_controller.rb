class GaarchController < ApplicationController
  def index
    ultima_data = Gaarch.order(date: 'asc').last.date
    @current_date = ultima_data
    conditions = params[:q] || {}
    conditions = {date_eq: ultima_data}.merge(conditions)
    @q = Gaarch.ransack(conditions)
    @q.sorts = ['stock'] if @q.sorts.empty?
    @gaarch = @q.result(distinct: true).page(params[:page])
  end
  
  def search
    index
    render :index
  end
end
