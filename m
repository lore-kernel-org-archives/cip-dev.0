From: trung.huynh.uw@rvc.renesas.com (Trung. Huynh)
Date: Wed, 10 Jan 2018 04:04:40 +0000
Subject: [cip-dev] B@D: iwg20m support
In-Reply-To: <001801d389a5$45b84630$d128d290$@toshiba.co.jp>
References: <1513231035-42479-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
	<8334d32c-edfb-76dd-3246-dca7cd9a9d62@siemens.com>
	<006d01d3786a$533dec70$f9b9c550$@toshiba.co.jp>
	<69bab283668346d480ae1f5957b054fb@rvc.renesas.com>
	<018401d38925$8188fc70$849af550$@toshiba.co.jp>
	<0f469353c2f94f64a2a55a3eb3f02317@rvc.renesas.com>
	<001801d389a5$45b84630$d128d290$@toshiba.co.jp>
Message-ID: <e50cd71ea4d444889b39b3a96876a59f@rvc.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear Daniel,

-----Original Message-----
From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp] 
Sent: Wednesday, January 10, 2018 6:55 AM
To: Trung. Huynh <trung.huynh.uw@rvc.renesas.com>
Cc: cip-dev at lists.cip-project.org; O365-Chan Duc. Vu <chan.vu.xv@renesas.com>; O365-Minh Thuy Dinh. Tran <minh.tran.xc@renesas.com>; O365-Anh The. Tran <anh.tran.jc@renesas.com>; Binh Thanh. Nguyen <binh.nguyen.uw@rvc.renesas.com>; O365-Yoshinori Kaneko <yoshinori.kaneko.xg@renesas.com>; O365-Yasushi Onishi <yasushi.onishi.xc@renesas.com>
Subject: RE: [cip-dev] B at D: iwg20m support

Dear Trung san,

> -----Original Message-----
> From: Trung. Huynh [mailto:trung.huynh.uw at rvc.renesas.com]
> Sent: Tuesday, January 09, 2018 7:41 PM Dear Daniel,
> 
> Yes, I tried it and working well, but I want to custom some devices 
> under kernel layer to execute our test cases as well as packing some 
> dependencies To do that I must expand file system that why I got this issue.

Please could you read my e-mail  and answer my question about your plan?. 

Thanks,
Daniel

> -----Original Message-----
> From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp]
> Sent: Tuesday, January 9, 2018 3:41 PM
> To: Trung. Huynh <trung.huynh.uw@rvc.renesas.com>
> Cc: cip-dev at lists.cip-project.org; O365-Chan Duc. Vu 
> <chan.vu.xv@renesas.com>; O365-Minh Thuy Dinh. Tran 
> <minh.tran.xc@renesas.com>; O365-Anh The. Tran 
> <anh.tran.jc@renesas.com>; Binh Thanh. Nguyen 
> <binh.nguyen.uw@rvc.renesas.com>; O365-Yoshinori Kaneko 
> <yoshinori.kaneko.xg@renesas.com>; O365-Yasushi Onishi 
> <yasushi.onishi.xc@renesas.com>
> Subject: RE: [cip-dev] B at D: iwg20m support
> 
> Dear Trung san,
> 
> First of all, please could you give me some feedback about the LAVA 
> configuration files and AWS links that I sent to the list before holidays?. Did you try them and did they work for you?.
> 
> See my answers below.
> 
> > -----Original Message-----
> > From: Trung. Huynh [mailto:trung.huynh.uw at rvc.renesas.com]
> > Sent: Tuesday, January 02, 2018 6:37 PM
> > To: Daniel Sangorrin
> > Cc: cip-dev at lists.cip-project.org; O365-Chan Duc. Vu; O365-Minh Thuy 
> > Dinh. Tran; O365-Anh The. Tran; Binh Thanh. Nguyen; O365- Yoshinori 
> > Kaneko; O365-Yasushi Onishi
> > Subject: RE: [cip-dev] B at D: iwg20m support
> >
> > Dear Daniel,
> >
> > One important thing is how big is root fs size get maximal? Is it limited?
> > Your configuration on iwg20m is to assign 8 ramdisks with enlargement of each block 100MB approx:
> >
> > CONFIG_BLK_DEV_RAM=y
> > CONFIG_BLK_DEV_RAM_COUNT=8
> > CONFIG_BLK_DEV_RAM_SIZE=102400
> > CONFIG_EXT4_FS=y
> > CONFIG_EXT4_USE_FOR_EXT2=y
> > CONFIG_USB_XHCI_RCAR=n
> 
> Currently, "my configuration" is just the mainstream 
> shmobile_defconfig (as suggested by Chris if I remember correctly). If 
> you need to change the default configuration on cip-core upstream, 
> please send me a defconfig (make savedefconfig) or a list of configuration options that should be added to shmobile_defconfig. However, in this case I think those options are very dependent on what you are putting on your filesystem so it might be a better idea if you create your own private branch and change the configuration as you need.
> 
> If you actually plan to submit the tests/dependencies to cip-core then 
> adding those config options to cip-core would actually make sense. Is this your plan?

