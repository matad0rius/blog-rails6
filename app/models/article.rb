class Article < ApplicationRecord 
    # VALIDATIONS We need to put the restriction to create the article
    validates :title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum:10, maximum: 300}
end