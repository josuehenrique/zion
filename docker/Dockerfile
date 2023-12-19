FROM ruby:2.5.5-buster
LABEL maintainer="Josué Henrique Ferreira da Silva"

ENV APP_HOME /zion
ENV BUNDLE_PATH /gems
ENV PATH $BUNDLE_PATH/bin:$GEM_HOME/gems/bin:./node_modules/.bin:$PATH

# Persist bash history between sessions
RUN mkdir /commandhistory
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
  && echo $SNIPPET >> "/root/.bashrc"

# add pg repository
RUN echo "deb http://apt.postgresql.org/pub/repos/apt buster-pgdg main" > /etc/apt/sources.list.d/pgdb.list && \
    curl -k https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

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
    postgresql-client-11

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
