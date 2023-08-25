FROM ruby:2.5
MAINTAINER phucdd@larion.com

# Install apt based dependencies required to run Rails as 
# well as RubyGems. As the Ruby image itself is based on a 
# Debian image, we use apt-get to install those.
RUN apt-get update \
  && apt-get install -y \
     build-essential \
     nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Configure the main working directory. This is the base 
# directory used in any further RUN, COPY, and ENTRYPOINT 
# commands.
RUN mkdir -p /app 
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install 
# the RubyGems. This is a separate step so the dependencies 
# will be cached unless changes to one of those two files 
# are made.
COPY Gemfile* ./ 
RUN gem install bundler -v 1.17.3 && bundle install --jobs 20 --retry 5

# Copy the main application.
COPY . ./

# Add sshd
RUN apt-get update \
  && apt-get install -y \
     openssh-server \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd
RUN echo 'root:testPDDO123' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo 'export GEM_HOME=/usr/local/bundle' >> /etc/profile
RUN echo 'export BUNDLE_APP_CONFIG=/usr/local/bundle' >> /etc/profile
RUN echo 'export PATH=$PATH:/usr/local/bundle' >> /etc/profile

EXPOSE 22
#CMD ["/usr/sbin/sshd", "-D"]

# Configure an entry point, so we don't need to specify 
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

# Expose port 3000 to the Docker host, so we can access it 
# from the outside.
EXPOSE 3000

# Setup default environment variables
ENV DB_HOST=localhost \
    DB_PORT=5432 \
    DB_USER=postgres \
    DB_PASS=postgres

# The main command to run when the container starts. Also 
# tell the Rails dev server to bind to all interfaces by 
# default.
CMD ["rails", "server", "-b", "0.0.0.0"]
