FROM ruby:3.3.2

WORKDIR /app

RUN apt-get update -qq && apt-get install -y \
  imagemagick \
  poppler-utils \
  && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

COPY Gemfile Gemfile.lock /app/

RUN bundle install

COPY . /app/

CMD ["ruby", "app.rb"]
