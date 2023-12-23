FROM ruby:3.1
ARG RUBYGEMS_VERSION=3.3.20
RUN mkdir /attendance
WORKDIR /attendance
COPY Gemfile /attendance/Gemfile
COPY Gemfile.lock /attendance/Gemfile.lock
RUN bundle install
COPY . /attendance

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
