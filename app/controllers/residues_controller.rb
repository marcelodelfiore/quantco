class ResiduesController < ApplicationController
  def show
    @residue = Residue.find(params[:id])
    @chart_data = @residue.to_chart
  end
end
