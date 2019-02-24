FROM debian:stretch-slim
LABEL maintainer="noreply@suspectnode.com"

ENV DEBIAN_FRONTEND noninteractive

# Install everything
RUN \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y cron wget certbot && \
	cd /opt && \
	wget https://github.com/oGGy990/certbot-dns-inwx/archive/v2.1.1.tar.gz && \
	tar -xzf v2.1.1.tar.gz && \
	cd /opt/certbot-dns-inwx-2.1.1 && \
	python3 setup.py develop --no-deps && \
	mv inwx.cfg /etc/letsencrypt/. && \
	cd /opt && \
	rm -rf v2.1.1.tar.gz 

# Create volume
VOLUME /etc/letsencrypt
    
# Add cron job to check for renewal
RUN echo "42 */12 * * * /usr/bin/certbot renew"  | crontab -

# Sleeping
CMD [ "cron", "-f" ]
