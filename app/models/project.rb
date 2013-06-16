class Project < ActiveRecord::Base
  belongs_to :starter, :class_name =>"Account", :foreign_key =>"started_by_id"
  belongs_to :leader, :class_name =>"Account", :foreign_key =>"leaded_by_id"
  has_many :tasks
end
