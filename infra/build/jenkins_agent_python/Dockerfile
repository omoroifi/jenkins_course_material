FROM jenkins/ssh-slave

RUN update-alternatives --install /usr/bin/java java /usr/local/openjdk-8/bin/java 1
RUN apt-get update && apt-get install -y python3 python3-pip python3-virtualenv
RUN pip3 install flake8 robotframework-lint
