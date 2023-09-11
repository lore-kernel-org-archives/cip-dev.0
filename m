Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A73BEEB57D
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 14:47:12 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.60521.1694443627921841848
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 07:47:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,244,1688396400"; 
   d="scan'208";a="175705234"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Sep 2023 23:47:06 +0900
Received: from localhost.localdomain (unknown [10.226.92.180])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CEDB14003FDD;
	Mon, 11 Sep 2023 23:47:04 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/15] Enable Renesas PMIC RAA215300 and RTC builtin support
Date: Mon, 11 Sep 2023 15:46:47 +0100
Message-Id: <20230911144702.948246-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 14:47:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13024

This patch series aims to enable PMIC RAA215300 and builtin RTC support
 
All the patches are cherry-picked from the mainline except the first patch.

The first patch is equivalent to the commit 2023c5c8fe2e85 "rtc: isl1208:
do not advertise update interrupt feature if no interrupt specified" on
the mainline.
Without this patch, an error message [1] is seen on 5.10.y-cip kernel as
built-in RTC found on the PMIC does not populate interrupt by default on
RZ/G2L SMARC EVK platform.

[1]
hwclock: select() to /dev/rtc0 to wait for clock tick timed out

Bartosz Golaszewski (1):
  rtc: destroy mutex when releasing the device

Biju Das (13):
  rtc: isl1208: Fix clock tick timed out message
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
  arm64: dts: renesas: rzg2lc-smarc-som: Enable PMIC and built-in RTC

Dmitry Baryshkov (1):
  clk: fixed-rate: add devm_clk_hw_register_fixed_rate

 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     | 18 ++++++++
 .../boot/dts/renesas/rzg2lc-smarc-som.dtsi    | 18 ++++++++
 arch/arm64/configs/defconfig                  |  2 +
 drivers/clk/clk-fixed-rate.c                  | 28 +++++++++++--
 drivers/i2c/i2c-core-base.c                   | 19 +++++++++
 drivers/regulator/Kconfig                     |  6 ++-
 drivers/regulator/raa215300.c                 | 36 ++++++++--------
 drivers/rtc/class.c                           |  1 +
 drivers/rtc/rtc-isl1208.c                     | 24 +++++------
 include/linux/clk-provider.h                  | 41 +++++++++++++++----
 include/linux/i2c.h                           |  2 +
 11 files changed, 153 insertions(+), 42 deletions(-)

-- 
2.25.1


