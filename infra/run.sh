#!/bin/bash -eu

cdir=$(dirname $0)
secret_dir=$cdir/secret

mkdir -p "$secret_dir"
creds_file=$secret_dir/user_credentials
key_algo=rsa
key_file=$secret_dir/id_$key_algo


if [ ! -e "$creds_file" ]; then
    echo "Please enter credentials to be used for the Jenkins and the Gitea"
    echo "WARNING: the password will be stored in clear text in file $creds_file"
    echo
    echo -n "Enter username (default: $USER): "
    read -r USERNAME
    if ! [[ $USERNAME ]]; then USERNAME=$USER; fi
    default_password=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-10})
    echo -n "Enter password (default: $default_password): "
    read -r PASSWORD
    if ! [[ $PASSWORD ]]; then PASSWORD=$default_password; fi
    echo
    printf "USERNAME=%s\nPASSWORD=%s\n" "$USERNAME" "$PASSWORD" > "$creds_file"
    echo
fi

if [ ! -e "$key_file" ]; then
    ssh-keygen -C "" -N "" -t "$key_algo" -f "$key_file"
fi

mkdir -p "$cdir/data/jenkins_home"
SSH_PUB_KEY="$(cat $key_file.pub)" HOST_UID=$(id -u) HOST_GID=$(id -g) docker-compose up $@
