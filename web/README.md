# Azure Cosmos DB Starter – Todo App

A simple Todo App built on [Next.js](https://nextjs.org/) and [Azure Cosmos DB](https://aka.ms/trycosmosdbvercel).
## Environment Setup Instructions

### Pre requisites

Azure [Cosmos DB account](https://learn.microsoft.com/en-us/azure/cosmos-db/), database and container. Please make sure the [Partition Key](https://learn.microsoft.com/en-us/azure/cosmos-db/partitioning-overview) for container is '/id'.

### Getting Started Steps

- Install dependencies from the root folder - `npm install`

- Rename sample.env to .env and set appropriate variables.

  - COSMOSDB_ENDPOINT: This is the connection endpoint for the database.
  - COSMOSDB_KEY : This is the connection key for the database.
  - COSMOSDB_DATABASE_NAME : This is the name of the database to store todos.
  - COSMOSDB_CONTAINER_NAME : This is the name of the container to store todos.

You can obtain the connection string by navigating to your Azure Cosmos DB account page's key blade, and select Primary connection string. Copy the value to use.

- Start the project - `npm run dev`

<br />
<br />

## Technical Documentation

### Tech Stack

| Name | Description |
| :--- | ---: |
| [Next.js](https://nextjs.org/) | React framework |
| [Azure Cosmos DB](https://learn.microsoft.com/en-us/azure/cosmos-db/) | NoSQL database service in Azure |
| [Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/) | App Hosting PaaS |
| [Chakra UI](https://chakra-ui.com/) | Simple, Modular & Accessible UI Components for your React Applications |

<br />

### Folder Structure
```bash
.
├── components
│   ├── AddTodo.js
│   ├── Layout.js
│   ├── Todo.js
│   └── Todos.js
├── pages
│   ├── _app.js
│   ├── index.js
│   └── todos
│       └── [id].js
├── public
│   └── favicon.ico
├── .env
├── .gitignore
├── README.md
├── package-lock.json
├── package.json
└── server.js
```

<br />

### High Level Technical Architecture

![High Level Technical Design](https://ambitustemplateassets.blob.core.windows.net/assets/cosmos-todo.png?sp=r&st=2024-02-15T02:27:22Z&se=2029-12-31T10:27:22Z&sv=2022-11-02&sr=b&sig=LvRyc9VpN1P3p60Y2R8LPTGtRzW%2F8K9D0L9ZL%2B4kmBc%3D)

<br />

### Cost to host in Azure

Official estimate from Azure Pricing Calculator - [Azure Pricing Calculator](https://azure.com/e/d2243ee749a44397a3483f2569578564)

| Service Category | Service Type | Description | Estimated Monthly Cost | Estimated Upfront Cost |
| :---: | :---: | :---: | :---: | :---: |
| Compute | Azure App Service | *Basic Tier; 1 B1 (1 Core(s), 1.75 GB RAM, 10 GB Storage) x 730 Hours; Linux OS; 0 SNI SSL Connections; 0 IP SSL Connections; 0 Custom Domains; 0 Standard SLL Certificates; 0 Wildcard SSL Certificates* | $12.41 | $0 |
| Database | Azure Cosmos DB | *Azure Cosmos DB for NoSQL (formerly Core), Serverless, Always-free quantity disabled, Single Region Write (Single-Master) - East US (Write Region), 4 million RUs, 5 GB transactional storage, 2 copies of periodic backup storage, Dedicated Gateway not enabled* | $2.25 | $0 |
| Developer Tools | Azure DevOps | *Basic Plan; 5 User(s)* | $0 | $0 |
| Total | | | $14.66 | $0 |

***Disclaimer: The above cost is an estimate and may vary based on the actual usage. Caravel Labs or Microsoft is not responsible for additional costs incurred.***

***Template Codebase inspired from Azure's CosmosDB Starter Repo***