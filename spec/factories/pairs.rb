FactoryGirl.define do
  factory :pair do
    initialize_with { Pair.where(_id: _id).first_or_initialize }
    _id { SecureRandom.hex }
    ativo_indep { FFaker::Company.name }
    ativo_dep { FFaker::Company.name }
    periodo { [100, 120, 140, 160, 180, 200].sample }
    data_inicial { Random.rand(2010...2020).to_s + Random.rand(1..12).to_s + Random.rand(1..31).to_s }

    trait :com_residuo do
      after(:create) do |pair|
        create :residue, ativo_indep: pair.ativo_indep, ativo_dep: pair.ativo_dep, data_inicial: pair.data_inicial, periodo: pair.periodo
      end
    end
  end
end
