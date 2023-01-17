# README

This README would normally document whatever steps are necessary to get the
application up and running.

https://docs.google.com/presentation/d/1bgVEZK-_TedfflUmv5w4YYcDqkzgEeIaeSCww5KlEak/edit?usp=sharing


# dev setup

* install docker (https://docs.docker.com/get-docker/)
then run following commands

```
docker-compose up --build
docker-compose exec web rails db:setup
docker-compose exec web rails db:seed
```
* verify the api works. run the following curl on your terminal

```
curl "localhost:3000/producepricetimeline?search=apple"
```
