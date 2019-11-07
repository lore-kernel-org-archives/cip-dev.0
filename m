From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 7 Nov 2019 07:53:06 +0000
Subject: [cip-dev] Regarding RZ/G1CeMMC backporting patches
In-Reply-To: <OSAPR01MB323483328A804743354D1BAD92780@OSAPR01MB3234.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2103831ABFCEAE5F3CA232E7B8660@OSBPR01MB2103.jpnprd01.prod.outlook.com>
	<OSAPR01MB323483328A804743354D1BAD92780@OSAPR01MB3234.jpnprd01.prod.outlook.com>
Message-ID: <OSBPR01MB2103FCB062395320458130EDB8780@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


Hi Nobuhiro-San,

Thanks for the feedback.

> -----Original Message-----
> From: nobuhiro1.iwamatsu at toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Thursday, November 7, 2019 7:18 AM
> To: Biju Das <biju.das@bp.renesas.com>; cip-dev at lists.cip-project.org;
> pavel at denx.de
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: RE: Regarding RZ/G1CeMMC backporting patches
> 
> Hi Biju,
> 
> 
> 
> > -----Original Message-----
> > From: Biju Das [mailto:biju.das at bp.renesas.com]
> > Sent: Tuesday, October 29, 2019 2:47 AM
> > To: cip-dev at lists.cip-project.org; Pavel Machek <pavel@denx.de>;
> > iwamatsu nobuhiro(?? ?? ????????)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> > <fabrizio.castro@bp.renesas.com>
> > Subject: Regarding RZ/G1CeMMC backporting patches
> >
> > Hi All,
> >
> > RZ/G1C eMMC IP is different from other RZ/G1 SoC's. It is having an
> > internal DMA for data transfer which is similar to R-Car Gen3.
> >
> > Support for internal DMAC is added in 4.14 kernel and support for
> > RZ/G1C added on 4.20 kernel.
> >
> > I have backported the relevant patches(86 patches)  to 4.4 kernel and
> > shared at [1].
> > [1]. https://gitlab.com/bijud/emmc
> >
> > Please review this patches and share your opinion, so that I can send
> > it to cip patchwork
> 
> OK, I will check this. If you can, please send this series cip-dev too.

I will send this series to cip-dev.

Cheers,
Biju
