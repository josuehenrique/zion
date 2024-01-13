#!/bin/bash
PORT=${PORT:-"3000"}

if [ "$LOAD_SCHEMA" = "true" ]; then
    echo "Will load DB schema"
    bundle exec rake db:create db:schema:load db:migrate
else
    echo "Will migrate DB schema"
    bundle exec rake db:migrate #Should always run in production
fi

bundle exec puma -p $PORT -C /zion/config/puma.rb
