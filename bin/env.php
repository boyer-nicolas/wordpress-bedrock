<?php

final class EnvGenerator
{
    private $env_file;
    private $interactive;

    public function __construct($argc, $argv)
    {
        // Check if the --no-interaction flag is set
        $this->interactive = true;
        if ($argc > 1 && in_array('--no-interaction', $argv))
        {
            echo "\n\e[31m[WARNING]\e[0m No interaction mode enabled.";
            $this->interactive = false;
        }

        if (file_exists('.env'))
        {
            echo "\n\e[31m[WARNING]\e[0m .env file already exists. Do you want to overwrite it? (y/n) ";
            if ($this->interactive)
            {
                $input = trim(fgets(STDIN));
            }
            else
            {
                $input = 'y';
            }
            // get the input
            if ($input == 'y')
            {
                $this->env_file = '.env';
                unlink($this->env_file);
            }
            else
            {
                echo "\n\nExiting...\n";
                exit;
            }
        }

        echo "\n\n\e[34m[STEP 1/5] Preparation\e[0m";

        $this->info("Copying .env.example to .env...");
        copy('.env.example', '.env');

        $this->info("Retrieving env file contents...");
        $this->env_file = file_get_contents('.env');

        echo "\n\n\e[34m[STEP 2/5] String generation\e[0m";
        // Generate strings
        $secure_auth_key = $this->generateRandomString();
        $auth_key = $this->generateRandomString();
        $logged_in_key = $this->generateRandomString();
        $nonce_key = $this->generateRandomString();
        $secure_auth_salt = $this->generateRandomString();
        $auth_salt = $this->generateRandomString();
        $logged_in_salt = $this->generateRandomString();
        $nonce_salt = $this->generateRandomString();
        $mysql_password = $this->generateRandomString(35, false);
        $mysql_root_password = $this->generateRandomString(45, false);

        $this->info("String generation completed.");

        // DB
        echo "\n\n\e[34m[STEP 3/5] Database configuration\e[0m";
        $mysql_database = $this->ask('Enter the name of the database', 'niwee');
        $mysql_user = $this->ask('Enter the name of the database user', 'niwee');
        $mysql_port = $this->ask('Enter the database port', '3306');
        $mysql_host = $this->ask('Enter the database hostname', 'mariadb');
        $mysql_prefix = $this->ask('Enter the database prefix', 'niwee_');
        $mysql_password = $this->ask('Enter the database password', $mysql_password);
        $need_database_creation = $this->ask('Do you need to create the database? (1/0)', '0');

        if ($need_database_creation === "1")
        {
            echo "\n[WARNING] Since you selected to create the database, the root password will be used to create the database. Please provide it below.";
            $mysql_root_password = $this->ask('Enter the root password of the database', $mysql_root_password);
        }

        // ENV
        echo "\n\n\e[34m[STEP 4/5] WP configuration\e[0m";
        $wp_env = $this->ask('The environment you are using the app for (development, staging, production)', 'development');

        // Networking
        $git_repo_name = exec('basename `git rev-parse --show-toplevel`');
        $wp_network = $this->ask('What is the name of the network (It represents the name of the app)', $git_repo_name);
        $wp_dev_url = $this->ask('The URL of the development environment', 'https://wordpress.localhost');
        $wp_staging_url = $this->ask('The URL of the staging environment', '');
        $wp_prod_url = $this->ask('The URL of the production environment', '');

        // Datetime/Localization
        $wp_locale = $this->ask('The locale of the app', 'fr_FR');
        $wp_timezone = $this->ask('Enter the timezone of the app', 'Europe/Paris');

        // Permissions
        $current_user = exec('id -u');
        $current_group = exec('id -g');
        $wp_puid = $this->ask('Enter the PUID of the app', $current_user);
        $wp_pgid = $this->ask('Enter the PGID of the app', $current_group);

        // SMTP
        echo "\n\n\e[34m[STEP 5/5] SMTP configuration\e[0m";
        $smtp_email = $this->ask('Enter the email address of the SMTP server', '');
        $smtp_password = $this->ask('Enter the password of the SMTP server', '');
        $smtp_name = $this->ask('Enter the name you want to appear as when sending emails', '');
        $smtp_host = $this->ask('Enter the hostname of the SMTP server', '');
        $smtp_port = $this->ask('Enter the port of the SMTP server', '');


        $this->info("Replacing keys...");
        $this->env_file = $this->replace_token('secure_auth_key', $secure_auth_key);
        $this->env_file = $this->replace_token('auth_key', $auth_key);
        $this->env_file = $this->replace_token('logged_in_key', $logged_in_key);
        $this->env_file = $this->replace_token('nonce_key', $nonce_key);
        $this->env_file = $this->replace_token('secure_auth_salt', $secure_auth_salt);
        $this->env_file = $this->replace_token('auth_salt', $auth_salt);
        $this->env_file = $this->replace_token('logged_in_salt', $logged_in_salt);
        $this->env_file = $this->replace_token('nonce_salt', $nonce_salt);
        $this->env_file = $this->replace_token('mysql_password', $mysql_password);
        $this->env_file = $this->replace_token('mysql_root_password', $mysql_root_password);
        $this->env_file = $this->replace_token('mysql_database', $mysql_database);
        $this->env_file = $this->replace_token('mysql_user', $mysql_user);
        $this->env_file = $this->replace_token('mysql_host', $mysql_host);
        $this->env_file = $this->replace_token('mysql_prefix', $mysql_prefix);
        $this->env_file = $this->replace_token('mysql_port', $mysql_port);
        $this->env_file = $this->replace_token('smtp_email', $smtp_email);
        $this->env_file = $this->replace_token('smtp_password', $smtp_password);
        $this->env_file = $this->replace_token('smtp_name', $smtp_name);
        $this->env_file = $this->replace_token('smtp_host', $smtp_host);
        $this->env_file = $this->replace_token('smtp_port', $smtp_port);
        $this->env_file = $this->replace_token('need_database_creation', $need_database_creation);
        $this->env_file = $this->replace_token('wp_env', $wp_env);
        $this->env_file = $this->replace_token('wp_dev_url', $wp_dev_url);
        $this->env_file = $this->replace_token('wp_staging_url', $wp_staging_url);
        $this->env_file = $this->replace_token('wp_prod_url', $wp_prod_url);
        $this->env_file = $this->replace_token('wp_locale', $wp_locale);
        $this->env_file = $this->replace_token('wp_timezone', $wp_timezone);
        $this->env_file = $this->replace_token('wp_puid', $wp_puid);
        $this->env_file = $this->replace_token('wp_pgid', $wp_pgid);
        $this->env_file = $this->replace_token('wp_network', $wp_network);

        $this->info("Writing .env file...");
        file_put_contents('.env', $this->env_file);

        $this->info("Installation completed.");
    }

