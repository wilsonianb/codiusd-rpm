#!/bin/bash

set -e

CODIUSD_VERSION=${CODIUSD_VERSION-`npm view codiusd version`}
export CODIUSD_VERSION

sudo npm install -g codiusd@$CODIUSD_VERSION --unsafe-perm
tar -czf ~/rpmbuild/SOURCES/codiusd.tar.gz codiusd.service -C `npm root -g` codiusd

CODIUSD_RELEASE=${CODIUSD_RELEASE-1}
export CODIUSD_RELEASE

rpmbuild -bs codiusd.spec

/bin/cat <<EOM >~/.config/mock.cfg
config_opts['files']['etc/profile.d/mystuff.sh'] = """
export CODIUSD_VERSION=$CODIUSD_VERSION
export CODIUSD_RELEASE=$CODIUSD_RELEASE
"""
EOM

/usr/bin/mock -r epel-7-x86_64 --rebuild ~/rpmbuild/SRPMS/codiusd-$CODIUSD_VERSION-$CODIUSD_RELEASE.src.rpm

sudo cp /var/lib/mock/epel-7-x86_64/result/codiusd*.rpm out/

