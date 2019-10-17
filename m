From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 07:57:53 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 0/6] Add HDMI AUDIO/CAN/CANFD support
Message-ID: <1571295479-39328-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add HDMI AUDIO/CAN/CANFD support for HiHope RZ/G2M platform.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

Biju Das (1):
  dt-bindings: can: rcar_canfd: document r8a774a1 support

Fabrizio Castro (5):
  arm64: dts: renesas: r8a774a1: Use extended audio dmac registers
  arm64: dts: renesas: hihope-common: Add HDMI audio support
  arm64: dts: renesas: r8a774a1: Add missing assigned-clocks for CAN[01]
  arm64: dts: renesas: r8a774a1: Add CANFD support
  arm64: dts: renesas: hihope-rzg2-ex: Enable CAN interfaces

 .../devicetree/bindings/net/can/rcar_canfd.txt     |  9 +++--
 arch/arm64/boot/dts/renesas/hihope-common.dtsi     | 47 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi    | 22 ++++++++++
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          | 31 +++++++++++++-
 4 files changed, 104 insertions(+), 5 deletions(-)

-- 
2.7.4
