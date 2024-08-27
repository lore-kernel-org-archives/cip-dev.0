Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAADC54731
	for <webhook@archiver.kernel.org>; Tue, 27 Aug 2024 21:06:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1384.1724792773718936280
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Aug 2024 14:06:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.10,181,1719846000"; 
   d="scan'208";a="220720142"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Aug 2024 06:06:12 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.135])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5EF2D40083DF;
	Wed, 28 Aug 2024 06:06:10 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y cip v2 0/9] Backport ravb driver performance improvements
Date: Tue, 27 Aug 2024 22:06:00 +0100
Message-Id: <20240827210609.12695-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Aug 2024 21:06:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16819

This series includes the performance improvements present in Linux
v6.11-rc1 along with dependencies.

The patch commit messages have not been changed as part of this
backport, so they refer to performance achieved during testing with the
upstream kernel.

The performance improvement achieved by applying this backport series
on top of v6.1.101-cip25 is as follows, measured using iperf3:

  RZ/G2L:
    * Similar TX/RX bandwidth
    * 50% less CPU usage during TCP RX test
    * 21% less CPU usage during UDP RX test
  
  RZ/G2UL:
    * 6% increase in TCP TX bandwidth
    * 34% increase in TCP RX bandwidth
    * 500% increase in UDP RX bandwidth
    * 24% loss in UDP TX bandwidth
  
  RZ/G3S:
    * 38% increase in TCP TX bandwidth
    * 48% increase in TCP RX bandwidth
    * 481% increase in UDP RX bandwidth
    * 17% loss in UDP TX bandwidth
  
  RZ/Five:
    * 19% increase in TCP TX bandwidth
    * 225% increase in TCP RX bandwidth
    * >10,000% increase in UDP RX bandwidth
        (UDP RX bandwidth was <100kbps and unstable with v6.1.101-cip25
         so it's difficult to get an exact figure here)
    * 6% loss in UDP TX bandwidth

Small losses in UDP TX bandwidth are considered acceptable to achieve
the above improvements in other test cases. If UDP TX bandwidth must be
maximised for a particular use case, NAPI threaded mode can be disabled
at runtime via sysfs writes.

Changes v1->v2:
  * Added Geert's patch to ensure that PAGE_PAGE is enabled.
  * Added Pavel's Reviewed-by tag to patches 1-8.
  * Removed unnecessary whitespace in commit messages.

Geert Uytterhoeven (1):
  ravb: RAVB should select PAGE_POOL

Heiner Kallweit (1):
  net: add netdev_sw_irq_coalesce_default_on()

Paul Barker (7):
  net: ravb: Simplify poll & receive functions
  net: ravb: Align poll function with NAPI docs
  net: ravb: Refactor RX ring refill
  net: ravb: Refactor GbEth RX code path
  net: ravb: Enable SW IRQ Coalescing for GbEth
  net: ravb: Use NAPI threaded mode on 1-core CPUs with GbEth IP
  net: ravb: Allocate RX buffers via page pool

 drivers/net/ethernet/renesas/Kconfig     |   1 +
 drivers/net/ethernet/renesas/ravb.h      |  14 +-
 drivers/net/ethernet/renesas/ravb_main.c | 488 +++++++++++++----------
 include/linux/netdevice.h                |   1 +
 net/core/dev.c                           |  16 +
 5 files changed, 299 insertions(+), 221 deletions(-)

-- 
2.43.0


