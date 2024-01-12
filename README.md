## Gitlab License Generator

!!! This script made for testing only !!!

Script is tested with Gitlab EE 16.7.0.

Simplest usage of the script is running it in the Docker Compose.

Take attention on command line arguments for ruby license.rb.

```sh
docker-compose -f docker-compose-makelicense.yaml up
```

After that you should mount output license file to a Gitlab instance.
It's also convenient to use the Docker Compose for this.
For example, see docker-compose.yaml.

Run it.
```sh
docker-compose up -d
docker-compose logs --tail=10 -f gitlab
```
