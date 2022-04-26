FROM ruby:2.5.1

ENV APP_HOME /zion

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

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
    git \
    postgresql-client

RUN adduser zion 

RUN echo "zion ALL=(root) NOPASSWD:ALL" >> /etc/sudoers

USER zion

WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

RUN gem install bundler \
    && bundle install --jobs 3
