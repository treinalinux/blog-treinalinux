module PostsHelper
  def full_name(target)
    target.first_name.to_s + ' ' + target.last_name.to_s
  end
end
