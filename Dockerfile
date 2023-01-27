# syntax=docker/dockerfile:1
# Add a script to be executed every time the container starts.
FROM ruby:3.1.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install


ENV PATH /root/.yarn/bin:$PATH
ARG build_without
ARG rails_env


COPY . /rails_terraform_docker
WORKDIR /rails_terraform_docker
RUN gem install bundler
RUN bundle install

RUN RAILS_ENV=production NODE_ENV=production SECRET_KEY_BASE=not_set OLD_AWS_SECRET_ACCESS_KEY=not_set OLD_AWS_ACCESS_KEY_ID=not_set bundle exec rake assets:precompile
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
