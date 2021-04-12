HOWTO
========

Close repository, for example:

    # git clone git://github.com/oe-alliance/build-enviroment.git -b 4.4 openspa-7.4


Add docker-compose.yml file:

    version: '3.9'

    services:
      openspa:
        image: thempra/openpli-dev:latest
        container_name: openspa
        user: openpli
        environment:
          - SSH_AUTH_SOCK=/ssh-agent
          - DISTRO=openspa
          - MACHINE=zgemmah92s
          - DISTRO_TYPE=release
        volumes:
          - ${SSH_AUTH_SOCK}:/ssh-agent
          - ./openspa-7.4:/openpli     
 
Attach to docker container

    # docker exec -it openspa bash

Now, you can start to create your custom image:

    # make update

    # make image