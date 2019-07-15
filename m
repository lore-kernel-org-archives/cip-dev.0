From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:17:19 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 0/6] Add RTC support
Message-ID: <1563200245-30331-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add RTC support for EK874 platform.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

This patch series is depend on the below patch series
https://patchwork.kernel.org/project/cip-dev/list/?series=145931

Alexandre Belloni (2):
  rtc: nvmem: use devm_nvmem_register()
  rtc: nvmem: remove nvmem from struct rtc_device

Biju Das (4):
  dt-bindings: rtc: add rx8571 compatible
  rtc: rx8581: Add support for Epson rx8571 RTC
  arm64: defconfig: enable RX-8581 config option
  arm64: dts: renesas: r8a774c0-cat874: add RTC support

 .../devicetree/bindings/trivial-devices.txt        |   1 +
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts    |  19 ++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/rtc/Kconfig                                |   5 +-
 drivers/rtc/nvmem.c                                |  29 ++----
 drivers/rtc/rtc-rx8581.c                           | 114 +++++++++++++++++++--
 include/linux/rtc.h                                |   1 -
 7 files changed, 139 insertions(+), 31 deletions(-)

-- 
2.7.4
