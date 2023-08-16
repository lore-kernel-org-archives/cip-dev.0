Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965EBC41513
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:20:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.162029.1692195622758359845
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:20:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="173100176"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2023 23:20:21 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AE4A14210C24;
	Wed, 16 Aug 2023 23:20:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/31] Add Renesas PMIC RAA215300 driver and builtin RTC support
Date: Wed, 16 Aug 2023 15:19:46 +0100
Message-Id: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:20:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12682

This patch series aims to add PMIC RAA215300 driver and builtin RTC support
 
All the patches are cherry-picked from the mainline except the last
3 patches.

The last 3 patches are from next and just added here for testing.

Note:
Some improvement patches to mainline after the internal review[1]
[1] https://lore.kernel.org/linux-renesas-soc/20230816135550.146657-1-biju.das.jz@bp.renesas.com/T/#t

Alexandre Belloni (9):
  rtc: nvmem: remove nvram ABI
  rtc: rv3032: fix nvram nvmem priv pointer
  rtc: fix RTC removal
  rtc: introduce features bitfield
  rtc: add alarm related features
  rtc: expose correction feature
  rtc: rtc_update_irq_enable: rework UIE emulation
  rtc: expose RTC_FEATURE_UPDATE_INTERRUPT
  rtc: isl1208: quiet maybe-unused variable warning

Bartosz Golaszewski (5):
  Documentation: list RTC devres helpers in devres.rst
  rtc: add devm_ prefix to rtc_nvmem_register()
  rtc: rework rtc_register_device() resource management
  rtc: shrink devm_rtc_allocate_device()
  rtc: destroy mutex when releasing the device

Biju Das (13):
  regulator: dt-bindings: Add Renesas RAA215300 PMIC bindings
  regulator: Add Renesas PMIC RAA215300 driver
  regulator: raa215300: Add build dependency with COMMON_CLK
  dt-bindings: rtc: isl1208: Convert to json-schema
  dt-bindings: rtc: isil,isl1208: Document clock and clock-names
    properties
  rtc: isl1208: Drop name variable
  rtc: isl1208: Make similar I2C and DT-based matching table
  rtc: isl1208: Drop enum isl1208_id and split isl1208_configs[]
  rtc: isl1208: Add isl1208_set_xtoscb()
  rtc: isl1208: Add support for the built-in RTC on the PMIC RAA215300
  arm64: defconfig: Enable PMIC RAA215300 and RTC ISL 1208 configs
  arm64: dts: renesas: rzg2l-smarc-som: Enable PMIC and built-in RTC
  arm64: dts: renesas: rzg2lc-smarc-som: Enable PMIC and built-in RTC

Quentin Schulz (1):
  rtc: isl1208: do not advertise update interrupt feature if no
    interrupt specified

Shang XiaoJing (1):
  rtc: class: Fix potential memleak in devm_rtc_allocate_device()

