FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn
RUN mkdir /run-share
WORKDIR /run-share
COPY Gemfile /run-share/Gemfile
COPY Gemfile.lock /run-share/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /run-share
RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids