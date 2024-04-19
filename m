Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80D3C071FD
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:17:57 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web11.15255.1713514676887593126
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:17:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=D+ViPVsg;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51abd9fcbf6so638218e87.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514675; x=1714119475; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2hlPxOFybFH23T/YECy3SSN4xpZfD7q3OR4joXitpc=;
        b=D+ViPVsgnR4BDWg6aoAH1Sbk3gleegEaG43eoqGTVFHELlc6rHYCEVsrrBGzgyo012
         ZoY9VgURmllpG5rG9wo+EdC5Ylp2lk90+C12kvMAzMFmBTZA5RX507R4iftJmFLxhDRB
         pd7aoiVNaoSAv0Vhfemn0ZeWtuCji4ggjchY6zy6cuGY8BBR/lKTf/Xiq9hzBfsJqkNJ
         +uc18EKt3hQfDla8CEcv7GIPZkQmLGymm8q3rBfB5s6t7Vkup6nZ9zawUtOhH8Z8MpG4
         lqS4OtBqP4OTm853SPKvhD0R6ioJ/Y5TVF9NDLplN6wwSAYh+hoIqiesqIsEvvsLM7ce
         g/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514675; x=1714119475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2hlPxOFybFH23T/YECy3SSN4xpZfD7q3OR4joXitpc=;
        b=cM2BtgTgHhoYtP2NoDWx8qBEzHNJitVdo3QzIEv5DDf4YrpmM3jrwNXXzhZFuN6WfH
         WGjbesKdtsDub/uRtsSSFoZ3I5CgutMvI8zhoEQ++R8RtDk2oCCX6PAG0cf7CZ6znFB9
         csTCSfXvJVdCnXSKpCXlcUN6k/pWH6vmddvRg87kQInAxp3pToKB5XQT2/wSVKVS9EB9
         Boxy2FaC5B8piGiH2OulaxhInO5M7v2907/ELpSAVvTaXEcGfZWOZWL5m0k2sSlHezh5
         nts8xUqueHclfKaumXqdAGyy/Ql7fzCD4Zcc/J8/xit78Ee2f+J1C9T6hfJyWvcDxli1
         QnFw==
X-Gm-Message-State: AOJu0Yzjdpg+ze/Z5BsLaavqCiFzyODk6wPjn12xbwvlW3jsgU6aik8d
	tB6GyOzsg+wIqSxCszb/7l0hvvVNODfg130e2ZEMbJjTI8svfEhv0JuOa6JZPoc=
X-Google-Smtp-Source: AGHT+IE3fkVXUt+XC40H/mU4lCev1UrsuBhrzDKvXLvhRo51SQ4KK7Rj031/y9mdYT+pd51r3QbLbw==
X-Received: by 2002:a05:6512:3b11:b0:515:cd23:7090 with SMTP id f17-20020a0565123b1100b00515cd237090mr1488218lfv.8.1713514675129;
        Fri, 19 Apr 2024 01:17:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:17:54 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 07/53] clk: renesas: rzg2l: Check reset monitor registers
Date: Fri, 19 Apr 2024 11:16:56 +0300
Message-Id: <20240419081742.3496709-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:17:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15594

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit da235d2fac212d0add570e755feb1167a830bc99 upstream.

The hardware manual of both RZ/G2L and RZ/G3S specifies that the reset
monitor registers need to be interrogated when the reset signals are
toggled (chapters "Procedures for Supplying and Stopping Reset Signals"
and "Procedure for Activating Modules").  Without this, there is a
chance that different modules (e.g. Ethernet) are not ready after their
reset signal is toggled, leading to failures (on probe or resume from
deep sleep states).

The same indications are available for RZ/V2M for TYPE-B reset controls.

Fixes: ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
Fixes: 8090bea32484 ("clk: renesas: rzg2l: Add support for RZ/V2M reset monitor reg")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231207070700.4156557-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 59 ++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index fee4d3d5c265..491fb64b1a3c 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1121,12 +1121,27 @@ static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
 	const struct rzg2l_cpg_info *info = priv->info;
 	unsigned int reg = info->resets[id].off;
-	u32 value = BIT(info->resets[id].bit) << 16;
+	u32 mask = BIT(info->resets[id].bit);
+	s8 monbit = info->resets[id].monbit;
+	u32 value = mask << 16;
 
 	dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
 
 	writel(value, priv->base + CLK_RST_R(reg));
-	return 0;
+
+	if (info->has_clk_mon_regs) {
+		reg = CLK_MRST_R(reg);
+	} else if (monbit >= 0) {
+		reg = CPG_RST_MON;
+		mask = BIT(monbit);
+	} else {
+		/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
+		udelay(35);
+		return 0;
+	}
+
+	return readl_poll_timeout_atomic(priv->base + reg, value,
+					 value & mask, 10, 200);
 }
 
 static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
@@ -1135,14 +1150,28 @@ static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
 	const struct rzg2l_cpg_info *info = priv->info;
 	unsigned int reg = info->resets[id].off;
-	u32 dis = BIT(info->resets[id].bit);
-	u32 value = (dis << 16) | dis;
+	u32 mask = BIT(info->resets[id].bit);
+	s8 monbit = info->resets[id].monbit;
+	u32 value = (mask << 16) | mask;
 
 	dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id,
 		CLK_RST_R(reg));
 
 	writel(value, priv->base + CLK_RST_R(reg));
-	return 0;
+
+	if (info->has_clk_mon_regs) {
+		reg = CLK_MRST_R(reg);
+	} else if (monbit >= 0) {
+		reg = CPG_RST_MON;
+		mask = BIT(monbit);
+	} else {
+		/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
+		udelay(35);
+		return 0;
+	}
+
+	return readl_poll_timeout_atomic(priv->base + reg, value,
+					 !(value & mask), 10, 200);
 }
 
 static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
@@ -1154,9 +1183,6 @@ static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
 	if (ret)
 		return ret;
 
-	/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
-	udelay(35);
-
 	return rzg2l_cpg_deassert(rcdev, id);
 }
 
@@ -1165,18 +1191,21 @@ static int rzg2l_cpg_status(struct reset_controller_dev *rcdev,
 {
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
 	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->resets[id].off;
-	u32 bitmask = BIT(info->resets[id].bit);
 	s8 monbit = info->resets[id].monbit;
+	unsigned int reg;
+	u32 bitmask;
 
 	if (info->has_clk_mon_regs) {
-		return !!(readl(priv->base + CLK_MRST_R(reg)) & bitmask);
+		reg = CLK_MRST_R(info->resets[id].off);
+		bitmask = BIT(info->resets[id].bit);
 	} else if (monbit >= 0) {
-		u32 monbitmask = BIT(monbit);
-
-		return !!(readl(priv->base + CPG_RST_MON) & monbitmask);
+		reg = CPG_RST_MON;
+		bitmask = BIT(monbit);
+	} else {
+		return -ENOTSUPP;
 	}
-	return -ENOTSUPP;
+
+	return !!(readl(priv->base + reg) & bitmask);
 }
 
 static const struct reset_control_ops rzg2l_cpg_reset_ops = {
-- 
2.39.2


