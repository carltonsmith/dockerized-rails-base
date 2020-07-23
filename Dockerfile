FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /tanf
WORKDIR /tanf
COPY Gemfile /tanf/Gemfile
COPY Gemfile.lock /tanf/Gemfile.lock
RUN bundle install
RUN yarn install
RUN rake assets:precompile
COPY . /tanf

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
