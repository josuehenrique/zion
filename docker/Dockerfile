FROM ruby:2.5.1

ENV APP_HOME /zion

RUN apt-get update -y && apt-get install sudo -y

RUN adduser zion 
RUN echo "zion ALL=(root) NOPASSWD:ALL" >> /etc/sudoers

USER zion

RUN sudo apt-get install postgresql-client -y

RUN sudo mkdir $APP_HOME

WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

RUN gem install bundler \
    && bundle install --jobs 3

ADD . $APP_HOME

RUN gem install bundler && bundle install 
