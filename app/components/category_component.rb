# frozen_string_literal: true

class CategoryComponent < ViewComponent::Base
  attr_reader :category 

  def initialize(category: nil)
    @category = category
  end



  def title 
    category ? @category.name : t('.all')
  end

  def link 
    category ? products_path(category_id: @category.id) : products_path
  end

  def active?
    return true if !category && !params[:category_id] #El ! es un false
    category&.id == params[:category_id].to_i
  end 

  def background 
    active? ? "bg-gray-300" : "bg-gray-100"
  end

  def classes 
    " text-gray-600 px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-100 #{background}"
  end

end
