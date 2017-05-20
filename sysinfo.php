<html>
	<head>
		<title>SysInfo</title>
		<meta HTTP-EQUIV="REFRESH" CONTENT="30">
	</head>
	<body style="background-color: black; color: white;">

		<h1>SysInfo</h1>

		<br>

		<pre>
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
		</pre>

	</body>
</html>