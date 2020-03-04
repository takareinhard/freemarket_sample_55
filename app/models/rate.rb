class Rate < ApplicationRecord
  belongs_to :user, optional: true
end
