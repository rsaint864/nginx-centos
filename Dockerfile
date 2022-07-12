#Getting base image from CentOS 7
FROM centos:centos7

MAINTAINER myself <mymail@mail.com>
ENV container docker

#Update Software Repository
RUN yum -y install epel-release
RUN yum -y update
RUN yum -y install nginx
RUN yum -y install systemd; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN mkdir -p /home/apps
COPY home.html /home/apps/home.html
COPY default /etc/nginx/sites-available/default

EXPOSE 80

#ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
#CMD ["/usr/sbin/init","/usr/sbin/nginx", "-g", "daemon off;"]

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
