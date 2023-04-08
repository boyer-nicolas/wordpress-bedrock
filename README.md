# Wordpress Bedrock

## Dependencies

- [Docker](https://docs.docker.com/get-docker/)
- [Composer](https://getcomposer.org/doc/00-intro.md)
- [Node JS](https://github.com/nvm-sh/nvm#installing-and-updating) (npm, yarn)

## Getting Started

- ➡️ Clone the project

```bash
git clone git@gitlab.com:niwee-productions/docker-images/wordpress.git
cd <your-project>
```

- ➡️ Install dependencies

```bash
composer install
```

- ➡️ Generate sensible data

```bash
composer gen:env
```

- ➡️ Start the project

```bash
docker compose build
docker compose up
```

## Available commands

To see which commands are available, you can run:

```bash
composer list
```

### A brief summary (last updated on 4/4/2023)

```bash
db
    db:dump Export the database to sql/dump.sql
    db:import Import to the database from sql/dump.sql
fix
    fix:url Sets the WP url to the one defined in the .env
gen
    gen:env Generates keys with random characters & asks for database data
make
    make:child Generates child theme with webpack support
    make:template Creates default users, default pages & fixes url structure/datetime
media
    media:pull Pulls sql & uploads from the storage server
    media:push Pushes sql & uploads to the storage server
prod
    prod:down Stops the production environment
    prod:up Starts the production environment
staging
    staging:down Stops the staging environment
    staging:up Starts the staging environment
```

## ⌨️ Development

### Plugins

To add a plugin, you can use composer:

```bash
composer require wpackagist-plugin/<plugin-name>
```

You can find plugins [here](https://wpackagist.org/).

### Themes

To add a theme, you can use composer:

```bash
composer require wpackagist-theme/<theme-name>
```

You can find themes [here](https://wpackagist.org/).