Yes, we would like to submit those configurations to cip-core upstream then everyone can use it as a baseline.
Before doing it, I want to make sure on which I've already done will be ok.
Of course the new configuration get branch as an option to do our test cases if it's passed through

Regarding shmobile_defconfig, attachment shows up for you.
Thank you.

> 
> > If we try to test more function as our wish (more dependencies in ramdisk), assuming that the root fs size could be 150MB.
> > For G1M 1GB of RAM, just increase CONFIG_BLK_DEV_RAM_SIZE to 250000 
> > and reduce CONFIG_BLK_DEV_RAM_COUNT to 4
> iWave.
> 
> By the way, you might also need to modify the u-boot settings so that the ramdisk does not overlap with the kernel or the device tree.
> And the LAVA configuration files.
> 
> Thanks,
> Daniel
> 
> 
> > -----Original Message-----
> > From: cip-dev-bounces at lists.cip-project.org
> > [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Daniel 
> > Sangorrin
> > Sent: Tuesday, December 19, 2017 8:40 AM
> > To: 'Daniel Wagner' <daniel.wagner@siemens.com>
> > Cc: cip-dev at lists.cip-project.org
> > Subject: Re: [cip-dev] B at D: iwg20m support
> >
> > Dear Daniel Wagner,
> >
> > > -----Original Message-----
> > > From: Daniel Wagner [mailto:daniel.wagner at siemens.com]
> > > Sent: Monday, December 18, 2017 8:36 PM
> > > To: Daniel Sangorrin
> > > Cc: cip-dev at lists.cip-project.org
> > > Subject: Re: [cip-dev] B at D: iwg20m support
> > >
> > > Hi Daniel,
> > >
> > > On 12/14/2017 06:57 AM, Daniel Sangorrin wrote:
> > > > Hi Trung-san, Robert and all
> > > >
> > > > I received the AWS credentials from Agustin and uploaded the 
> > > > cip-core binaries for the Renesas iwg20m board.
> > > >
> > > > https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-
> > > > co re /iwg20m/core-image-minimal-iwg20m.cpio.gz
> > > > https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-
> > > > co
> > > > re
> > > > /iwg20m/r8a7743-iwg20d-q7.dtb
> > > > https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-
> > > > co
> > > > re
> > > > /iwg20m/uImage
> > >
> > > Just out of curiosity: how did you build the root fs? The naming 
> > > indicates that you used Yocto. I am still setting up my test 
> > > environment for rt testing and wrote two kas files to create me a root fs:
> > >
> > > https://github.com/igaw/cip-rt-misc/blob/master/docs/kas-bbb.yml
> > > https://github.com/igaw/cip-rt-misc/blob/master/docs/kas-minnowboa
> > > rd
> > > .y
> > > ml
> > >
> > > They are not self contained yet. Will fixed that right now. The 
> > > idea that you can write
> > >
> > > 	kas build kas-bbb.yml
> > >
> > > and you get a root fs for testing.
> >
> > The CIP Core rootfs was built using Deby (poky build system + 
> > meta-debian). You can see a tutorial in the CIP wiki and a more up-to- date README and kas file in the source code.
> >
> > https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip-cor
> > e-
> > quickstart
> > https://gitlab.com/cip-project/cip-core/blob/master/deby/poky/meta-c
> > ip
> > -iwg20m/README.IWG20M.txt
> > https://gitlab.com/cip-project/cip-core/blob/master/deby/poky/meta-c
> > ip
> > -iwg20m/kas-iwg20m.yml
> >
> > An overview of the CIP Core is here:
> > https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip-cor
> > e https://gitlab.com/cip-project/cip-core/blob/master/deby/README.md
> >
> > For the BBB please check this other Readme and kas file:
> > https://gitlab.com/cip-project/cip-core/blob/master/deby/poky/meta-c
> > ip
> > -bbb/README.BBB.txt
> > https://gitlab.com/cip-project/cip-core/blob/master/deby/poky/meta-c
> > ip
> > -bbb/kas-bbb.yml
> >
> > You can add the packages "openssh nfs-utils rt-tests strace procps", they are available in meta-debian.
> >
> > Unfortunately, you cannot simply add "meta-qt5" because it may 
> > conflict with meta-debian. Instead you would need to use meta- debian qt5 recipes (only if you really need qt5 for testing RT).
> >
> > Thanks,
> > Daniel Sangorrin
> >
> >
> >
> >
> >
> >
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
> 
> 



-------------- next part --------------
A non-text attachment was scrubbed...
Name: shmobile_defconfig
Type: application/octet-stream
Size: 105521 bytes
Desc: shmobile_defconfig
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180110/80f6a0ec/attachment-0001.obj>
