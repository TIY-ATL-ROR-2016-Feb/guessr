module Blog
  user = User.find(brit)
  user.posts.includes(:comments).map { |post| post.comments }

  class User < AR::Base
    has_many :posts
  end

  class Post < AR::Base
    belongs_to :user
    has_many :comments
  end

  class Comment < AR::Base
    belongs_to :user # the author
    belongs_to :post
  end
end




















module Guessr
  class Player < ActiveRecord::Base
    has_many :games
  end
end
