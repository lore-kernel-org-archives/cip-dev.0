Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6413C3DA7E
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:00:58 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.58079.1722265254667312243
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:00:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="217876769"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Jul 2024 00:00:52 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0222C4018253;
	Tue, 30 Jul 2024 00:00:50 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y cip 0/8] Backport ravb driver performance improvements
Date: Mon, 29 Jul 2024 15:00:41 +0000
Message-Id: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:00:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16645

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

 drivers/net/ethernet/renesas/ravb.h      |  14 +-
 drivers/net/ethernet/renesas/ravb_main.c | 488 +++++++++++++----------
 include/linux/netdevice.h                |   1 +
 net/core/dev.c                           |  16 +
 4 files changed, 298 insertions(+), 221 deletions(-)

-- 
2.25.1


