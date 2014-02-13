#encoding:utf-8
module Manage
  module CategoriesHelper
    def datetime_text(datetime)
      datetime.localtime.strftime('%Y-%-m-%-d %H:%M:%S') unless datetime.nil?
    end

    #def date_text(date)
    #  date.localtime.strftime('%Y-%-m-%-d') unless date.nil?
    #end

    def category_list(first_option_text = '', level = Category::FIRST_LEVEL)
      categories = []
      categories.push [first_option_text, 0] unless first_option_text.blank?
      Category.where(level: level).all.each do |a|
        categories.push [a.name, a.id]
      end
      categories
    end

    def category_all_list
      categories = []
      Category.all.each do |a|
        categories.push [a.name, a.id]
      end
      categories
    end

  end
end