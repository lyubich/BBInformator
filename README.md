# Slack bot server
Part of slack bot application with bot logic

**All next commands should be run from project root!**  
**Text in "[]" bracers is optionals, if no text - apply for all**  
**Text in "<>" bracers is required your own value**  

### Preparing

* for install docker-compose use guide https://docs.docker.com/compose/install/
* copy .pg.env.template to .pg.env and fill it fields
* copy docker-compose.local.yml for **local settings** or docker-compose.production.yml for **production settings** to docker-compose.override.yml

### Local start containers
For start containers run command
```console
$ docker-compose build
$ docker-compose up -d
```

### Restart containers
For restart containers run command
```console
$ docker-compose restart [container name]
```

### Check logs
For check container logs run command
```console
$ docker-compose logs --tail=20 -f <container name>
```

### Stop containers
For stop containers run command
```console
$ docoker-compose stop [container name]
```

### Database access
For db access use command
```console
$ docker-compose exec postgres bash
$ psql -U <username> -W <database   >
```

### Database migrations
For create database migrations use
```console
$ docker-compose exec ruby bash
$ rails generate model <your model>
$ rails db:migrate
```
For run database migrations use
```console
$ docker-compose exec ruby bash
$ rails db:migrate
```



















