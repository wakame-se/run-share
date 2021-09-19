FROM ruby:2.6.5
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
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
RUN mkdir -p /run-share/tmp/sockets
RUN mkdir -p /run-share/tmp/pids
RUN touch /run-share/tmp/sockets/puma.sock