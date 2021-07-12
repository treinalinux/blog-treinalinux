# Blog Treina Linux

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
