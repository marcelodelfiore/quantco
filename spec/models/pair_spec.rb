require 'rails_helper'

RSpec.describe Pair, type: :model do
  describe 'tendo uma data nao normalizada' do
    let!(:pair) {create :pair, data_inicial: '20170226' }

    it 'deve conseguir carregar como normalizada' do
      expect(pair.data).to eq Date.new(2017, 02, 26)
    end

    it 'nao deve ser alterada pela leitura da normalizada' do
      expect(pair.data).to eq Date.new(2017, 02, 26)
      expect(pair.data_inicial).to eq '20170226'
    end

    it 'deve ser alterada ao salvar uma normalizada' do
      data = Date.current
      pair.data = data
      expect(pair.data_inicial).to eq ("%04d" % data.year) + ("%02d" % data.month) + ("%02d" % data.day)
    end
  end

  describe 'criando um par com residuo' do
    let!(:pair) {create :pair, :com_residuo }
    it 'deve conter um residuo do mesmo tamanho do periodo' do
      expect(pair.residue.residuos.count).to eq(pair.periodo)
    end
  end
end