Yang Yingliang (2):
  rtc: class: don't call cdev_device_del() when cdev_device_add() failed
  rtc: class: check return value when calling dev_set_name()

 .../bindings/regulator/renesas,raa215300.yaml |  85 ++++++++
 .../devicetree/bindings/rtc/isil,isl1208.txt  |  38 ----
 .../devicetree/bindings/rtc/isil,isl1208.yaml | 100 +++++++++
 .../driver-api/driver-model/devres.rst        |   6 +
 arch/alpha/kernel/rtc.c                       |   2 +-
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  18 ++
 .../boot/dts/renesas/rzg2lc-smarc-som.dtsi    |  18 ++
 arch/arm64/configs/defconfig                  |   2 +
 drivers/mfd/menelaus.c                        |   2 +-
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/raa215300.c                 | 190 ++++++++++++++++++
 drivers/rtc/class.c                           |  77 +++----
 drivers/rtc/interface.c                       |  47 ++---
 drivers/rtc/nvmem.c                           |  86 +-------
 drivers/rtc/rtc-88pm80x.c                     |   2 +-
 drivers/rtc/rtc-88pm860x.c                    |   2 +-
 drivers/rtc/rtc-ab-b5ze-s3.c                  |   2 +-
 drivers/rtc/rtc-ab-eoz9.c                     |   2 +-
 drivers/rtc/rtc-ab3100.c                      |   2 +-
 drivers/rtc/rtc-ab8500.c                      |   2 +-
 drivers/rtc/rtc-abx80x.c                      |   2 +-
 drivers/rtc/rtc-ac100.c                       |   2 +-
 drivers/rtc/rtc-armada38x.c                   |   2 +-
 drivers/rtc/rtc-aspeed.c                      |   2 +-
 drivers/rtc/rtc-at91rm9200.c                  |   2 +-
 drivers/rtc/rtc-at91sam9.c                    |   2 +-
 drivers/rtc/rtc-au1xxx.c                      |   2 +-
 drivers/rtc/rtc-bd70528.c                     |   2 +-
 drivers/rtc/rtc-brcmstb-waketimer.c           |   2 +-
 drivers/rtc/rtc-cadence.c                     |   2 +-
 drivers/rtc/rtc-cmos.c                        |   5 +-
 drivers/rtc/rtc-coh901331.c                   |   2 +-
 drivers/rtc/rtc-cpcap.c                       |   2 +-
 drivers/rtc/rtc-cros-ec.c                     |   2 +-
 drivers/rtc/rtc-da9052.c                      |   2 +-
 drivers/rtc/rtc-da9063.c                      |   2 +-
 drivers/rtc/rtc-davinci.c                     |   2 +-
 drivers/rtc/rtc-digicolor.c                   |   2 +-
 drivers/rtc/rtc-dm355evm.c                    |   2 +-
 drivers/rtc/rtc-ds1305.c                      |   5 +-
 drivers/rtc/rtc-ds1307.c                      |   5 +-
 drivers/rtc/rtc-ds1343.c                      |   5 +-
 drivers/rtc/rtc-ds1347.c                      |   2 +-
 drivers/rtc/rtc-ds1374.c                      |   2 +-
 drivers/rtc/rtc-ds1511.c                      |   6 +-
 drivers/rtc/rtc-ds1553.c                      |   5 +-
 drivers/rtc/rtc-ds1672.c                      |   2 +-
 drivers/rtc/rtc-ds1685.c                      |   5 +-
 drivers/rtc/rtc-ds1742.c                      |   5 +-
 drivers/rtc/rtc-ds2404.c                      |   2 +-
 drivers/rtc/rtc-ds3232.c                      |   2 +-
 drivers/rtc/rtc-ep93xx.c                      |   2 +-
 drivers/rtc/rtc-fsl-ftm-alarm.c               |   2 +-
 drivers/rtc/rtc-ftrtc010.c                    |   2 +-
 drivers/rtc/rtc-goldfish.c                    |   2 +-
 drivers/rtc/rtc-imx-sc.c                      |   2 +-
 drivers/rtc/rtc-imxdi.c                       |   2 +-
 drivers/rtc/rtc-isl12026.c                    |   4 +-
 drivers/rtc/rtc-isl1208.c                     | 146 ++++++++++----
 drivers/rtc/rtc-jz4740.c                      |   2 +-
 drivers/rtc/rtc-lpc32xx.c                     |   2 +-
 drivers/rtc/rtc-ls1x.c                        |   2 +-
 drivers/rtc/rtc-m41t80.c                      |   2 +-
 drivers/rtc/rtc-m48t59.c                      |   5 +-
 drivers/rtc/rtc-m48t86.c                      |   5 +-
 drivers/rtc/rtc-mc13xxx.c                     |   2 +-
 drivers/rtc/rtc-meson-vrtc.c                  |   2 +-
 drivers/rtc/rtc-meson.c                       |   4 +-
 drivers/rtc/rtc-mpc5121.c                     |   2 +-
 drivers/rtc/rtc-mrst.c                        |   2 +-
 drivers/rtc/rtc-mt2712.c                      |   2 +-
 drivers/rtc/rtc-mt6397.c                      |   2 +-
 drivers/rtc/rtc-mv.c                          |   2 +-
 drivers/rtc/rtc-mxc.c                         |   2 +-
 drivers/rtc/rtc-mxc_v2.c                      |   2 +-
 drivers/rtc/rtc-omap.c                        |   4 +-
 drivers/rtc/rtc-pcap.c                        |   2 +-
 drivers/rtc/rtc-pcf2123.c                     |   2 +-
 drivers/rtc/rtc-pcf2127.c                     |   4 +-
 drivers/rtc/rtc-pcf85063.c                    |   4 +-
 drivers/rtc/rtc-pcf85363.c                    |   4 +-
 drivers/rtc/rtc-pcf8563.c                     |   2 +-
 drivers/rtc/rtc-pic32.c                       |   2 +-
 drivers/rtc/rtc-pl030.c                       |   2 +-
 drivers/rtc/rtc-pl031.c                       |   2 +-
 drivers/rtc/rtc-pm8xxx.c                      |   2 +-
 drivers/rtc/rtc-ps3.c                         |   2 +-
 drivers/rtc/rtc-r9701.c                       |   2 +-
 drivers/rtc/rtc-rc5t619.c                     |   2 +-
 drivers/rtc/rtc-rk808.c                       |   2 +-
 drivers/rtc/rtc-rp5c01.c                      |   5 +-
 drivers/rtc/rtc-rs5c348.c                     |   2 +-
 drivers/rtc/rtc-rv3028.c                      |   6 +-
 drivers/rtc/rtc-rv3029c2.c                    |   4 +-
 drivers/rtc/rtc-rv3032.c                      |   8 +-
 drivers/rtc/rtc-rv8803.c                      |   5 +-
 drivers/rtc/rtc-rx8010.c                      |   2 +-
 drivers/rtc/rtc-rx8581.c                      |   4 +-
 drivers/rtc/rtc-s35390a.c                     |   2 +-
 drivers/rtc/rtc-sa1100.c                      |   2 +-
 drivers/rtc/rtc-sc27xx.c                      |   2 +-
 drivers/rtc/rtc-sd3078.c                      |   2 +-
 drivers/rtc/rtc-sh.c                          |   2 +-
 drivers/rtc/rtc-sirfsoc.c                     |   2 +-
 drivers/rtc/rtc-snvs.c                        |   2 +-
 drivers/rtc/rtc-st-lpc.c                      |   2 +-
 drivers/rtc/rtc-starfire.c                    |   2 +-
 drivers/rtc/rtc-stk17ta8.c                    |   5 +-
 drivers/rtc/rtc-stmp3xxx.c                    |   2 +-
 drivers/rtc/rtc-sun4v.c                       |   2 +-
 drivers/rtc/rtc-sun6i.c                       |   2 +-
 drivers/rtc/rtc-sunxi.c                       |   2 +-
 drivers/rtc/rtc-tegra.c                       |   2 +-
 drivers/rtc/rtc-test.c                        |   2 +-
 drivers/rtc/rtc-tps6586x.c                    |   2 +-
 drivers/rtc/rtc-tps65910.c                    |   2 +-
 drivers/rtc/rtc-tx4939.c                      |   5 +-
 drivers/rtc/rtc-vr41xx.c                      |   2 +-
 drivers/rtc/rtc-vt8500.c                      |   2 +-
 drivers/rtc/rtc-wilco-ec.c                    |   2 +-
 drivers/rtc/rtc-wm831x.c                      |   2 +-
 drivers/rtc/rtc-xgene.c                       |   2 +-
 drivers/rtc/rtc-zynqmp.c                      |   2 +-
 drivers/rtc/sysfs.c                           |   2 -
 include/linux/rtc.h                           |  23 +--
 include/uapi/linux/rtc.h                      |   8 +
 127 files changed, 750 insertions(+), 394 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
 create mode 100644 drivers/regulator/raa215300.c

-- 
2.25.1


