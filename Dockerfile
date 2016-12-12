FROM harishaws/gwlinux

USER root

MAINTAINER team.moloko@axway.com

ENV TZ Europe/Dublin

ADD APIGateway_Install.run /APIGateway_Install.run

RUN chmod u+x APIGateway_Install.run

#ADD lic.lic /

ADD scripts /scripts

RUN cd / && \
./APIGateway_Install.run \
--mode unattended \
--unattendedmodeui none \
--setup_type complete \
--prefix /opt/Axway/ \
--licenseFilePath /lic.lic \
--apimgmtLicenseFilePath /lic.lic \
--analyticsLicenseFilePath /lic.lic \
--firstInNewDomain 0 \
--configureGatewayQuestion 0 \
--nmStartupQuestion 0 \
--enable-components nodemanager,apimgmt,cassandra \
--disable-components analytics,apitester,policystudio,configurationstudio,qstart \
--startCassandra 0 \
--cassandraInstalldir /opt \
--cassandraJDK /opt/Axway/apigateway/platform/jre

RUN rm APIGateway_Install.run

EXPOSE 8065 8075 8080 8085 8089 8090 4444

ENV GWDIR=/opt/Axway/apigateway
ENV JAVA_HOME=/opt/Axway/apigateway/Linux.x86_64/jre/

RUN  ln -s /opt/Axway/apigateway/Linux.x86_64/jre/bin/java /usr/bin/java
