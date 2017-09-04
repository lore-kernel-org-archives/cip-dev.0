From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Mon, 4 Sep 2017 17:42:37 +0900
Subject: [cip-dev] B@D: mapping serial device to the VM for ser2net
Message-ID: <000801d32559$c31e3450$495a9cf0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

I'm trying to setup ser2net for LAVA to access the serial port output of the 
Renesas iwg20m board via local telnet from within the B at D virtual machine.

I managed to get it working by using the Serial port settings window at
the Oracle VM Virtualbox Manager (GUI). In particular, I used port mode 'Host Device'
and '/dev/ttyUSB1' for the Path/Address (the device file name on the host).

That maps the host's /dev/ttyUSB1 to the VM's /dev/ttyS0, so I also had
to modify the /etc/ser2net.conf file and specify that port 2000 is supposed
to use a 115200 baud rate.

Although works fine (telnet localhost 2000), I see that you guys are using the 
port 8020 for /dev/ttyUSB0 by default so I was wondering if there is a better strategy. 
# I have also tried using the "USB" settings in the Virtualbox Manager (after installing 
# the extension pack), but I haven't figured out how to it works yet

Thanks,
Daniel
