FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /todo_on_rails
COPY Gemfile /todo_on_rails/Gemfile
COPY Gemfile.lock /todo_on_rails/Gemfile.lock
RUN gem install bundler
RUN bundle install

ENV RAILS_ENV production
ENV RACK_ENV production

COPY . /todo_on_rails

CMD ["rails", "server"]