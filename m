From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Thu, 25 Apr 2019 00:54:25 +0000
Subject: [cip-dev] [PATCH 4.19.y 00/17] Backport USB support for RZ/G2E
In-Reply-To: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <TYAPR01MB41896BA03209A9CA6D1DC5D7923D0@TYAPR01MB4189.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Fabrizio,

> Dear All,
>
> this series backports SoC specific USB Host 2.0/HSUSB/USB 3.0 DRD
> support for the RZ/G2E (a.k.a. R8A774C0).
> While at it, this series also cherry-picks some patches useful for
> the RZ/G2M (a.k.a. R8A774A1).
>
> Thanks,
> Fab
>
> Fabrizio Castro (11):
>   dt-bindings: rcar-gen3-phy-usb2: Add r8a774a1 support
>   dt-bindings: rcar-gen3-phy-usb2: Add r8a774c0 support
>   arm64: dts: renesas: r8a774c0: Add USB2.0 phy and host device nodes
>   usb: renesas_usbhs: add support for RZ/G2E
>   dt-bindings: usb: renesas_usbhs: Add r8a774c0 support
>   dt-bindings: dmaengine: usb-dmac: Add binding for r8a774c0
>   arm64: dts: renesas: r8a774c0: Add USB-DMAC and HSUSB device nodes
>   usb: gadget: udc: renesas_usb3: add support for r8a774c0
>   usb: gadget: udc: renesas_usb3: Add r8a774a1 support
>   usb: gadget: udc: renesas_usb3: Add bindings for r8a774c0
>   arm64: dts: renesas: r8a774c0: Add USB3.0 device nodes
>
> Yoshihiro Shimoda (6):
>   usb: renesas_usbhs: Add reset_control
>   usb: renesas_usbhs: Add multiple clocks management
>   Revert "usb: renesas_usbhs: add extcon notifier to set mode for
>     non-otg channel"
>   dt-bindings: usb: renesas_usbhs: add clock-names property
>   usb: gadget: udc: renesas_usb3: add support for r8a77990
>   usb: gadget: udc: renesas_usb3: add a safety connection way for
>     forced_b_device
>
>  .../devicetree/bindings/dma/renesas,usb-dmac.txt   |   1 +
>  .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  11 +-
>  .../devicetree/bindings/usb/renesas_usb3.txt       |   6 +-
>  .../devicetree/bindings/usb/renesas_usbhs.txt      |   7 +-
>  arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 104 +++++++++++++++++++
>  drivers/usb/gadget/udc/renesas_usb3.c              |  30 +++++-
>  drivers/usb/renesas_usbhs/common.c                 | 113 +++++++++++++++++++--
>  drivers/usb/renesas_usbhs/common.h                 |   5 +-
>  drivers/usb/renesas_usbhs/rcar3.c                  |  11 --
>  9 files changed, 256 insertions(+), 32 deletions(-)
>

Looks good to me all patches.
Pavel, do you have a comment about this series?

Best regards,
  Nobuhiro

________________________________________
???: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> ? Fabrizio Castro <fabrizio.castro@bp.renesas.com> ??????
????: 2019?4?25? 2:20
??: cip-dev at lists.cip-project.org
CC: Biju Das
??: [cip-dev]  [PATCH 4.19.y 00/17] Backport USB support for RZ/G2E

Dear All,

this series backports SoC specific USB Host 2.0/HSUSB/USB 3.0 DRD
support for the RZ/G2E (a.k.a. R8A774C0).
While at it, this series also cherry-picks some patches useful for
the RZ/G2M (a.k.a. R8A774A1).

Thanks,
Fab

Fabrizio Castro (11):
  dt-bindings: rcar-gen3-phy-usb2: Add r8a774a1 support
  dt-bindings: rcar-gen3-phy-usb2: Add r8a774c0 support
  arm64: dts: renesas: r8a774c0: Add USB2.0 phy and host device nodes
  usb: renesas_usbhs: add support for RZ/G2E
  dt-bindings: usb: renesas_usbhs: Add r8a774c0 support
  dt-bindings: dmaengine: usb-dmac: Add binding for r8a774c0
  arm64: dts: renesas: r8a774c0: Add USB-DMAC and HSUSB device nodes
  usb: gadget: udc: renesas_usb3: add support for r8a774c0
  usb: gadget: udc: renesas_usb3: Add r8a774a1 support
  usb: gadget: udc: renesas_usb3: Add bindings for r8a774c0
  arm64: dts: renesas: r8a774c0: Add USB3.0 device nodes

Yoshihiro Shimoda (6):
  usb: renesas_usbhs: Add reset_control
  usb: renesas_usbhs: Add multiple clocks management
  Revert "usb: renesas_usbhs: add extcon notifier to set mode for
    non-otg channel"
  dt-bindings: usb: renesas_usbhs: add clock-names property
  usb: gadget: udc: renesas_usb3: add support for r8a77990
  usb: gadget: udc: renesas_usb3: add a safety connection way for
    forced_b_device

 .../devicetree/bindings/dma/renesas,usb-dmac.txt   |   1 +
 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  11 +-
 .../devicetree/bindings/usb/renesas_usb3.txt       |   6 +-
 .../devicetree/bindings/usb/renesas_usbhs.txt      |   7 +-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 104 +++++++++++++++++++
 drivers/usb/gadget/udc/renesas_usb3.c              |  30 +++++-
 drivers/usb/renesas_usbhs/common.c                 | 113 +++++++++++++++++++--
 drivers/usb/renesas_usbhs/common.h                 |   5 +-
 drivers/usb/renesas_usbhs/rcar3.c                  |  11 --
 9 files changed, 256 insertions(+), 32 deletions(-)

--
2.7.4

_______________________________________________
cip-dev mailing list
cip-dev at lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
