FROM ubuntu:latest
MAINTAINER Jamie Lennox <jamielennox@gmail.com>

RUN apt-get update && \
    apt-get install -y apache2 python3 python3-dev libapache2-mod-wsgi-py3 wget git gcc libffi-dev libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget -O- https://bootstrap.pypa.io/get-pip.py | python3 && \
    git clone https://git.openstack.org/openstack/requirements /opt/requirements && \
    pip install rpdb ipdb && \
    pip install -c /opt/requirements/global-requirements.txt PyMySQL python-memcached && \
    rm -rf /root/.cache/pip/*

RUN groupadd -r keystone && \
    useradd -r -g keystone -G www-data -d /var/lib/keystone -m keystone && \
    mkdir /etc/keystone /var/log/keystone && \
    chown -R keystone:keystone /etc/keystone /var/log/keystone

COPY keystone.conf /etc/keystone/keystone.conf
COPY wsgi-keystone.conf /etc/apache2/sites-available/wsgi-keystone.conf
COPY entrypoint.sh /entrypoint.sh

RUN ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled/wsgi-keystone.conf

VOLUME ["/opt/keystone", "/opt/keystonemiddleware", "/opt/keystoneauth"]
CMD ["/entrypoint.sh"]
