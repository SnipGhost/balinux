<html>
	<head>
		<title>SysInfo</title>
		<meta HTTP-EQUIV="REFRESH" CONTENT="30">
	</head>
	<body>

		<h1>Test sysinfo</h1>

		<pre>
		<?php
			$ini = parse_ini_file("scripts.ini");
			echo "<br><hr><br>";
			echo system($ini['loadavg']);
			echo system($ini['iostat']);
			echo system($ini['netinf']);
			echo system($ini['toptlk']);
			echo system($ini['netcon']);
			echo system($ini['cpuinf']);
			echo system($ini['diskst']);
			echo "<br><hr><br>";
			echo system("top -b -n 1 | head -n 15");
		?>
		</pre>

	</body>
</html>