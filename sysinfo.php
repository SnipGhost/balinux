<html>
	<head>
		<title>SysInfo</title>
		<meta HTTP-EQUIV="REFRESH" CONTENT="<?php echo $updateTime;?>">
	</head>
	<body style="background-color: black; color: white; font-family: monospace;">

		<h1>Collected system information by <?php echo date('H:i:s d.m.Y')?> UTC</h1>

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
		
	</body>
</html>