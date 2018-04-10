From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 10 Apr 2018 17:45:01 +0000
Subject: [cip-dev] [PATCH 0/7] Add HSUSB to r8a7743
In-Reply-To: <1523380574.2654.190.camel@codethink.co.uk>
References: <1520336087-12870-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1523380574.2654.190.camel@codethink.co.uk>
Message-ID: <TY1PR01MB17701A0E2A1A022B2794B349C0BE0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

> Subject: Re: [cip-dev][PATCH 0/7] Add HSUSB to r8a7743
>
> I've applied this series, thanks.  I added back the compatible strings
> that you left out of the last patch, since I didn't see any need to
> diverge from upstream there.

Ok.

Thanks,
Fab

>
> Ben.
>
> On Tue, 2018-03-06 at 11:34 +0000, Fabrizio Castro wrote:
> > Dear All,
> >
> > this series backports all the patches necessary to add HSUSB support
> > to the r8a7743.
> >
> > Thanks,
> > Fabrizio
> >
> > Biju Das (5):
> >   usb: renesas_usbhs: Add compatible string for r8a7743/5
> >   ARM: dts: r8a7743: Add HS-USB device node
> >   ARM: dts: iwg20d-q7: Enable HS-USB
> >   ARM: dts: r8a7743: Add USB-DMAC device nodes
> >   ARM: dts: r8a7743: Enable DMA for HSUSB
> >
> > Simon Horman (2):
> >   usb: renesas_usbhs: add SoC names to compatibility string
> >     documentation
> >   usb: renesas_usbhs: add fallback compatibility strings
> >
> >  .../devicetree/bindings/usb/renesas_usbhs.txt      | 22 ++++++++----
> >  arch/arm/boot/dts/iwg20d-q7-common.dtsi            |  7 +++-
> >  arch/arm/boot/dts/r8a7743.dtsi                     | 40 ++++++++++++++++++++++
> >  drivers/usb/renesas_usbhs/common.c                 |  9 +++++
> >  4 files changed, 71 insertions(+), 7 deletions(-)
> >
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
