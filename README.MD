# pgdump-from-docker-container
This repo allows exporting of DB dump from a docker container & download it to local pc & at last split it into chunks of 100 MB

## Setup
Copy `env.example.sh` file to `.env.example.sh` and configure the variables.

## Running the app
Simply hit `./export_pgdump.sh` and see the output on console.