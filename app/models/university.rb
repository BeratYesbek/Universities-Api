# == Schema Information
#
# Table name: universities
#
#  id         :bigint           not null, primary key
#  name       :string
#  city_id    :bigint           not null
#  country_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class University < ApplicationRecord
  belongs_to :city
  belongs_to :country
end
