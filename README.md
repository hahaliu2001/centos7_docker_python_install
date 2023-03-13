# centos7_docker_python_install

the project install python 3.11.2 on Centos7.9.2009 docker

Default CentOS repositories do not carry latest version of Python, we need download,build and install Python
Building Python 3.11 requires a openssl 1.1.1 or newer. The version available on the system repositories is old, we also need build and install openssl1.1.1 first.

Dockerfile shows step by step to build and install python3.11.2

I have tested it on ubuntu 16.04.4 host

## how to use it
first need install docker on host linux
### build docker image
```
./build_docker.sh #build docker image
docker image ls  # check docker image
```
REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
centos7_python          v1                  7855a94069f9        17 minutes ago      1.03GB

### run docker
```
./run_docker.sh #generate container centos7_python

```
// check docker container
root@nuc:~/docker_deploy/deploy_centos# docker container ls
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
2de4cf92e7cc        centos7_python:v1   "/usr/sbin/init"    13 minutes ago      Up 13 minutes                           centos7_python

### verify
```
docker exec -it centos7_python bash  #start an interactive shell inside a Docker Container
python3 --version # return python3 version to be 3.11.2
```
### remove docker container and image
```
./rm_docker.sh
```
## how to add authorized user to .ssh
// in my test, client is macOS and has generated ira key
cat id_rsa.pub and copy the keys// run on client (macOS in my test)
ssh to centos
cd .ssh
create authorized_keys and paste copied keys into this file
// permissions on the ~/.ssh/authorized_keys should be 400 / 600 (permissions on the owner only).
// set permission to 777 not work
chmod 400 authorized_keys // 

