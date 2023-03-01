# G2 Ansible IaC

[Ansible doc](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

- [x] Essentials
- [x] Swap
- [x] Docker
- [x] Traefik
- [x] MySQL
- [x] Redis
- [x] Node exporter
- [x] Gitlab runner
- [x] Reboot

```
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

```
ansible-playbook setup.yml
```

```
ansible-vault encrypt_string --name 'password_name'
```

```
Change these defaults
Swap: 2G
Traefik: auth
MySQL: auth
Redis: auth
```
