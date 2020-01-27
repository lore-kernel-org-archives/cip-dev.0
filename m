From: prabhakar.mahadev-lad.rj@bp.renesas.com (Prabhakar Mahadev Lad)
Date: Mon, 27 Jan 2020 07:09:55 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 07/10] usb: host: xhci-plat: Add
 r8a7744	support
In-Reply-To: <TYAPR01MB36787FE926D7C607F6B0734F92080@TYAPR01MB3678.jpnprd01.prod.outlook.com>
References: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1579856900-21381-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSBPR01MB516071CAB831BEB6007BD8E7AA0E0@OSBPR01MB5160.jpnprd01.prod.outlook.com>
 <TYAPR01MB36787FE926D7C607F6B0734F92080@TYAPR01MB3678.jpnprd01.prod.outlook.com>
Message-ID: <OSBPR01MB5160B0BBC566323C51A78435AA0B0@OSBPR01MB5160.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Nobuhiro,

> -----Original Message-----
> From: nobuhiro1.iwamatsu at toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 26 January 2020 22:07
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> cip-dev at lists.cip-project.org; pavel at denx.de
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>
> Subject: RE: [cip-dev] [PATCH 4.4.y-cip 07/10] usb: host: xhci-plat: Add
> r8a7744 support
>
> Hi Prabhakar,
>
> > -----Original Message-----
> > From: Prabhakar Mahadev Lad
> > [mailto:prabhakar.mahadev-lad.rj at bp.renesas.com]
> > Sent: Friday, January 24, 2020 7:13 PM
> > To: Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj at bp.renesas.com>;
> > cip-dev at lists.cip-project.org; iwamatsu nobuhiro(?? ?? ?????
> > ???) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> > Cc: Chris Paterson <Chris.Paterson2@renesas.com>
> > Subject: RE: [cip-dev] [PATCH 4.4.y-cip 07/10] usb: host: xhci-plat:
> > Add
> > r8a7744 support
> >
> > Hi All,
> >
> > > -----Original Message-----
> > > From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of
> > > Lad Prabhakar
> > > Sent: 24 January 2020 09:08
> > > To: cip-dev at lists.cip-project.org; Nobuhiro Iwamatsu
> > > <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> > > Subject: [cip-dev] [PATCH 4.4.y-cip 07/10] usb: host: xhci-plat: Add
> > > r8a7744 support
> > >
> > > This patch adds xhci r8a7744 driver support.
> > >
> > > Signed-off-by: Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  drivers/usb/host/xhci-plat.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > Just a background wrt this patch as this isn't a backport from
> > mainline kernel,  in mainline kernel for RZ/G1 the compatible string
> > defaults to "renesas,rcar-gen2-xhci"  which isn't present in CIP, and
> > the way xhci-plat.c in cip handles compatibility is different compared
> > to mainline as a result this patch is added This is patch is similar to  "
> > usb: host: xhci-plat: Add r8a7743 support"
> > (d09ccbb733864223402b541bdb9897cfe811881c) present in cip kernel.
>
> Thanks for your additional information.
> I will add the above comment to the commit message and commit.
>
Thank you.

Cheers,
--Prabhakar


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, 40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE reg. no.: DE 14978647
