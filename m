Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D863C04E69
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:25:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.162189.1692195901931158900
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:25:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="176787854"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 23:25:01 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B0E6F4210E49;
	Wed, 16 Aug 2023 23:24:59 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/13] Add Renesas PMIC RAA215300 driver and builtin RTC support
Date: Wed, 16 Aug 2023 15:24:45 +0100
Message-Id: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:25:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12716

This patch series aims to add PMIC RAA215300 driver and builtin RTC support
 
All the patches are cherry-picked from the mainline except the last
3 patches.

The last 3 patches are from next and just added here for testing.

Note:
Some improvement patches to mainline after the internal review[1]
[1] https://lore.kernel.org/linux-renesas-soc/20230816135550.146657-1-biju.das.jz@bp.renesas.com/T/#t

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

 .../bindings/regulator/renesas,raa215300.yaml |  85 ++++++++
 .../devicetree/bindings/rtc/isil,isl1208.txt  |  38 ----
 .../devicetree/bindings/rtc/isil,isl1208.yaml | 100 +++++++++
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  18 ++
 .../boot/dts/renesas/rzg2lc-smarc-som.dtsi    |  18 ++
 arch/arm64/configs/defconfig                  |   2 +
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/raa215300.c                 | 190 ++++++++++++++++++
 drivers/rtc/rtc-isl1208.c                     | 130 +++++++++---
 10 files changed, 520 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
 create mode 100644 drivers/regulator/raa215300.c

-- 
2.25.1


