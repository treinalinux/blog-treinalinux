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

