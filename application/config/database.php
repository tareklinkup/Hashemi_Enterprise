<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$active_group = 'default';
$query_builder = TRUE;

$db['default'] = array(
	'dsn'	=> '',
	'hostname' => 'localhost',
	
    'username' => 'root',
    'password' => '',
  	'database' => 'hashemi_enteprise',
	
//   	'username' => 'hashemie_admin1',
//   	'password' => 'Wul0[z*D.3_1',
//   	'database' => 'hashemie_software',
	
	// 'username' => 'expressre2ailbd_admin11',
	// 'password' => 'e+Zg~uM$3I)~',
	// 'database' => 'expressre2ailbd_pos1',
		

	'dbdriver' => 'mysqli',
	'dbprefix' => '',
	'pconnect' => FALSE,
	'db_debug' => (ENVIRONMENT !== 'production'),
	'cache_on' => FALSE,
	'cachedir' => '',
	'char_set' => 'utf8',
	'dbcollat' => 'utf8_general_ci',
	'swap_pre' => '',
	'encrypt' => FALSE,
	'compress' => FALSE,
	'stricton' => FALSE,
	'failover' => array(),
	'save_queries' => TRUE
);