Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4008EB64D7
	for <webhook@archiver.kernel.org>; Fri, 30 Jun 2023 15:51:28 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.16097.1688140286836415918
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Jun 2023 08:51:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,171,1684767600"; 
   d="scan'208";a="166244097"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Jul 2023 00:51:25 +0900
Received: from localhost.localdomain (unknown [10.226.93.15])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 44556400CE6D;
	Sat,  1 Jul 2023 00:51:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 2/3] i2c: rzv2m: Replace lowercase macros with static inline functions
Date: Fri, 30 Jun 2023 16:51:17 +0100
Message-Id: <20230630155118.584293-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630155118.584293-1-biju.das.jz@bp.renesas.com>
References: <20230630155118.584293-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Jun 2023 15:51:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12165

commit 252f211bd0328c6a3d7d30eaf4d59a8363f3d578 upstream.

Convert macros bit_setl and bit_clrl with static inline functions
as normally we'd put macro names in all uppercase.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/i2c/busses/i2c-rzv2m.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rzv2m.c b/drivers/i2c/busses/i2c-rzv2m.c
index 2d0d005b00fa..9481cac85e2e 100644
--- a/drivers/i2c/busses/i2c-rzv2m.c
+++ b/drivers/i2c/busses/i2c-rzv2m.c
@@ -50,9 +50,6 @@
 #define IICB0MDSC	BIT(7)		/* Bus Mode */
 #define IICB0SLSE	BIT(1)		/* Start condition output */
 
-#define bit_setl(addr, val)		writel(readl(addr) | (val), (addr))
-#define bit_clrl(addr, val)		writel(readl(addr) & ~(val), (addr))
-
 struct rzv2m_i2c_priv {
 	void __iomem *base;
 	struct i2c_adapter adap;
@@ -78,6 +75,16 @@ static const struct bitrate_config bitrate_configs[] = {
 	[RZV2M_I2C_400K] = { 52, 900 },
 };
 
+static inline void bit_setl(void __iomem *addr, u32 val)
+{
+	writel(readl(addr) | val, addr);
+}
+
+static inline void bit_clrl(void __iomem *addr, u32 val)
+{
+	writel(readl(addr) & ~val, addr);
+}
+
 static irqreturn_t rzv2m_i2c_tia_irq_handler(int this_irq, void *dev_id)
 {
 	struct rzv2m_i2c_priv *priv = dev_id;
-- 
2.25.1


