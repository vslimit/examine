class Category < ActiveRecord::Base
  attr_accessible :code, :name, :pid, :level

  has_many :subjects
  FIRST_LEVEL = 1

  class << self
     def has_child(id)
       Category.count(:conditions => {:pid => id}) > 0
     end
  end

  def parent_category
    Category.find(self.pid) unless self.pid == 0
  end

  def level_value
    self.level = self.pid == 0 ? FIRST_LEVEL : parent_category.level + 1
  end

end
