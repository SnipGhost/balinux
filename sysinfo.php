<html>
	<head>
		<title>SysInfo</title>
		<meta HTTP-EQUIV="REFRESH" CONTENT="10">
	</head>
	<body>

		<h1>Test sysinfo</h1>

		<pre>
			<?php
				echo system("top -b -n 1 | head -n 15");
			?>
		</pre>

	</body>
</html>