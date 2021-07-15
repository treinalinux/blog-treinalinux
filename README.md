# Blog Treina Linux

Estou criando o projeto **Blog Treina Linux** com Ruby On Rails, isso é inicialmente um teste.

Pode se tornar um projeto oficial no futuro, no momento apenas realizando uma documentação de um projeto básico em Ruby on Rails.

## Creating the project

```
rails _6.1.3.2_ new blog-treinalinux
```

## Project dependencies

```
gem 'kaminari', '~> 1.2', '>= 1.2.1'
```

### Project dependencies for development

```
npm install -D git-commit-msg-linter
```


## Creating controller site

```
rails generate controller Site index
```

## Routes

List routes

```
# In web browser
http://localhost:3000/rails/info/routes

# In terminal
rails routes 
```


## Scaffold Author

```
rails generate scaffold Author first_name:string last_name:string description:string
```


## Creating model Address

```
rails generate model Address country:string state:string city:string district:string street:string number:string complement:string

# rails db:migrate
rails db:migrate
```

## Configured data validation

```ruby
class Author < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :last_name, presence: true
  validates :description, allow_nil: true, length: { maximum: 500 }
end
```

## Callback of Model

```ruby
class Author < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, allow_nil: true, length: { maximum: 500 }

  after_validation :titleize_last_name, if: Proc.new { |a| a.last_name.present? }, on: :create

  private

  # transforms to the first letters in capital
  def titleize_last_name
    self.last_name = last_name.titleize
  end
end
```

# Crud operations on rails console

```ruby
❯ rails console

# Create
irb(main):001:0> Author.create(first_name: 'Linus', last_name: 'Torvalds')


## Instance and only writes to the database
irb(main):002:0> author = Author.new
irb(main):003:0> author.first_name = 'Steve'
irb(main):004:0> author.last_name = 'Jobs'
irb(main):005:0> author.save


# Read
## Database query
irb(main):011:0> Author.all
irb(main):012:0> Author.all.length
irb(main):013:0> Author.all.count
irb(main):014:0> author = Author.find_by(first_name: 'Linus')
irb(main):015:0> author = Author.find_by(first_name: 'Linus', last_name: "Torvalds")

irb(main):016:0> authors = Author.where(last_name: 'Alves')
irb(main):017:0> authors = Author.where(last_name: 'Alves').count
irb(main):018:0> authors = Author.where(last_name: 'Alves')
irb(main):019:0> authors[0]
irb(main):020:0> authors[2]
irb(main):021:0> authors[3]

# Update
irb(main):022:0> silva = Author.find_by(first_name: "Alan", last_name: "Alves")
irb(main):023:0> silva.last_name = 'da Silva Alves'
irb(main):024:0> silva
irb(main):025:0> silva.save

irb(main):026:0> silva.update(last_name: 'Alves')


# Delete

irb(main):027:0> silva.destroy 
irb(main):028:0> Author.destroy_by(last_name: 'Alves')
irb(main):029:0> Author.destroy_all

```

## Associations in the model

```ruby

❯ rails console 

rails generate migration AddAuthorReferenceToAddress author:references 

❯ rails db:migrate 

❯ rails console  

irb(main):007:0> Author.all

irb(main):008:0> address.author

irb(main):002:0> author = Author.create(first_name: 'Linus', last_name: 'Torvalds')

irb(main):002:0> author = Author.create(first_name: 'Linus', last_name: 'Torvalds')

irb(main):003:0> address = Address.create(street: 'Rua 123', author: author)

irb(main):003:0> address = Address.create(street: 'Rua 123', author: author)

irb(main):007:0> author.address

irb(main):007:0> address.author


# after has_many

reload!

irb(main):007:0> author = Author.create(first_name: 'Linus', last_name: 'Torvalds')

irb(main):005:0> address = Address.create(street: 'Rua 123', author: author)

irb(main):006:0> author.addresses

```

## Automating tasks with seed

```
❯ vim db/seeds.rb
```

```ruby
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cadastrando a base de dados inicial...'
Author.create(first_name: 'Linus', last_name: 'Torvalds')
Author.create(first_name: 'Steve', last_name: 'Jobs')

```

```
❯ rails console 
```

```ruby

irb(main):001:0> Address.create(street: 'Rua do Linus')
irb(main):002:0> Author.first.update(first_name: 'Tio')

```

```

# db:reset or db:seed:replant
❯ rails db:reset
❯ rails db:seed:replant

❯ rails console

```

```ruby

irb(main):002:0> Address.all
irb(main):003:0> Author.first

```

## Creating model Post

```bash

rails generate model Post content:string publish_at:datetime author:references
rails generate migration AddTitleToPost title:string
rails db:migrate

```

