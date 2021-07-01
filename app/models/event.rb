class Event < ApplicationRecord
   scope :from_date, ->(from_date){
    where(
      'events.start_date::date >= ?', from_date
    )
  } 
  scope :to_date, ->(to_date){
    where(
      'events.start_date::date <= ?', to_date
    )
  }
end
