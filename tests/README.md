Here are all the tests you need to test the thing !

- [Setting up](#setting-up)
- [Tests](#tests)
    - [Security](#security)
        - [SSH Hardening](#ssh-hardening)
        - [NGINX Hardening](#nginx-hardening)
    - [Content](#content)
    - [Behaviour](#behaviour)

# Setting up

You will need [Inspec](https://inspec.io) to run the tests. See [the installation guide](https://downloads.chef.io/inspec)

# Tests

We break up the tests into a few profiles

    - security
        - ssh
        - nginx
    - content
    - behaviour

## Security

### SSH Hardening

We use the [Dev-Sec SSH baseline profile](https://github.com/dev-sec/ssh-baseline) for testing ssh configuration: 

```bash
inspec exec -t ssh://<username>@<forum_hostname> https://github.com/dev-sec/ssh-baseline
```

### NGINX Hardening

## Content

We test the content by expecting a few predefined categories. See [content](content/).

## Behaviour

We use cucumber to describe various desired features of the service. See [cucumber/README](cucumber/features/README.md) for more details.