class PairsController < ApplicationController
  def index
    ultima_data = Pair.order(data_inicial: 'asc').last.data_inicial

    conditions = params[:q] || {}
    conditions = {data_inicial_eq: ultima_data}.merge(conditions)
    @q = Pair.ransack(conditions)
    @q.sorts = ['ativo_indep asc', 'ativo_dep', 'ADF_result'] if @q.sorts.empty?
    @pairs = @q.result(distinct: true).page(params[:page])
  end

  def search
    index
    render :index
  end
end
