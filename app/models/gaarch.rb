class Gaarch
  include Mongoid::Document
  field :stock, type: String
  field :date, type: String
  field :annual_gaarch_vol, type: Float
  field :daily_gaarch_vol, type: Float
  field :annual_narrow_gaarch_vol, type: Float
  field :daily_narrow_gaarch_vol, type: Float 
  store_in collection: 'DailyGaarch'
end