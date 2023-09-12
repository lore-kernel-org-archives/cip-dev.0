Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA69EE3F1C
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 19:59:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.454.1694548776019451894
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 12:59:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,141,1688396400"; 
   d="scan'208";a="175845700"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Sep 2023 04:59:35 +0900
Received: from localhost.localdomain (unknown [10.226.93.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 641D040A488A;
	Wed, 13 Sep 2023 04:59:33 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 07/15] mfd: rz-mtu3: Replace raw_spin_lock->spin_lock()
Date: Tue, 12 Sep 2023 20:59:07 +0100
Message-Id: <20230912195915.607664-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
References: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 19:59:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13081

commit d92df6fb812c5c126d1a3a06034bb2f2bb0e585f upstream.

As per kernel documentation, use raw_spinlock_t only in real critical core
code, low-level interrupt handling, and places where disabling preemption
or interrupts is required. Here the lock is for concurrent register access
from different drivers, hence spin_lock() is sufficient.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZIL%2FitcJvV5s3Bnf@duo.ucw.cz/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Link: https://lore.kernel.org/r/20230815073445.9579-3-biju.das.jz@bp.renesas.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mfd/rz-mtu3.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/rz-mtu3.c b/drivers/mfd/rz-mtu3.c
index 08d99bf4b0d2..c611bedde3f7 100644
--- a/drivers/mfd/rz-mtu3.c
+++ b/drivers/mfd/rz-mtu3.c
@@ -20,7 +20,7 @@
 struct rz_mtu3_priv {
 	void __iomem *mmio;
 	struct reset_control *rstc;
-	raw_spinlock_t lock;
+	spinlock_t lock;
 };
 
 /******* MTU3 registers (original offset is +0x1200) *******/
@@ -174,11 +174,11 @@ void rz_mtu3_shared_reg_update_bit(struct rz_mtu3_channel *ch, u16 offset,
 	struct rz_mtu3_priv *priv = mtu->priv_data;
 	unsigned long tmdr, flags;
 
-	raw_spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->lock, flags);
 	tmdr = rz_mtu3_shared_reg_read(ch, offset);
 	__assign_bit(pos, &tmdr, !!val);
 	rz_mtu3_shared_reg_write(ch, offset, tmdr);
-	raw_spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 EXPORT_SYMBOL_GPL(rz_mtu3_shared_reg_update_bit);
 
@@ -254,13 +254,13 @@ static void rz_mtu3_start_stop_ch(struct rz_mtu3_channel *ch, bool start)
 	bitpos = rz_mtu3_get_tstr_bit_pos(ch);
 
 	/* start stop register shared by multiple timer channels */
-	raw_spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->lock, flags);
 
 	tstr = rz_mtu3_shared_reg_read(ch, offset);
 	__assign_bit(bitpos, &tstr, start);
 	rz_mtu3_shared_reg_write(ch, offset, tstr);
 
-	raw_spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 bool rz_mtu3_is_enabled(struct rz_mtu3_channel *ch)
@@ -275,9 +275,9 @@ bool rz_mtu3_is_enabled(struct rz_mtu3_channel *ch)
 	bitpos = rz_mtu3_get_tstr_bit_pos(ch);
 
 	/* start stop register shared by multiple timer channels */
-	raw_spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->lock, flags);
 	tstr = rz_mtu3_shared_reg_read(ch, offset);
-	raw_spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return tstr & BIT(bitpos);
 }
@@ -347,7 +347,7 @@ static int rz_mtu3_probe(struct platform_device *pdev)
 		return PTR_ERR(ddata->clk);
 
 	reset_control_deassert(priv->rstc);
-	raw_spin_lock_init(&priv->lock);
+	spin_lock_init(&priv->lock);
 	platform_set_drvdata(pdev, ddata);
 
 	for (i = 0; i < RZ_MTU_NUM_CHANNELS; i++) {
-- 
2.25.1


