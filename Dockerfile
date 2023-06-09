#1 This is the official Ruby image (https://hub.docker.com/_/ruby) - a complete Linux system with Ruby installed
FROM ruby:3.1.3

#2 Install applications needed for building Rails app
RUN apt-get update && apt-get install -y \
 build-essential libpq-dev nodejs zlib1g-dev liblzma-dev

#3 The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD
# If a directory doesn’t exist, it will be created
WORKDIR /app

#4 Copy files from current location to image WORKDIR
COPY . . 

#5 Install gems in the image
RUN bundle install

#RUN bundle exec rails db:migrate

#RUN bundle exec rails db:seed
#6 Command that will be executed when you run the image
CMD bundle exec rails s -p 3000 -b '0.0.0.0'
