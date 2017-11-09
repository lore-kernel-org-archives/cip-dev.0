From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 9 Nov 2017 10:11:37 +0000
Subject: [cip-dev] Status of cip-core
In-Reply-To: <004001d34c87$5c8fcbe0$15af63a0$@toshiba.co.jp>
References: <003901d34be2$acfa4010$06eec030$@toshiba.co.jp>
	<TY1PR06MB0702C3FFC11A847C16DBD931B7460@TY1PR06MB0702.apcprd06.prod.outlook.com>
	<004001d34c87$5c8fcbe0$15af63a0$@toshiba.co.jp>
Message-ID: <TY1PR06MB07021E908A4C6E2A762DC3E4B7570@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel,

Apologies for the slow response. Lots of ramblings below, happy to set up a call if it's easier to go through the details.

> From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp]
> Sent: 24 October 2017 06:17
> 
> Hello Chris,
> 
> > -----Original Message-----
> > From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
> > Sent: Tuesday, October 24, 2017 3:23 AM
> > To: Daniel Sangorrin; cip-dev at lists.cip-project.org; 'Jan Kiszka'
> > Subject: RE: [cip-dev] Status of cip-core
> >
> > Hello Daniel,
> >
> > Thank you for the update.
> >
> > > - modules.tgz is not generated for iwg20m (for bbb it is): I have to
> > > investigate why but I think it is not a big problem since they are
> > > included in the file system images. Probably the reason is just that
> > > shmobile_defconfig has modules disabled.
> >
> > Correct :)
> 
> I have noticed that the shmobile_defconfig from the official linux-cip repo is
> quite different from the one at https://github.com/renesas-rz/renesas-cip.

Let me explain...

The renesas-rz github website is used to host the complete Yocto BSP package for the RZ/G iWave platforms. This is used as a basis for the "Renesas RZ/G Linux Platform" which was launched in October.

This BSP is based on the CIP Kernel, but as you can see has a lot of patches applied on top. The main reason for these additional patches is that the iwg20m platform is not yet fully supported upstream.

If using the above BSP for your testing, I'd recommend that you stick with the v4.4.55-cip3 branch. This has been fully verified and should be working.

Whilst Renesas are continuously working on the renesas-rz github repository, in tandem we are also upstreaming support to the mainline Kernel for the iwg20m platform. Periodically once a new Kernel release has been made we are backporting support to the official CIP Kernel.

The latest CIP Kernel (v4.4.92-cip11) includes support for clk, pinctrl, GPIO, Ethernet and eMMC on the iwg20m platform.


> 
> Previously I tested the official kernel using a ramdisk and it was successful so
> I didn't notice the difference. But today I've tried to boot the official kernel
> with the SD Card file system and it didn't work.

Currently the official CIP Kernel does not support SD on the iwg20m. Support upstream will be included in Kernel v4.15. We plan to backport support once v4.15 is released, but can backport when v4.15-rc1 is out if there is an urgent need.

> 
> One problem was that EXT3/4 wasn't enabled.

Yes. Historically shmobile_defconfig doesn't have ext3/4 enabled upstream :( I guess one option would be to enable this on the CIP Kernel?

> I decided to use renesas-cip's
> shmobile_defconfig to build the official linux-cip kernel. However, I got a
> build error because https://gitlab.com/cip-project/linux-cip/blob/linux-4.4.y-
> cip/drivers/usb/host/xhci-rcar.c
> references a firmware called  "r8a779x_usb3_v1.dlmem" which wasn't
> available on the official kernel. I could solve that either by copying the
> firmware from renesas-cip or by commenting out the corresponding
> configuration flags.

There may well be other differences between the config used in the renesas-rz BSP compared to the upstream/CIP version. It might be best to stick with the version in the CIP Kernel and just enable EXT3/4 as required. This is what we use to test when backporting to the CIP Kernel.

> 
> I managed to build the official kernel but still I couldn't get it to boot from the
> SD Card.

Again, due to lack of SD support in the official Kernel (see r8a7743-iwg20d-q7.dts).

> # By the way, I noticed that the mmc numbering also changed (mmcblk0p2
> was working on renesas-cip kernel as the 2nd partition of the SD Card, but for
> the official kernel that was a partition on the eMMC and the kernel could not
> recognize mmcblk2p2).
> 
> I wonder if this problem comes from the device tree. On the renesas-cip
> repository there was a r8a7743-iwgm.dts file that worked fine, but on the
> official repository the one with the closest name was r8a7743-iwg20d-q7.dts.
> This one worked fine when I boot from a ramdisk but not when I boot from
> the SD Card.
> 
> Should I use renesas-cip kernel again?

As you have no need for the entire BSP (you only need the Kernel), I'd recommend using the official CIP Kernel. For now this would mean that you'd need to either use NFS or eMMC for your RFS. If using eMMC you'll need to enable EXT3/4 on top of shmobile_defconfig.

This has the added benefit that CIP Core will use and test the official CIP Kernel, rather than Renesas' out of tree BSP version.

> I noticed that the new versions are been merged. I was using renesas-cip's
> v4.4.69-cip4 but I can see a newer branch called  v4.4.83-cip8

v4.4.55-cip3 is the only version properly tested. I think the other versions are just rebases.

Binh-san, could you confirm the current status of the newer branches on renesas-rz?


Kind regards, Chris

> 
> Thanks,
> Daniel
> 
