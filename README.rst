=================================
Keystone Docker Devel Environment
=================================

Intro
=====

This repository provides a simple `docker-compose`_ environment that uses the
`keystone`_, `keystonemiddleware`_ and `keystoneauth`_ repositories from the local
machine. It is designed to allow quick testing of changes to these components.

.. _keystone: https://git.openstack.org/cgit/openstack/keystone
.. _keystonemiddleware: https://git.openstack.org/cgit/openstack/keystonemiddleware
.. _keystoneauth: https://git.openstack.org/cgit/openstack/keystoneauth
.. _docker-compose: https://docs.docker.com/compose/

Usage
=====

You will need to create a `.env file`_ for your own environment. Within it you will need a:

.. code:: ini

  KEYSTONE_DIR=/path/to/keystone
  KEYSTONEAUTH_DIR=/path/to/keystoneauth
  KEYSTONEMIDDLEWARE_DIR=/path/to/keystonemiddleware

These directories will be mounted into the container.

After which you can run:

.. code:: console

  docker-compose up

Useful additions to running docker-compose are:

  `--build`: build the local docker before running.

  `--force-recreate`: rebuild everything from scratch.

  `--abort-on-container-exit`: crash if there's a problem.

.. _.env file: https://docs.docker.com/compose/env-file/
