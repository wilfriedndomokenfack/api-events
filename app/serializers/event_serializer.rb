class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, 
        :description,  
        :start_date, 
        :end_date, 
        :start_time, 
        :end_time, 
        :user_id
end
