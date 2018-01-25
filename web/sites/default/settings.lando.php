<?php

if ($_SERVER['LANDO'] == 'ON') {
  $databases['default']['default'] = [
    'driver' => 'mysql',
    'database' => getenv('DB_NAME'),
    'username' => getenv('DB_USER'),
    'password' => getenv('DB_PASSWORD'),
    'host' => getenv('DB_HOST'),
    'port' => getenv('DB_PORT'),
  ];

  $config['search_api.server.default_solr_server']['backend_config']['connector_config']['core'] = 'drupal';
  $config['search_api.server.default_solr_server']['backend_config']['connector_config']['path'] = '/solr';
  $config['search_api.server.default_solr_server']['backend_config']['connector_config']['host'] = 'solrserver';
  $config['search_api.server.default_solr_server']['backend_config']['connector_config']['port'] = '8983';

  $settings['hash_salt'] = md5(getenv('LANDO_HOST_IP'));
}
