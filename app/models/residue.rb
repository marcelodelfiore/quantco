class Residue
  include Mongoid::Document
  store_in database: 'cointegracao'
  field :desvio, type: Float
  field :periodo, type: Integer
  field :data_inicial, type: String
  field :media, type: Float
  field :ativo_indep, type: String
  field :ativo_dep, type: String
  field :residuos, type: Array
  store_in collection: 'Residues'

  def data=(value)
    self.data_inicial = ("%04d" % value.year) + ("%02d" % value.month) + ("%02d" % value.day)
  end

  def data
    ano = data_inicial[0..3]
    mes = data_inicial[4..5]
    dia = data_inicial[6..7]
    Date.strptime("#{ano}-#{mes}-#{dia}", '%Y-%m-%d')
  end

  def pair
    Pair.where(ativo_indep: ativo_indep, ativo_dep: ativo_dep, data_inicial: data_inicial, periodo: periodo).first
  end


  def to_chart
    start_date = (self.periodo-1).business_days.before(self.data)
    residues = []
    desvio = []
    self.residuos.reverse.each_with_index do |residuo,index|
      date = index.business_days.after(start_date).to_time.to_i*1000
      residues << [date, residuo]
      desvio << [date,-2*self.desvio, 2*self.desvio]

    end
    {
      title: "Ativos (#{ativo_indep},#{ativo_dep}) - #{periodo} dias",
      residues: residues,
      desvio: desvio
    }
  end
end
