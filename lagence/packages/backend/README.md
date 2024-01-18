# L'agence - Backend

Backend of the L'agence project made with [Express](https://expressjs.com/). It is used to serve the API for the website and the Java application.

## Installation

Run the following command to install the dependencies:

```bash
yarn
```

## Configuration

Create the `.env` file at the root of the project and fill it with the following content:

```bash
# Database
DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=
DB_DATABASE=lagence

MAILER_EMAIL=eseolagence@gmail.com
MAILER_PASSWORD="idkl nueb jgrt gpaq "
```

## Usage

Run the following command to start the server:

```bash
yarn dev
```

_NB: The server will automatically restart when you make changes to the code._

## ORM

The ORM used is [TypeORM](https://typeorm.io/#/).

All the models are located in the `src/models` folder.

### Migrations

Migrations are used to update the production database schema without losing the data. They are located in the `migrations` folder. A migration is generally created once a feature is finished and ready to be deployed.

_NB: In development, the database is automatically synchronized with the models, so you don't need to run the migrations._

To generate a migration, run the following command:

```bash
yarn migration:generate ./migrations/<MigrationName>
```

To run all the migrations, run the following command:

```bash
yarn migration:run
```
