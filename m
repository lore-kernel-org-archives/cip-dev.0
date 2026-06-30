Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0806EC44509
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:57 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19425.1782820128892970710
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TK9h46Um;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47488efcf30so1036412f8f.3
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820127; x=1783424927; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMnGCZAg7Xehxqj/bO7jhvn87cWgFHWgOp+ODKym6rY=;
        b=TK9h46UmT8IKNOVCBcU8XK/ciqUofRxdR6UrbCwwgmKJkXBExWVVas+9CTqzwbP9zR
         n+5d7Ul6sQ+Go+nyIrmhiUsmiTVWV8gNnlyw+g0R6lHkpzWOEQhEwpd46gR1VWG1JjVn
         VELbXTveJ70lBtGhmtl5ByJvAE9mYN4c+fjp0iDnZHLdtXbcN0Ma22aZo/r4JP5r2AOG
         srqGyDWoJRYfP3Xw8MPqU9GOataBct9ppwWuF7b1Bg3t2mHT/rNqaZYE5rCv+TjVyN77
         7GEscP9Zz85hoZaPIbB0lfPmnqWiHSt+q8EK5Y0/xK0t/sg2AoGiOgMTO58hMnJOHZmx
         lBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820127; x=1783424927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iMnGCZAg7Xehxqj/bO7jhvn87cWgFHWgOp+ODKym6rY=;
        b=P/b4zgP9xpBuDdZMZsPOoHV4y6T7eTdnxD/dBmJ4r+XgEMv2VBgaDorRRo6Eh2q+aT
         228xlE+a2RubcQqkI5XGKKRSEaaCf1R6xA/fxh0JOOiqgp5OPAF20hRFoAVOFVVBqR0I
         RtqHx+Wjn10aWygRq0WWX0IFhArximwhbOg1dlRs4xAMnM+UJ5VtZsEyDnnDJKZqpY/5
         777EUbvFtxD7uZptODF5hKkcMA92ePSp3ml9RaBV90JJqKd1q48kaF53LWTfDAT5ibPB
         MrvKYVBipd+h/URf8pJ9VeanngK6TirMdCKB7EzlaZ5VFCtIZxidqnTyPPN5CUwtn2Bz
         /96g==
X-Gm-Message-State: AOJu0Yxm57uZKzAASXtti0PqfveAtsCbv94mFVnlEIALWoMMDoLtRixy
	tfiIorWEJfL+QsMiy+UECP6j+eifLTJIcKRgqGu8BcxrSSTsiW8Bby5Gx9wDc/R8
X-Gm-Gg: AfdE7cnUwVWnT70cIb0HfAarb7szX1IXPG9ecln23nDOrkwlvNDK2/hudv/xig0KmAs
	YHo38Ogu4jE+zfjUitM/eMRtdenSzxPPlBeozWqRoKODMiZ5GyuyTDyMLmuzftWue9bqLTU6mGF
	xMGfOeS3WT8CBG1gkzaEW2ShaK4jeVPDzZ6ZluuI3MTnh8QY8SqD0+xJgJTaBagCw7kqfD78PPa
	8nwrBmq1kMfZxFKCrA2VyJWS1hUOV+ZqhjrbqeBwhaFC/LQr/KOMMZ/6ApkP70sh4zXLKy75USo
	lX6k0B9LXm9GTrcrDFLlz6kJiJgwD8G0ybcg4q6506h5Ykli48Kh+yqq58uaxYJUfRJ0TbNwOwi
	iPZsbmO5Es1wJCQpehGId0D/AQDbSwuMIqkX1bTjjeiTjLibAnFcIfHwblrv9dsAUKFt/DuXtBB
	QxiOW2SpOcU6dRHzhPG4xVV+9VsWAgfjn4FK8HGA==
X-Received: by 2002:a05:6000:2386:b0:475:e015:c2a with SMTP id ffacd0b85a97d-475e0150e6fmr2488498f8f.8.1782820127061;
        Tue, 30 Jun 2026 04:48:47 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:46 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 12/39] clk: renesas: rzg2l: Simplify rzg2l_cpg_assert() and rzg2l_cpg_deassert()
Date: Tue, 30 Jun 2026 12:47:31 +0100
Message-ID: <20260630114813.92739-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23336

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

[ Upstream commit 341b0f1b6cba5f4f317f4bb51efa8e9f566ac8e3 ]

Combine common code from rzg2l_cpg_assert() and rzg2l_cpg_deassert() into a
new __rzg2l_cpg_assert() helper to avoid code duplication. This reduces
maintenance effort and improves code clarity.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/20250903082757.115778-2-tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 44 +++++++++++----------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index c26b0a85df43..25e565100986 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1751,8 +1751,8 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 
 #define rcdev_to_priv(x)	container_of(x, struct rzg2l_cpg_priv, rcdev)
 
-static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
-			    unsigned long id)
+static int __rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id, bool assert)
 {
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
 	const struct rzg2l_cpg_info *info = priv->info;
@@ -1760,9 +1760,13 @@ static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 	u32 mask = BIT(info->resets[id].bit);
 	s8 monbit = info->resets[id].monbit;
 	u32 value = mask << 16;
+	int ret;
 
-	dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
+	dev_dbg(rcdev->dev, "%s id:%ld offset:0x%x\n",
+		assert ? "assert" : "deassert", id, CLK_RST_R(reg));
 
+	if (!assert)
+		value |= mask;
 	writel(value, priv->base + CLK_RST_R(reg));
 
 	if (info->has_clk_mon_regs) {
@@ -1777,37 +1781,19 @@ static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 	}
 
 	return readl_poll_timeout_atomic(priv->base + reg, value,
-					 value & mask, 10, 200);
+					 assert == !!(value & mask), 10, 200);
+}
+
+static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	return __rzg2l_cpg_assert(rcdev, id, true);
 }
 
 static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
 			      unsigned long id)
 {
-	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
-	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->resets[id].off;
-	u32 mask = BIT(info->resets[id].bit);
-	s8 monbit = info->resets[id].monbit;
-	u32 value = (mask << 16) | mask;
-
-	dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id,
-		CLK_RST_R(reg));
-
-	writel(value, priv->base + CLK_RST_R(reg));
-
-	if (info->has_clk_mon_regs) {
-		reg = CLK_MRST_R(reg);
-	} else if (monbit >= 0) {
-		reg = CPG_RST_MON;
-		mask = BIT(monbit);
-	} else {
-		/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
-		udelay(35);
-		return 0;
-	}
-
-	return readl_poll_timeout_atomic(priv->base + reg, value,
-					 !(value & mask), 10, 200);
+	return __rzg2l_cpg_assert(rcdev, id, false);
 }
 
 static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
-- 
2.43.0


