FROM jboss/base-jdk:8
MAINTAINER Charalampos Chomenidis <hampos@me.com>

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 8.2.0.Final

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME && curl http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz | tar zx && mv $HOME/wildfly-$WILDFLY_VERSION $HOME/wildfly

USER root

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/jboss/wildfly
#ENV JAVA_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=n

# Expose the ports we're interested in
EXPOSE 8080
#EXPOSE 8787

ADD ./scripts/standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml
ADD ./packages/Jaqpot.ear /opt/jboss/wildfly/standalone/deployments/Jaqpot.ear

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]

