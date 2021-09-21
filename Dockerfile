FROM ruby:2.6.5
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    vim
WORKDIR /run-share
ADD Gemfile /run-share/Gemfile
ADD Gemfile.lock /run-share/Gemfile.lock
RUN gem install bundler
RUN bundle install
ADD . /run-share
RUN mkdir -p tmp/sockets
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb", "-e", "production"]