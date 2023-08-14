FROM ruby:3.1.2-alpine

LABEL Name=smartsw-ruby Version=3.1

WORKDIR /app

RUN gem update bundler

RUN apk --update --upgrade --no-cache add \
  build-base \
  libpq-dev \
  tzdata \
  nodejs \
  postgresql-dev

RUN apk --update add less

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
