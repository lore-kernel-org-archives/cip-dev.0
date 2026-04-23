Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5862F589A9
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 12:06:54 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17814.1776945994972266832
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Apr 2026 05:06:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: chris.brandt@renesas.com)
X-CSE-ConnectionGUID: PTefnh2aT4CIhqhGkFFNFA==
X-CSE-MsgGUID: JHJbLbO2SQqPnH1vbWfzLg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Apr 2026 21:06:46 +0900
Received: from lenovo-p330 (unknown [132.158.152.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D5192419B460;
	Thu, 23 Apr 2026 21:06:45 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH 5.10.y-cip v2 10/10] clk: renesas: Add missing log message terminators
Date: Thu, 23 Apr 2026 08:06:30 -0400
Message-ID: <20260423120630.1487798-11-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423120630.1487798-1-chris.brandt@renesas.com>
References: <20260423120630.1487798-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Apr 2026 12:06:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22803

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 4fef3fd633be4a1a18c490a63f4131284f6ee0f4 upstream.

Complete printed messages should be terminated by newline characters.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Link: https://patch.msgid.link/cd0b3624066b80ed0bb00d489c99e2c1a06d755f.1768480559.git.geert+renesas@glider.be
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/clk/renesas/clk-vbattb.c       | 4 ++--
 drivers/clk/renesas/renesas-cpg-mssr.c | 2 +-
 drivers/clk/renesas/rzg2l-cpg.c        | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/clk-vbattb.c b/drivers/clk/renesas/clk-vbattb.c
index a5f9b736ef2c..afedc099405e 100644
--- a/drivers/clk/renesas/clk-vbattb.c
+++ b/drivers/clk/renesas/clk-vbattb.c
@@ -69,11 +69,11 @@ static void vbattb_clk_action(void *data)
 
 	ret = reset_control_assert(rstc);
 	if (ret)
-		dev_err(dev, "Failed to de-assert reset!");
+		dev_err(dev, "Failed to de-assert reset!\n");
 
 	ret = pm_runtime_put_sync(dev);
 	if (ret < 0)
-		dev_err(dev, "Failed to runtime suspend!");
+		dev_err(dev, "Failed to runtime suspend!\n");
 
 	of_clk_del_provider(dev->of_node);
 }
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index e373ae4360a2..17b7e29a900c 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -314,7 +314,7 @@ struct clk *cpg_mssr_clk_src_twocell_get(struct of_phandle_args *clkspec,
 	}
 
 	if (IS_ERR(clk))
-		dev_err(dev, "Cannot get %s clock %u: %ld", type, clkidx,
+		dev_err(dev, "Cannot get %s clock %u: %ld\n", type, clkidx,
 		       PTR_ERR(clk));
 	else
 		dev_dbg(dev, "clock (%u, %u) is %pC at %lu Hz\n",
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 70ddfc917a17..8cb0403b43c3 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -984,7 +984,7 @@ static int rzg2l_cpg_sipll5_set_rate(struct clk_hw *hw,
 	ret = readl_poll_timeout(priv->base + CPG_SIPLL5_MON, val,
 				 !(val & CPG_SIPLL5_MON_PLL5_LOCK), 100, 250000);
 	if (ret) {
-		dev_err(priv->dev, "failed to release pll5 lock");
+		dev_err(priv->dev, "failed to release pll5 lock\n");
 		return ret;
 	}
 
@@ -1011,7 +1011,7 @@ static int rzg2l_cpg_sipll5_set_rate(struct clk_hw *hw,
 	ret = readl_poll_timeout(priv->base + CPG_SIPLL5_MON, val,
 				 (val & CPG_SIPLL5_MON_PLL5_LOCK), 100, 250000);
 	if (ret) {
-		dev_err(priv->dev, "failed to lock pll5");
+		dev_err(priv->dev, "failed to lock pll5\n");
 		return ret;
 	}
 
@@ -1217,7 +1217,7 @@ static struct clk
 	}
 
 	if (IS_ERR(clk))
-		dev_err(dev, "Cannot get %s clock %u: %ld", type, clkidx,
+		dev_err(dev, "Cannot get %s clock %u: %ld\n", type, clkidx,
 			PTR_ERR(clk));
 	else
 		dev_dbg(dev, "clock (%u, %u) is %pC at %lu Hz\n",
-- 
2.52.0


