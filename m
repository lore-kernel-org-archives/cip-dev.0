From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 15 Sep 2017 13:58:13 +0000
Subject: [cip-dev] [PATCH v2 00/18] Add Device tree support for
	iWave	G20D-Q7 board
In-Reply-To: <1504190063-61519-1-git-send-email-biju.das@bp.renesas.com>
References: <1504190063-61519-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <KL1PR06MB17024B5A7950AF05BA980730B86C0@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

Any update on this?

Regds,
Biju

> -----Original Message-----
> From: Biju Das [mailto:biju.das at bp.renesas.com]
> Sent: 31 August 2017 15:34
> To: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> <biju.das@bp.renesas.com>; cip-dev at lists.cip-project.org
> Subject: [PATCH v2 00/18] Add Device tree support for iWave G20D-Q7 board
>
> This patch series aims to add initial SoC DT/Clock and iWave G20D-Q7 DT.
> The clock patch is based on the similar work done on r8a7791(R-Car M2) SoC.
>
>  This series has been tested against linux-cip tag v4.4.83-cip8 branch.
>
> V1-->V2
>      Added SoC node
>  https://lists.cip-project.org/pipermail/cip-dev/2017-
> August/000461.html
>
> Biju Das (7):
>   ARM: shmobile: r8a7743: Add clock index macros for DT sources
>   clk: shmobile: Document r8a7743 CPG clock support
>   clk: shmobile: Document r8a7743 CPG DIV6 clock support
>   clk: shmobile: Document r8a7743 MSTP clock support
>   ARM: dts: r8a7743: Add clocks
>   ARM: dts: iwg20m: Add iWave RZG1M Qseven SOM
>   ARM: dts: iwg20d-q7: Add support for iWave G20D-Q7 board based on
>     RZ/G1M
>
> Geert Uytterhoeven (3):
>   ARM: dts: r8a7743: Link ARM GIC to clock and clock domain
>   ARM: dts: r8a7743: Fix SCIFB0 dmas indentation
>   ARM: dts: r8a7743: Remove unit-address and reg from integrated cache
>
> Marc Zyngier (1):
>   ARM: DTS: Fix register map for virt-capable GIC
>
> Sergei Shtylyov (5):
>   ARM: dts: r8a7743: initial SoC device tree
>   ARM: dts: r8a7743: add SYS-DMAC support
>   ARM: dts: r8a7743: add [H]SCIF{A|B} support
>   ARM: dts: r8a7743: add Ether support
>   ARM: dts: r8a7743: add IRQC support
>
> Simon Horman (2):
>   ARM: shmobile: defconfig: Enable r8a774[35] SoCs
>   ARM: multi_v7_defconfig: Enable r8a774[35] SoCs
>
>  .../bindings/clock/renesas,cpg-div6-clocks.txt     |   1 +
>  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
>  .../clock/renesas,rcar-gen2-cpg-clocks.txt         |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/r8a7743-iwg20d-q7.dts            |  25 +
>  arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |  29 +
>  arch/arm/boot/dts/r8a7743.dtsi                     | 866 +++++++++++++++++++++
>  arch/arm/configs/multi_v7_defconfig                |   2 +
>  arch/arm/configs/shmobile_defconfig                |   2 +
>  include/dt-bindings/clock/r8a7743-clock.h          | 166 ++++
>  10 files changed, 1094 insertions(+)
>  create mode 100644 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
>  create mode 100644 arch/arm/boot/dts/r8a7743-iwg20m.dtsi
>  create mode 100644 arch/arm/boot/dts/r8a7743.dtsi  create mode 100644
> include/dt-bindings/clock/r8a7743-clock.h
>
> --
> 1.9.1




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
