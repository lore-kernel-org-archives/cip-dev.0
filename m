From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 06:45:15 +0000
Subject: [cip-dev] Regarding backporting RTC PCF85263 driver to cip 4.4
 kernel
In-Reply-To: <OSBPR01MB4184F508CBC36F2E3BFDAE1B92CC0@OSBPR01MB4184.jpnprd01.prod.outlook.com>
References: <OSBPR01MB210389D3E16B7A69C24ADF0EB8F20@OSBPR01MB2103.jpnprd01.prod.outlook.com>
	<20190714214606.GA19428@amd>
	<OSBPR01MB4184F508CBC36F2E3BFDAE1B92CC0@OSBPR01MB4184.jpnprd01.prod.outlook.com>
Message-ID: <OSBPR01MB2103C4E8B2658D37C2B0164EB8CF0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Nobuhiro,

Thanks for the feedback.

.feghali.xb at renesas.com>; cip-
> dev at lists.cip-project.org
> Subject: RE: [cip-dev] Regarding backporting RTC PCF85263 driver to cip 4.4
> kernel
> 
> Hi,
> 
> > -----Original Message-----
> > From: cip-dev-bounces at lists.cip-project.org
> > [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Pavel
> > Machek
> > Sent: Monday, July 15, 2019 6:46 AM
> > To: Biju Das <biju.das@bp.renesas.com>
> > Cc: Christopher Feghali <christopher.feghali.xb@renesas.com>;
> > cip-dev at lists.cip-project.org
> > Subject: Re: [cip-dev] Regarding backporting RTC PCF85263 driver to
> > cip
> > 4.4 kernel
> >
> > Hi!
> > >
> > > RTC PCF85263 is used by iWave RZ/G1C SBC( iwg23s) platform.  We have
> > > upstreamed  this driver support  on 4.19 kernel [1] [1].
> > >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c
> > om
> > >
> > mit/drivers/rtc/rtc-pcf85363.c?h=v5.2&id=fc979933bcf162595b6004d0de4
> > ef
> > > fb64c323152
> > >
> > > This driver is based  on RTC PCF 85363 driver which has rtc
> > > nvmem/alarm support [2] .  Rtc nvmem framework is introduced in 4.13
> > > [2].
> > >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c
> > om
> > >
> > mit/drivers/rtc/rtc-pcf85363.c?h=v5.2&id=a9687aa2764dd2669602bd19dc6
> > 36
> > > cbeef5293d5
> > >
> > > We are seeing the following options for backporting this driver to
> > > 4.4 kernel
> >
> > First, you did a lot of work there...
> >
> > > Option 1:
> > > Backport this driver[1] to 4.4 kernel along with nvmem/alarm support.
> > > we have already done this work and patches are available at [3] [3].
> > > https://gitlab.com/bijud/pcf85263/tree/master
> >
> > Ok, this is rather long/big series, and some parts are quite scary:
> > https://gitlab.com/bijud/pcf85263/blob/master/0013-rtc-nvmem-allow-r
> > egistering-the-nvmem-device-before-.patch
> >
> > > Option 2:
> > > Backport RTC PCF85263 driver, removing  Alarm/nvmem functionality
> > > from [2] .
> >
> > So we basically get this one, and few patches on top, local to the new
> > files.
> > https://gitlab.com/bijud/pcf85263/blob/master/0015-rtc-add-support-f
> > or-NXP-PCF85363-real-time-clock.patch
> >
> > I think I prefer option 2.
> >
> > > Option 3:
> > > Don't backport RTC support at all.
> >
> > Applying patch #15 is easy. We can do option 2 I believe.
> >
> 
> I think that option 2 is good.

OK. Will send patch based on option 2.

Regards,
Biju
