FROM fedora:27

MAINTAINER Michael Scherer <mscherer@redhat.com>

LABEL \
      # Location of the STI scripts inside the image.
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i \
      io.k8s.description="Platform for building Asciibinder data container" \
      io.k8s.display-name="Asciibinder data, Fedora 27" \
      io.openshift.tags="builder,asciibinder"


ENV \
    STI_SCRIPTS_PATH=/usr/libexec/s2i/ \
    HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:$PATH
RUN mkdir -p /opt/app-root/src
RUN useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin -c "Default Application User" default 
RUN chown -R 1001:0 /opt/app-root
RUN dnf install -y tar bsdtar shadow-utils ; dnf clean all


RUN dnf install -y rubygem-bundler ruby-devel make gcc gcc-c++ findutils git libffi-devel redhat-rpm-config; dnf clean all
RUN gem install ascii_binder 
COPY ./s2i/Makefile ./s2i/bin/ $STI_SCRIPTS_PATH
RUN mkdir -p /srv/build
WORKDIR ${HOME}

VOLUME /srv/build

USER 1001

#EXPOSE 8080
# Set the default CMD to print the usage of the language image
CMD $STI_SCRIPTS_PATH/usage

