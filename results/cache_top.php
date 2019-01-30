 <?php

// get file name
$phpself = isset($_SERVER['PHP_SELF']) ? basename($_SERVER['PHP_SELF']) : '';
$phpself = trim($phpself, '.php');
// block access if unexpected characters found in the file name
if(preg_match("/:|;|'|\(|\)/", $phpself)) $phpself = '';

// retrieve parameters
$params = array('prefix', 'rows', 'invariants', 'different_template', 'termination', 'nontermination', 'cfr_iterations', 'lib', 'cfr_strategy','database');
$cachefile='';
if ($phpself != ''){
    $token =$phpself;
    foreach($params as $p){
        if (isset($_GET[$p]) && $_GET[$p] != '')
            $token .= "-".$_GET[$p];
    }
    if (isset($_GET["all"]))
        $token .= "-all";
    // define cache file name
    $cachefile = ($phpself != '') ? 'cache/'.md5($token).'.chh' : '';
}
if(!empty($cachefile) && file_exists($cachefile)){
    // set lifetime in minutes
    $cachetime = 10 * 60; 
  
    // Serve from the cache if it is younger than $cachetime
    if(!isset($_GET["force"]) &&
       (filesize($cachefile) > 0) &&
      ((time() - $cachetime) < filemtime($cachefile))){
        // the page has been cached from an earlier request
        // output the contents of the cache file
        echo '<p style="float:right;"> Taken from cache at: '.date('jS F H:i:s', filemtime($cachefile)).' </p>';
        include_once($cachefile); 
        
        // exit the script, so that the rest isn't executed
        exit;
    }        
}
// start the output buffer
ob_start();   
?> 