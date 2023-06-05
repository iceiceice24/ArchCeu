# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

Installing the Windows Subsystem for Linux:
Step 1 - Open Powershell and run: wsl --install -d Ubuntu

Step 2 - Reboot your computer to finish the installation.
Once initial setup is finished, you will be prompted to create a username and password for your Ubuntu install.

Installing Ruby
Step 1: The first step is to install dependencies for compiling Ruby. Open your Terminal and run the following commands to install them.

sudo apt-get update
sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev

Step 2: Install rbenv
Now we will install rbenv and set the appropriate environment variables. Use the following set of commands to get rbenv for git repository.

git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH = "$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH = "$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' << ~/.bash_profile
exec $SHELL

Step 3: Install Ruby
Before installing Ruby, determine which version of Ruby you want to install. We will install Ruby 2.2.3. Use the following command for installing Ruby.

rbenv install -v 2.2.3
rbenv global 2.2.3
ruby -v

Output should be:
ruby 3.2.1 (2023-02-08 revision 31819e82c8) [x86_64-linux]

Thereafter, it is better to install the Bundler gem, because it helps to manage your application dependencies. Use the following command to install bundler gem.

gem install bundler

Step 4: Configuring Git
Replace my name and email address in the following steps with the ones you used for your Github account.

git config --global color.ui true
git config --global user.name "YOUR NAME"
git config --global user.email "YOUR@EMAIL.com"
ssh-keygen -t ed25519 -C "YOUR@EMAIL.com"

The next step is to take the newly generated SSH key and add it to your Github account.

cat ~/.ssh/id_ed25519.pub

Once you've done this, you can check and see if it worked:

ssh -T git@github.com
You should get a message like this:

Hi excid3! You've successfully authenticated, but GitHub does not provide shell access.

Step 5: Install Rails
Use the following command for installing Rails version 7.0.4.3

install rails -v 7.0.4.3
rbenv rehash
rails -v

Output:
Rails 7.0.4.3

Installing PostgreSQL
Step 1: To configure Ruby on Rails with PostgreSQL as a database for your web application, you will first install the database onto your server. Using sudo privileges, update your APT package index to make sure that your repositories are up to date:

sudo apt update

Next, install PostgreSQL and its development libraries:

sudo apt install postgresql postgresql-contrib libpq-dev

Step 2: Creating a New Database Role
To create a PostgreSQL super user role, run the following command, substituting the highlighted word with your Ubuntu username:

sudo -u postgres createuser -s sammy -P

Since you specified the -P flag, you will be prompted to enter a password for your new role. Enter your desired password, making sure to record it so that you can use it in a configuration file in a later step.

Clone the repository and run the server of the ArchCeu
Step 1: Open bash and type:

git clone git@github.com:iceiceice24/ArchCeu.git

Step 2: add a database and type this into your terminal in ruby on rails

cd /mnt/c/FolderNameThatYouCloneTheRepo/ArchCeu OR cd /mnt/c/ArchCeu
rails db:create
bundle install
rails db:migrate
rails db:seed

then run the server by typing:

rails s

you can use the default admin for the website:
email: 'adosh@ceu.edu.ph',
password: 'adosh@ceu.edu.ph',
