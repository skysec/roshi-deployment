Roshi Deployment
================

Ansible set of roles to deploy Soundcloud time-series event storage, Roshi Server (https://github.com/soundcloud/roshi). Based on an existing Linux Ubuntu Image, it can deploy roshi-server, redis and nginx as a reverse-proxy.

Requirements
------------

This version requires Ubuntu 14.04 and an user "ubuntu" with ssh access (key authentication). Ansible is required in order to run the playbooks.

Build and Deploy
------------

The following steps are required in order to deploy roshi:

- Install ansible
- Update the "host" file, specifically "roshi ansible_host=<ip address>", under [roshi], and set the correct ip address.
- Run the following command: ansible-playbook --private-key <path to ssh private key> deploy.yml

The deploy mechanism uses a previously built artifact, a debian package, containing a binary version of roshi-server. This way, the building and deployment are decoupled, providing a tested, repeatable and faster deployment.

For the deployment of the binary artifact, an AWS s3 bucket is being used as a http service. The building playbook is included (build.yml). In order to build a new artifact, the playbook must be run in a host with boto, and with the AWS enviroment variables (ACCESS_KEY and SECRET_ACCESS_KEY), also, the bucket name must be replaced in playbooks/vars/main.yml and roles/roshi-server/defaults/main.yml.


Thanks
------

The golang role is provided by Joshua Lund (jlund), and can be found here: https://github.com/jlund/ansible-go
