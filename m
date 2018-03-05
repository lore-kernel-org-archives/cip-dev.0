From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 5 Mar 2018 11:16:48 +0000
Subject: [cip-dev] [PATCH 0/6] Add SDHI support to r8a7743
In-Reply-To: <1519991092-4465-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519991092-4465-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <TY1PR06MB07020FEC041CF5090732C5F6B7DA0@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Fabrizio,

> From: Fabrizio Castro [mailto:fabrizio.castro at bp.renesas.com]
> Sent: 02 March 2018 11:45
> 
> Dear All,
> 
> this patch series adds SDHI support to the r8a7743 SoC.

Thank you for the patches.

> 
> The only patch that hasn't been backported in this series is:
> "ARM: shmobile: r8a7743: Rename SDHI clocks"
> 
> This work has been based on top of this series:
> https://lists.cip-project.org/pipermail/cip-dev/2018-February/000863.html
> 
> Thanks,
> Fabrizio
> 
> Biju Das (5):
>   mmc: renesas_sdhi: Add r8a7743/5 support
>   mmc: renesas_sdhi: Add r8a7743/5 support
>   ARM: dts: r8a7743: Add SDHI controllers
>   ARM: dts: iwg20m: Enable SDHI0 controller
>   ARM: dts: iwg20d-q7: Add SDHI1 support
> 
> Fabrizio Castro (1):
>   ARM: shmobile: r8a7743: Rename SDHI clocks

Series: Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

Kind regards, Chris

> 
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  2 +
>  arch/arm/boot/dts/r8a7743-iwg20d-q7.dts            | 40
> ++++++++++++++++++++
>  arch/arm/boot/dts/r8a7743-iwg20m.dtsi              | 17 +++++++++
>  arch/arm/boot/dts/r8a7743.dtsi                     | 43 +++++++++++++++++++++-
>  drivers/mmc/host/sh_mobile_sdhi.c                  |  2 +
>  include/dt-bindings/clock/r8a7743-clock.h          |  4 +-
>  6 files changed, 104 insertions(+), 4 deletions(-)
> 
> --
> 2.7.4
