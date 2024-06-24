# Install NVM (Node Version Manager) and Node.js
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bash_profile
nvm install --lts

# Add NodeSource repository and install Node.js
curl -sL https://deb.nodesource.com/setup_19.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt update
sudo apt install -y nodejs

# Install necessary dependencies
sudo apt install -y python-software-properties python g++ make ruby ruby-dev ruby-railties postgresql postgresql-contrib imagemagick ghostscript libpq-dev libffi-dev

# Install yarn globally
sudo npm install -g yarn

# Clone Coursemology repository and set up
git clone https://github.com/Coursemology/coursemology2.git
cd coursemology2/
git submodule update --init --recursive

# Install Ruby gems and Node packages
gem install bundler:2.2.33
bundle config set --local without 'ci:production'
bundle install
cd client && yarn; cd -

# Set up the database
bundle exec rake db:setup

# Start the application using Foreman
gem install foreman
foreman start

# Build client assets
cd client && yarn build:development
cd client && yarn build:test

# Set default host in configuration
new_host='vntest.com'
sed -i "s/config.x.default_host = '.*'/config.x.default_host = '$new_host'/g" config/application.rb
bundle config set --local path 'vendor/bundle'

# Start and enable PostgreSQL service
sudo systemctl stop postgresql.service
sudo systemctl start postgresql.service
sudo systemctl enable postgresql.service

# Add PostgreSQL user
sudo -u postgres psql -c "SELECT usename FROM pg_user WHERE usename = 'admin';"
sudo -u postgres psql -c "CREATE USER postgres WITH PASSWORD 'password';"
sudo -u postgres psql -c "ALTER USER postgres WITH SUPERUSER;"

# Add Yarn package repository and install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn

# Update RubyGems and install necessary gems
gem update --system
gem update
gem install foreman thor -v 1.0.0 fiddle

# Clean up unnecessary gems
gem cleanup fiddle
