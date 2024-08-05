Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790CBC52D71
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 16:43:58 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.12744.1722876227989460929
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 09:43:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,265,1716217200"; 
   d="scan'208";a="218711286"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Aug 2024 01:43:51 +0900
Received: from localhost.localdomain (unknown [10.226.92.197])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BF9F64020F32;
	Tue,  6 Aug 2024 01:43:49 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 03/30] media: i2c: ov5645: Drop empty comment
Date: Mon,  5 Aug 2024 17:42:56 +0100
Message-ID: <20240805164342.211857-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 16:43:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16725

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9a018670dfa06b44efac08793b82a167d8a167ff upstream.

Drop empty multiline comment.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 2e6135d0a31a..6897f542737a 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -14,9 +14,6 @@
  *   https://www.mail-archive.com/linux-media%40vger.kernel.org/msg92671.html
  */
 
-/*
- */
-
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.43.0


