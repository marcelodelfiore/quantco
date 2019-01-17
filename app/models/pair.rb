class Pair
  include Mongoid::Document
  store_in database: 'cointegracao'
  field :nivel_confianca, type: Integer
  field :beta_tempo, type: Float
  field :periodo, type: Integer
  field :sinal_entrada, type: Integer
  field :beta_ativo_dep, type: Float
  field :data_inicial, type: String
  field :ADF_result, type: String
  field :meia_vida, type: String
  field :alfa, type: Float
  field :ativo_indep, type: String
  field :ativo_dep, type: String
  store_in collection: 'Pairs'

  scope :order, -> order { System::Mongoid::Orderable.new(self, order).apply }

  def search
    @search ||= ::System::ActiveRecord.none.search(params[:q])
  end

  def data=(value)
    self.data_inicial = ("%04d" % value.year) + ("%02d" % value.month) + ("%02d" % value.day)
  end

  def data
    ano = data_inicial[0..3]
    mes = data_inicial[4..5]
    dia = data_inicial[6..7]
    Date.strptime("#{ano}-#{mes}-#{dia}", '%Y-%m-%d')
  end

  def residue
    Residue.where(ativo_indep: ativo_indep, ativo_dep: ativo_dep, data_inicial: data_inicial, periodo: periodo).first
  end
end
