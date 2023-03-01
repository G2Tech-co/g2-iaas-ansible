# G2 Ansible IaC (Infrastructure as code)

[Ansible doc](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Roles
- [x] Essentials
- [x] Swap
- [x] Docker
- [x] Traefik
- [x] MySQL
- [x] Redis
- [x] Node exporter
- [x] Gitlab runner
- [x] Reboot

## Setup
```
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

## Run
Add ssh config host name to `hosts`
```
ansible-playbook setup.yml
```

## Vault
```
ansible-vault encrypt_string --name 'password_name'
```

## Defaults
```
Swap: 2G
Traefik: auth
MySQL: auth
Redis: auth
```

## TODOs
- [ ] Limit containers ram & cpu
- [ ] Disaster recovery plan

### Testing
```
docker -H ssh://ansib exec -it mysql mysql -u <username> -p <database>
docker -H ssh://ansib exec -it redis redis-cli -p 6379 -a 'password' ping
```
