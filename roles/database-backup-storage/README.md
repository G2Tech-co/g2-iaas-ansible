## commands

```sh
gzip -dk dbbackup.gz
mysql -h 127.0.0.1 -P33306 -u database_user -p database_name < file.sql
```

### disk usage

du -s -h /* | sort -hr
