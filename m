From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 09:15:11 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 00/10] Add RTC support
Message-ID: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add RTC support for iWave iwg23s sbc based on RZ/G1C.

This patch series is based on linux-4.4.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

This patch series depend on
https://patchwork.kernel.org/project/cip-dev/list/?series=146261

Alexandre Belloni (1):
  rtc: pcf85363: add .max_register in regmap_config

Biju Das (6):
  rtc: pcf85363: set time accurately
  dt-bindings: rtc: pcf85363: Document pcf85263 real-time clock
  rtc: pcf85363: Add support for NXP pcf85263 rtc
  ARM: shmobile: Enable NXP pcf85363 rtc in shmobile_defconfig
  ARM: multi_v7_defconfig: Enable NXP pcf85363 rtc
  ARM: dts: iwg23s-sbc: Enable RTC

Eric Nelson (1):
  rtc: add support for NXP PCF85363 real-time clock

Fabrizio Castro (2):
  ARM: dts: r8a77470: Add I2C4 support
  ARM: dts: r8a77470: Add I2C[0123] support

 Documentation/devicetree/bindings/rtc/pcf85363.txt |  17 ++
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts          |  18 ++
 arch/arm/boot/dts/r8a77470.dtsi                    |  68 ++++++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/configs/shmobile_defconfig                |   1 +
 drivers/rtc/Kconfig                                |   9 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-pcf85363.c                         | 234 +++++++++++++++++++++
 8 files changed, 349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/pcf85363.txt
 create mode 100644 drivers/rtc/rtc-pcf85363.c

-- 
2.7.4
