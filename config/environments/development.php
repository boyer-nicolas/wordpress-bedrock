<?php

/**
 * Configuration overrides for WP_ENV === 'development'
 */

@ini_set('upload_max_size', '64M');
@ini_set('post_max_size', '64M');
@ini_set('max_execution_time', '300');

use Roots\WPConfig\Config;
use function Env\env;

Config::define('SAVEQUERIES', true);
Config::define('WP_DEBUG', true);
Config::define('WP_DEBUG_DISPLAY', true);
ini_set('log_errors', 1);
ini_set('error_log', LOG_PATH . '/debug.log');

Config::define('WP_DISABLE_FATAL_ERROR_HANDLER', true);
Config::define('SCRIPT_DEBUG', true);
Config::define('DISALLOW_INDEXING', true);
Config::define('FS_METHOD', 'direct');
Config::define('FS_METHOD', 'direct');
Config::define('WP_REDIS_HOST', 'redis');
Config::define('WP_REDIS_PORT', 6379);

Config::define('WPMS_MAIL_FROM_FORCE', true); // True turns it on, false turns it off.
Config::define('WPMS_MAIL_FROM_NAME', $_ENV['SMTP_NAME']);
Config::define('WPMS_MAIL_FROM_NAME_FORCE', true); // True turns it on, false turns it off.
Config::define('WPMS_MAILER', 'smtp'); // Possible values: 'mail', 'gmail', 'mailgun', 'sendgrid', 'smtp'.
Config::define('WPMS_SET_RETURN_PATH', true); // Sets $phpmailer->Sender if true.
Config::define('WPMS_DO_NOT_SEND', false); // Possible values: true, false.
Config::define('WPMS_SMTP_HOST', $_ENV['SMTP_HOST']); // The SMTP mail host.
Config::define('WPMS_SMTP_PORT', $_ENV['SMTP_PORT']); // The SMTP server port number.
Config::define('WPMS_SMTP_AUTOTLS', true); // True turns it on, false turns it off.
Config::define('WPMS_MAIL_FROM', $_ENV['SMTP_EMAIL']);
Config::define('WP_SITEURL', $_ENV['WP_DEV_URL']);
Config::define('WP_HOME', $_ENV['WP_DEV_URL']);


if ($_ENV['SMTP_EMAIL'] === "" || $_ENV['SMTP_PASSWORD'] === "")
{
    Config::define('WPMS_SMTP_AUTH', false);
}
else
{
    Config::define('WPMS_SMTP_USER', $_ENV['SMTP_EMAIL']);
    Config::define('WPMS_SMTP_PASS', $_ENV['SMTP_PASSWORD']);
    Config::define('WPMS_SMTP_AUTH', true);
}


if ($_ENV['SMTP_HOST'] === "mailhog" || $_ENV['SMTP_HOST'] === "maildev")
{
    Config::define('WPMS_SSL', '');
}
else
{
    Config::define('WPMS_SSL', 'ssl'); // Possible values '', 'ssl', 'tls' - note TLS is not STARTTLS.

}

if ($_ENV['SMTP_HOST'] === "" && $_ENV['SMTP_PORT'] === "" && $_ENV['SMTP_EMAIL'] === "" && $_ENV['SMTP_PASSWORD'] === "" && $_ENV['SMTP_NAME'] === "")
{
    Config::define('WPMS_ON', false);
}
else
{
    Config::define('WPMS_ON', true);
}

Config::define('JETPACK_DEV_DEBUG', true);


// Enable plugin and theme updates and installation from the admin
Config::define('DISALLOW_FILE_MODS', false);
