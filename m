From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 13:29:33 +0000
Subject: [cip-dev] [PATCH 4.19.y 00/60] Add basic RZ/G2M SoC support
In-Reply-To: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <TY1PR01MB1770AE7B492DEE23AA43A014C0A30@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

It looks like my local branch was missing the latest merge with stable, I have rebased and I'll send a v2 shortly.

Sorry about the noise.

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 28 August 2019 12:03
> Subject: [cip-dev][PATCH 4.19.y 00/60] Add basic RZ/G2M SoC support
> 
> Dear All,
> 
> this series aims at providing basic RZ/G2M SoC dtsi support.
> 
> Thanks,
> Fab
> 
> Biju Das (13):
>   dt-bindings: dmaengine: usb-dmac: Add binding for r8a774a1
>   arm64: dts: renesas: Initial r8a774a1 SoC device tree
>   arm64: dts: renesas: r8a774a1: Add SYS-DMAC controller nodes
>   arm64: dts: renesas: r8a774a1: Add INTC-EX device node
>   arm64: dts: renesas: r8a774a1: Add RWDT node
>   arm64: dts: renesas: r8a774a1: Add I2C and IIC-DVFS support
>   arm64: dts: renesas: r8a774a1: Add RZ/G2M thermal support
>   arm64: dts: renesas: r8a774a1: Add all MSIOF nodes
>   arm64: dts: renesas: r8a774a1: Add Cortex-A53 CPU cores
>   arm64: dts: renesas: r8a774a1: Add audio support
>   arm64: dts: renesas: r8a774a1: Add USB2.0 phy and host(EHCI/OHCI)
>     device nodes
>   arm64: dts: renesas: r8a774a1: Add USB-DMAC and HSUSB device nodes
>   arm64: dts: renesas: r8a774a1: Add USB3.0 device nodes
> 
> Chris Paterson (1):
>   arm64: dts: renesas: r8a774a1: Add CAN nodes
> 
> Enrico Weigelt, metux IT consult (1):
>   gpio: rcar: Pedantic formatting
> 
> Fabrizio Castro (21):
>   dt-bindings: can: rcar_can: Add r8a774a1 support
>   dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
>   dt-bindings: can: rcar_can: Add r8a774c0 support
>   dt-bindings: rcar-gen3-phy-usb3: Add r8a774a1 support
>   dt-bindings: usb-xhci: Add r8a774a1 support
>   dt-bindings: usb-xhci: Add r8a774c0 support
>   dt-bindings: usb: renesas_usbhs: Add r8a774a1 support
>   dt-bindings: thermal: rcar-gen3-thermal: Add r8a774a1 support
>   thermal: rcar_gen3_thermal: Add r8a774a1 support
>   arm64: dts: renesas: r8a774a1: Add SCIF and HSCIF nodes
>   arm64: dts: renesas: r8a774a1: Add Ethernet AVB node
>   arm64: dts: renesas: r8a774a1: Add pinctrl device node
>   arm64: dts: renesas: r8a774a1: Add GPIO device nodes
>   arm64: dts: renesas: r8a774a1: Add SDHI nodes
>   arm64: dts: renesas: r8a774a1: Add IPMMU device nodes
>   arm64: dts: renesas: r8a774a1: Add PWM device nodes
>   arm64: dts: renesas: r8a774a1: Add FCPF and FCPV instances
>   arm64: dts: renesas: r8a774a1: Replace power magic numbers
>   arm64: dts: renesas: r8a774a1: Replace clock magic numbers
>   arm64: dts: renesas: r8a774a1: Fix hsusb reg size
>   arm64: dts: renesas: r8a774a1: Add clkp2 clock to CAN nodes
> 
> Geert Uytterhoeven (15):
>   clk: renesas: cpg-mssr: Use genpd of_node instead of local copy
>   clk: renesas: cpg-mssr: Remove error messages on out-of-memory
>     conditions
>   soc: renesas: rcar-sysc: Remove rcar_sysc_power_{down,up}() helpers
>   soc: renesas: rcar-sysc: Merge PM Domain registration and linking
>   soc: renesas: rcar-sysc: Fix power domain control after system resume
>   serial: sh-sci: Fix TX DMA buffer flushing and workqueue races
>   serial: sh-sci: Terminate TX DMA during buffer flushing
>   serial: sh-sci: Fix crash in rx_timer_fn() on PIO fallback
>   serial: sh-sci: Extract sci_dma_rx_chan_invalidate()
>   serial: sh-sci: Extract sci_dma_rx_reenable_irq()
>   serial: sh-sci: Fix fallback to PIO in sci_dma_rx_complete()
>   dmaengine: rcar-dmac: Reject zero-length slave DMA requests
>   arm64: dts: renesas: Fix whitespace around assignments
>   arm64: dts: renesas: Remove unneeded status from thermal nodes
>   arm64: dts: renesas: r8a774a1: Enable DMA for SCIF2
> 
> Hiroyuki Yokoyama (1):
>   dmaengine: rcar-dmac: Update copyright information
> 
> Kazuya Mizuguchi (1):
>   ravb: remove tx buffer addr 4byte alilgnment restriction for R-Car
>     Gen3
> 
> Niklas S?derlund (1):
>   mmc: renesas_sdhi_internal_dmac: set scatter/gather max segment size
> 
> Rob Herring (1):
>   arm64: dts: Remove inconsistent use of 'arm,armv8' compatible string
> 
> Sergei Shtylyov (1):
>   spi: sh-msiof: fix deferred probing
> 
> Simon Horman (1):
>   ravb: Avoid unsupported internal delay mode for R-Car E3/D3
> 
> Vladimir Zapolskiy (2):
>   gpio: rcar: reference device instead of platform device
>   gpio: rcar: select General Output Register to set output states
> 
> Wolfram Sang (1):
>   dmaengine: rcar-dmac: set scatter/gather max segment size
> 
>  .../devicetree/bindings/dma/renesas,usb-dmac.txt   |    1 +
>  .../devicetree/bindings/net/can/rcar_can.txt       |    9 +-
>  .../devicetree/bindings/phy/rcar-gen3-phy-usb3.txt |   10 +-
>  .../bindings/thermal/rcar-gen3-thermal.txt         |    1 +
>  .../devicetree/bindings/usb/renesas_usbhs.txt      |    3 +-
>  Documentation/devicetree/bindings/usb/usb-xhci.txt |    5 +-
>  arch/arm64/boot/dts/renesas/r8a774a1.dtsi          | 1695 ++++++++++++++++++++
>  drivers/clk/renesas/renesas-cpg-mssr.c             |   12 +-
>  drivers/dma/sh/rcar-dmac.c                         |    9 +-
>  drivers/gpio/gpio-rcar.c                           |   38 +-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c      |    8 +
>  drivers/net/ethernet/renesas/ravb.h                |    6 +-
>  drivers/net/ethernet/renesas/ravb_main.c           |  158 +-
>  drivers/soc/renesas/rcar-sysc.c                    |   65 +-
>  drivers/spi/spi-sh-msiof.c                         |    4 +-
>  drivers/thermal/rcar_gen3_thermal.c                |    1 +
>  drivers/tty/serial/sh-sci.c                        |   80 +-
>  17 files changed, 1936 insertions(+), 169 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> 
> --
> 2.7.4
