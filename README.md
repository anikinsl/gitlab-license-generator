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
    command:
      - /bin/bash
      - -c
      - |
        cd /root/license
        gem install gitlab-license
        rm -f Gitlab.gitlab-license license_key license_key.pub
        ruby license.rb 'My Name' 'My Organization' mymail@example.com"

    volumes:
      - './:/root/license:Z'
```

And run it
```sh
docker-compose up
```

After that you should mount output license file to a Gitlab instance.

```yaml
version: '3.7'
services:
  gitlab:
    container_name: gitlab
    image: gitlab/gitlab-ee:16.7.0-ee.0
    restart: always
    hostname: 'my-gitlab'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'https://my-gitlab.domain.my'
        letsencrypt['enable'] = false
        gitlab_rails['initial_license_file'] = "/tmp/Gitlab.gitlab-license"

    ports:
      - '443:443'
    volumes:
      - '/gitlab/config:/etc/gitlab'
      - '/gitlab/logs:/var/log/gitlab'
      - '/gitlab/data:/var/opt/gitlab'
      - './Gitlab.gitlab-license:/tmp/Gitlab.gitlab-license'
      - './license_key.pub:/opt/gitlab/embedded/service/gitlab-rails/.license_encryption_key.pub'
```
