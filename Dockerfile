FROM quay.io/keaosolutions/centos-systemd:latest
MAINTAINER Mark Olliver <mark@keao.cloud>

RUN yum install epel-release -y && yum clean all

RUN yum install -y http://yum.postgresql.org/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
RUN yum update -y && yum clean all

RUN yum install -y yum-utils yum-plugin-ovl tar git curl bind-utils unzip wget openssh-server openssh-clients krb5-workstation initscripts postgresql96 postgresql96-libs postgresql96-odbc postgresql-jdbc python-psycopg2 java-1.8.0-openjdk-devel java-1.8.0-openjdk-headless java-1.8.0-openjdk sudo && yum clean all

RUN useradd -m -s /bin/bash -c "CentOS Build User" centos

ADD ./jdk.sh /etc/profile.d/jdk.sh
ADD ./sudo_centos /etc/sudoers.d/centos

RUN chmod 400 /etc/sudoers.d/centos
RUN systemctl enable sshd

ENTRYPOINT ["/usr/sbin/init"]
