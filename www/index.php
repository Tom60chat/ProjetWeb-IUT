<?php
require '../includes/flight/Flight.php';
require '../includes/smarty/libs/Smarty.class.php';
require './routes.php';
require('../includes/pdo.php');
require('../includes/utility.php');

session_start();

$db = new PDO("mysql:host=$host;port=$port;dbname=$dbname;charset=utf8", $username, $password);

$db -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

Flight::set('db', $db);

Flight::register('view', 'Smarty', array(), function($smarty){
    $smarty->template_dir = './templates/';
    $smarty->compile_dir = './templates_c/';
    $smarty->config_dir = './config/';
    $smarty->cache_dir = './cache/';
});

Flight::map('render', function($template, $data){
    Flight::view()->assign($data);
    Flight::view()->display($template);
});

if (isset($_SESSION['user']))
    Flight::view() -> assign('session', $_SESSION['user']);

Flight::start();
