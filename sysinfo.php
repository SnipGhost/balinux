<html>
	<head>
		<title>SysInfo</title>
		<meta HTTP-EQUIV="REFRESH" CONTENT="<?php echo $updateTime;?>">
	</head>
	<body style="background-color: black; color: white; font-family: monospace;">

		<center><h1>Collected system information by <?php echo date('H:i:s d.m.Y')?></h1></center>

		<?php
			$hdr = getallheaders();
			$proxys = $hdr['X-NGX-VERSION'];
			$hostnm = explode(' ', $_SERVER['SERVER_SOFTWARE']);
			$server = $_SERVER['SERVER_ADDR'].":".$hdr['X-Apache-Port']." (".$hostnm[0].")";
			$client = $hdr['X-Real-IP'].":".$hdr['X-Real-Port'];
			$redirc = $_SERVER['REMOTE_ADDR'].":".$_SERVER['REMOTE_PORT'];
			echo "<div align=\"right\">";
			echo "<table style=\"color: aqua; font-weight: bold; margin-right: 20px;\">";
			echo "<tr><td> nginx:</td><td>".$proxys."</td></tr>";
			echo "<tr><td>apache:</td><td>".$server."</td></tr>";
			echo "<tr><td>client (nginx side):</td><td>".$client."</td></tr>";
			echo "<tr><td>client (apache side):</td><td>".$redirc."</td></tr>";
			echo "</table></div>";
		?>

		<br>

		<?php
			$ini = parse_ini_file($iniFile);
			echo "<br><span> Load Average </span><br>";
			echo passthru($ini['loadavg'])."<br>";
			echo "<br><span> Disks statistics </span><br>";
			echo passthru($ini['iostat'])."<br>";
			echo "<br><span> Network load in ".$updateTime." sec </span><br>";
			echo passthru($ini['netinf'])."<br>";
			echo "<br><span> Top talkers in ".$updateTime." sec </span><br>";
			echo passthru($ini['toptlk'])."<br>";
			echo "<br><span> Network connections </span><br>";
			echo passthru($ini['netcon'])."<br>";
			echo "<br><span> CPU load in ".$updateTime." sec </span><br>";
			echo passthru($ini['cpuinf'])."<br>";
			echo "<br><span> Filesystems usage </span><br>";
			echo passthru($ini['diskst'])."<br>";
		?>

		<div align="right"><span style="color: lime; margin-right: 30px;">By Mikhail Kucherenko, 05.2017</span></div>
		
	</body>
</html>