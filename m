From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 10 Apr 2018 17:44:29 +0000
Subject: [cip-dev] [PATCH 00/10] Add PCI and USB PHY support to iwg20d
In-Reply-To: <1523380479.2654.188.camel@codethink.co.uk>
References: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1523380479.2654.188.camel@codethink.co.uk>
Message-ID: <TY1PR01MB177059834A0F0CEA7CF38768C0BE0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

> Subject: Re: [cip-dev][PATCH 00/10] Add PCI and USB PHY support to iwg20d
>
> I've applied this series, thanks.  I edited in the missing upstream
> commit reference.

Thank you for doing this.

Fab

>
> Ben.
>
> On Mon, 2018-03-05 at 11:39 +0000, Fabrizio Castro wrote:
> > This series backports patches necessary to add PCI and USB PHY support
> > to iWave's iwg20d board.
> >
> > Thanks,
> > Fabrizio
> >
> > Biju Das (7):
> >   PCI: rcar: Add device tree support for r8a7743/5
> >   ARM: dts: r8a7743: Add internal PCI bridge nodes
> >   phy: rcar-gen2: Add r8a7743/5 support
> >   ARM: dts: r8a7743: Add USB PHY DT support
> >   ARM: dts: r8a7743: Link PCI USB devices to USB PHY
> >   ARM: dts: iwg20d-q7: Enable internal PCI
> >   ARM: dts: iwg20d-q7: Enable USB PHY
> >
> > Simon Horman (3):
> >   PCI: rcar: Add gen2 fallback compatibility string for pci-rcar-gen2
> >   PCI: rcar-gen2: Use gen2 fallback compatibility last
> >   phy: rcar-gen2: add fallback binding
> >
> >  .../devicetree/bindings/pci/pci-rcar-gen2.txt      | 15 +++-
> >  .../devicetree/bindings/phy/rcar-gen2-phy.txt      | 12 ++-
> >  arch/arm/boot/dts/iwg20d-q7-common.dtsi            | 26 ++++++
> >  arch/arm/boot/dts/r8a7743.dtsi                     | 95 ++++++++++++++++++++++
> >  drivers/pci/host/pci-rcar-gen2.c                   |  1 +
> >  drivers/phy/phy-rcar-gen2.c                        |  1 +
> >  6 files changed, 145 insertions(+), 5 deletions(-)
> >
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
