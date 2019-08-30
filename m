From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 30 Aug 2019 08:31:53 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 0/5] Add HopeRun RZ/G2[M] main/sub
	boards
Message-ID: <1567150318-36833-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add support for HopeRun RZ/G2[M] main/sub boards.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

This patch series depend upon
https://patchwork.kernel.org/project/cip-dev/list/?series=166545


Biju Das (5):
  dt-bindings: arm: renesas: Add HopeRun RZ/G2[M] boards
  dt-bindings: Add vendor prefix for HopeRun
  arm64: dts: renesas: Add HiHope RZ/G2M main board support
  arm64: dts: renesas: hihope-common: Add pincontrol support to
    scif2/scif clock
  arm64: dts: renesas: Add HiHope RZ/G2M sub board support

 Documentation/devicetree/bindings/arm/shmobile.txt |  5 ++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm64/boot/dts/renesas/Makefile               |  2 +
 arch/arm64/boot/dts/renesas/hihope-common.dtsi     | 53 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi    | 55 ++++++++++++++++++++++
 .../boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts  | 15 ++++++
 .../boot/dts/renesas/r8a774a1-hihope-rzg2m.dts     | 26 ++++++++++
 7 files changed, 157 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/hihope-common.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts

-- 
2.7.4
