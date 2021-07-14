module AuthorsHelper
  def number_of_posts(author)
    if author.posts.count > 0
      author.posts.count
    else
      'None'
    end
  end
end
