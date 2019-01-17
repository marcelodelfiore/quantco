FactoryGirl.define do
  factory :residue do
    initialize_with { Residue.where(
      ativo_indep: ativo_indep,
      ativo_dep: ativo_dep,
      data_inicial: data_inicial,
      periodo: periodo)
      .first_or_initialize }

    _id { SecureRandom.hex }
    ativo_indep { FFaker::Company.name }
    ativo_dep { FFaker::Company.name }
    periodo { [100, 120, 140, 160, 180, 200].sample }
    data_inicial { Random.rand(2010...2020).to_s + Random.rand(1..12).to_s + Random.rand(1..31).to_s }
    residuos { periodo.to_i.times.map{ rand * 8 - 4 } }
    desvio { rand * 5 - 2.5  }
  end
end
