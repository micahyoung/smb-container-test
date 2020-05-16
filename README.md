# Test apps for SMB in containers on Cloud Foundry Windows and Docker Windows

## Usage
1. Rename `secrets/env.sh.template` to `secrets/env.sh` and add valid values
1. Run test:
```
./run.sh app-1
```
This will create a CF app named `test-app-1` and a temporary docker image if successful
