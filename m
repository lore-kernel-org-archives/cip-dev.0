From: trung.huynh.uw@rvc.renesas.com (Trung. Huynh)
Date: Tue, 2 Jan 2018 09:37:14 +0000
Subject: [cip-dev] B@D: iwg20m support
In-Reply-To: <006d01d3786a$533dec70$f9b9c550$@toshiba.co.jp>
References: <1513231035-42479-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
	<8334d32c-edfb-76dd-3246-dca7cd9a9d62@siemens.com>
	<006d01d3786a$533dec70$f9b9c550$@toshiba.co.jp>
Message-ID: <69bab283668346d480ae1f5957b054fb@rvc.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear Daniel,

One important thing is how big is root fs size get maximal? Is it limited?
Your configuration on iwg20m is to assign 8 ramdisks with enlargement of each block 100MB approx:

CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=8
CONFIG_BLK_DEV_RAM_SIZE=102400
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_USB_XHCI_RCAR=n

If we try to test more function as our wish (more dependencies in ramdisk), assuming that the root fs size could be 150MB.
For G1M 1GB of RAM, just increase CONFIG_BLK_DEV_RAM_SIZE to 250000 and reduce CONFIG_BLK_DEV_RAM_COUNT to 4 iWave.

-> Output is booting failed, attachment to show what occurring.

Regards,
Trung

-----Original Message-----
From: cip-dev-bounces@lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Daniel Sangorrin
Sent: Tuesday, December 19, 2017 8:40 AM
To: 'Daniel Wagner' <daniel.wagner@siemens.com>
Cc: cip-dev at lists.cip-project.org
Subject: Re: [cip-dev] B at D: iwg20m support

Dear Daniel Wagner,

> -----Original Message-----
> From: Daniel Wagner [mailto:daniel.wagner at siemens.com]
> Sent: Monday, December 18, 2017 8:36 PM
> To: Daniel Sangorrin
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] B at D: iwg20m support
> 
> Hi Daniel,
> 
> On 12/14/2017 06:57 AM, Daniel Sangorrin wrote:
> > Hi Trung-san, Robert and all
> >
> > I received the AWS credentials from Agustin and uploaded the 
> > cip-core binaries for the Renesas iwg20m board.
> >
> > https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core
> > /iwg20m/core-image-minimal-iwg20m.cpio.gz
> > https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core
> > /iwg20m/r8a7743-iwg20d-q7.dtb 
> > https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core
> > /iwg20m/uImage
> 
> Just out of curiosity: how did you build the root fs? The naming 
> indicates that you used Yocto. I am still setting up my test 
> environment for rt testing and wrote two kas files to create me a root fs:
> 
> https://github.com/igaw/cip-rt-misc/blob/master/docs/kas-bbb.yml
> https://github.com/igaw/cip-rt-misc/blob/master/docs/kas-minnowboard.y
> ml
> 
> They are not self contained yet. Will fixed that right now. The idea 
> that you can write
> 
> 	kas build kas-bbb.yml
> 
> and you get a root fs for testing.

The CIP Core rootfs was built using Deby (poky build system + meta-debian). You can see a tutorial in the CIP wiki and a more up-to-date README and kas file in the source code.

https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip-core-quickstart
https://gitlab.com/cip-project/cip-core/blob/master/deby/poky/meta-cip-iwg20m/README.IWG20M.txt
https://gitlab.com/cip-project/cip-core/blob/master/deby/poky/meta-cip-iwg20m/kas-iwg20m.yml

An overview of the CIP Core is here:
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip-core
https://gitlab.com/cip-project/cip-core/blob/master/deby/README.md

For the BBB please check this other Readme and kas file:
https://gitlab.com/cip-project/cip-core/blob/master/deby/poky/meta-cip-bbb/README.BBB.txt
https://gitlab.com/cip-project/cip-core/blob/master/deby/poky/meta-cip-bbb/kas-bbb.yml

You can add the packages "openssh nfs-utils rt-tests strace procps", they are available in meta-debian.

Unfortunately, you cannot simply add "meta-qt5" because it may conflict with meta-debian. Instead you would need to use meta-debian qt5 recipes (only if you really need qt5 for testing RT).

Thanks,
Daniel Sangorrin






_______________________________________________
cip-dev mailing list
cip-dev at lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
