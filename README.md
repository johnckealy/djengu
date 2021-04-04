
![Build](https://github.com/johnckealy/djengu/actions/workflows/build.yml/badge.svg)

<img src="https://raw.githubusercontent.com/johnckealy/djengu/main/frontend/src/assets/djengu-logo.svg"
     alt="logo image" width="230" />

<em> A full production and development environment for Django and Vue. </em>

Djengu is a framework for creating decoupled web applications with Django and Vue.
It's essentially a full-stack cookie-cutter. Most of the the heavy lifting in
setting up both development and production environments is taken care of, such as
server set-up, mock environments, containerization, SSL/TLS, DNS, testing, and much more.

The concept behind Djengu is that it will remove all reliance on itself once set up.
Djengu will create everything you need, then quietly remove itself –
leaving you with a clean, reliable, production-ready Django/Vue application.

At the moment, Djengu is limited to Django and Quasar Framework. Support for
Vue CLI and Nuxt.js will be added soon. The tool is currently tested for Linux,
but this will extend to OSX soon.

## Quick start

First, clone the repository, replacing `myproject` below with your desired project name.
```bash
git clone https://github.com/johnckealy/djengu.git myproject
cd myproject
```

Djengu is controlled by a `Makefile`. To start, simply run

```bash
make
```

After a quick initial set up, you can run
```bash
make backend-serve
```
then, in a new tab, run
```bash
make frontend-serve
```
and your application will be ready.

NOTE: If you chose the option that includes `authentication` during setup, you will
find that the development environment runs with SSL. You'll need to self-sign
the cert – this is as simple as "accepting the risk" when prompted by your browser.
You may also need to do this for your backend address as well (just click `VISIT DJANGO API`
on the home page).


## Installation

Djengu requires that the following tools be installed locally before starting.

– python-virtualenv

– node.js

– npm

## Simulating the production environment

Before setting up on a real server, it can be extremely useful to simulate
the production environment. Djengu makes use of Vagrant, a tool that allows you to make
changes in your dev environment while mirroring the production code in a virtual machine.

To use this feature, you'll need to install [Vagrant](https://www.vagrantup.com/downloads)
and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

The `Vagrantfile` controls the set up. If you don't wish to use this feature, you can
simply remove it.

Create the environment with
```bash
make configure-vagrant
```
This may take a few minutes the first time it is run.

When the VM is set up, you may enter it using
```bash
vagrant ssh
```

If the setup completed successfully, there should be an instance of CaddyServer running in the VM.
You may verify this using
```bash
docker ps
```
If there are any issues at this stage, `cd` into the `/caddy` directory in the VM and check
the `Caddyfile` for any errors.

Now, `cd` into the `/djengu` directory in the VM. You should see your project. If you make
an edit in your local machine, Vagrant will mirror these changes in the VM, allowing you to
tweak your production settings without needing to make changes in two different places.

Before running the deploy, it's a good idea to check the `env/.env.prod` file to make
sure your settings are correct.

When you're happy, run

```bash
make deploy
```

This will simulate a real deployment. To see the application, simply visit the domain
you entered during the set up. If you tweak this domain, or any other settings that
may affect the CaddyServer, remember to re-run `make configure-vagrant` from your
local machine (not the VM).

NOTE: The reason you were prompted for a password when running `make configure-vagrant`
is because Djengu needed access to the `/etc/hosts` file. This is the only change
Djengu makes to your machine outside of it's own repository. When you're finished
with the Vagrant testing, it's a good idea to open `/etc/hosts` and remove these lines.
If you use the same domain for testing and deployment, the hosts entry may
interfere with your access to the real application.

To remove the VM, run
```bash
vagrant destroy
```
from the root directory.



## Technologies

Because Djengu takes care of a lot of underlying technologies, certain
choices have already been made. This results in more simplicity and
speed, but less flexibility. Djengu will install with the
following technologies.

Make
– Django / Django Rest Framework
– Quasar Framework (a Vue.js framework)
– PostgreSQL
– Docker
– Vagrant
– Github Actions
– JWT authentication
– Dj Rest Auth
– Server-side rendering (SSR)

If you'd like to see more choices, please consider contributing to the
project.

## Vscode

If you are a Visual Studio Code user, there are some premade scripts
for running the backend application in the `.vscode/` directory. If you don't
use vscode, just go ahead and delete this directory.

## Hosting multiple web applications on the same server instance

Because Djengu is decoupled by design, it is possible to host
several completely independent applications on the same server
instance. This is done using CaddyServer's built-in reverse-proxy.

Everything is controlled from the `Caddyfile`, which will
install at `/caddy/Caddyfile` in the vagrant VM. You can add
extra applications and then reference the docker containers.
The important thing to remember when doing this is to use
unique port numbers for each instance, and reference these
port numbers in the `Caddyfile`. In production, you may place the `caddy/`
directory anywhere you wish, but you must add each individual
application to the same `Caddyfile`.

## Flavours

Djengu currently has three choices (more will be added as the project progresses):

1) `Basic`: Creates a basic Quasar and Django application.

2) `Authentication`: Django and Quasar with JWT token authentication out of the box

## Test Users

If you build Djengu with authentication, there is a test
account built in. The credentials are
```
username: guest
password: secret
```

You can also log in with username `admin` and the admin password
you entered during setup.


## API

Djengu applications are based on a `Makefile`, which you'll find
in the root directory. Here's a summary of what is possible.
Feel free to add your own `Make` recipes to the file.

#### `make`
Run the setup script.

#### `make build-*`
See the make file for the various options. This runs the various
builders for the backend and frontend.

#### `make configure-vagrant`
Run this to setup the Vagrant virtual machine. The initial
run of this command will set up the virtual machine based
on the `.djengu/.production_toolbox/server_setup.sh` set
up script. You can also use this script on a real server,
e.g. when initializing a DigitalOcean droplet.

If you make changes to any domain names or any other server
related settings in the `.env.prod` file, remember to
re-run this recipe.

#### `make clean`
Remove all build files and start everything fresh.

#### `make deploy`
Deploy the application on the production server (or vagrant VM).

#### `make decrypt-dotenv`
You'll need to run this command outside of the `make` recipe,
because you must replace `foo` with the actual key. DO NOT
ADD THE DECRYPTION KEY TO THE MAKEFILE.

#### `make encrypt-dotenv`
Encrypt the `env/` folder. Running this recipe will prompt you
to create an encryption passphrase. You can add this passphrase
as a Github secret to allow Github actions to apply the CI/CD.

The recipe will create a file named `env.tar.gpg`. You may check
this file into version control, just be sure not to check in any
reference to the decryption passphrase. Use the command inside
the `make decrypt-dotenv` recipe to decypt on the server, or in CI/CD
(use the command, not the recipe itself, since the key must be set manually).

#### `make frontend-serve`
Run the development environment for the frontend.

#### `make backend-serve`
Run the development environment for the backend.



## Contribute

Feel free to raise a Github issue with bugs and feature suggestions. You
can also send a pull request.

