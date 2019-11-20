From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 20 Nov 2019 16:47:14 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 0/6] Add CMT/RWDT support
Message-ID: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add CMT/RWDT support for RZ/G1C based iwg23s-sbc.

Backported the relevent patches to linux-4.4.y-cip.

Biju Das (6):
  dt-bindings: watchdog: renesas-wdt: Document r8a77470 support
  ARM: dts: r8a77470: Add watchdog support to SoC dtsi
  ARM: dts: iwg23s-sbc: Enable watchdog support
  dt-bindings: timer: renesas, cmt: Document r8a77470 CMT support
  ARM: dts: r8a77470: Add CMT SoC specific support
  ARM: dts: iwg23s-sbc: Enable cmt0

 .../devicetree/bindings/timer/renesas,cmt.txt      |  2 +
 .../devicetree/bindings/watchdog/renesas-wdt.txt   |  1 +
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts          |  9 +++++
 arch/arm/boot/dts/r8a77470.dtsi                    | 45 ++++++++++++++++++++++
 4 files changed, 57 insertions(+)

-- 
2.7.4
