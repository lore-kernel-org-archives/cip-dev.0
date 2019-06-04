From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 4 Jun 2019 09:17:09 +0000
Subject: [cip-dev] [isar-cip-core] iwg20m: temporary patch for review
In-Reply-To: <TY2PR01MB3323A8D6687CA6A6167A4D01D0150@TY2PR01MB3323.jpnprd01.prod.outlook.com>
References: <20190604061412.8886-1-daniel.sangorrin@toshiba.co.jp>
	<TYAPR01MB2285186B782CB310BB133B42B7150@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<TY2PR01MB3323A8D6687CA6A6167A4D01D0150@TY2PR01MB3323.jpnprd01.prod.outlook.com>
Message-ID: <TYAPR01MB22856FCFA39D3863764C781EB7150@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel,

> From: daniel.sangorrin at toshiba.co.jp <daniel.sangorrin@toshiba.co.jp>
> Sent: 04 June 2019 09:51
> 
> Hello Chris,
> 
> > From: Chris Paterson <Chris.Paterson2@renesas.com>
> <snip>
> > > +# Boot partition files
> > > +DTB_FILE = "r8a7743-iwg20d-q7.dtb"
> >
> > I wonder if it is better to use r8a7743-iwg20d-q7-dbcm-ca.dtb instead. This
> does the same as
> > r8a7743-iwg20d-q7.dtb but also enables the add-on board that comes with
> most iwg20d kits.
> > The add-on board adds HDMI output, CAN bus and various SCIF interfaces.
> 
> OK, I will use that one then.
> 
> > > +# [Note] u-boot is in an SPI flash memory and needs a JTAG debugger to
> re-
> > > flash
> >
> > It is also possible to write to the SPI from Linux, but having JTAG as backup
> is recommended as there is no backup
> > SPI if the write goes wrong.
> 
> Yeah, it's a bit risky.
> By the way, the u-boot in the board is from 2013. Is it possible to use a newer
> one? If yes, do you know the name of the configuration file/entrypoint?

Alas no. The u-boot provided by the Renesas RZ/G1 BSP [1] is still only based on v2013.01.01. 

[1] https://github.com/renesas-rz/meta-renesas/blob/certified-linux-v2.1.1/meta-rzg1/recipes-bsp/u-boot/u-boot_2013.01.01.bb

Kind regards, Chris

> 
> Thanks,
> Daniel
> 
> 
> 
> 
> >
> > Kind regards, Chris
> >
> > > +
> > > +# SDCard Boot partition (copies files in IMAGE_BOOT_FILES)
> > > +part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --
> label
> > > boot --align 1 --size 32M --extra-space 0
> > > +
> > > +# Rootfs partition
> > > +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align
> > > 1024 --size 2G --active
> > > +
> > > +bootloader --append "rootwait console=ttySC0,115200"
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > cip-dev mailing list
> > > cip-dev at lists.cip-project.org
> > > https://lists.cip-project.org/mailman/listinfo/cip-dev
