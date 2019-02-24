# docker-certbot-inwx

Permanently running container with certbot and plugin for [INWX](https://www.inwx.com/) DNS challenge. A renew of all certificates is triggered every 12 hours.

Big shout out to [oGGy990/certbot-dns-inwx](https://github.com/oGGy990/certbot-dns-inwx) for the DNS plugin.

## Usage

Create directory for persistent data storage, e.g.:

```
mkdir -p ~/docker/certbot-inwx
```

Create the INWX configuration file `inwx.cfg`. See [oGGy990/certbot-dns-inwx](https://github.com/oGGy990/certbot-dns-inwx) for more detailed information.

```
certbot_dns_inwx:dns_inwx_url           = https://api.domrobot.com/xmlrpc/
certbot_dns_inwx:dns_inwx_username      = your_username
certbot_dns_inwx:dns_inwx_password      = your_password
certbot_dns_inwx:dns_inwx_shared_secret = your_shared_secret optional
```

**chmod 0600 is strongly recommended**

Start the container:

``` 
docker run --detach --restart=always --name certbot-inwx -v /path/to/storage:/etc/letsencrypt suspectnode/docker-certbot-inwx
```

## Create new certificates

If you want to create new certificates you can enter the container easily with

``` 
docker exec -it certbot-inwx bash
``` 

and request your new certificate

```
certbot certonly -a certbot-dns-inwx:dns-inwx -d *.domain.tld -d domain.tld
```
