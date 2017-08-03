From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 3 Aug 2017 13:18:45 +0000
Subject: [cip-dev] Project-X (minimal root filesystem) for renesas board
In-Reply-To: <004101d2f6ca$76f8f6e0$64eae4a0$@toshiba.co.jp>
References: <001001d2efdc$d8312a30$88937e90$@toshiba.co.jp>
	<390B4EACA1A32748BA6BC7F859F7D7165D08C00F@GSJPOSKDCEMBX16.service.hitachi.net>
	<004101d2efeb$c53518b0$4f9f4a10$@toshiba.co.jp>
	<390B4EACA1A32748BA6BC7F859F7D7165D08C27D@GSJPOSKDCEMBX16.service.hitachi.net>
	<003c01d2f06f$ddc420e0$994c62a0$@toshiba.co.jp>
	<5954B871.2000601@codethink.co.uk>
	<004101d2f6ca$76f8f6e0$64eae4a0$@toshiba.co.jp>
Message-ID: <TY1PR06MB07022139C523225AAC899853B7B10@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel, all,

> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-
> project.org] On Behalf Of Daniel Sangorrin
> Sent: 07 July 2017 03:41
> 
> Hi Agustin, Chris
> 
> > -----Original Message-----
> > From: cip-dev-bounces at lists.cip-project.org
> > [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Agustin
> > Benito Bethencourt
> > Sent: Thursday, June 29, 2017 5:21 PM
> > To: cip-dev at lists.cip-project.org
> > Subject: Re: [cip-dev] Project-X (minimal root filesystem) for renesas
> > board
> >
> > Hi,
> >
> > On 29/06/17 02:37, Daniel Sangorrin wrote:
> > > Hi Koguchi-san,
> > >
> > >> -----Original Message-----
> > >> From: ???? / KOGUCHI?TAKUO
> [mailto:takuo.koguchi.sw at hitachi.com]
> > >> Sent: Wednesday, June 28, 2017 6:08 PM
> > >> To: 'Daniel Sangorrin'; cip-dev at lists.cip-project.org
> > >> Cc: 'Chris Paterson'
> > >> Subject: RE: RE: Project-X (minimal root filesystem) for renesas
> > >> board
> > >>
> > >> Daniel-san,
> > >>
> > >>> I think this is not a good approach. We would need to have a new
> > >>> linux-cip folder for each release.
> > >> Let make it clear. Will you please describe your recommendation?
> > >
> > > Yes, please see below.
> > >
> > >>> Patches for the cyclone board should be on its own CIP kernel
> > >>> repository (where you can merge cip releases and add tags). Then,
> > >>> we can choose which version we want by specifying the repository and
> tag/commit_id.
> > >> Good point.  But  CIP kernel repository is curerntly used for
> > >> release assuming it is tested. And CycloneV is not supported by CIP
> > >> at
> > this
> > >> moment. So I put the patches in the yocto project way.
> > >
> > > I didn't mean to put it on Ben's CIP repository rather on github.
> > > This way you can better maintain your "out-of-tree" cyclone V
> > patches
> > > and merge (do not rebase please) changes from Ben's CIP kernel regularly.
> In other words, do the same as Renesas is doing at [1].
> > >
> > > [1] https://github.com/renesas-rz/renesas-cip
> >
> > In order to have all the cip related code in one place, it would be
> > good, if anybody is using github, that at least there is a mirror of
> > that repo in gitlab. When we start automating builds/test, that would
> > be helpful.
> 
> Agustin: I don't mind, but is this necessary?.
> Chris: Will you create another repository for u-boot?

Sorry for the delay.

u-boot source for the RZ/G1-M iWave platform is now available [1].

We've tested this using the gcc-arm-none-eabi-5_4-2016q3 [2] compiler:

export PATH=/opt/gcc-arm-none-eabi-5_4-2016q3/bin:$PATH
export CROSS_COMPILE=arm-none-eabi-
export ARCH=arm
make iwg20m_q7_config
make

The u-boot binary can be loaded onto the platform using JTAG or by writing it to the eMMC (be very careful though as this overwrites the current u-boot, so if it goes wrong you'll need JTAG to un-brick the board). Instructions can be found in the Software User Guide included on the CD which comes with the platform.


[1] https://github.com/renesas-rz/renesas-u-boot-cip/tree/2013.01.01/rzg1-iwave
[2] https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads

Kind regards, Chris

> 
> Thanks,
> Daniel
> 
> 
> 
> >
> > >
> > >>> I don't think it is necessary since the CIP root filesystem only supports a
> few packages.
> > >>> Do you mind if I rewrite this and other unnecessary definitions?
> > >> I am happy if you go ahead and fix it!
> > >
> > > OK, thanks. I will also separate Beaglebone from Cyclone V.
> > >
> > > Thanks,
> > > Daniel
> > >
> > >> Best regards,
> > >> Takuo Koguchi
> > >>
> > >>
> > >>
> > >>> -----Original Message-----
> > >>> From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp]
> > >>> Sent: Wednesday, June 28, 2017 5:52 PM
> > >>> To: ???? / KOGUCHI?TAKUO; cip-dev at lists.cip-project.org
> > >>> Cc: 'Chris Paterson'
> > >>> Subject: [!]RE: Project-X (minimal root filesystem) for renesas
> > >>> board
> > >>>
> > >>> Ho Koguchi-san
> > >>>
> > >>>> -----Original Message-----
> > >>>> From: ???? / KOGUCHI?TAKUO
> [mailto:takuo.koguchi.sw at hitachi.com]
> > >>>> Sent: Wednesday, June 28, 2017 5:35 PM
> > >>>> To: Daniel Sangorrin; cip-dev at lists.cip-project.org
> > >>>> Cc: 'Chris Paterson'
> > >>>> Subject: RE: Project-X (minimal root filesystem) for renesas
> > >>>> board
> > >>>>
> > >>>> Hi Daniel-san,
> > >>>>
> > >>>>> I have a few questions:
> > >>>>>    - Why do you have two directories "linux-cip" and
> > >>>>> "linux-cip2" that are almost
> > >>> identical?
> > >>>>
> > >>>> linux-cip directory is for linux-4.4.55-cip3.
> > >>>> linux-cip2 is for the previous release and it is not necessary if you
> update linux-cip.
> > >>>
> > >>> I think this is not a good approach. We would need to have a new
> > >>> linux-cip folder for each release.
> > >>>
> > >>> Patches for the cyclone board should be on its own CIP kernel
> > >>> repository (where you can merge cip releases and add tags). Then,
> > >>> we can choose which version we want by specifying the repository and
> tag/commit_id.
> > >>>
> > >>>>>    - I can see some xserver-related definitions on the board's
> > >>>>> configuration file. Are those necessary?
> > >>>> beaglebone.conf is based on poky/meta-yocto-bsp/conf/machine.
> > >>>> xserver-related definition was inculude in the original.  I am not sure if
> it is necessary.
> > >>>
> > >>> I don't think it is necessary since the CIP root filesystem only supports a
> few packages.
> > >>> Do you mind if I rewrite this and other unnecessary definitions?
> > >>>
> > >>> Thanks,
> > >>> Daniel
> > >>>
> > >>>>
> > >>>>
> > >>>> Takuo Koguchi
> > >>>>
> > >>>>
> > >>>>> -----Original Message-----
> > >>>>> From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp]
> > >>>>> Sent: Wednesday, June 28, 2017 4:05 PM
> > >>>>> To: cip-dev at lists.cip-project.org; ???? / KOGUCHI?TAKUO
> > >>>>> Cc: 'Chris Paterson'
> > >>>>> Subject: [!]Project-X (minimal root filesystem) for renesas
> > >>>>> board
> > >>>>>
> > >>>>> Hi Koguchi-san,
> > >>>>> Cc: Chris, cip-dev
> > >>>>>
> > >>>>> I'm going to add support to project-X for the Renesas iwg20m
> > >>>>> board which is equipped with an armv7 chip.
> > >>>>> I have noticed that you added support for beaglebone and cyclone
> > >>>>> on the deby-armv7 folder [1].
> > >>>>>
> > >>>>> I have a few questions:
> > >>>>>    - Why do you have two directories "linux-cip" and
> > >>>>> "linux-cip2" that are almost
> > >>> identical?
> > >>>>>    - I can see some xserver-related definitions on the board's
> > >>>>> configuration file. Are those necessary?
> > >>>>>
> > >>>>> Thanks,
> > >>>>> Daniel
> > >>>>>
> > >>>>> [1]
> > >>>>> https://gitlab.com/cip-playground/project-x/tree/master/deby-arm
> > >>>>> v7
> > >>>>>
> > >>>
> > >>>
> > >
> > >
> > >
> > > _______________________________________________
> > > cip-dev mailing list
> > > cip-dev at lists.cip-project.org
> > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > >
> >
> > --
> > Agustin Benito Bethencourt
> > Principal Consultant - FOSS at Codethink
> > agustin.benito at codethink.co.uk
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
> 
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
