#
# Stock Grafana + a few custom dashboards
#

FROM grafana/grafana:4.1.1

RUN apt-get update && \
    apt-get install -y curl

COPY run.sh /run.sh

EXPOSE 3000
ENTRYPOINT /run.sh
