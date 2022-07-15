Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34704C43334
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:39:24 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.3828.1657870760365428455
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:39:20 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="127957711"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:39:19 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A4110421BAF6;
	Fri, 15 Jul 2022 16:39:17 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RESEND 5.10.y-cip 00/13] Add thermal driver and watchdog
 driver enhancements
Date: Fri, 15 Jul 2022 08:39:03 +0100
Message-Id: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:39:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8811

This patch series aims to add thermal driver support and watchdog driver enhancments
for RZ/G2L platform.

Resending this patch series as patchwork is not showing
patch#2 and #3 of the earlier series.

Andy Shevchenko (2):
  kernel.h: split out mathematical helpers
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
 fs/nfs/callback_proc.c          |   5 +
 include/linux/bitops.h          |  11 +-
 include/linux/dcache.h          |   1 +
 include/linux/iommu-helper.h    |   4 +-
 include/linux/kernel.h          | 173 +---------------------
 include/linux/math.h            | 177 +++++++++++++++++++++++
 include/linux/rcu_node_tree.h   |   2 +
 include/linux/units.h           |  22 ++-
 lib/errname.c                   |   1 +
 lib/errseq.c                    |   1 +
 lib/find_bit.c                  |   3 +-
 lib/math/div64.c                |   4 +-
 lib/math/int_pow.c              |   2 +-
 lib/math/int_sqrt.c             |   3 +-
 lib/math/reciprocal_div.c       |   9 +-
 20 files changed, 544 insertions(+), 219 deletions(-)
 create mode 100644 drivers/thermal/rzg2l_thermal.c
 create mode 100644 include/linux/math.h

-- 
2.25.1


