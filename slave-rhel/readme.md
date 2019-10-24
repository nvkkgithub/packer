# Development
```
packer build -var-file=slave-rhel.variables-dev.json -var 'aws_access_key=foo' -var 'aws_secret_key=bar' slave-rhel.json
packer build -var-file=slave-rhel.variables-dev.json slave-rhel.json
```

# Production
```
packer build -var-file=slave-rhel.variables-prod.json slave-rhel.json
```