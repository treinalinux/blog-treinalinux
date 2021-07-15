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

## Helper full_name created and implemented

```ruby

❯ vim app/helpers/posts_helper.rb                  

module PostsHelper
  def full_name(target)
    target.first_name.to_s + ' ' + target.last_name.to_s
  end
end


```

```ruby

...
  <%= post_form.label :author_id, 'Author' %>
  <%= post_form.select :author_id,
    Author.all.map { |a| [full_name(a), a.id] },
    selected: post.author_id %>
  <br></br>
...

```


## Working mailcatcher

```bash

# Install default 
❯ gem install mailcatcher

# If error use install with example
❯ gem install mailcatcher -- --with-cflags="-Wno-error=implicit-function-declaration"


# Start mailcatcher
❯ mailcatcher                                                                        
Starting MailCatcher

==> smtp://127.0.0.1:1025
==> http://127.0.0.1:1080/
*** MailCatcher runs as a daemon by default. Go to the web interface to quit.

```

**Help mailcatcher**

```bash
❯ mailcatcher --help
Usage: mailcatcher [options]
        --ip IP                      Set the ip address of both servers
        --smtp-ip IP                 Set the ip address of the smtp server
        --smtp-port PORT             Set the port of the smtp server
        --http-ip IP                 Set the ip address of the http server
        --http-port PORT             Set the port address of the http server
        --http-path PATH             Add a prefix to all HTTP paths
        --no-quit                    Don't allow quitting the process
        --[no-]growl
    -f, --foreground                 Run in the foreground
    -b, --browse                     Open web browser
    -v, --verbose                    Be more verbose
    -h, --help                       Display this help information

```

**Configure mailcatcher on environments development**

```ruby

vim config/environments/development.rb

...

   36   # Don't care if the mailer can't send.                                                    
   37   config.action_mailer.raise_delivery_errors = false                                        
   38                                                                                             
+  39   # config mailcatcher added                                                                
+  40   config.action_mailer.delivery_method = :smtp                                              
+  41                                                                                             
+  42   config.action_mailer.smtp_settings = { address: '127.0.0.1', port: 1025 }

...

```

## Configure send mail on Mailer

```ruby

❯ vim app/mailers/post_mailer.rb  

class PostMailer < ApplicationMailer
  def new_post
    @post = params[:post]
    mail(to: 'notification@post.com', subject: 'New post was created')
  end
end

```

**html and text**

```ruby

## In html

❯ vim app/views/post_mailer/new_post.html.erb 

<h1> Nova publicação </h1>

<p> Um novo post foi criado: </p>
<p><%= @post.title  %></p>


## In text

❯ vim app/views/post_mailer/new_post.text.erb 
Nova publicação

Um novo post foi criado:
<%= @post.title  %>

```


**Testing send mail**

```ruby
❯ rails c                         

irb(main):001:0> post = Post.first

irb(main):002:0> PostMailer.with(post: post).new_post.deliver_now
```

## Working Jobs

```bash
❯ rails generate job NewPostsNotification --queue notification

❯ vim  app/jobs/new_posts_notification_job.rb 

```

```ruby

class NewPostsNotificationJob < ApplicationJob
  queue_as :notification

  def perform(subscribers)
    posts = Post.where(publish_at: (Time.now - 1.week)..).select(:title)
    subscribers.each do |subscriber|
      SubscribersMailer.with(subscriber: subscriber, posts: posts)
        .new_posts.deliver_now
    end
  end
end

```

```bash

❯ rails generate mailer SubscribersMailer new_posts

❯ vim app/mailers/subscribers_mailer.rb

```

```ruby

class SubscribersMailer < ApplicationMailer
  def new_posts
    @posts = params[:posts]
    @subscriber = params[:subscriber]

    mail to: @subscriber[:email]
  end
end

```

```
❯ mailcatcher
```

```ruby

❯ rails c

irb(main):001:0> Post.update_all(publish_at: Time.now - 1.day)

irb(main):002:0> NewPostsNotificationJob.perform_later([{email: 'joao@gmail.com', name: 'Joao'}, {email: 'lucas@gmail.com', name: 'Lucas'}])

```