    private function ask(string $question, string $default = '')
    {
        if ($this->interactive === false)
        {
            return $default;
        }
        if ($default === "")
        {
            $defaultMessage = "No default value provided.";
        }
        else
        {
            $defaultMessage = "Default value: $default";
        }

        echo "\n\e[35m[QUESTION]\e[0m " . $question . " \e[34m[$defaultMessage]\e[0m: ";
        $answer = $this->get_input();
        if (empty($answer))
        {
            if ($default === "")
            {
                echo "\e[31m[ERROR]\e[0m No default value provided. Please enter a value.\n";
                return $this->ask($question, $default);
            }
            else
            {
                echo "\e[34m[INFO]\e[0m Using default value: \e[32m$default\e[0m\n";
                return $default;
            }
        }
        else
        {
            echo "\e[32m[INFO]\e[0m Using provided value: \e[32m$answer\e[0m\n";
        }

        return $answer;
    }

    private function get_input()
    {
        $handle = fopen("php://stdin", "r");
        $line = fgets($handle);
        return trim($line);
    }

    private function info(string $message)
    {
        echo "\n\e[34m[INFO]\e[0m " . $message;
    }

    private function generateRandomString(int $length = 25, bool $special_chars = true)
    {
        $extra_chars = "";

        if ($special_chars)
        {
            $extra_chars = "!?$#&^`*()_+-=|{}[]:;<>.,";
        }


        $characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$extra_chars";
        $charactersLength = strlen($characters);
        $randomString = '';
        for ($i = 0; $i < $length; $i++)
        {
            $randomString .= $characters[random_int(0, $charactersLength - 1)];
        }
        return $randomString;
    }

    private function replace_token(string $key, string $value)
    {
        return str_replace($key, $value, $this->env_file);
    }
}

new EnvGenerator($argc, $argv);
