From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 8 Mar 2018 13:32:02 +0000
Subject: [cip-dev] [PATCH 0/6] Add SDHI support to r8a7743
In-Reply-To: <1520446245.23626.47.camel@codethink.co.uk>
References: <1519991092-4465-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1520446245.23626.47.camel@codethink.co.uk>
Message-ID: <TY1PR01MB17701AD5203FCDEBA357E586C0DF0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

> Subject: Re: [cip-dev][PATCH 0/6] Add SDHI support to r8a7743
>
> On Fri, 2018-03-02 at 11:44 +0000, Fabrizio Castro wrote:
> > Dear All,
> >
> > this patch series adds SDHI support to the r8a7743 SoC.
> >
> > The only patch that hasn't been backported in this series is:
> > "ARM: shmobile: r8a7743: Rename SDHI clocks"
> >
> > This work has been based on top of this series:
> > https://lists.cip-project.org/pipermail/cip-dev/2018-February/000863.html
>
> Applied, thanks.  (It's a shame you had to drop UHS support... I worked
> on upstreaming it but didn't quite get it into shape before 4.4.)

Thank you for that. The plan is to get back to UHS later on, what are your thoughts about its backporting?

Thanks,
Fab

>
> Ben.
>
> > Thanks,
> > Fabrizio
> >
> > Biju Das (5):
> >   mmc: renesas_sdhi: Add r8a7743/5 support
> >   mmc: renesas_sdhi: Add r8a7743/5 support
> >   ARM: dts: r8a7743: Add SDHI controllers
> >   ARM: dts: iwg20m: Enable SDHI0 controller
> >   ARM: dts: iwg20d-q7: Add SDHI1 support
> >
> > Fabrizio Castro (1):
> >   ARM: shmobile: r8a7743: Rename SDHI clocks
> >
> >  Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  2 +
> >  arch/arm/boot/dts/r8a7743-iwg20d-q7.dts            | 40 ++++++++++++++++++++
> >  arch/arm/boot/dts/r8a7743-iwg20m.dtsi              | 17 +++++++++
> >  arch/arm/boot/dts/r8a7743.dtsi                     | 43 +++++++++++++++++++++-
> >  drivers/mmc/host/sh_mobile_sdhi.c                  |  2 +
> >  include/dt-bindings/clock/r8a7743-clock.h          |  4 +-
> >  6 files changed, 104 insertions(+), 4 deletions(-)
> >
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
>




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
