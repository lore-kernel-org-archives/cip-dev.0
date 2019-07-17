From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Wed, 17 Jul 2019 23:20:29 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 05/10] rtc: pcf85363: Add support
	for	NXP pcf85263 rtc
In-Reply-To: <OSBPR01MB2103ED72F24A325F68299855B8C90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
	<1563264921-42973-6-git-send-email-biju.das@bp.renesas.com>
	<OSAPR01MB3234ABFCA10DAC2E6D74289692C90@OSAPR01MB3234.jpnprd01.prod.outlook.com>
	<OSBPR01MB2103ED72F24A325F68299855B8C90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <OSAPR01MB3234A60856510B217AFE040992C90@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> -----Original Message-----
> From: Biju Das [mailto:biju.das at bp.renesas.com]
> Sent: Wednesday, July 17, 2019 4:16 PM
> To: iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev at lists.cip-project.org
> Subject: RE: [cip-dev] [PATCH 4.4.y-cip 05/10] rtc: pcf85363: Add support
> for NXP pcf85263 rtc
> 
> Hi Nobuhiro,
> 
> Thanks for the feedback.
> 
> > Subject: RE: [cip-dev] [PATCH 4.4.y-cip 05/10] rtc: pcf85363: Add
> > support for NXP pcf85263 rtc
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: cip-dev-bounces at lists.cip-project.org
> > > [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Biju Das
> > > Sent: Tuesday, July 16, 2019 5:15 PM
> > > To: cip-dev at lists.cip-project.org
> > > Cc: Biju Das <biju.das@bp.renesas.com>
> > > Subject: [cip-dev] [PATCH 4.4.y-cip 05/10] rtc: pcf85363: Add
> > > support for NXP pcf85263 rtc
> > >
> > > commit fc979933bcf162595b6004d0de4effb64c323152 upstream.
> > >
> > > Add support for NXP pcf85263 real-time clock. pcf85263 rtc is
> > > compatible with pcf85363,except that pcf85363 has additional 64
> > > bytes of
> > RAM.
> > >
> > > 1 byte of nvmem is supported and exposed in sysfs (# is the instance
> > > number,starting with 0): /sys/bus/nvmem/devices/pcf85x63-#/nvmem
> > >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com> [ Removed rtc
> > > nvmem support. Added I2C ID table for rtc-pcf85263 ]
> >
> > You've deleted Alexandre's Signed-off-by tag from original patch.
> 
> Thanks for pointing this out. It is a mistake.  Can you please fix this
> while applying to the tree?
> 
> Or
> 
> Do you want me to send another patch fixing this? Please let me know.
> 

Pavel applied this patch with signed-off-by tag. Thanks Pavel.

Best regards,
  Nobuhiro
