# docker-symfony4-php
Docker image of PHP 7.2 for Symfony 4

##### Docker Stack example config

```dockerfile
version: '3'
services:
  php:
    image: bmxmale/docker-symfony4-php:dev
    volumes:
      - $HOME/www/PartnerCenter/SDPartnerCenter:/srv/symfony
    deploy:
      mode: global
      labels:
        - "traefik.backend=SDPartnerCenter"
        - "traefik.port=8000"
        - "traefik.frontend.rule=Host:partner.udviklet.dk"
        - "traefik.docker.network=MAGENTO_network"
networks:
    default:
        external:
            name: MAGENTO_network
```

If we got Traefik service, after start server we could test our site on http://partner.udviklet.dk ( domain point to 127.0.0.1 )

##### To start server run

```bash
php bin/console server:run 0.0.0.0:8000
```
