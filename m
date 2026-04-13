Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DE5F34C77
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 17:17:53 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.277700.1776100659634165962
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Apr 2026 10:17:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: chris.brandt@renesas.com)
X-CSE-ConnectionGUID: IukyCaaEScCA/SBuOt0LMQ==
X-CSE-MsgGUID: PeHQv6PiThmliJbcas/OJw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Apr 2026 02:17:44 +0900
Received: from lenovo-p330 (unknown [132.158.152.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C9F2B4036C46;
	Tue, 14 Apr 2026 02:17:43 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH 6.12.y-cip 7/7] clk: renesas: Add missing log message terminators
Date: Mon, 13 Apr 2026 13:17:33 -0400
Message-ID: <20260413171733.3088070-7-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171733.3088070-1-chris.brandt@renesas.com>
References: <20260413171733.3088070-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Apr 2026 17:17:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22688

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
 drivers/clk/renesas/rzv2h-cpg.c        | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/renesas/clk-vbattb.c b/drivers/clk/renesas/clk-vbattb.c
index ff9d1ead455c..2a961775b1d8 100644
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
index 92f76b937e83..e4d42e24485d 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -412,7 +412,7 @@ struct clk *cpg_mssr_clk_src_twocell_get(struct of_phandle_args *clkspec,
 	}

 	if (IS_ERR(clk))
-		dev_err(dev, "Cannot get %s clock %u: %ld", type, clkidx,
+		dev_err(dev, "Cannot get %s clock %u: %ld\n", type, clkidx,
 		       PTR_ERR(clk));
 	else
 		dev_dbg(dev, "clock (%u, %u) is %pC at %lu Hz\n",
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index d7be966bf394..7d9d41f4f439 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -980,7 +980,7 @@ static int rzg2l_cpg_sipll5_set_rate(struct clk_hw *hw,
 	ret = readl_poll_timeout(priv->base + CPG_SIPLL5_MON, val,
 				 !(val & CPG_SIPLL5_MON_PLL5_LOCK), 100, 250000);
 	if (ret) {
-		dev_err(priv->dev, "failed to release pll5 lock");
+		dev_err(priv->dev, "failed to release pll5 lock\n");
 		return ret;
 	}

@@ -1007,7 +1007,7 @@ static int rzg2l_cpg_sipll5_set_rate(struct clk_hw *hw,
 	ret = readl_poll_timeout(priv->base + CPG_SIPLL5_MON, val,
 				 (val & CPG_SIPLL5_MON_PLL5_LOCK), 100, 250000);
 	if (ret) {
-		dev_err(priv->dev, "failed to lock pll5");
+		dev_err(priv->dev, "failed to lock pll5\n");
 		return ret;
 	}

@@ -1215,7 +1215,7 @@ static struct clk
 	}

 	if (IS_ERR(clk))
-		dev_err(dev, "Cannot get %s clock %u: %ld", type, clkidx,
+		dev_err(dev, "Cannot get %s clock %u: %ld\n", type, clkidx,
 			PTR_ERR(clk));
 	else
 		dev_dbg(dev, "clock (%u, %u) is %pC at %lu Hz\n",
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 2f54458778b8..170dbe452c34 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -602,7 +602,7 @@ static int rzv2h_cpg_pll_set_rate(struct pll_clk *pll_clk,
 					val, !(val & CPG_PLL_MON_LOCK),
 					100, 2000);
 	if (ret) {
-		dev_err(priv->dev, "Failed to put PLLDSI into standby mode");
+		dev_err(priv->dev, "Failed to put PLLDSI into standby mode\n");
 		return ret;
 	}

@@ -630,7 +630,7 @@ static int rzv2h_cpg_pll_set_rate(struct pll_clk *pll_clk,
 					val, (val & CPG_PLL_MON_LOCK),
 					100, 2000);
 	if (ret) {
-		dev_err(priv->dev, "Failed to put PLLDSI into normal mode");
+		dev_err(priv->dev, "Failed to put PLLDSI into normal mode\n");
 		return ret;
 	}

@@ -1023,7 +1023,7 @@ static struct clk
 	}

 	if (IS_ERR(clk))
-		dev_err(dev, "Cannot get %s clock %u: %ld", type, clkidx,
+		dev_err(dev, "Cannot get %s clock %u: %ld\n", type, clkidx,
 			PTR_ERR(clk));
 	else
 		dev_dbg(dev, "clock (%u, %u) is %pC at %lu Hz\n",
--
2.52.0


