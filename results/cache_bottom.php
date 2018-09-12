 <?php

// open the cache file for writing
if(!empty($cachefile)){
    $fp = @fopen($cachefile, 'w'); 
    // save the contents of output buffer to the file
    @fwrite($fp, ob_get_contents());
    // close the file
    @fclose($fp);         
}
// Send the output to the browser
ob_end_flush();    
?> 