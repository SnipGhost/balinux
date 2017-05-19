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
			echo system($ini['loadavg']);
			echo system($ini['iostat']);
			echo system($ini['netinf']);
			echo system($ini['toptlk']);
			echo system($ini['netcon']);
			echo system($ini['cpuinf']);
			echo system($ini['diskst']);
		?>
		</pre>

	</body>
</html>