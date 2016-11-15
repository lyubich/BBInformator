# README

1. Install Docker Engine (https://docs.docker.com/engine/installation/linux/ubuntulinux/ - Update your apt sources, Prerequisites by Ubuntu Version, Install, Create a Docker group)
2. Install Docker Compose (https://docs.docker.com/compose/install/ - NOT PIP!!!)
3. Copy .pg.env.template in .pg.env, and fill.
4. Create docker-compose.override.yml (copy docker-compose.local.yml for LOCAL, copy docker-compose.production.yml for PRODACTION)
In the project directory
5. docker-compose build
6. docker-compose run ruby /bin/bash -c "gem install rails && rails new"
7. docker-compose up -d (sudo service postgresql stop, if need)




















