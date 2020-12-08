FROM ruby:2.7.1

RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs

RUN apt-get install apt-transport-https
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

WORKDIR /documents/portfolio/payways
COPY Gemfile Gemfile.lock /documents/portfolio/payways/
RUN bundle install
COPY . /documents/portfolio/payways