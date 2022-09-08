# Rails Ecommerce App

This is a basic Ecommerce API built with Rails

To install,

```
git clone https://github.com/mitchdmarino/Rails-Auth.git
```

Install all dependencies

```
bundle install
```

Create db and migrate schema

```
rake db:create
rake db:migrate
```

Add the admin user to the database. To login as an admin, use the email admin@admin.com, password: 12340987

```
rails db:seed
```

Now run your application

rails s

Authentication: JWT tokens created by Rails API
