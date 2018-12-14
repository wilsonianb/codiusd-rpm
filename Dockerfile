FROM centos:7
MAINTAINER Brandon Wilson <brandon@coil.com>

RUN yum update -y

RUN curl --silent --location https://rpm.nodesource.com/setup_10.x | bash -
RUN yum install -y mock nodejs rpm-build sudo

# Cannot run mock as root
RUN useradd -G wheel,mock rpmuser && \
    passwd -d rpmuser
USER rpmuser

RUN mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

WORKDIR /opt/codiusd

COPY codiusd.spec ./
COPY codiusd.service ./
COPY build_rpm.sh ./

CMD ./build_rpm.sh
