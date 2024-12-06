Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD428E7717B
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:11:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.33197.1733476301806921318
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:11:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: b1lRTT/AQBSdp2QfaAtiHg==
X-CSE-MsgGUID: upAe2EofQDuzdTjnUojluA==
X-IronPort-AV: E=Sophos;i="6.12,213,1728918000"; 
   d="scan'208";a="231085690"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Dec 2024 18:11:42 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id ABC1441F5140;
	Fri,  6 Dec 2024 18:11:31 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 04/16] mtd: spi-nor: fix select_uniform_erase to skip 0 erase size
Date: Fri,  6 Dec 2024 09:11:10 +0000
Message-ID: <20241206091122.67133-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17351

From: Michael Walle <michael@walle.cc>

commit 39eece67a3cf027aa5b39d7da5feadc4711504e6 upstream.

4bait will set the erase size to 0 if there is no corresponding
opcode for the 4byte erase. Fix spi_nor_select_uniform_erase to skip
the 0 erase size to avoid mtd device registration failure cases.

Reported-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/20220810220654.1297699-6-michael@walle.cc
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mtd/spi-nor/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 75c1ef19352b..4dba8dc989b5 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2132,6 +2132,10 @@ spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
 
 		tested_erase = &map->erase_type[i];
 
+		/* Skip masked erase types. */
+		if (!tested_erase->size)
+			continue;
+
 		/*
 		 * If the current erase size is the one, stop here:
 		 * we have found the right uniform Sector Erase command.
-- 
2.43.0


