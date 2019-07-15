From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:28:44 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 0/6] Add LED/WDT support
Message-ID: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add LED/Watchdog support for EK874 platform.
It also enabled DMA for SCIF2 and fixes SCIF5 DMA channels.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

This patch series is depend on the below patch series
https://patchwork.kernel.org/project/cip-dev/list/?series=145943

Biju Das (1):
  arm64: dts: renesas: r8a774c0: sort subnodes of the soc node

Fabrizio Castro (2):
  arm64: dts: renesas: r8a774c0-cat874: Add LEDs support
  arm64: dts: renesas: r8a774c0-cat874: Add RWDT support

Geert Uytterhoeven (2):
  arm64: dts: renesas: r8a774c0: Enable DMA for SCIF2
  arm64: dts: renesas: r8a774c0: Fix SCIF5 DMA channels

Niklas S?derlund (1):
  arm64: dts: renesas: r8a774c0: Remove invalid compatible value for
    CSI40

 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts |  29 +++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi       | 261 ++++++++++++------------
 2 files changed, 160 insertions(+), 130 deletions(-)

-- 
2.7.4
