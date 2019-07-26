## A Docker container, containing the dapperdox server. https://github.com/DapperDox/dapperdox

From their README :

> Themed documentation generator, server and API explorer for OpenAPI (Swagger) Specifications. Helps you build integrated, browsable reference documentation and guides. For example, the [Companies House Developer Hub](https://developer.companieshouse.gov.uk/api/docs/) built with the alpha version.


There is a dapperdox docker project (https://github.com/bircow/docker-dapperdox). I couldn't get this to work for multiple spec-files. Possibly a deficiency in go-wrapper.

This project will not run locally in isolation. (Maybe post POC)

To see the container in action look at https://gitlab.digital.homeoffice.gov.uk/cto/api-directory 

## Description

The Dockerfile contains the bulk of the detail. It basically :

- Creates the dapperdox binary in a container stage
- Copies the binary into the second stage container
- Copies the base assets (templates, css etc)
- Prepares a assets/sections directory for copied in project markdown
- runs a bash script to move files around in the directory structure

## run.sh

This file copies spec files and md file around. 
When this container is run a volume is created and mapped to /specs. Git-sync containers write to this volume, 
but the files are in the wrong structure. This script is a simple fix. 

## quay

The drone file pushes this to the quay open repository.
