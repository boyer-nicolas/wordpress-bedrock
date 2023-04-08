<?php

/**
 * Configuration overrides for WP_ENV === 'staging'
 */

@ini_set('upload_max_size', '64M');
@ini_set('post_max_size', '64M');
@ini_set('max_execution_time', '300');

use Roots\WPConfig\Config;

/**
 * You should try to keep staging as close to production as possible. However,
 * should you need to, you can always override production configuration values
 * with `Config::define`.
 *
 * Example: `Config::define('WP_DEBUG', true);`
 * Example: `Config::define('DISALLOW_FILE_MODS', false);`
 */

Config::define('DISALLOW_INDEXING', false);

Config::define('WP_DEBUG', true);
Config::define('WP_DEBUG_DISPLAY', false);
ini_set('log_errors', 1);
ini_set('error_log', LOG_PATH . '/debug.log');

Config::define('WP_REDIS_HOST', 'redis');
Config::define('WP_REDIS_PORT', 6379);

Config::define('WP_SITEURL', $_ENV['WP_PRODUCTION_URL']);
Config::define('WP_HOME', $_ENV['WP_PRODUCTION_URL']);

if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')
{
    $_SERVER['HTTPS'] = 'on';
}

if (isset($_SERVER['HTTP_X_FORWARDED_HOST']))
{
    $_SERVER['HTTP_HOST'] = $_SERVER['HTTP_X_FORWARDED_HOST'];
}


Config::define('JETPACK_DEV_DEBUG', false);
