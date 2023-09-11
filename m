Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB7EE7FF4
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 16:28:55 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.1251.1694449726325808064
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 09:28:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,244,1688396400"; 
   d="scan'208";a="175711372"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Sep 2023 01:28:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.180])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 35ACC401D159;
	Tue, 12 Sep 2023 01:28:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/14] Enable Renesas PMIC RAA215300 and RTC builtin support
Date: Mon, 11 Sep 2023 17:28:26 +0100
Message-Id: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 16:28:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13040

This patch series aims to enable PMIC RAA215300 and builtin RTC support on
RZ/G2L SMARC EVK platform.
 
All the patches are cherry-picked from the mainline.

Biju Das (13):
  i2c: Add i2c_get_match_data()
  regulator: raa215300: Update help description
  regulator: raa215300: Change the scope of the variables {clkin_name,
    xin_name}
  regulator: raa215300: Fix resource leak in case of error
  regulator: raa215300: Add const definition
  regulator: raa215300: Change rate from 32000->32768
  regulator: raa215300: Add missing blank space
  rtc: isl1208: Simplify probe()
  rtc: isl1208: Fix incorrect logic in isl1208_set_xtoscb()
  arm64: defconfig: Enable PMIC RAA215300 and RTC ISL 1208 configs
  arm64: dts: renesas: rzg2l-smarc-som: Enable PMIC and built-in RTC
  arm64: dts: renesas: rzg2lc-smarc-som: Add PHY interrupt support for
    ETH0
  arm64: dts: renesas: rzg2lc-smarc-som: Enable PMIC and built-in RTC

Chris Paterson (1):
  arm64: dts: renesas: rzg2l: Fix txdv-skew-psec typos

 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     | 22 ++++++++++--
 .../boot/dts/renesas/rzg2lc-smarc-som.dtsi    | 26 ++++++++++++--
 .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    |  4 +--
 arch/arm64/configs/defconfig                  |  2 ++
 drivers/i2c/i2c-core-base.c                   | 19 ++++++++++
 drivers/regulator/Kconfig                     |  6 +++-
 drivers/regulator/raa215300.c                 | 36 ++++++++++---------
 drivers/rtc/rtc-isl1208.c                     | 14 +++-----
 include/linux/i2c.h                           |  2 ++
 9 files changed, 97 insertions(+), 34 deletions(-)

-- 
2.25.1