Added validations on model Post

```
❯ cat app/models/post.rb
```

```ruby
class Post < ApplicationRecord
  belongs_to :author
  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :content, allow_nil: true
  validates :publish_at, allow_nil: true
end

```

Added **has_many :posts** on model Author

```
❯ cat app/models/author.rb
```

```ruby
class Author < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, allow_nil: true, length: { maximum: 500 }

  after_validation :titleize_last_name, if: Proc.new { |a| a.last_name.present? }, on: :create

  has_many :addresses, dependent: :destroy
  has_many :posts

  private

  # transforms to the first letters in capital
  def titleize_last_name
    self.last_name = last_name.titleize
  end
end

```

## Creating views with rails generate controller Posts

```ruby
❯ vim app/models/post.rb                                


class Post < ApplicationRecord
  belongs_to :author
  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
end
```

```
❯ rails generate controller Posts
```


```ruby
❯ vim app/controllers/posts_controller.rb 


class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
end
```

```ruby
❯ vim config/routes.rb  


Rails.application.routes.draw do
  resources :authors
  get 'site', to: 'site#index'
  root to: 'site#index'
  get '/posts', to: 'posts#index'
end

```

```ruby
❯ vim app/views/posts/index.html.erb


<h1>Posts</h1>

<% if @posts.size > 0 %>
  <% @posts.each do |post| %>
    <%= post.title %>
    </br>
  <% end  %>
<% else %>
    <p>No post registered</p>
<% end %>

```

```ruby
❯ rails console 

author = Author.first

Post.create(title: 'My first Kernel', author: author)

Post.create(title: 'My first Git', author: author)

```

## Creating and using helpers

Example of helpers

```ruby
❯ rails c      

irb(main):001:0> helper.number_to_human(1000000000000)
=> "1 Trillion"

```

**Creating helpers**

```ruby

❯ vim app/helpers/authors_helper.rb


module AuthorsHelper
  def number_of_posts(author)
    if author.posts.count > 0
      author.posts.count
    else
      'None'
    end
  end
end

```

**Using helper time_ago_in_words**

```ruby

❯ vim app/views/posts/index.html.erb

<h1>Posts</h1>

<% if @posts.size > 0 %>
  <table>
    <thead>
      <tr>
        <th>Title</th>
        <th>Created</th>
      </tr>
    </thead>
    <tbody>
      <% @posts.each do |post| %>
        <tr>
          <td><%= post.title %></td>
          <td><%= time_ago_in_words(post.created_at) %></td>
        </tr>
      <% end  %>
    </tbody>
  </table>
<% else %>
    <p>No post registered</p>
<% end %>

```

```ruby

❯ vim app/views/authors/index.html.erb


<p id="notice"><%= notice %></p>

<h1>Authors</h1>

<table>
  <thead>
    <tr>
      <th>First name</th>
      <th>Last name</th>
      <th>Description</th>
      <th>Posts</th>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% @authors.each do |author| %>
      <tr>
        <td><%= author.first_name %></td>
        <td><%= author.last_name %></td>
        <td><%= author.description %></td>
        <td><%= number_of_posts(author) %></td>
        <td><%= link_to 'Show', author %></td>
        <td><%= link_to 'Edit', edit_author_path(author) %></td>
        <td><%= link_to 'Destroy', author, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
</table>

<br>

<%= link_to 'New Author', new_author_path %>

```

# Working Partials


```ruby
❯ vim app/views/posts/new.html.erb

<%= render partial: 'form', locals: { post: @post } %>

```

## Adjusting controller posts

```ruby

❯ vim app/controllers/posts_controller.rb

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end

```

## Adjusting routes

```rudy

❯ vim config/routes.rb                            

Rails.application.routes.draw do
  resources :authors
  get 'site', to: 'site#index'
  root to: 'site#index'
  resources :posts
end

```

## Creating form of Partials

```ruby
❯ vim app/views/posts/_form.html.erb 


<%= form_with(model: post) do |post_form| %>
  <%= post_form.label :title %>
  <%= post_form.text_field :title %>

  <%= post_form.label :content %>
  <%= post_form.text_area :content, size: '60x10' %>

  <%= post_form.label :publish_at %>
  <%= post_form.datetime_local_field :publish_at %>

  <%= post_form.label :author_id, 'Author' %>
  <%= post_form.select :author_id,
    Author.all.map { |a| [a.first_name.to_s + ' ' + a.last_name.to_s, a.id] },
    selected: post.author_id %>
  <br></br>
  <%= post_form.submit %>
<% end %>

```

## create and update actions implemented

```ruby
...

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to '/posts'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to '/posts'
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :publish_at, :author_id)
  end

...

```
