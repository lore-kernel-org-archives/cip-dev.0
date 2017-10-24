From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 24 Oct 2017 14:17:17 +0900
Subject: [cip-dev] Status of cip-core
In-Reply-To: <TY1PR06MB0702C3FFC11A847C16DBD931B7460@TY1PR06MB0702.apcprd06.prod.outlook.com>
References: <003901d34be2$acfa4010$06eec030$@toshiba.co.jp>
	<TY1PR06MB0702C3FFC11A847C16DBD931B7460@TY1PR06MB0702.apcprd06.prod.outlook.com>
Message-ID: <004001d34c87$5c8fcbe0$15af63a0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Chris,

> -----Original Message-----
> From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
> Sent: Tuesday, October 24, 2017 3:23 AM
> To: Daniel Sangorrin; cip-dev at lists.cip-project.org; 'Jan Kiszka'
> Subject: RE: [cip-dev] Status of cip-core
> 
> Hello Daniel,
> 
> Thank you for the update.
> 
> > - modules.tgz is not generated for iwg20m (for bbb it is): I have to investigate
> > why but I think it is not a big problem since they are included in the file
> > system images. Probably the reason is just that shmobile_defconfig has
> > modules disabled.
> 
> Correct :)

I have noticed that the shmobile_defconfig from the official linux-cip repo
is quite different from the one at https://github.com/renesas-rz/renesas-cip.

Previously I tested the official kernel using a ramdisk and it was successful so
I didn't notice the difference. But today I've tried to boot the official kernel
with the SD Card file system and it didn't work.

One problem was that EXT3/4 wasn't enabled. I decided to use renesas-cip's
shmobile_defconfig to build the official linux-cip kernel. However, I got a build
error because
https://gitlab.com/cip-project/linux-cip/blob/linux-4.4.y-cip/drivers/usb/host/xhci-rcar.c
references a firmware called  "r8a779x_usb3_v1.dlmem" which wasn't available
on the official kernel. I could solve that either by copying the firmware from renesas-cip 
or by commenting out the corresponding configuration flags.

I managed to build the official kernel but still I couldn't get it to boot from the SD Card.
# By the way, I noticed that the mmc numbering also changed (mmcblk0p2 was working
on renesas-cip kernel as the 2nd partition of the SD Card, but for the official kernel that
was a partition on the eMMC and the kernel could not recognize mmcblk2p2).

I wonder if this problem comes from the device tree. On the renesas-cip repository
there was a r8a7743-iwgm.dts file that worked fine, but on the official repository
the one with the closest name was r8a7743-iwg20d-q7.dts. This one worked fine
when I boot from a ramdisk but not when I boot from the SD Card.

Should I use renesas-cip kernel again?
I noticed that the new versions are been merged. I was using renesas-cip's v4.4.69-cip4
but I can see a newer branch called  v4.4.83-cip8

Thanks,
Daniel
