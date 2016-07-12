#!/bin/bash

set -ex

# These need to be installed at runtime so that the volumes are mounted
pip install -c /opt/requirements/global-requirements.txt -r /opt/keystoneauth/requirements.txt
pip install -c /opt/requirements/global-requirements.txt -r /opt/keystonemiddleware/requirements.txt
pip install -c /opt/requirements/global-requirements.txt -r /opt/keystone/requirements.txt

# can't use -e and -c together so we install deps with -c then override with dev versions
pip install --no-deps -e /opt/keystoneauth
pip install --no-deps -e /opt/keystonemiddleware
pip install --no-deps -e /opt/keystone

keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage db_sync

keystone-manage bootstrap

#apache2ctl restart && tail -f /var/log/apache2/*
exec apache2ctl -DFOREGROUND
