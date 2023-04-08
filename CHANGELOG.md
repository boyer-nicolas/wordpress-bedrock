CHANGELOG
----------------------

[2023-04-05]

[2023-04-04]
 * chore(media.sh): add TODO to rewrite script in PHP fix(media.sh): remove unused progress bar code fix(messages.sh): remove unnecessary shebang and add newline at end of file
 * fix(db.sh): fix success message when importing database fix(db.sh): fix success message when changing siteurl fix(db.sh): fix success message when flushing cache feat(media.sh): add support for remote progress bar when syncing media chore(composer.json): add process-timeout configuration to avoid composer timeout errors
 * refactor(docker-entrypoint.sh): remove warning message for missing app.yml file
 * fix(.gitlab-ci.yml): add '|| true' to docker-compose up and docker-compose ps commands
 * feat(.gitlab-ci.yml): add caching for vendor/ and .env files in composer74 and test74 stages
 * fix(.gitlab-ci.yml): change docker-compose.ci.yml to docker-compose.yml in sed commands and docker-compose commands
 * chore(.gitlab-ci.yml): remove docker login from before_script and add it to each job script
 * chore(.gitlab-ci.yml): use environment variable for php image registry URL
 * feat(.gitlab-ci.yml): add composer74 stage to install dependencies and generate env file before testing. Add composer74 as a dependency to test74 stage.
 * fix(.gitlab-ci.yml): move docker-compose build command to after sed commands
 * feat(.gitlab-ci.yml): add php7.4-cli and composer installation to the test74 job feat(bin/env.php): add --no-interaction flag to disable user interaction and add wp_prod_url token to .env file
 * refactor(githooks): add source command to messages.sh script feat(githooks): add info message before running test suite chore(gitlab-ci.yml): add TODO to install composer dependencies and generate environment file docs(child.sh): add comments to explain the purpose of the script and the TODO
 * feature(ci): Removed php8.0 & 8.1 testing
 * 💡feat(#media.sh): Improved overall logging & DX
 * Removed app.yml
 * Githooks
 * 🪚 refactor(#entrypoint): Removed architecture check as it will be done manually
 * 🪚 refactor(#docker): Matched bedrock folder with current dir
 * 💡feat(#env): Now generating all template values with composer gen:env
 * 🧹 chore(#gitignore): Removed residual lockfiles
 * 📖 docs(#Readme): Added emojis so people read this
 * 📖 docs(#readme): Specified how to get started

[2023-04-03]
 * 🪚 refactor(#app): Is not a submodule anymore
 * 💡feat(#ta): race
 * 🪚 refactor(#docker): Now using compose in app

[2023-03-31]
 * 💡feat(#env): Fixed url configs
 * 🔨 fix(#media): Media now pulling and not pushing on launch to prevent data loss
 * 💡feat(#Bedrock): Automation works
 * 🪚 refactor(#app): Removed app folder
 * 🪚 refactor(#Automatisation): Bedrock files now autogenerating & wp config seems ok. Still have to figure out server settings

[2023-03-30]
 * 🔨 fix(#env): Fixed production base conf
 * 📖 docs(#Readme): Added bedrock doc
 * 🪚 refactor(#App): Added plugins etc...
 * 💡feat(#Env): Added generator + bedrock files

[2023-03-17]
 * 🪚 refactor(#vars): placed in dockerfile instead of utils
 * 🔨 fix(#URL): Now uses only 1 variable (wouaou)

[2023-03-16]
 * 💡feat(#cron): Now exports database periodically
 * 💡feat(#media): Now autopulls media & launches wp cron
 * 🔨 fix(#version): Defaults to 7.4
 * 💡feat(#urls): Now changing to correct urls
 * 🔨 fix(#rollback): rollback to 6ac2630efc28fc485d2b11867437de227c8359d5
 * 🧹 chore(#rollback): 6ac2630efc28fc485d2b11867437de227c8359d5
 * 💡feat(#db): Added reload privileges ensure to root before flushing on new db
 * 🔨 fix(#db): Removed single quotes in args

[2023-03-01]
 * 🔨 fix(#config): Added port to mysql host for distant db
 * 🔨 fix(#permissions): Production permissions setting now uses container + user
 * 💡feat(#php): Now builds from 7.4 to 8.1
 * 💡feat(#env): Added wp base env vars

[2023-02-15]
 * 💡feat(#php): bump from php image

[2023-01-28]
 * 🔨 fix(#smtp): Fixed typo in smtp email variable name

[2023-01-27]
 * 💡feat(#launcher): removed this shit

[2023-01-05]
 * 💡feat(#Update): WP 6.1.1

[2022-12-13]
 * feat(#Opti): Added optimization libraries

[2022-12-06]
 * chore(#CI): Implemented buildx to multiplatformbuild image to fucking apple silicon
 * fix(#M1): Switched to V8 platform
 * feat(#M1): Support for apple silicon

[2022-11-23]
 * fix(#DebugBar): Added debug bar php file to dockerfile copy statement
 * feat(#Debug): Added debug bar to mesure page load time
 * fix(#SMTP): Smtp auth

[2022-11-22]
 * feat(#SMTP): Added options to run ssl or not depending on host/port
 * chore(#Debug): Added debug options depending on env
 * fix(#SMTP): Fixed smtp config definition
 * fix(#Permissions): Removed log before file permissions so commands can exec
 * feat(#Permissions): Implemented permissions fix for production
 * feat(#prods): Adapted config to handle productions without custom entrypoints

[2022-11-21]

[2022-11-18]
 * feat(#Varnish): Added varnish cache clear on launcher
 * refactor(#Stack): Simplifed test stack
 * chore(#Frank): Prevent fail on reassign when deleting user frank

[2022-11-17]
 * feat(#Entrypoint): Added unwanted users removal, autodelete w3

[2022-11-16]
 * feat(#StatusPage): Improved status logging
 * feat(#StatusPage): Works
 * feat(#StatusPage): Implementing statuspage
 * fix(#CI): Removed caddy from ci so it doesnt fail when it cannot have its ports
 * feat(#Logging): Logging improved, url set to wordpress.localhost to prevent errors on macos

[2022-11-15]
 * fix(#Registry): Moved base image to our registry
 * feat(#Registry): Trying registry with temporary auth

[2022-11-14]
 * refactor(#Ci): Remove build stage
 * fix(#PNAEM): Added safe directory to prevent pname issues on macos
 * refactor(#CI): Image build without tag moved to push stage
 * feat(#Pname): Added Pname check on entrypoint launch
 * fix(#WPCLI): Removed wpcli from ci
 * fix(#user): remove user policies
 * refactor(#PHP): Switch to our PHP image instead of the official WP

[2022-11-03]
 * feat(#Frank): Added condition to remove user frank if exists
 * fix(#WPCLI): Rollback on wpcli installation via curl
 * fix(#Locale): Removed locale from wpcore download
 * build(#6.1): WP 6.1
 * feat(#WPCLI): WPCLI now installed with composer

[2022-10-25]
 * feat(#URL): Now showing where site will be availableSN      ```
 * fix(#URL): FIxed URL on macos

[2022-10-24]

[2022-09-29]
 * chore(#BUMP): WP Version 6.0.3

[2022-09-22]
 * fix(#DOcker): Removed container on CI check if pass
 * fix(#SMTP): Fixed ssmtp conf for maildev
 * feat(#Error handling): Project won't stop if plugin update fails
 * fix(#MYSQL_PORT): Removeed mysql port from dbhost to prevent crash on launch
 * fix(#Docker): Added detach mode on test phase
 * fix(#CI/CD): Choosen stage now exists (Pipeline  #648030979)
 * feat(#CI/CD): Re-implemented test phase
 * fix(#Skippings): Removed skip checks, skip plugins & skip themes from entrypoint
 * feat(#Database): Added DB check before changing URIs
 * refactor(#PRod): Removed prod init in image to lighten load

[2022-09-05]
 * chore(#Removed lonely comment): Lonely comment was so alone I decided to let him go.
 * feat(#Test): Coucou le test !
 * feat(#(File Permissions) Removed file permissions autocheck and added XDEBUG): Fuck
 * Just Saving my work.
 * Improved fpm conf
 * Raised FPM conf

[2022-08-31]

[2022-08-23]
 * WP version 6.0.2

[2022-08-22]
 * Fixed typo causing launch fail
 * Added extra config and fixed wpcli self-shutdown

[2022-07-13]
 * Added server port variable to remove problems with blocksy
 * Update Dockerfile

[2022-06-14]
 * Update opcache.ini, Dockerfile
 * Update 6.0.1

[2022-06-09]
 * Fixing Pipeline
 * WP 6.0

[2022-05-23]

[2022-04-13]
 * Added auto gitignore on apps

[2022-04-12]
 * Added

[2022-04-06]
 * Fixed
 * Just Saving my work.
 * Just Saving my work.
 * Just Saving my work.
 * Just Saving my work.
 * Just Saving my work.
 * Just Saving my work.
 * Added
 * Fixed
 * Just Saving my work.
 * Switching
 * Testing
 * Trying
 * Now
 * Added
 * Forgot
 * Added
 * Added
 * switched
 * Added
 * Trying

[2022-04-04]
 * Ta
 * Just Saving my work.
 * Removed
 * Changed
 * Re-enabled

[2022-03-31]
 * Now
 * Added

[2022-03-30]
 * Just Saving my work.
 * Added

[2022-03-14]

[2022-03-11]
 * [FIX] ==> WP DEBUG

[2022-03-04]
 * refactor: updated core to 5.9.2
 * Just Saving my work.
 * Just Saving my work.

[2022-02-25]
 * [FEATURE] ==> Added redis options
 * Just Saving my work.
 * Just Saving my work.
 * [FIX] ==> Url change on startup, file permissions

[2022-02-23]
 * Fix
 * [FEATURE] ==> Put prod init in separate script not to run if not asked

[2022-02-22]
 * [REFACTOR] ==> Removed debugger as wordpress is too buggy
 * [FEATURE] ==> Simplified dynamic URL
 * [FEATURE] ==> Added proxy support
 * [FEATURE] ==> Added proxy support

[2022-02-15]
 * [FEATURE] ==> Added whoops debugger
 * [FIX] ==> Debugger

[2022-02-14]

[2022-02-07]
 * Just Saving my work.
 * [FIX] ==> Prod file permissions
 * [FEATURE] ==> Core is now local, removed permission check
 * Just Saving my work.

[2022-02-01]
 * Update Dockerfile
 * Update docker-entrypoint.sh

[2022-01-27]
 * [FEATURE] ==> Increased mysql response time
 * [FEATURE] ==> Added redis
 * [FIX] ==> Removed push from prod branch instanciation
 * [FIX] ==> If themes don't match, activate instead of exit
 * [FIX] ==> Intl php
 * Just Saving my work.
 * [FIX] ==> Simplified create_prod_branch function

[2022-01-26]
 * [FIX] ==> Prod branch init/create on all situations
 * Update background.sh

[2021-12-13]
 * Prepared environment for prod pull
 * Removed pull-slave

[2021-12-10]
 * Added commands to ensure well behavior of prod branches
 * Added add + stash before checkout on prod branches
 * Switched script to create branches to function

[2021-12-09]
 * prout
 * Fixed branch creation
 * Fixed permissions on backup slave
 * Added backup slave

[2021-12-08]
 * Added wpcli db rename
 * save
 * Added echo of date in readme to ensure branches creation
 * Fixed readme
 * Fixed readme creation
 * Added touch of readmes on branches creation

[2021-12-07]
 * Fixed git instanciation
 * Switche pipeline to dind
 * Changed wp check location to wait for wp core
 * Fixed entrypoint
 * Added wp doctor
 * Added chmod on pull slave folder
 * Testing prod pull slave
 * Removed code navigation && makefile
 * save
 * save
 * Should have fixed code intelligence
 * Fixed registry uri
 * Added docker login with deploy token
 * save
 * Replacing markdown badges with custom repo badges
 * Testing out pipeline

[2021-12-03]
 * save
 * save
 * Added ci file copy

[2021-12-02]

[2021-11-16]
 * Fixed push and build
 * Can launch server

[2021-10-29]
 * save
 * save
 * Now using yq to get yaml env variables

[2021-10-28]

[2021-10-06]
 * Removed build script and node
 * Made prod init launch sooner and removed pm2 compil

[2021-09-27]
 * Added delete option on rsync to remove old files

[2021-09-23]
 * Removed child copy in dockerfile
 * Removed child in this image, put in infrastructure
 * Fixed prod.sql db import path && added base wp in /var/www/html

[2021-09-22]
 * fixed prod pull  (rollback)

[2021-09-21]
 * Remove cron
 * removed prod init
 * Added prod branch option
 * Fixed prod init

[2021-09-20]
 * changed cron method but it still does not work

[2021-09-19]
 * added echo messages on sourcing of app and prod confs
 * fixed ta mere

[2021-09-16]

[2021-09-15]
 * Fixed update everything ask

[2021-09-12]
 * Added maxfilesize increase on wp config gen when pushing prod
 * Removed useless info messages

[2021-09-09]
 * Fixed prod pull
 * Fixed prod push

[2021-09-06]

[2021-09-02]
 * now backuping every 5minutes
 * Fixed backup cron and prod url
 * Set wp container ps1 hostnmae

[2021-08-19]
 * Now installing ssh as user
 * Trying to fix ssh known hosts on prod
 * fixed cron

[2021-08-16]

[2021-08-11]
 * improved url change
 * fixed prod-config to prod.conf
 * fixed build.sh permissions

[2021-08-10]
 * removed extra config on prod & secrets on logs
 * added missing ps1 function
 * now running as user niwee now using direct git configuration now using more secure prod folder commented everything

[2021-07-26]
 * README.md edited online with Bitbucket

[2021-07-21]

[2021-07-15]
 * save
 * testing webhook
 * trying webhook
 * build 5.8.0

[2021-07-14]
 * added auto remove of comments in prod-config file
 * fixed backup full

[2021-07-13]
 * added make prod init
 * added prod init
 * can now make child inside container

[2021-07-12]
 * Update README.md
 * added roadmap
 * made readme so much more readable

[2021-07-11]
 * fixed symlink (by removing it)
 * added debug
 * allowed for docker prod mode more bullet proof idk tired
 * fixed sass

[2021-07-10]
 * fixed url change on prod pull
 * fixed some variables for prod
 * fixed prod variables
 * fixed wp theme, db dumps and prod variables (but I'm not sure)
 * fixed mysql vars
 * removed makefile

[2021-07-06]
 * removed makefile
 * now using with wp ingra

[2021-07-05]
 * fixed prod table prefixx

[2021-07-02]
 * fixed prod
 * save
 * save
 * save
 * save
 * syntax update
 * added nice notices
 * save
 * fixed prod config vars
 * test
 * test
 * test
 * fixed wp dump prod

[2021-07-01]
 * fixed prod
 * small

[2021-06-28]
 * added auto url change and nodejs fix

[2021-06-25]

[2021-06-11]
 * added all of the options for smtp and tried a fix for git instantication
 * fixed local option
 * fixed typo in backup
 * added --local or -l option to backup
 * fixed smtp on prod
 * added WP_LANG option to force language download
 * added change of url in prod mode
 * fixed prod docker

[2021-06-10]
 * fixed git -c and prod mode
 * 5.7.2
 * added prod mode option in background
 * added prod mode
 * added deploy mode readme
 * added deploy mode option

[2021-06-07]
 * removed mega backups and switched to backup.sql method
 * fixed error email && added -f command
 * switched cron to 15minutes
 * added auto db backups

[2021-05-25]
 * updated to 5.7.2

[2021-05-04]

[2021-05-01]
 * rollback but this time it's working
 * rollback
 * changed rights method change to avoid 403 on restart

[2021-04-28]
 * added git config pull on prod/clone
 * removed build pm2 prod
 * made wpcli update itself in dockerfile instead of entrypoint

[2021-04-24]
 * fixed js
 * moved up build task
 * now have to set wp theme var manually (or else script minifying breaks

[2021-04-22]

[2021-04-21]
 * fixed file permissions on load
 * changed method for config extra
 * fixe dbash
 * added bash back
 * added redis config

[2021-04-17]
 * updated to 5.7.1

[2021-04-08]

[2021-04-04]
 * added pdo mysql

[2021-04-02]
 * save

[2021-03-27]
 * added max attempts for mariadb connection

[2021-03-23]
 * added more log messages
 * changed php ini path so config actually loads

[2021-03-18]

[2021-03-17]
 * removed wp core update on entrypoint and waiting for mariadb message in loop (is now before)
 * fixed cannot setup production error message

[2021-03-14]

[2021-03-12]
 * changed import dump name and switched all available commands to background task
 * readded rsync after prod task to instanciate it
 * removed pythong
 * added opcache
 * removed most annoying errors
 * figured out how to wait for db connection
 * added docker compose test file
 * added build on push
 * added test and run commands
 * added test command
 * update 5.7

[2021-03-10]
 * added prod config generation before build task

[2021-03-07]
 * added custom make command to build versions

[2021-03-04]
 * readded export

[2021-03-02]
 * fuck

[2021-02-24]

[2021-02-22]
 * built 5.6.2
 * added global smtp config and more log messages

[2021-02-19]
 * added smtp conf but can't verify cause i gotta go
 * added make dev

[2021-02-18]
 * changed back cloning method
 * fixed wp prod create with allow root
 * added prod config on prod task
 * updated prod path on watch
 * switched from prod-git to prod folder
 * added mirror from server to prod folder
 * added update on everything on build
 * fixed prod clone
 * fixed container not launching if git url fails
 * added condition on git clone (frank tu peux push)

[2021-02-16]
 * added child theme condition in build script
 * added auto building for src files
 * added ... i don't remember
 * added condition on symlink
 * added symlink creation for build files and niwee folder creation

[2021-02-15]
 * removed npm
 * successfully installing pm2 and npm + gulp cli
 * euh
 * added npm version check on entrypoint

[2021-02-11]
 * xdebug now working

[2021-02-09]
 * added xdebug

[2021-02-05]
 * added xdebug
 * added everything from tools
 * added latest version

[2021-01-31]
 * reverted dockerfile to php 7.4
 * reverting to php7.4, php8 image not stable.
 * removed wpcli
 * updated to php8

[2021-01-27]

[2021-01-26]
 * alpine is now the latest version
 * everything working
 * removed echo output of smtp and extra config
 * removed useless info messages
 * put wp config extra before importing database
 * put smtp and config extra back
 * removed lots of stuff from this image and put it in tools

[2021-01-25]
 * commented make build on makefile because I'm dumb, added allow root on checking if wp is installed in entrypoint
 * added --allow-root to wpcli update
 * changed condition for build db
 * removed prod data
 * pre-configured smtp
 * ta mère
 * First Commit
