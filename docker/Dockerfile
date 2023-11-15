FROM ruby:2.5.1

ENV APP_HOME /zion

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

RUN apt-get update -y && \
    apt-get install -y \
    sudo \
    gcc \
    g++ \
    make \
    build-essential \
    libpq-dev \
    cmake \
    nodejs \
    vim \
    git

RUN apt update -y && apt install postgresql-client -y

RUN adduser zion 

RUN echo "zion ALL=(root) NOPASSWD:ALL" >> /etc/sudoers

USER zion

WORKDIR $APP_HOME

COPY Gemfile* .

RUN gem install bundler -v 2.3.26 \
    && bundle install --jobs 3
