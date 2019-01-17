class History
  include Mongoid::Document
  store_in database: 'cointegracao'
  field :data_inicial, type: String
  field :ativo_indep, type: String
  field :ativo_dep, type: String
  field :sinal_entrada, type: Integer
  store_in collection: 'PairsHistory'
end