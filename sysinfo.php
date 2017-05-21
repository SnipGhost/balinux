<html>
	<head>
		<title>SysInfo</title>
		<meta HTTP-EQUIV="REFRESH" CONTENT="30">
	</head>
	<body style="background-color: black; color: white; font-family: monospace;">

		<h1>Collected system information by <?php echo $_SERVER['REQUEST_TIME'];?> UTC</h1>

		<br>

		<?php
			$ini = parse_ini_file($iniFile);
			echo passthru($ini['loadavg']);
			echo passthru($ini['iostat']);
			echo passthru($ini['netinf']);
			echo passthru($ini['toptlk']);
			echo passthru($ini['netcon']);
			echo passthru($ini['cpuinf']);
			echo passthru($ini['diskst']);
		?>
		
	</body>
</html>