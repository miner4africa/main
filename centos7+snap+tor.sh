#!/bin/sh
#
# CentOS7 snap+tor -> 59051-59055
# Sat Sep 21 03:37:56 UTC 2019
#

bash <<'EOF'

setenforce 0

sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config

yum -q -y install epel-release && yum update -q -y && yum install -q -y snapd && systemctl enable --now snapd.socket && ln -s /var/lib/snapd/snap /snap

mkdir /etc/tor

echo 'SOCKSPort 0.0.0.0:59051 IsolateClientAddr IsolateSOCKSAuth KeepAliveIsolateSOCKSAuth IsolateClientProtocol IsolateDestPort IsolateDestAddr' > /etc/tor/torrc
echo 'SOCKSPort 0.0.0.0:59052 IsolateClientAddr IsolateSOCKSAuth KeepAliveIsolateSOCKSAuth IsolateClientProtocol IsolateDestPort IsolateDestAddr' >> /etc/tor/torrc
echo 'SOCKSPort 0.0.0.0:59053 IsolateClientAddr IsolateSOCKSAuth KeepAliveIsolateSOCKSAuth IsolateClientProtocol IsolateDestPort IsolateDestAddr' >> /etc/tor/torrc
echo 'SOCKSPort 0.0.0.0:59054 IsolateClientAddr IsolateSOCKSAuth KeepAliveIsolateSOCKSAuth IsolateClientProtocol IsolateDestPort IsolateDestAddr' >> /etc/tor/torrc
echo 'SOCKSPort 0.0.0.0:59055 IsolateClientAddr IsolateSOCKSAuth KeepAliveIsolateSOCKSAuth IsolateClientProtocol IsolateDestPort IsolateDestAddr' >> /etc/tor/torrc

snap install tor || snap install tor && snap start --enable tor.tor

ss -ltpn
id
uname
echo ${USER}
EOF
