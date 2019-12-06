From: JohnsonCH.Chen@moxa.com (=?iso-2022-jp?B?Sm9obnNvbiBDSCBDaGVuICgbJEJERD48Ui4bKEIp?=)
Date: Fri, 6 Dec 2019 01:57:06 +0000
Subject: [cip-dev] [PATCH linux-4.4.y-cip v3] gpiolib: Fix bad of_node
 pointer
In-Reply-To: <OSAPR01MB32342D7B751F945831829B34925C0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
References: <1575553177-23044-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TYAPR01MB2285A3EC80223FE434CEBC4EB75C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <OSAPR01MB32342D7B751F945831829B34925C0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
Message-ID: <HK0PR01MB3521AC0A474F018406404184FA5F0@HK0PR01MB3521.apcprd01.prod.exchangelabs.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear all,

Thanks for this patch. It help us a lot!

Best regards,
Johnson

> From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of 
> nobuhiro1.iwamatsu at toshiba.co.jp
> Sent: Friday, December 6, 2019 6:56 AM
> To: Chris.Paterson2 at renesas.com; fabrizio.castro at bp.renesas.com; 
> cip-dev at lists.cip-project.org
> Cc: biju.das at bp.renesas.com
> Subject: Re: [cip-dev] [PATCH linux-4.4.y-cip v3] gpiolib: Fix bad 
> of_node pointer
>
> Hi,
>
> > -----Original Message-----
> > From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
> > Sent: Friday, December 6, 2019 3:52 AM
> > To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>; 
> > cip-dev at lists.cip-project.org
> > Cc: iwamatsu nobuhiro(?? ?? ????????)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel at denx.de; Biju Das 
> > <biju.das@bp.renesas.com>; Fabrizio Castro 
> > <fabrizio.castro@bp.renesas.com>
> > Subject: RE: [cip-dev][PATCH linux-4.4.y-cip v3] gpiolib: Fix bad 
> > of_node pointer
> >
> > Hello,
> >
> > > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Sent: 05 December 2019 13:40
> > >
> > > Not every driver initialises of_node from struct gpio_chip, 
> > > therefore the replacement of of_node from struct gpio_chip with
> > > dev->of_node in the below commit won't work on every
> > > platform:
> > > baff4777cdb8 ("gpiolib: Support 'gpio-reserved-ranges' property") 
> > > The final result is that on some platforms the kernel will try to 
> > > dereference a NULL pointer, with obvious consequences.
> > >
> > > This patch makes sure the pointer gets initialised before its 
> > > first usage.
> > >
> > > Fixes: baff4777cdb8 ("gpiolib: Support 'gpio-reserved-ranges'
> > > property")
> > > Reported-by: Johnson CH Chen <JohnsonCH.Chen@moxa.com>
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > >
> > > ---
> > > Hi guys,
> > >
> > > sorry for the trouble.
> > > v2 broke Intel builds (thank you Chris for spotting this), v3 
> > > fixes
> > that.
> >
> > I've tested v3 (current linux-v4.4.y-cip 7b4a8ef7 + a revert for v2) 
> > and all builds pass:
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/100999
> > 517
>
> Thanks for test report.
>
> >
> > > Are you happy to replace v2 with v3 on linux-4.4.y-cip?
> >
> > I guess this depends on CIP's rules on force-pushing ??
> >
>
> I applied v3 instead of v2 and force-push.
>
> Best regards,
>   Nobuhiro
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
