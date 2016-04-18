web: bundle exec rails server -p $PORT
rpush: bundle exec rpush start -e $RACK_ENV -f
worker: bundle exec sidekiq start -e $RACK_ENV -C config/sidekiq.yml

