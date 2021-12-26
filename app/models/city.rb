class City < ApplicationRecord
  belongs_to :state,optional: true
  belongs_to :country
end
