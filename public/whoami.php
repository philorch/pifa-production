<?
echo "<title>P I F A</title>\n";
echo "I am <b>";
passthru('hostname');
echo "</b> ..... this site is for www.pifa.org.<br><hr size=1>\nCurrent time is<b>";
echo date('l jS \of F Y h:i:s A');
echo "<br>IP: ";
echo $_SERVER['REMOTE_ADDR'];

if ( isset ($_SERVER['HTTP_X_FORWARDED_FOR']) ) {
        echo "<br>X-Forwarded-For: ";
        echo $_SERVER['HTTP_X_FORWARDED_FOR'];
}
echo "</b>\n";
//if(extension_loaded('apc') && ini_get('apc.enabled'))
//{
//    echo "APC enabled!";
//}
//else {
//    echo "APC disabled!";
//}

?>

