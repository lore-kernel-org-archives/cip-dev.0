Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30D9E67482
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:20 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78202.1766402238500801743
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JJWMFmjc;
 spf=pass (domain: gmail.com, ip: 209.85.218.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b736ffc531fso679687566b.1
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402237; x=1767007037; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1rZGLNM5MiWRd1yNF+Il4T4Qmt7KAMZY9nOdHuSsvU=;
        b=JJWMFmjcmuY7fX9jDpGji8qU3UeKuFAwHdj9BqZMwr+HWXDUB4Bgh1nWDive9igAWp
         KqBgUjrbOARdsouGru0MqciGEObeDiuY7koZTQ0wUuv60jkGJK/M+T14V5Mf1xCh19TL
         yX5V4wpO9duG0ZyBP0WrDCQNXZhuhtjczUbjIebMZ6X0gvUcZP87B1yLVafHfkX06r0X
         D23lhQKHtdsVMrq09gCkwiww4CxrJfgj8yD9YIlFFsQMrC3kDJldyPlGEYyA4MDnTdEu
         fxA+NquTUI5UI1R+kXqFwHFn2R+VfKJLqQcCQFrQYZDuwo1VqUp2LpiblGA6rRiV/GId
         iYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402237; x=1767007037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q1rZGLNM5MiWRd1yNF+Il4T4Qmt7KAMZY9nOdHuSsvU=;
        b=qd/ARjViLADFf02YLk8V+rJZngrB4dSyQy1LAblQWdmAUMXQ7MfvYB9vTc/n5mB2CF
         AQgsCo8ZjxtE7lsCV+CR9OSxCiG+PTGmKIf/8P/KMvmHFlyxBuNy52wc65ogcmIr7iMc
         w+nAe4UVk/ZPrlh2ZIrqMROchzj1ammOH+hbWPzQdRN8gF2vouBK1/oys1zlWO8tYHbk
         Qj93vyr8s2ktYOuHDwfzcZMGoAb2NLWw0uADE1D6yj71opG+Ruqt63r7sgEcoVKwnvn9
         +EMk34SvaV4pOJlCZAKuDtpPJdqngLoOEmgUScT+WdGwJhWvHqVVF0T2da5jbMgeSM6/
         2b1Q==
X-Gm-Message-State: AOJu0YyT5vYFoNTwP3lmvnSRiairklwv3uom6zTOjwvLjEv4i+27yLT6
	u41Q6lNks2NjUTvt3lm2Iga7co521NXs5aaRn2o19U6E2umH8Gr0H5TwAmB9sA==
X-Gm-Gg: AY/fxX7fbaCUKy2ELN+/rAJE4AAd7LTQdijHF4/1EszfuFmkpOi1QR1zhBPGWvyEKDw
	dsNlC1ukM00kK+6fvzpg+BQ/xm68cL/rY2smRjHykgIHRPXM8I4JMsuN7oLB4aSQBPUyaDda/Nf
	i33QhWcqE4VWnZTz99TJUfND8Tq1DcqKroAXJsvDr96LPJYFLlqJ+ZP/xVR1kNQTeJVSzU/fl2T
	FXj2pY2jRA9+++GEeoBd8xBPvtBV/PXA7FZLOlMYmx/mUFmdlT9z9gBkgg4fsdGHNuM2/4UbAvF
	1uZojtCjIBW21M1BNg55y6rb4AE/4dMYE5IYdidfUlxA6k5zWFYz7/0N+tJg7MqOyzZGhlMOdrx
	MLRMpbZ3cG6g5Tm8NUeToo51hCCuLQDoi+8CzkdBWJhXp76OtxnL46iFbYtNRBXi4sWrN0EtD28
	L8yuzdGqu1vFdfwJEoNozzaNqo+PoFDZo9ZT8=
X-Google-Smtp-Source: AGHT+IEFbqd4Yq1lTrYIoW1uaIVILJXIxzx5vMQJRyRO0qqu44OGYYZn2BGYjob5NMlMF9U/LnwOog==
X-Received: by 2002:a17:907:9444:b0:b7a:58ab:3de1 with SMTP id a640c23a62f3a-b8036f13014mr1214804366b.20.1766402236484;
        Mon, 22 Dec 2025 03:17:16 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:16 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 20/24] can: rcar_canfd: Extract rcar_canfd_global_{,de}init()
