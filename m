From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 11 Jan 2018 14:49:48 +0900
Subject: [cip-dev] B@D: iwg20m support
In-Reply-To: <bacb02dc0d194be8b13138e98cf8aa33@rvc.renesas.com>
References: <1513231035-42479-1-git-send-email-daniel.sangorrin@toshiba.co.jp>	<8334d32c-edfb-76dd-3246-dca7cd9a9d62@siemens.com>
	<006d01d3786a$533dec70$f9b9c550$@toshiba.co.jp>
	<69bab283668346d480ae1f5957b054fb@rvc.renesas.com>
	<018401d38925$8188fc70$849af550$@toshiba.co.jp>
	<0f469353c2f94f64a2a55a3eb3f02317@rvc.renesas.com>
	<001801d389a5$45b84630$d128d290$@toshiba.co.jp>
	<e50cd71ea4d444889b39b3a96876a59f@rvc.renesas.com>
	<000f01d389d3$715dbdf0$541939d0$@toshiba.co.jp>
	<bacb02dc0d194be8b13138e98cf8aa33@rvc.renesas.com>
Message-ID: <008f01d38a9f$fdce8680$f96b9380$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear Trung san,

> -----Original Message-----
> From: Trung. Huynh [mailto:trung.huynh.uw at rvc.renesas.com]
..
> >
> > Please let me confirm just in case. Am I right if I say that you plan to you submit not only the kernel configuration flags
> > but also test dependency definitions to cip core, and the corresponding yaml files for B at D?.
> > If that's correct I will be glad to accept them.
> 
> Yes, we would love to be apart in B at D with our contribution for who need to take our test suites as a testing plan.
> We do not promise this is to become excellent suites but we do our best to have a good things that somebody to
> think about at first

OK, that's great!

> > > Regarding shmobile_defconfig, attachment shows up for you.
> >
> > Thanks, you only changed these flags right?
> > CONFIG_BLK_DEV_RAM_SIZE=250000
> > CONFIG_BLK_DEV_RAM_COUNT=4
> 
> You're right, the cip-core I pulled down from global site without changing anything, it just be changed those flags
> and built under standalone of Linaro's cross compiler.

I just realized that you might be using the wrong branch of cip-core. You should be using the "master" branch not the "jethro"
one which was used and frozen for the cip-core release and the quickstart wiki page (the master branch depends on "morty"). 
The jethro branch was using a non-official CIP kernel repository (https://github.com/renesas-rz/renesas-cip) but on the 
master branch we are using the official CIP kernel.  For that reason, shmobile_defconfig on the main branch is different
and some drivers have not been merged yet. 
Please could you check which branch you are using?

I have added your kernel configuration changes:
https://gitlab.com/cip-project/cip-core/commit/c1efa6325909815731abe0b69ec7e19e2e56aee7
Please let me know if that works for you.

Could you show me how you built cip-core using Linaro's cross compiler?
By the way, cip-core builds its own toolchain, are you using Linaro's to reduce build time? 

Thanks,
Daniel

> > > > > -----Original Message-----
> > > > > From: cip-dev-bounces at lists.cip-project.org
> > > > > [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Daniel
> > > > > Sangorrin
> > > > > Sent: Tuesday, December 19, 2017 8:40 AM
> > > > > To: 'Daniel Wagner' <daniel.wagner@siemens.com>
> > > > > Cc: cip-dev at lists.cip-project.org
> > > > > Subject: Re: [cip-dev] B at D: iwg20m support
> > > > >
> > > > > Dear Daniel Wagner,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Daniel Wagner [mailto:daniel.wagner at siemens.com]
> > > > > > Sent: Monday, December 18, 2017 8:36 PM
> > > > > > To: Daniel Sangorrin
> > > > > > Cc: cip-dev at lists.cip-project.org
> > > > > Subject: Re: [cip-dev] B at D: iwg20m support
> > > > > >
> > > > > > Hi Daniel,
> > > > > >
> > > > > > On 12/14/2017 06:57 AM, Daniel Sangorrin wrote:
> > > > > > > Hi Trung-san, Robert and all
> > > > > > >
> > > > > > > I received the AWS credentials from Agustin and uploaded the
> > > > > > > cip-core binaries for the Renesas iwg20m board.
> > > > > > >
> > > > > > > https://s3-us-west-2.amazonaws.com/download.cip-project.org/ci
> > > > > > > p- co re /iwg20m/core-image-minimal-iwg20m.cpio.gz
> > > > > > > https://s3-us-west-2.amazonaws.com/download.cip-project.org/ci
> > > > > > > p-
> > > > > > > co
> > > > > > > re
> > > > > > > /iwg20m/r8a7743-iwg20d-q7.dtb
> > > > > > > https://s3-us-west-2.amazonaws.com/download.cip-project.org/ci
> > > > > > > p-
> > > > > > > co
> > > > > > > re
> > > > > > > /iwg20m/uImage
> > > > > >
> > > > > > Just out of curiosity: how did you build the root fs? The naming
> > > > > > indicates that you used Yocto. I am still setting up my test
> > > > > > environment for rt testing and wrote two kas files to create me a root fs:
> > > > > >
> > > > > > https://github.com/igaw/cip-rt-misc/blob/master/docs/kas-bbb.yml
> > > > > > https://github.com/igaw/cip-rt-misc/blob/master/docs/kas-minnowb
> > > > > > oa
> > > > > > rd
> > > > > > .y
> > > > > > ml
> > > > > >
> > > > > > They are not self contained yet. Will fixed that right now. The
> > > > > > idea that you can write
> > > > > >
> > > > > > 	kas build kas-bbb.yml
> > > > > >
> > > > > > and you get a root fs for testing.
> > > > >
> > > > > The CIP Core rootfs was built using Deby (poky build system +
> > > > > meta-debian). You can see a tutorial in the CIP wiki and a more up-to- date README and kas file in the source code.
> > > > >
> > > > > https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip-c
> > > > > or
> > > > > e-
> > > > > quickstart
> > > > > https://gitlab.com/cip-project/cip-core/blob/master/deby/poky/meta
> > > > > -c
> > > > > ip
> > > > > -iwg20m/README.IWG20M.txt
> > > > > https://gitlab.com/cip-project/cip-core/blob/master/deby/poky/meta
> > > > > -c
> > > > > ip
> > > > > -iwg20m/kas-iwg20m.yml
> > > > >
> > > > > An overview of the CIP Core is here:
> > > > > https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip-c
> > > > > or e
> > > > > https://gitlab.com/cip-project/cip-core/blob/master/deby/README.md
> > > > >
> > > > > For the BBB please check this other Readme and kas file:
> > > > > https://gitlab.com/cip-project/cip-core/blob/master/deby/poky/meta
> > > > > -c
> > > > > ip
> > > > > -bbb/README.BBB.txt
> > > > > https://gitlab.com/cip-project/cip-core/blob/master/deby/poky/meta
> > > > > -c
> > > > > ip
> > > > > -bbb/kas-bbb.yml
> > > > >
> > > > > You can add the packages "openssh nfs-utils rt-tests strace procps", they are available in meta-debian.
> > > > >
> > > > > Unfortunately, you cannot simply add "meta-qt5" because it may
> > > > > conflict with meta-debian. Instead you would need to use meta- debian qt5 recipes (only if you really need qt5 for testing RT).
> > > > >
> > > > > Thanks,
> > > > > Daniel Sangorrin
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > _______________________________________________
> > > > > cip-dev mailing list
> > > > > cip-dev at lists.cip-project.org
> > > > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > > >
> > > >
> > >
> > >
> 
> 
