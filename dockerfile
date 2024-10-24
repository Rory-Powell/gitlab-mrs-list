# Use an official Ruby runtime as a parent image
FROM ruby:3.1.2

# Set the working directory inside the container to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install the specific version of bundler
RUN gem install bundler:2.3.15

# Install any needed packages specified in Gemfile
RUN bundle install

# Make port 4567 available to the world outside this container
EXPOSE 4000

# Define environment variable
ENV NAME GitlabMRsList

# Run `make web` when the container launches
CMD ["make", "web"]
