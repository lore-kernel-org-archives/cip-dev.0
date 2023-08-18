Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AD2C678DC
	for <webhook@archiver.kernel.org>; Fri, 18 Aug 2023 09:28:21 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.7435.1692350893584802847
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Aug 2023 02:28:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,182,1684767600"; 
   d="scan'208";a="173270367"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Aug 2023 18:28:11 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B252D41DADA0;
	Fri, 18 Aug 2023 18:28:09 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/14] Add Renesas PMIC RAA215300 driver and builtin RTC support
Date: Fri, 18 Aug 2023 10:27:53 +0100
Message-Id: <20230818092807.159112-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Aug 2023 09:28:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12772

This patch series aims to add PMIC RAA215300 driver and builtin RTC support

All the patches are cherry-picked from the mainline except the last
3 patches.

The last 3 patches are from next and just added here for testing.

Note:
Some improvement patches send to mainline after the review[1]
[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20230818&id=e21ac64e669e960688e79bf5babeed63132dac8a
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20230818&id=727d7c1c3695657873d62030b968ba97c8698c54
[3] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230817161038.407960-1-biju.das.jz@bp.renesas.com/

Alexandre Belloni (1):
  rtc: isl1208: quiet maybe-unused variable warning

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
 drivers/rtc/rtc-isl1208.c                     | 132 +++++++++---
 10 files changed, 521 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
 create mode 100644 drivers/regulator/raa215300.c

-- 
2.25.1


