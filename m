From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Mon, 27 Jan 2020 19:37:20 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 00/10] Renesas RZ/G1N extend
 peripherals supported by platform
In-Reply-To: <20200127120418.GA19331@duo.ucw.cz>
References: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB367809BA4ED634F3B3D8A6BD92080@TYAPR01MB3678.jpnprd01.prod.outlook.com>
 <20200127120418.GA19331@duo.ucw.cz>
Message-ID: <OSAPR01MB36678FE97942CE18F826E3F0920B0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> -----Original Message-----
> From: Pavel Machek [mailto:pavel at denx.de]
> Sent: Monday, January 27, 2020 9:04 PM
> To: iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: prabhakar.mahadev-lad.rj at bp.renesas.com;
> cip-dev at lists.cip-project.org; pavel at denx.de;
> chris.paterson2 at renesas.com
> Subject: Re: [PATCH 4.4.y-cip 00/10] Renesas RZ/G1N extend peripherals
> supported by platform
> 
> Hi!
> 
> > > Lad Prabhakar (1):
> > >   usb: host: xhci-plat: Add r8a7744 support
> > >
> > >  Documentation/devicetree/bindings/usb/usb-xhci.txt |   3 +-
> > >  arch/arm/boot/dts/r8a7744-iwg20m.dtsi              |  26 +++
> > >  arch/arm/boot/dts/r8a7744.dtsi                     | 219
> > > +++++++++++++++++++++
> > >  drivers/usb/host/xhci-plat.c                       |   7 +-
> > >  4 files changed, 252 insertions(+), 3 deletions(-)
> > >
> >
> > Looks good to me.
> > I will apply this series if there is no objection.
> 
> Looks good to me, too.

Thanks! I will apply this series.

Best regards,
  Nobuhiro
