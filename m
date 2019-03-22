From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:56:16 +0000
Subject: [cip-dev] [PATCH 0/5] Add Ethernet/Watchdog support
Message-ID: <1553248581-64466-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add Ethernet/Watchdog support for EK874 platform.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

This patch series is depend on the below patch series
https://patchwork.kernel.org/patch/10865441/

Biju Das (1):
  arm64: dts: renesas: cat875: Add ethernet support

Fabrizio Castro (4):
  dt-bindings: net: ravb: Add support for r8a774c0 SoC
  arm64: dts: renesas: r8a774c0: Add Ethernet AVB node
  dt-bindings: watchdog: renesas-wdt: Document r8a774c0 support
  arm64: dts: renesas: r8a774c0: Add watchdog support

 .../devicetree/bindings/net/renesas,ravb.txt       |  1 +
 .../devicetree/bindings/watchdog/renesas-wdt.txt   |  1 +
 arch/arm64/boot/dts/renesas/cat875.dtsi            | 30 ++++++++++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 55 ++++++++++++++++++++++
 4 files changed, 87 insertions(+)

-- 
2.7.4
