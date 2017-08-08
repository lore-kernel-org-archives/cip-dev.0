From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 8 Aug 2017 10:18:03 +0000
Subject: [cip-dev] [PATCH 00/14] Add Device tree support for iWave
	G20D-Q7 board
In-Reply-To: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
References: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <TY1PR06MB0702B115FD3694B9778C66DFB78A0@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


> From: Biju Das [mailto:biju.das at bp.renesas.com]
> Sent: 08 August 2017 10:50
> 
> This patch series aims to add initial SoC DT/Clock and iWave G20D-Q7 DT.
> 
> The clock patch is based on the similar work done on r8a7791(R-Car M2) SoC.
> 
> This series has been tested against linux-cip tag v4.4.y-cip master branch.

For the series: Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>


> 
> Biju Das (8):
>   ARM: dts: r8a7743: initial SoC device tree
>   ARM: shmobile: r8a7743: Add clock index macros for DT sources
>   clk: shmobile: Document r8a7743 CPG clock support
>   clk: shmobile: Document r8a7743 CPG DIV6 clock support
>   clk: shmobile: Document r8a7743 MSTP clock support
>   ARM: dts: r8a7743: Add clocks
>   ARM: dts: iwg20m: Add iWave RZG1M Qseven SOM
>   ARM: dts: iwg20d-q7: Add support for iWave G20D-Q7 board based on
>     RZ/G1M
> 
> Sergei Shtylyov (4):
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
>  arch/arm/boot/dts/r8a7743.dtsi                     | 871 +++++++++++++++++++++
>  arch/arm/configs/multi_v7_defconfig                |   2 +
>  arch/arm/configs/shmobile_defconfig                |   2 +
>  include/dt-bindings/clock/r8a7743-clock.h          | 166 ++++
>  10 files changed, 1099 insertions(+)
>  create mode 100644 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
>  create mode 100644 arch/arm/boot/dts/r8a7743-iwg20m.dtsi
>  create mode 100644 arch/arm/boot/dts/r8a7743.dtsi  create mode 100644
> include/dt-bindings/clock/r8a7743-clock.h
> 
> --
> 1.9.1
