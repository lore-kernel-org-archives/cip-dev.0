Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3D5EE3F1D
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 19:59:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.450.1694548765259810954
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 12:59:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,141,1688396400"; 
   d="scan'208";a="179568799"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Sep 2023 04:59:32 +0900
Received: from localhost.localdomain (unknown [10.226.93.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 29F9640A489B;
	Wed, 13 Sep 2023 04:59:30 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 06/15] mfd: rz-mtu3: Reduce critical sections
Date: Tue, 12 Sep 2023 20:59:06 +0100
Message-Id: <20230912195915.607664-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
References: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 19:59:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13080

commit a160d1286b5907603a5d4329f6047709bc423480 upstream.

Reduce critical sections on rz_mtu3_start_stop_ch() and
rz_mtu3_is_enabled() by moving offset and bitpos computation
outside the critical section and drop the 'ret' variable on
rz_mtu3_is_enabled() and return 'tstr & BIT(bitpos)' directly.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZIMAse1ikTuycJ02@duo.ucw.cz/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Link: https://lore.kernel.org/r/20230815073445.9579-2-biju.das.jz@bp.renesas.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mfd/rz-mtu3.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/rz-mtu3.c b/drivers/mfd/rz-mtu3.c
index 04006f4aa702..08d99bf4b0d2 100644
--- a/drivers/mfd/rz-mtu3.c
+++ b/drivers/mfd/rz-mtu3.c
@@ -250,11 +250,12 @@ static void rz_mtu3_start_stop_ch(struct rz_mtu3_channel *ch, bool start)
 	u16 offset;
 	u8 bitpos;
 
+	offset = rz_mtu3_get_tstr_offset(ch);
+	bitpos = rz_mtu3_get_tstr_bit_pos(ch);
+
 	/* start stop register shared by multiple timer channels */
 	raw_spin_lock_irqsave(&priv->lock, flags);
 
-	offset = rz_mtu3_get_tstr_offset(ch);
-	bitpos = rz_mtu3_get_tstr_bit_pos(ch);
 	tstr = rz_mtu3_shared_reg_read(ch, offset);
 	__assign_bit(bitpos, &tstr, start);
 	rz_mtu3_shared_reg_write(ch, offset, tstr);
@@ -267,21 +268,18 @@ bool rz_mtu3_is_enabled(struct rz_mtu3_channel *ch)
 	struct rz_mtu3 *mtu = dev_get_drvdata(ch->dev->parent);
 	struct rz_mtu3_priv *priv = mtu->priv_data;
 	unsigned long flags, tstr;
-	bool ret = false;
 	u16 offset;
 	u8 bitpos;
 
-	/* start stop register shared by multiple timer channels */
-	raw_spin_lock_irqsave(&priv->lock, flags);
-
 	offset = rz_mtu3_get_tstr_offset(ch);
 	bitpos = rz_mtu3_get_tstr_bit_pos(ch);
-	tstr = rz_mtu3_shared_reg_read(ch, offset);
-	ret = tstr & BIT(bitpos);
 
+	/* start stop register shared by multiple timer channels */
+	raw_spin_lock_irqsave(&priv->lock, flags);
+	tstr = rz_mtu3_shared_reg_read(ch, offset);
 	raw_spin_unlock_irqrestore(&priv->lock, flags);
 
-	return ret;
+	return tstr & BIT(bitpos);
 }
 EXPORT_SYMBOL_GPL(rz_mtu3_is_enabled);
 
-- 
2.25.1


