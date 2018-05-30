From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 30 May 2018 18:35:56 +0100
Subject: [cip-dev] [PATCH v2 00/11] Add support for Thermal and CMT
Message-ID: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add support for thermal and CMT.

This patchset is rebased on top of the previous patch set

0001-pinctrl-sh-pfc-r8a7791-Add-can_clk-function.patch
to
0058-thermal-rcar_thermal-don-t-open-code-of_device_get_m.patch

V1-->V2
     * Incorporated thermal related review comments
     * Added CMT support

Biju Das (2):
  dt-bindings: thermal: rcar: Add device tree support for r8a7743
  ARM: dts: r8a7743: Add thermal device to DT

Bui Duc Phuc (1):
  thermal: rcar_thermal: don't call thermal_zone_device_unregister when
    USE_OF_THERMAL

Dirk Behme (1):
  thermal: rcar_thermal: Fix priv->zone error handling

Eduardo Valentin (1):
  thermal: convert rcar_thermal to use
    devm_thermal_zone_of_sensor_register

Fabrizio Castro (2):
  ARM: dts: r8a7743: Add CMT SoC specific support
  ARM: dts: iwg20m: Enable cmt0

Kuninori Morimoto (1):
  thermal: rcar-thermal: enable hwmon when
    thermal_zone_of_sensor_register is used

Laxman Dewangan (1):
  thermal: of-thermal: Add devm version of
    thermal_zone_of_sensor_register

Nicolai Stange (2):
  clocksource: sh_cmt: Compute rate before registration again
  clockevents/drivers/sh_cmt: Set ->min_delta_ticks and
    ->max_delta_ticks

 .../devicetree/bindings/thermal/rcar-thermal.txt   |  1 +
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |  4 ++
 arch/arm/boot/dts/r8a7743.dtsi                     | 67 ++++++++++++++++++
 drivers/clocksource/sh_cmt.c                       | 47 +++++++------
 drivers/thermal/of-thermal.c                       | 81 ++++++++++++++++++++++
 drivers/thermal/rcar_thermal.c                     | 26 +++++--
 include/linux/thermal.h                            | 18 +++++
 7 files changed, 220 insertions(+), 24 deletions(-)

-- 
2.7.4
