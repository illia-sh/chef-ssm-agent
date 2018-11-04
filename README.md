# ssm-agent

Installing and Configuring SSM Agent
```
default['ssm_agent']['pkg']['action'] = 'install'
```
for removal define attribute:
```
default['ssm_agent']['pkg']['action'] = 'remove'
```

### Default driver DOCKER

### For with docker-driver ; default to centos7

    chef gem install kitchen-docker

### for RHEL ec2-driver testing run locally

    export AWS_PROFILE=
    export AWS_ACCESS_KEY_ID=
    export AWS_SECRET_ACCESS_KEY=
    export AWS_SG_ID=
    export AWS_AWS_SUBNET_ID=
    export AWS_SSH_KEY_ID=

### apply on specific host (requires a minimum version of chef-client 13.10.4)
```
chef-run user@host cookbook_path/ssm-agent
```
