class AddCategoryToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :category, null: true, foreign_key: true
    #CATEGORY ERA NULL: FALSE PERO PARA PODER MIGRAR LO PUSE TRUE
  end
end
