include .env

.PHONY: up down stop prune ps shell drush logs

default: info

DRUPAL_ROOT ?= /var/www/html/web

up:
	lando start

info:
	lando info

update:
	lando composer update

db:
	platform db:dump -f database.sql.gz --environment $(E) --gzip -y
	lando db-import database.sql.gz

deploy:
	lando composer update
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