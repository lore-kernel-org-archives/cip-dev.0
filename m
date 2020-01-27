From: pavel@denx.de (Pavel Machek)
Date: Mon, 27 Jan 2020 13:04:19 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 00/10] Renesas RZ/G1N extend
 peripherals supported by platform
In-Reply-To: <TYAPR01MB367809BA4ED634F3B3D8A6BD92080@TYAPR01MB3678.jpnprd01.prod.outlook.com>
References: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB367809BA4ED634F3B3D8A6BD92080@TYAPR01MB3678.jpnprd01.prod.outlook.com>
Message-ID: <20200127120418.GA19331@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > Lad Prabhakar (1):
> >   usb: host: xhci-plat: Add r8a7744 support
> > 
> >  Documentation/devicetree/bindings/usb/usb-xhci.txt |   3 +-
> >  arch/arm/boot/dts/r8a7744-iwg20m.dtsi              |  26 +++
> >  arch/arm/boot/dts/r8a7744.dtsi                     | 219
> > +++++++++++++++++++++
> >  drivers/usb/host/xhci-plat.c                       |   7 +-
> >  4 files changed, 252 insertions(+), 3 deletions(-)
> > 
> 
> Looks good to me.
> I will apply this series if there is no objection.

Looks good to me, too.

Thanks,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200127/80967210/attachment.sig>
