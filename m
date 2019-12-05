From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Thu, 5 Dec 2019 22:56:15 +0000
Subject: [cip-dev] [PATCH linux-4.4.y-cip v3] gpiolib: Fix bad of_node
 pointer
In-Reply-To: <TYAPR01MB2285A3EC80223FE434CEBC4EB75C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <1575553177-23044-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TYAPR01MB2285A3EC80223FE434CEBC4EB75C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <OSAPR01MB32342D7B751F945831829B34925C0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> -----Original Message-----
> From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
> Sent: Friday, December 6, 2019 3:52 AM
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>;
> cip-dev at lists.cip-project.org
> Cc: iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel at denx.de; Biju Das
> <biju.das@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: RE: [cip-dev][PATCH linux-4.4.y-cip v3] gpiolib: Fix bad of_node
> pointer
> 
> Hello,
> 
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Sent: 05 December 2019 13:40
> >
> > Not every driver initialises of_node from struct gpio_chip, therefore
> > the replacement of of_node from struct gpio_chip with dev->of_node in
> > the below commit won't work on every
> > platform:
> > baff4777cdb8 ("gpiolib: Support 'gpio-reserved-ranges' property") The
> > final result is that on some platforms the kernel will try to
> > dereference a NULL pointer, with obvious consequences.
> >
> > This patch makes sure the pointer gets initialised before its first
> > usage.
> >
> > Fixes: baff4777cdb8 ("gpiolib: Support 'gpio-reserved-ranges'
> > property")
> > Reported-by: Johnson CH Chen <JohnsonCH.Chen@moxa.com>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > ---
> > Hi guys,
> >
> > sorry for the trouble.
> > v2 broke Intel builds (thank you Chris for spotting this), v3 fixes
> that.
> 
> I've tested v3 (current linux-v4.4.y-cip 7b4a8ef7 + a revert for v2) and
> all builds pass:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/100999
> 517

Thanks for test report.

> 
> > Are you happy to replace v2 with v3 on linux-4.4.y-cip?
> 
> I guess this depends on CIP's rules on force-pushing ??
> 

I applied v3 instead of v2 and force-push.

Best regards,
  Nobuhiro
