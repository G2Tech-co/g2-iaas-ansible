# G2 Ansible IaC

[Ansible doc](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

- [x] essentials
- [x] docker
- [x] mysql
- [x] traefik
- [x] Gitlab runner
- [ ] Node exporter
- [ ] Redis

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
