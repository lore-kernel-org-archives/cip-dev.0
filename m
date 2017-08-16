From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Wed, 16 Aug 2017 07:02:36 +0000
Subject: [cip-dev] [PATCH  00/11] Add Pinctrl support for r8a7743
In-Reply-To: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
References: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <TY1PR06MB07024C4E4C3D48CFEF3221F5B7820@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



> From: Biju Das [mailto:biju.das at bp.renesas.com]
> Sent: 10 August 2017 14:15
> 
> This series aims to add Pinctrl support for r8a7743.
> All the patches in this series are cherry-picked from upstream kernel

For the series: Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

> 
> Geert Uytterhoeven (3):
>   pinctrl: sh-pfc: Add PINMUX_SINGLE()
>   pinctrl: sh-pfc: r8a7791: Use PINMUX_SINGLE() instead of raw
>     PINMUX_DATA()
>   pinctrl: sh-pfc: r8a7791: Add SCIF_CLK support
> 
> Jacopo Mondi (1):
>   pinctrl: sh-pfc: r8a7791: Add ADI pinconf support
> 
> Sergei Shtylyov (7):
>   pinctrl: sh-pfc: r8a7791: add EtherAVB pin groups
>   pinctrl: sh-pfc: r8a7791: Add missing HSCIF1 pinmux data
>   pinctrl: sh-pfc: r8a7791: Add missing DVC_MUTE signal
>   pinctrl: sh-pfc: r8a7791: Fix SCIF2 pinmux data
>   pinctrl: sh-pfc: r8a7791: Fix IPSR comment typos
>   pinctrl: sh-pfc: r8a7791: Grand I2C rename
>   pinctrl: sh-pfc: r8a7791: Add R8A7743 support
> 
>  .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +
>  drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
>  drivers/pinctrl/sh-pfc/Makefile                    |    1 +
>  drivers/pinctrl/sh-pfc/core.c                      |    6 +
>  drivers/pinctrl/sh-pfc/core.h                      |    1 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c               | 1558 ++++++++++++--------
>  drivers/pinctrl/sh-pfc/sh_pfc.h                    |    8 +
>  7 files changed, 928 insertions(+), 652 deletions(-)
> 
> --
> 1.9.1
