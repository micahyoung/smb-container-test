# Test apps for SMB in containers on Cloud Foundry Windows and Docker Windows
All apps attempt to: 
1. connect to share
1. write a file named "test.txt" with content "hello"
1. cat it out
1. delete the file

## Usage
1. Rename `secrets/env.sh.template` to `secrets/env.sh` and add valid values
1. Run test:
```
./run.sh app-1
```
This will create a CF app named `test-app-1` and a temporary docker image if successful
