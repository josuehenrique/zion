FROM ruby:2.5.1

ENV APP_HOME /zion

RUN apt update && apt install lsb-release -y
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list
RUN echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdb.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

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
    postgresql-client-12

# ADD PHANTOMJS
COPY spec/bin/phantomjs-2.1.1-linux-x86_64.tar.bz2 /usr/local/share/
RUN cd /usr/local/share/ && tar jxvf phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN ln -s /usr/local/share/phantomjs-2.1.1-linux-x86_64/ /usr/local/share/phantomjs
RUN ln -s /usr/local/share/phantomjs/bin/phantomjs /usr/local/bin/phantomjs

RUN adduser zion 

RUN echo "zion ALL=(root) NOPASSWD:ALL" >> /etc/sudoers

USER zion

WORKDIR $APP_HOME

COPY Gemfile* .

RUN gem install bundler -v 2.3.26 \
    && bundle install --jobs 3
