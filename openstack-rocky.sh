yum update -y
systemctl stop postfix firewalld NetworkManager
systemctl disable postfix firewalld NetworkManager
systemctl mask NetworkManager
yum remove postfix NetworkManager NetworkManager-libnm -y
yum install ntpdate -y
yum install https://repos.fedorapeople.org/repos/openstack/openstack-rocky/rdo-release-rocky-2.noarch.rpm -y
yum update –y
yum install  openstack-packstack -y
packstack --gen-answer-file=openstack.conf
sed -i 's/CONFIG_NTP_SERVERS=/CONFIG_NTP_SERVERS=0.ro.pool.ntp.org/g' openstack.conf
sed -i 's/CONFIG_PROVISION_DEMO=y/CONFIG_PROVISION_DEMO=n/g' openstack.conf
sed -i 's/CONFIG_HORIZON_SSL=n/CONFIG_HORIZON_SSL=y/g' openstack.conf
sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl restart sshd
packstack --answer-file openstack.conf

