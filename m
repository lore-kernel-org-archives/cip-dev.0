Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A6CC3DA49
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 07:56:57 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5540.1721116607082293588
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 00:56:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="211463290"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Jul 2024 16:56:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A2DA541CF052;
	Tue, 16 Jul 2024 16:56:43 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/23] Add PMIC DA9062 support
Date: Tue, 16 Jul 2024 08:56:05 +0100
Message-ID: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 07:56:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16500

This patch series aims to add PMIC DA9062 support for SMARC RZ/{G2UL,Five}
EVK platforms.

All the patches are cherry-picked from the mainline.

Biju Das (18):
  mfd: da9062: Simplify obtaining I2C match data
  rtc: da9063: Make IRQ as optional
  rtc: da9063: Use device_get_match_data()
  rtc: da9063: Use dev_err_probe()
  pinctrl: da9062: Add OF table
  Input: da9063 - simplify obtaining OF match data
  Input: da9063 - drop redundant prints in probe()
  Input: da9063 - use dev_err_probe()
  dt-bindings: watchdog: dlg,da9062-watchdog: Add fallback for DA9061
    watchdog
  dt-bindings: watchdog: dlg,da9062-watchdog: Document DA9063 watchdog
  dt-bindings: mfd: da9062: Update watchdog description
  dt-bindings: mfd: dlg,da9063: Update watchdog child node
  dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
  dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
  dt-bindings: mfd: dlg,da9063: Sort child devices
  dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema
  arm64: dts: renesas: rzg2ul-smarc: Enable PMIC and built-in RTC, GPIO
    and ONKEY
  arm64: defconfig: Enable Renesas DA9062 PMIC

Christoph Niedermaier (2):
  mfd: da9062: Use MFD_CELL_OF macro
  mfd: da9062: Remove IRQ requirement

Nik Bune (1):
  dt-bindings: watchdog: da9062-wdt: convert txt to yaml

Samuel Holland (2):
  rtc: da9063: Mark the alarm IRQ as a wake IRQ
  Input: da9063 - add wakeup support

 .../bindings/input/da9062-onkey.txt           |  47 ----
 .../bindings/input/dlg,da9062-onkey.yaml      |  38 +++
 .../devicetree/bindings/mfd/da9062.txt        | 123 ---------
 .../devicetree/bindings/mfd/dlg,da9063.yaml   | 248 +++++++++++++++---
 .../bindings/thermal/da9062-thermal.txt       |  36 ---
 .../bindings/thermal/dlg,da9062-thermal.yaml  |  35 +++
 .../bindings/watchdog/da9062-wdt.txt          |  34 ---
 .../watchdog/dlg,da9062-watchdog.yaml         |  54 ++++
 MAINTAINERS                                   |   6 +-
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  58 ++++
 arch/arm64/configs/defconfig                  |   4 +
 drivers/input/misc/da9063_onkey.c             |  70 +++--
 drivers/mfd/da9062-core.c                     | 197 +++++++-------
 drivers/pinctrl/pinctrl-da9062.c              |   7 +
 drivers/rtc/rtc-da9063.c                      |  83 +++---
 15 files changed, 573 insertions(+), 467 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/da9062-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
 delete mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml

-- 
2.43.0


