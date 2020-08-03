# README

P2P

# About

P2P is created to enable user to get a loan for the purposes he/she needs with help of other users.

# Compatibility

* Ruby 2.6.3
* Ruby on Rails 5.2.4
* PostgresSQL 12.3

#Installation

1. Setup PostgrSQL:

https://www.digitalocean.com/community/tutorials/postgresql-ubuntu-16-04-ru

2. Install ruby:

https://rvm.io/rvm/install

```sh
  $ rvm install 2.6.3
```

3. Clone repository:

git clone https://github.com/M1ha11/P2P.git

4. In your project directory:

```sh
  $ bundle install
  $ rake db:create
  $ rake db:migrate
  ```

# Test Coverage

```sh
$ xdg-open coverage/index.html
```
