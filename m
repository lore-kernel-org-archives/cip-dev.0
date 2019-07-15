From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:01:40 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 00/12] Add USB Host support
Message-ID: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add USB host support for EK874 platform.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

This patch series is depend on the below patch series
https://patchwork.kernel.org/project/cip-dev/list/?series=145929

Biju Das (2):
  phy: rcar-gen3-usb2: Add support for r8a77470
  arm64: dts: renesas: cat874: Add USB-HOST support

Yoshihiro Shimoda (10):
  phy: renesas: rcar-gen3-usb2: fix vbus_ctrl for role sysfs
  phy: renesas: rcar-gen3-usb2: Rename has_otg_pins to uses_otg_pins
  phy: renesas: rcar-gen3-usb2: Check a property to use otg pins
  phy: renesas: rcar-gen3-usb2: unify OBINTEN handling
  phy: renesas: rcar-gen3-usb2: add conditions for uses_otg_pins ==
    false
  phy: renesas: rcar-gen3-usb2: change a condition "dr_mode"
  phy: renesas: rcar-gen3-usb2: add is_otg_channel to use "role" sysfs
  phy: renesas: rcar-gen3-usb2: follow the hardware manual procedure
  phy: renesas: rcar-gen3-usb2: Use pdev's device pointer on dev_vdbg()
  phy: renesas: rcar-gen3-usb2: enable/disable independent irqs

 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts |  15 ++
 drivers/phy/renesas/Kconfig                     |   2 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c        | 286 +++++++++++++++++++-----
 3 files changed, 250 insertions(+), 53 deletions(-)

-- 
2.7.4
