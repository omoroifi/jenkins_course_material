# Omoroi Jenkins Course material

This repository will setup a set of containers.

You'll get:
* Jenkins ( http://localhost:8080 )
* Two Jenkins agents
* Gitea Git hosting service ( http://localhost:3000 )
* Example web-application:
  * Test server ( http://localhost:5500 )
  * Production ( http://localhost:5000 )

![Course infra overview](/infra.png)

## Prerequisites

Fairly recent:
* Docker
* Docker Compose (=< 1.27)

## Setup

* `cd infra`
* Run `./run.sh`
* Follow the instructions
