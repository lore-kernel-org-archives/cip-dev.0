Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075D5C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 12:39:11 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.7762.1686055141851081249
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 05:39:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,221,1681138800"; 
   d="scan'208";a="165950423"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Jun 2023 21:39:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5DA5341E7A3F;
	Tue,  6 Jun 2023 21:38:58 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip] counter: rz-mtu3-cnt: Unlock on error in rz_mtu3_count_ceiling_write()
Date: Tue,  6 Jun 2023 13:38:56 +0100
Message-Id: <20230606123856.371722-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 12:39:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11879

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 1e28dfdf40d7293882ba7eb70a3bc0e9ab625377 upstream.

These error paths need to call mutex_unlock(&priv->lock) before
returning.  The lock is taken in rz_mtu3_lock_if_counter_is_valid().

Fixes: 25d21447d896 ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/7b535d6b-6031-493a-84f6-82842089e637@kili.mountain
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
This patch depend upon [1]
[1] https://lore.kernel.org/cip-dev/OS0PR01MB592226547765F3A740314D2D8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com/T/#t
---
 drivers/counter/rz-mtu3-cnt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index a371bab68499..48c83933aa2f 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -358,13 +358,17 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
 	switch (count->id) {
 	case RZ_MTU3_16_BIT_MTU1_CH:
 	case RZ_MTU3_16_BIT_MTU2_CH:
-		if (ceiling > U16_MAX)
+		if (ceiling > U16_MAX) {
+			mutex_unlock(&priv->lock);
 			return -ERANGE;
+		}
 		priv->mtu_16bit_max[ch_id] = ceiling;
 		break;
 	case RZ_MTU3_32_BIT_CH:
-		if (ceiling > U32_MAX)
+		if (ceiling > U32_MAX) {
+			mutex_unlock(&priv->lock);
 			return -ERANGE;
+		}
 		priv->mtu_32bit_max = ceiling;
 		break;
 	default:
-- 
2.25.1


