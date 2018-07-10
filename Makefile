WSL=false
DRUPAL_ROOT ?= /var/www/html/web

include .env

.PHONY: up down stop prune ps shell drush logs

default: info

up:
	lando start

info:
	lando info

update:
	lando composer update

db-dump:
	platform db:dump -f database.sql.gz --environment $(E) --gzip -y

db-import:
	lando db-import database.sql.gz

db:
	platform db:dump -f database.sql.gz --environment $(E) --gzip -y
	lando db-import database.sql.gz

deploy:
	@if [ $(WSL) = true ]; \
	then \
		composer update --no-interaction --prefer-dist;\
	else\
		lando composer update --no-interaction --prefer-dist;\
	fi
	lando drush cr
	lando drush -y updb
	lando drush -y config-import
	lando drush -y entup
	lando drush en devel kint stage_file_proxy -y
	lando drupal smo dev

clean:
	lando drupal smo prod
	lando drush pm-uninstall devel kint stage_file_proxy -y

css:
	sass web/themes/custom/spacebase/scss/style.scss web/themes/custom/spacebase/css/style.css
	lando drush cr

cr:
	lando drush cr

uli:
	lando drush uli --no-browser

stop:
	lando stop

# https://stackoverflow.com/a/6273809/1826109
%:
	@: