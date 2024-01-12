## Gitlab License Generator

!!! This script made for testing only !!!

Simplest usage of the script is running it in the Docker Compose.

Take attention on command line arguments for ruby license.rb.

Write docker-compose.yaml
```yaml
version: '3.7'
services:
  makelicense:
    image: ruby:3.3.0
    command: bash -c "cd /root/license && gem install gitlab-license && rm -f Gitlab.gitlab-license license_key license_key.pub && ruby license.rb 'My Name' 'My Organization' mymail@example.com"
    volumes:
      - './:/root/license:Z'
```

And run it
```sh
docker-compose up
```
