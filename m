Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE82CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:47:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.15471.1755679617497403191
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:46:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: LobOvluLRMy4/Nb8ef6sUg==
X-CSE-MsgGUID: t4K0gs9BSMOYYCfQUzykvg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Aug 2025 17:46:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4D228400B524;
	Wed, 20 Aug 2025 17:46:55 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/23] clk: renesas: Use str_on_off() helper
Date: Wed, 20 Aug 2025 09:45:47 +0100
Message-ID: <20250820084645.6988-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:47:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19796

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit aff664cc8cbc5c28e5aa57dc4201c34497f3c871 upstream.

Use the str_on_off() helper instead of open-coding the same operation.
Note that this does change the case of the flags, which doesn't matter
much for debug messages.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/622f8554dcb815c8fc73511a1a118c1724570fa9.1745840497.git.geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 3 ++-
 drivers/clk/renesas/rzg2l-cpg.c        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 0f27c33192e10..4e7eabfaec478 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -27,6 +27,7 @@
 #include <linux/psci.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 
 #include <dt-bindings/clock/renesas-cpg-mssr.h>
 
@@ -205,7 +206,7 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 	int error;
 
 	dev_dbg(dev, "MSTP %u%02u/%pC %s\n", reg, bit, hw->clk,
-		enable ? "ON" : "OFF");
+		str_on_off(enable));
 	spin_lock_irqsave(&priv->rmw_lock, flags);
 
 	if (priv->reg_layout == CLK_REG_LAYOUT_RZ_A) {
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 97d42328fa81a..804a4b55bd7c5 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -27,6 +27,7 @@
 #include <linux/pm_domain.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/units.h>
 
 #include <dt-bindings/clock/renesas-cpg-mssr.h>
@@ -1222,7 +1223,7 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	}
 
 	dev_dbg(dev, "CLK_ON 0x%x/%pC %s\n", CLK_ON_R(reg), hw->clk,
-		enable ? "ON" : "OFF");
+		str_on_off(enable));
 
 	value = bitmask << 16;
 	if (enable)
-- 
2.43.0


