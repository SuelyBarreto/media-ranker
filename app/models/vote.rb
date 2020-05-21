class Vote < ApplicationRecord

  belongs_to :user, counter_cache: true
  belongs_to :work, counter_cache: true
   
end
