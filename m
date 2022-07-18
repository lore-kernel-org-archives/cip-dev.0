Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427A1C433EF
	for <webhook@archiver.kernel.org>; Mon, 18 Jul 2022 09:24:41 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.25202.1658136274779570356
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jul 2022 02:24:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,280,1650898800";
   d="scan'208";a="128219414"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Jul 2022 18:24:33 +0900
Received: from biju-VirtualBox.ree.adwin.renesas.com (unknown [10.226.36.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7FD5C400194D;
	Mon, 18 Jul 2022 18:24:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH v2 5.10.y-cip 00/12] Add thermal driver and watchdog driver
 enhancements
Date: Mon, 18 Jul 2022 10:24:18 +0100
Message-Id: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Jul 2022 09:24:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8846

This patch series aims to add thermal driver support and watchdog driver enhancments
for RZ/G2L platform.

v1->v2:
 * Removed patch#1 and updated rzg2l_thermal.c to use kernel.h.

Andy Shevchenko (1):
  units: Add SI metric prefix definitions

Biju Das (10):
  thermal/drivers: Add TSU driver for RZ/G2L
  thermal/drivers/rz2gl: Add error check for reset_control_deassert()
  thermal/drivers/rz2gl: Fix OTP Calibration Register values
  watchdog: rzg2l_wdt: Fix 32bit overflow issue
  watchdog: rzg2l_wdt: Fix Runtime PM usage
  watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'
  watchdog: rzg2l_wdt: Fix reset control imbalance
  watchdog: rzg2l_wdt: Add error check for reset_control_deassert
  watchdog: rzg2l_wdt: Use force reset for WDT reset
  watchdog: rzg2l_wdt: Add set_timeout callback

Geert Uytterhoeven (1):
  arm64: defconfig: Enable additional support for Renesas platforms

 arch/arm64/configs/defconfig    |   4 +
 drivers/thermal/Kconfig         |   9 ++
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/rzg2l_thermal.c | 248 ++++++++++++++++++++++++++++++++
 drivers/watchdog/rzg2l_wdt.c    |  83 ++++++-----
 include/linux/units.h           |  20 +++
 6 files changed, 329 insertions(+), 36 deletions(-)
 create mode 100644 drivers/thermal/rzg2l_thermal.c

-- 
2.25.1


