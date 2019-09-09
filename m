From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  9 Sep 2019 09:52:02 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 0/4] Add USB support
Message-ID: <1568019126-45985-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add USB2.0/USB3.0 support for Hihope RZ/G2M platform.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

Biju Das (3):
  arm64: dts: renesas: r8a774a1: Fix USB 2.0 clocks
  arm64: dts: renesas: hihope-common: Add USB 2.0 support
  arm64: dts: renesas: hihope-common: Enable USB3.0

Yoshihiro Shimoda (1):
  phy: renesas: rcar-gen3-usb2: fix imbalance powered flag

 arch/arm64/boot/dts/renesas/hihope-common.dtsi | 106 +++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi      |  16 ++--
 drivers/phy/renesas/phy-rcar-gen3-usb2.c       |  19 ++++-
 3 files changed, 129 insertions(+), 12 deletions(-)

-- 
2.7.4
