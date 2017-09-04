From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Mon, 04 Sep 2017 13:21:42 +0100
Subject: [cip-dev] B@D: mapping serial device to the VM for ser2net
In-Reply-To: <000801d32559$c31e3450$495a9cf0$@toshiba.co.jp> (Daniel
	Sangorrin's message of "Mon, 4 Sep 2017 17:42:37 +0900")
References: <000801d32559$c31e3450$495a9cf0$@toshiba.co.jp>
Message-ID: <8760cyu015.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Daniel

"Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp> writes:

> Hi,
>
> I'm trying to setup ser2net for LAVA to access the serial port output of the 
> Renesas iwg20m board via local telnet from within the B at D virtual machine.
>
> I managed to get it working by using the Serial port settings window at
> the Oracle VM Virtualbox Manager (GUI). In particular, I used port mode 'Host Device'
> and '/dev/ttyUSB1' for the Path/Address (the device file name on the host).
>
> That maps the host's /dev/ttyUSB1 to the VM's /dev/ttyS0, so I also had
> to modify the /etc/ser2net.conf file and specify that port 2000 is supposed
> to use a 115200 baud rate.
>
> Although works fine (telnet localhost 2000), I see that you guys are using the 
> port 8020 for /dev/ttyUSB0 by default so I was wondering if there is a better strategy. 
> # I have also tried using the "USB" settings in the Virtualbox Manager (after installing 
> # the extension pack), but I haven't figured out how to it works yet
>

For the USB settings have you tried the config suggestions at the end of this page:
https://wiki.linuxfoundation.org/civilinfrastructureplatform/beagleboneblackboard
points 15-16 intended for windows but should also work with debian

I don't remember changing my local ser2net.conf and wondered whether
8020 was a default (or is that what you're saying), but it's been quite
a few months since I set it up!

Robert
