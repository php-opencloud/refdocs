<?php

if ($_SERVER['REQUEST_METHOD'] !== 'POST' 
  || $_GET['id'] !== getenv('CODE')
  ) {
    exit;
}

$cmd = sprintf("bash %s/build.sh", dirname(__DIR__));
exec($cmd);
