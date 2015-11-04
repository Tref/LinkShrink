echo "* Updating system"
yum -y update
echo "* Installing packages"
yum install build-essential libmagickcore-dev imagemagick libmagickwand-dev libxml2-dev libxslt1-dev git-core nginx redis-server curl nodejs htop mysql-devel

id -u deploy &> /dev/null

if [ $? -ne 0 ]
then
  echo "* Creating user deploy"
  useradd -m -g staff -s /bin/bash deploy
  echo "* Adding user deploy to sudoers"
  chmod +w /etc/sudoers
  echo "deploy ALL=(ALL) ALL" >> /etc/sudoers
  chmod -w /etc/sudoers
else
  echo "* deploy user already exists"
fi

echo "* Installing rbenv"

# Verify Git is installed:
if [ ! $(which git) ]; then
  echo "Git is not installed, can't continue."
  exit 1
fi

if [ -z "${RBENV_ROOT}" ]; then
  RBENV_ROOT="$HOME/.rbenv"
fi

# Install rbenv:
if [ ! -d "$RBENV_ROOT" ] ; then
  git clone https://github.com/sstephenson/rbenv.git $RBENV_ROOT
else
  cd $RBENV_ROOT
  if [ ! -d '.git' ]; then
    git init
    git remote add origin https://github.com/sstephenson/rbenv.git
  fi
  git pull origin master
fi

# Install plugins:
PLUGINS=(
  sstephenson/rbenv-vars
  sstephenson/ruby-build
  sstephenson/rbenv-default-gems
  sstephenson/rbenv-gem-rehash
  fesplugas/rbenv-installer
  fesplugas/rbenv-bootstrap
  rkh/rbenv-update
  rkh/rbenv-whatis
  rkh/rbenv-use
)

for plugin in ${PLUGINS[@]} ; do

  KEY=${plugin%%/*}
  VALUE=${plugin#*/}

  RBENV_PLUGIN_ROOT="${RBENV_ROOT}/plugins/$VALUE"
  if [ ! -d "$RBENV_PLUGIN_ROOT" ] ; then
    git clone https://github.com/$KEY/$VALUE.git $RBENV_PLUGIN_ROOT
  else
    cd $RBENV_PLUGIN_ROOT
    echo "Pulling $VALUE updates."
    git pull
  fi

done

# Show help if `.rbenv` is not in the path:
if [ ! $(which rbenv) ]; then
  echo "
Seems you still have not added 'rbenv' to the load path:

# ~/.bash_profile:

export RBENV_ROOT=\"\${HOME}/.rbenv\"

if [ -d \"\${RBENV_ROOT}\" ]; then
  export PATH=\"\${RBENV_ROOT}/bin:\${PATH}\"
  eval \"\$(rbenv init -)\"
fi
"

# install a Ruby version:
echo "* Installing ruby v2.2.3"
rbenv install 2.2.3

## OPTIONAL RVM INSTALL
# echo "* Installing rvm"
# . /etc/profile.d/rvm.sh &> /dev/null

# type rvm &> /dev/null

# if [ $? -ne 0 ]
# then
#   curl -L https://get.rvm.io | bash -s
#   echo "source /etc/profile.d/rvm.sh" >> /etc/bash.bashrc
#   . /etc/profile.d/rvm.sh &> /dev/null
# else
#   echo "* rvm already installed"
# fi

cat /etc/environment | grep RAILS_ENV
if [ $? -ne 0 ]
then
  echo "RAILS_ENV=production" >> /etc/environment
fi

echo "* Adding a gemrc file to deploy user"
echo -e "verbose: true\nbulk_threshold: 1000\ninstall: --no-ri --no-rdoc --env-shebang\nupdate: --no-ri --no-rdoc --env-shebang" > /home/deploy/.gemrc
chmod 644 /home/deploy/.gemrc
chown deploy /home/deploy/.gemrc
chgrp staff  /home/deploy/.gemrc

echo "* Adding ssh key to authorized_keys"
test -d /home/deploy/.ssh
if [ $? -ne 0 ]
then
  mkdir /home/deploy/.ssh
  chmod 700 /home/deploy/.ssh
  chown deploy /home/deploy/.ssh
  chgrp staff /home/deploy/.ssh
fi

# your public key
echo "your public key" > /home/deploy/.ssh/authorized_keys

chmod 600 /home/deploy/.ssh/authorized_keys
chown deploy /home/deploy/.ssh/authorized_keys
chgrp staff /home/deploy/.ssh/authorized_keys

echo "* Install ruby version 2.2.3"
ruby -v &> /dev/null
if [ $? -ne 0 ]
then
  rvm install 2.2.3
else
  echo "* Ruby already installed"
fi

echo "* Add user deploy to rvm group"
usermod -a -G rvm deploy

rvm --default use 2.2.3
ruby -v
echo "* DONE *"
echo "* Restarting system. Once complete you can begin installing your rails applications *"
reboot