#syntax=docker/dockerfile:1

FROM debian:bookworm-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends vsftpd \
    && mkdir -p /var/run/vsftpd/empty \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/vsftpd.conf /etc/vsftpd.conf
COPY ./tools/start_ftp.sh /root/start_ftp.sh

RUN chmod +x /root/start_ftp.sh

EXPOSE 21 21000-21010

ENTRYPOINT ["/root/start_ftp.sh"]
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]