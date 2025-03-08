
All services can be ran independently, but to run the whole system locally, please run the docker-compose.yml file using the command `docker compose up` (depending on your version of docker, this might be `docker-compose up`). 

## Prereqs

Have all of the following cloned locally: 
* [Members Hub](https://github.com/mrc-rowers-hub/mrc-members-hub): The frontend application where users interact with the system.
* [Condition Checker](https://github.com/mrc-rowers-hub/mrc-condition-checker): A service that provides real-time rowing conditions.
* [CRM](https://github.com/mrc-rowers-hub/mrc-crm): Manages rower details and membership data.
* [Scheduler Service](https://github.com/mrc-rowers-hub/mrc-scheduler-service): Handles scheduling and event organization.
* [Resources](https://github.com/mrc-rowers-hub/mrc-resources): Provides additional materials, such as training plans.

Expected structure:
```
├── deployment
│   └──local_running
│      └──docker-compose.yml
├── mrc-condition-checker
├── mrc-crm
├── mrc-members-hub 
├── mrc-resources
└── mrc-scheduler-service
```

Steps: 
1. rds terraform 
2. ecr terraform 
3. deploy_to_ecr.sh (`chmod +x deploy_to_ecr.sh` & `./deploy_to_ecr.sh`
   )