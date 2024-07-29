Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E67C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 14:30:18 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.57344.1722263417198856931
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 07:30:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="217875282"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Jul 2024 23:30:15 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9E6F6400EF68;
	Mon, 29 Jul 2024 23:30:13 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y cip 00/11] Backport ravb driver improvements
Date: Mon, 29 Jul 2024 14:30:00 +0000
Message-Id: <20240729143011.1920068-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 14:30:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16633

This series includes all relevant fixes, tidy-ups and other improvements
to the ravb driver present in Linux v6.10. This keeps the CIP 5.10
series aligned with the backports made for CIP 6.1.

Niklas Söderlund (7):
  ravb: Group descriptor types used in Rx ring
  ravb: Make it clear the information relates to maximum frame size
  ravb: Create helper to allocate skb and align it
  ravb: Use the max frame size from hardware info for RZ/G2L
  ravb: Move maximum Rx descriptor data usage to info struct
  ravb: Unify Rx ring maintenance code paths
  ravb: Correct buffer size to map for R-Car Rx

Paul Barker (4):
  net: ravb: Always process TX descriptor ring
  net: ravb: Always update error counters
  net: ravb: Count packets instead of descriptors in R-Car RX path
  net: ravb: Allow RX loop to move past DMA mapping errors

 drivers/net/ethernet/renesas/ravb.h      |  20 +-
 drivers/net/ethernet/renesas/ravb_main.c | 272 +++++++++--------------
 2 files changed, 114 insertions(+), 178 deletions(-)

-- 
2.25.1


