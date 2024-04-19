Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ECAC0650F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:17:57 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web10.15285.1713514675565484437
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:17:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GQIVrdSv;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so2194778e87.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514674; x=1714119474; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyCTJKLuss+FBt172vSFTgxvb5QYNSzGQefT8db14PU=;
        b=GQIVrdSve85MuiUC3po1n22AORYzb4wIBUZjDNoAPjS0Yij3jfseW5tY7Va36hpPYJ
         7lFFOkcUEEh1yheoSQ34iniUPJUiiN/1fceLOBQrdbkE0HmKhn+M3kS+jXJpgUmkPPHu
         C9Z5H1YC5e+LVu5HSUQMeA2alTcwIo5uDvsbyTifmDhaescokzU7e1jovb/OkQ49To71
         cevYElu5pqDzrtE8B5xDbv0Z/FZi+iQc0SaRlwOBObrU3QBxJm0M3xt7JBLs9R2D8d8s
         nbNoYwrjuuF7Idmx9Xbjft7Fk24/ZmE/TWzae1zIQ25KW6fidexg5gdSwnr/mq0qhUhv
         3Cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514674; x=1714119474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyCTJKLuss+FBt172vSFTgxvb5QYNSzGQefT8db14PU=;
        b=bvFHheDCPm4YvxuRSJIYFfCLZaXNfqgWMDLqI08cRX1jdoxerg12/iPyFi2eXOIAm+
         UnOsOnDmn/arYGt6X9OWRgtLUIbbaxB86bP5gEA40anZyo3rL0KABpqkGnxgJDuNX+UM
         SwHiFkBXVSnUCPJwsuCO1GADtmxMmyTKnwiDCK5tzDTpiaZQTWKxjvHzdBa2JVTe2K0b
         ABgiVTsHEBxtmMLShiE/mXnojTuEhMcDGTcpl/DGcRlyTEJRTRc0EMOKQI6L1JkvcITt
         YKo5yhoSsw6g6OJALOzmDIQvmQhNx2gOApXb7TuqTACof+8F5j1a1FUgLvEYPzopbq5f
         jfAg==
X-Gm-Message-State: AOJu0YwHV7Eq1eJ0KSuUotjBHzoX6bOcA43fp8dWUy5XifxlpB6ez0Cb
	KMKP1ZjukGhNbBA23OjhQyWd7aWqnX54sAfUJu/Q0IvuLqG3jjcAIhbH8EzXOB0=
X-Google-Smtp-Source: AGHT+IEV2ejGgdVGiXFNma1qV+O4+SH2hvE8AR52PgJjQFHjwq+ee9Bc0DU+TQpxb+Cn/GLHKFWPgw==
X-Received: by 2002:a05:6512:445:b0:519:1bcd:87cf with SMTP id y5-20020a056512044500b005191bcd87cfmr776183lfk.27.1713514673708;
        Fri, 19 Apr 2024 01:17:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:17:52 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 06/53] clk: renesas: rzg2l-cpg: Reuse code in rzg2l_cpg_reset()
Date: Fri, 19 Apr 2024 11:16:55 +0300
Message-Id: <20240419081742.3496709-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:17:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15593

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 5f9e29b9159a41fcf6733c3b59fa46a90ce3ae20 upstream.

Code in rzg2l_cpg_reset() is equivalent with the combined code of
rzg2l_cpg_assert() and rzg2l_cpg_deassert(). There is no need to have
different versions thus re-use rzg2l_cpg_assert() and rzg2l_cpg_deassert().

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120070024.4079344-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 38 +++++++++++++--------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 2260741433b2..fee4d3d5c265 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1115,29 +1115,6 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 
 #define rcdev_to_priv(x)	container_of(x, struct rzg2l_cpg_priv, rcdev)
 
-static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
-			   unsigned long id)
-{
-	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
-	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->resets[id].off;
-	u32 dis = BIT(info->resets[id].bit);
-	u32 we = dis << 16;
-
-	dev_dbg(rcdev->dev, "reset id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
-
-	/* Reset module */
-	writel(we, priv->base + CLK_RST_R(reg));
-
-	/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
-	udelay(35);
-
-	/* Release module from reset state */
-	writel(we | dis, priv->base + CLK_RST_R(reg));
-
-	return 0;
-}
-
 static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 			    unsigned long id)
 {
@@ -1168,6 +1145,21 @@ static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
+static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	int ret;
+
+	ret = rzg2l_cpg_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
+	udelay(35);
+
+	return rzg2l_cpg_deassert(rcdev, id);
+}
+
 static int rzg2l_cpg_status(struct reset_controller_dev *rcdev,
 			    unsigned long id)
 {
-- 
2.39.2


