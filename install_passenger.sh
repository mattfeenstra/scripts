#!/bin/sh
# passing the environment along like a cookie
bash -c "source /usr/local/rvm/scripts/rvm; rvm install ruby-1.9.3-p392; export >/tmp/install_passenger_env.out"
bash -c "source /tmp/install_passenger_env.out; rvm use ruby-1.9.3-p392; export >/tmp/install_passenger_env.out"
bash -c "source /tmp/install_passenger_env.out; rvm gemset create rdcsjcsvc; export >/tmp/install_passenger_env.out"
bash -c "source /tmp/install_passenger_env.out; rvm use 1.9.3-p392@rdcsjcsvc; export >/tmp/install_passenger_env.out"
bash -c "source /tmp/install_passenger_env.out; gem install --version \"3.0.19\" passenger; export >/tmp/install_passenger_env.out"
bash -c "source /tmp/install_passenger_env.out; passenger-install-apache2-module -a"

#source /usr/local/rvm/scripts/rvm
#rvm install ruby-1.9.3-p392
#rvm use ruby-1.9.3-p392
#rvm gemset create rdcsjcsvc
#rvm use 1.9.3-p392@rdcsjcsvc
#gem install --version "3.0.19" passenger
#passenger-install-apache2-module -a
