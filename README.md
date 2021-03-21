
![Build](https://github.com/johnckealy/auto-devops/actions/workflows/deploy-prod.yml/badge.svg)

<img src="https://raw.githubusercontent.com/johnckealy/djengu/main/frontend/src/assets/djengu-logo.svg"
     alt="logo image" width="230" />

<em> A full production and dev environment for Django and Vue. </em>

Djengu is a framework for creating decoupled web applications with Django and Vue.
It's essentially a cross-platform cookie-cutter. Most of the the heavy lifting in
setting up both development and production environments is taken care of, such as
server set-up, mock environments, containerization, SSL/TLS, DNS, testing, and much more.

The concept behind Djengu is that it will remove all reliance on itself once set up.
Djengu will create everything you need, then quietly remove itself –
leaving you with a clean, reliable, production-ready Django/Vue application.

At the moment, Djengu is limited to Django and Quasar Framework. Support for
Vue CLI and Nuxt.js will be added soon.

### Quick start

First, clone the repository.
```bash
git clone git@github.com:johnckealy/djengu.git
cd djengu
```

Djengu is controlled by a `Makefile`. To start, simply run

```bash
make
```

After a quick inititial set up, you can run
```bash
make frontend-serve
```
then, in a new tab, run
```bash
make backend-serve
```
and your application will be ready.


### Simulating the production environment

Before setting up on a real server, it can be extremely useful to simulate
the production environment. Djengu makes use of Vagrant, a tool that allows you to make
changes in your dev environment while mirroring the production code in a virtual machine.

To use this feature, you'll need to install [Vagrant](https://www.vagrantup.com/downloads)
and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

The `Vagrantfile` controls the set up. If you don't wish to use this feature, you can
simply remove it.

Create the environment with
```bash
vagrant up
```
followed by
```bash
vagrant ssh
```

Firstly,
a separate Docker container running an instance of `CaddyServer` must be spun up.

Edit the `env/.env.prod` file to specify your directory structure on your VPS (keep the `/vagrant`
directory until the code is moved to your VPS), as well as your preferrred PostgreSQL settings.

Then, you can simply enter the `/vagrant` directory and run

```
make deloy-prod
```

Finally, you must enter your Vagrant instance's IP address in `/etc/hosts` and associate a
domain name to it. This must be the same domain name as the one specified in the `Caddyfile`.
Then hey presto – you have a reverse proxy – you can add new apps with unique domain names simply
by adding the entry to the Caddyfile and running `make deploy-prod` in the new app.

### Technologies

Because Djengu takes care of a lot of underlying technologies, certain
choices have already been made. This results in more simplicity and
speed, but less flexibility. Djengu will install with the
following technologies.

– Django Rest Framework
– Quasar Framework (a Vue.js framework)
– PostgreSQL
– Docker
– Make
– Vagrant
– Github Actions
– JWT authentication
– Dj Rest Auth


If you'd like to see more choices, please consider contributing to the
project.

### Vscode

If you are a Visual Studio Code user, there are some premade scripts
for running the backend application in the `.vscode/` directory. If you don't
use vscode, just go ahead and delete this directory.

### Hosting multiple web applications on the same server instance

TODO

### Flavours

Djengu currently has three choices (more will be added as the project progresses):

1) `Basic`: Creates a basic Quasar and Django application.

2) `Authentication`: Django and Quasar with JWT token authentication out of the box

3) `Static-site`: Runs a basic Quasar application with no Django backend
