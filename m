From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Sun, 26 Jan 2020 22:15:54 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 00/10] Renesas RZ/G1N extend
 peripherals supported by platform
In-Reply-To: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <TYAPR01MB367809BA4ED634F3B3D8A6BD92080@TYAPR01MB3678.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Lad,

> -----Original Message-----
> From: Lad Prabhakar [mailto:prabhakar.mahadev-lad.rj at bp.renesas.com]
> Sent: Friday, January 24, 2020 6:08 PM
> To: cip-dev at lists.cip-project.org; iwamatsu nobuhiro(?? ?? ???
> ?????) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>
> Subject: [PATCH 4.4.y-cip 00/10] Renesas RZ/G1N extend peripherals
> supported by platform
> 
> This patch series adds support for following peripherals supported by
> RZ/G1N:
> 1: VSP
> 2: PWM
> 3: TPU
> 4: QSPI
> 5: MSIOF
> 6: xHCI
> 7: PCiec
> 8: NOR flash for iwg20m
> 
> This patch series is based on linux-4.4.y-cip and all the patches in this
> series are cherry-picked from upstream apart from "usb: host: xhci-plat:
> Add r8a7744 support"
> patch.
> 
> Biju Das (9):
>   ARM: dts: r8a7744: Add VSP support
>   ARM: dts: r8a7744: Add PWM SoC support
>   ARM: dts: r8a7744: Add TPU support
>   ARM: dts: r8a7744: Add QSPI support
>   ARM: dts: r8a7744: Add MSIOF[012] support
>   ARM: dts: r8a7744-iwg20m: Add SPI NOR support
>   dt-bindings: usb-xhci: Document r8a7744 support
>   ARM: dts: r8a7744: Add xhci support
>   ARM: dts: r8a7744: Add PCIe Controller device node
> 
> Lad Prabhakar (1):
>   usb: host: xhci-plat: Add r8a7744 support
> 
>  Documentation/devicetree/bindings/usb/usb-xhci.txt |   3 +-
>  arch/arm/boot/dts/r8a7744-iwg20m.dtsi              |  26 +++
>  arch/arm/boot/dts/r8a7744.dtsi                     | 219
> +++++++++++++++++++++
>  drivers/usb/host/xhci-plat.c                       |   7 +-
>  4 files changed, 252 insertions(+), 3 deletions(-)
> 

Looks good to me.
I will apply this series if there is no objection.

Best regards,
  Nobuhiro
