require 'rails_helper'

RSpec.describe Residue, type: :model do
  describe 'criando um residuo a partir de um par' do
    let!(:pair) {create :pair, :com_residuo }

    it 'O par deve ser acessível do resíduo' do
      expect(pair.residue.pair).to eq(pair)
    end
  end

  describe 'carregando as informações para um gráfico' do
    let!(:residue) {create :residue, periodo: 6, residuos: [2,3,-2,-3,1,2.5], data: Date.new(2017,02,27)}


    it 'deve carregar o nome do gráfico' do
      chart = residue.to_chart
      expected = "Ativos (#{residue.ativo_indep},#{residue.ativo_dep}) - #{residue.periodo} dias"
      expect(chart[:title]).to eq expected
    end

    it 'deve carregar residuos do gráfico' do
      chart = residue.to_chart
      expected = [
        [Date.new(2017,02,20).to_time.to_i*1000,2.5],
        [Date.new(2017,02,21).to_time.to_i*1000,1],
        [Date.new(2017,02,22).to_time.to_i*1000,-3],
        [Date.new(2017,02,23).to_time.to_i*1000,-2],
        [Date.new(2017,02,24).to_time.to_i*1000,3],
        [Date.new(2017,02,27).to_time.to_i*1000,2]
      ]
      expect(chart[:residues]).to eq expected
    end

    it 'deve carregar o desvio do gráfico' do
      chart = residue.to_chart

      expected = [
        [Date.new(2017,02,20).to_time.to_i*1000,-residue.desvio,residue.desvio],
        [Date.new(2017,02,21).to_time.to_i*1000,-residue.desvio,residue.desvio],
        [Date.new(2017,02,22).to_time.to_i*1000,-residue.desvio,residue.desvio],
        [Date.new(2017,02,23).to_time.to_i*1000,-residue.desvio,residue.desvio],
        [Date.new(2017,02,24).to_time.to_i*1000,-residue.desvio,residue.desvio],
        [Date.new(2017,02,27).to_time.to_i*1000,-residue.desvio,residue.desvio]
      ]
      expect(chart[:desvio]).to eq expected
    end
  end
end
