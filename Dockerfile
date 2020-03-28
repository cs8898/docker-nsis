FROM debian:unstable

ARG NSIS_VERSION 3.05-1

ARG FirewallPlugin https://nsis.sourceforge.io/mediawiki/images/d/d7/NSIS_Simple_Firewall_Plugin_1.20.zip

ARG ServicePlugin https://nsis.sourceforge.io/mediawiki/images/c/c9/NSIS_Simple_Service_Plugin_1.30.zip

RUN apt-get -t unstable update && \
    apt-get -t unstable install -y curl unzip nsis=${NSIS_VERSION} && \
    apt-get clean

RUN curl ${FirewallPlugin} -o /tmp/firewall_plugin.zip && \
    unzip /tmp/firewall_plugin.zip SimpleFC.dll -d /usr/share/nsis/Plugins/x86-ansi && \
    curl ${ServicePlugin} -o /tmp/service_plugin.zip && \
    unzip /tmp/service_plugin.zip SimpleSC.dll -d /usr/share/nsis/Plugins/x86-ansi && \
    rm /tmp/firewall_plugin.zip && \
    rm /tmp/service_plugin.zip

ENTRYPOINT ["makensis", "-V4"]
