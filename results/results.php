<?php include("cache_top.php"); ?>
<?php
$params = array('invariants', 'different_template', 'termination', 'nontermination','lib');
$command = 'python3 ./getData.py --cache ../../iRankFinder/database/json/';
if(isset($_GET["prefix"]) && $_GET["prefix"] != '')
    $command .= ' --prefix "'.$_GET["prefix"].'"'; 
if(isset($_GET["rows"]) && $_GET["rows"] != '')
    $command .= ' --rows "'.$_GET["rows"].'"';
if(isset($_GET["all"]))
    $command .= ' -all ';
foreach ($params as $p){
    if(isset($_GET[$p])){
        if ($_GET[$p] != ''){
            $arr =  explode(" ", $_GET[$p]);
            $command .= ' --'.$p;
            //print all the value which are in the array
            foreach($arr as $v){
                $command .= ' '.$v;
            }
        }
    }
}
if(isset($_GET["cfr_iterations"]) && $_GET["cfr_iterations"] != ''){
    $command .= ' --cfr-iterations ';
    $arr = explode(" ", $_GET["cfr_iterations"]);
    foreach($arr as $v){
        $int = (int)$v;
        $command .= ' '.$int;
    }
}
$command .= " 2>&1";
exec($command, $out, $status);
?>
<html>
<head>
<title>Experiments results: iRankFinder</title>
<link rel="stylesheet" href="./style-termination.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<h1>iRankFinder: Experiments results</h1>
<?php
foreach($out as $line){
    echo $line."\n";
}
?>
  <script>
  $( function() {
    $( document ).tooltip({
      hide: { delay: 1000, effect: "explode", duration: 1000 },content: function(callback) { 
     callback($(this).prop('title')); 
  }
    });
  } );
  </script>
  <style>
  label {
    display: inline-block;
    width: 5em;
  }
  </style>
</body>
</html>

<?php include("cache_bottom.php"); ?> 
