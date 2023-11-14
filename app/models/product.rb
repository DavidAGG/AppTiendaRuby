class Product < ApplicationRecord
    include PgSearch::Model
    pg_search_scope :search_full_text, against: {
        title: 'A',
        description: 'B',
    }

    #CONSTANTE 
    ORDER_BY = {
        newest: "created_at DESC",
        expensive: "price DESC",
        cheapest: "price ASC"
    }

    has_one_attached :photo
    
    validates :title, presence: true #SIGNIFICA QUE TIENE QUE SER LLENADO ESTE CAMPO A FUERZAS
    validates :description, presence: true
    validates :price, presence: true

    has_many :favorites, dependent: :destroy
    #UN PRODUCTO PERTENECE A UNA CATEGORIA Y A UN USUARIO
    belongs_to :category
    belongs_to :user, default: -> {Current.user}

    def owner?
        user_id == Current.user&.id
    end

    def favorite!
        favorites.create(user: Current.user)
    end

    def unfavorite!
        favorites.find_by(user: Current.user).destroy
    end

    def favorite
        favorites.find_by(user: Current.user)
    end
end