Date: Mon, 22 Dec 2025 11:16:52 +0000
Message-ID: <20251222111705.27028-21-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21206

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit fa5f4ec8fff8bc587a2cbf7101303306e045c11f ]

Extract the code to (de)initialize global state into separate functions,
for future reuse.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251124102837.106973-5-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 182 +++++++++++++++++-------------
 1 file changed, 104 insertions(+), 78 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 6db17bcb6f73..06806bd7e7ea 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1962,21 +1962,120 @@ static void rcar_canfd_channel_remove(struct rcar_canfd_global *gpriv, u32 ch)
 	}
 }
 
+static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
+{
+	struct device *dev = &gpriv->pdev->dev;
+	u32 rule_entry = 0;
+	u32 ch, sts;
+	int err;
+
+	err = reset_control_reset(gpriv->rstc1);
+	if (err)
+		return err;
+
+	err = reset_control_reset(gpriv->rstc2);
+	if (err)
+		goto fail_reset1;
+
+	/* Enable peripheral clock for register access */
+	err = clk_prepare_enable(gpriv->clkp);
+	if (err) {
+		dev_err(dev, "failed to enable peripheral clock: %pe\n",
+			ERR_PTR(err));
+		goto fail_reset2;
+	}
+
+	/* Enable RAM clock */
+	err = clk_prepare_enable(gpriv->clk_ram);
+	if (err) {
+		dev_err(dev,
+			"failed to enable RAM clock, error %d\n", err);
+		goto fail_clk;
+	}
+
+	err = rcar_canfd_reset_controller(gpriv);
+	if (err) {
+		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
+		goto fail_ram_clk;
+	}
+
+	/* Controller in Global reset & Channel reset mode */
+	rcar_canfd_configure_controller(gpriv);
+
+	/* Configure per channel attributes */
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+		/* Configure Channel's Rx fifo */
+		rcar_canfd_configure_rx(gpriv, ch);
+
+		/* Configure Channel's Tx (Common) fifo */
+		rcar_canfd_configure_tx(gpriv, ch);
+
+		/* Configure receive rules */
+		rcar_canfd_configure_afl_rules(gpriv, ch, rule_entry);
+		rule_entry += RCANFD_CHANNEL_NUMRULES;
+	}
+
+	/* Configure common interrupts */
+	rcar_canfd_enable_global_interrupts(gpriv);
+
+	/* Start Global operation mode */
+	rcar_canfd_update_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GMDC_MASK,
+			      RCANFD_GCTR_GMDC_GOPM);
+
+	/* Verify mode change */
+	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
+				 !(sts & RCANFD_GSTS_GNOPM), 2, 500000);
+	if (err) {
+		dev_err(dev, "global operational mode failed\n");
+		goto fail_mode;
+	}
+
+	return 0;
+
+fail_mode:
+	rcar_canfd_disable_global_interrupts(gpriv);
+fail_ram_clk:
+	clk_disable_unprepare(gpriv->clk_ram);
+fail_clk:
+	clk_disable_unprepare(gpriv->clkp);
+fail_reset2:
+	reset_control_assert(gpriv->rstc2);
+fail_reset1:
+	reset_control_assert(gpriv->rstc1);
+	return err;
+}
+
+static void rcar_canfd_global_deinit(struct rcar_canfd_global *gpriv, bool full)
+{
+	rcar_canfd_disable_global_interrupts(gpriv);
+
+	if (full) {
+		rcar_canfd_reset_controller(gpriv);
+
+		/* Enter global sleep mode */
+		rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
+	}
+
+	clk_disable_unprepare(gpriv->clk_ram);
+	clk_disable_unprepare(gpriv->clkp);
+	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
+}
+
 static int rcar_canfd_probe(struct platform_device *pdev)
 {
 	struct phy *transceivers[RCANFD_NUM_CHANNELS] = { NULL, };
 	const struct rcar_canfd_hw_info *info;
 	struct device *dev = &pdev->dev;
 	void __iomem *addr;
-	u32 sts, ch, fcan_freq;
 	struct rcar_canfd_global *gpriv;
 	struct device_node *of_child;
 	unsigned long channels_mask = 0;
 	int err, ch_irq, g_irq;
 	int g_err_irq, g_recc_irq;
-	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
+	u32 ch, fcan_freq;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2118,67 +2217,9 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = reset_control_reset(gpriv->rstc1);
+	err = rcar_canfd_global_init(gpriv);
 	if (err)
-		goto fail_dev;
-	err = reset_control_reset(gpriv->rstc2);
-	if (err) {
-		reset_control_assert(gpriv->rstc1);
-		goto fail_dev;
-	}
-
-	/* Enable peripheral clock for register access */
-	err = clk_prepare_enable(gpriv->clkp);
-	if (err) {
-		dev_err(dev, "failed to enable peripheral clock: %pe\n",
-			ERR_PTR(err));
-		goto fail_reset;
-	}
-
-	/* Enable RAM clock  */
-	err = clk_prepare_enable(gpriv->clk_ram);
-	if (err) {
-		dev_err(dev, "failed to enable RAM clock: %pe\n",
-			ERR_PTR(err));
-		goto fail_clk;
-	}
-
-	err = rcar_canfd_reset_controller(gpriv);
-	if (err) {
-		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
-		goto fail_ram_clk;
-	}
-
-	/* Controller in Global reset & Channel reset mode */
-	rcar_canfd_configure_controller(gpriv);
-
-	/* Configure per channel attributes */
-	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
-		/* Configure Channel's Rx fifo */
-		rcar_canfd_configure_rx(gpriv, ch);
-
-		/* Configure Channel's Tx (Common) fifo */
-		rcar_canfd_configure_tx(gpriv, ch);
-
-		/* Configure receive rules */
-		rcar_canfd_configure_afl_rules(gpriv, ch, rule_entry);
-		rule_entry += RCANFD_CHANNEL_NUMRULES;
-	}
-
-	/* Configure common interrupts */
-	rcar_canfd_enable_global_interrupts(gpriv);
-
-	/* Start Global operation mode */
-	rcar_canfd_update_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GMDC_MASK,
-			      RCANFD_GCTR_GMDC_GOPM);
-
-	/* Verify mode change */
-	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
-				 !(sts & RCANFD_GSTS_GNOPM), 2, 500000);
-	if (err) {
-		dev_err(dev, "global operational mode failed\n");
 		goto fail_mode;
-	}
 
 	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
 		err = rcar_canfd_channel_probe(gpriv, ch, fcan_freq,
@@ -2197,14 +2238,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
-	rcar_canfd_disable_global_interrupts(gpriv);
-fail_ram_clk:
-	clk_disable_unprepare(gpriv->clk_ram);
-fail_clk:
-	clk_disable_unprepare(gpriv->clkp);
-fail_reset:
-	reset_control_assert(gpriv->rstc2);
-	reset_control_assert(gpriv->rstc1);
+	rcar_canfd_global_deinit(gpriv, false);
 fail_dev:
 	return err;
 }
@@ -2219,15 +2253,7 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 		rcar_canfd_channel_remove(gpriv, ch);
 	}
 
-	rcar_canfd_disable_global_interrupts(gpriv);
-	rcar_canfd_reset_controller(gpriv);
-
-	/* Enter global sleep mode */
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
-	clk_disable_unprepare(gpriv->clk_ram);
-	clk_disable_unprepare(gpriv->clkp);
-	reset_control_assert(gpriv->rstc2);
-	reset_control_assert(gpriv->rstc1);
+	rcar_canfd_global_deinit(gpriv, true);
 }
 
 static int __maybe_unused rcar_canfd_suspend(struct device *dev)
-- 
2.43.0


