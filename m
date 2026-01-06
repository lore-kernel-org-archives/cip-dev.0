Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88BBCDC170
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:18 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88178.1767699910460810479
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nFACoW0z;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so6379185e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699909; x=1768304709; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcuSwAWpy5ogLioXgZMGiraUpPA67tiNsVfzCl/mhQ8=;
        b=nFACoW0zpHuGJ7mR4iYfVEjnAA24s9ouArmHKg0b6ZDL+5/RxAQNnRXodXIdE/l5IE
         o0pqyGtRnOsKSbc88uhp8+Jy2oN5Au/KrdvaJ22qJJr0onZxnUVDJ0ESDGNa+BAuAI1q
         B0deONu2GiOK0OXIuQANRBlHt8jfq76QOmeaDkwhMAXCFW5Jrq4Cn3W2MPeBalgRvDpj
         BB8pnsQRPKcAxiV+7WVSI6JvNn9iB900MicgX1kt6HilvH5Ufma+xR9D5+PcGB3OYLQ3
         zkihBXqYPuuFNu4LXleXXncNyG6KYeB2OBt/x/rPoCUGqO6GRLMvtoW0c8EXPNeunoGO
         Uh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699909; x=1768304709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jcuSwAWpy5ogLioXgZMGiraUpPA67tiNsVfzCl/mhQ8=;
        b=DP+OtPNA3SZEQmUNLHs6KsDZvXyQAKqlrp62RAKW8+hAP3JK+aYYp2xyShmwb8IOad
         0EpW9JhCxXcyfaYy9uXO79w0yIBSZy10w7HnPoKs+xCC+aRxyYW/0VbuyxO5lN6IPqqZ
         zp/Nfml1TINsyQDpkojkuZP+dIBkQIiUTWcHiZS92A0bUsNsIiwyCL7T89nvWEHCCFzM
         yos4gSJKZ0dkK62RMSson1y12TYgY2dCdlo5f5C+iyzcEAibPp6mBB/XIc0FTL75mUD6
         yKLZ90jOVt3KyWnUEHjLkVTjUAcV4qyRhircw+iFxImRE1mWgxXtvXy3tVbpmNKeiIDS
         QrIg==
X-Gm-Message-State: AOJu0YwlUYi/ANoMy2u6Fmvv59uoLduPW6HQwZwHzAKqQ4CEbZBEz1iO
	FiFu8Gb151g0q6cX+oYxdyfwH5kszxK0npJQUtFklIhM+rFHkGMhnbJ6FkTUUg==
X-Gm-Gg: AY/fxX5DIVSVAr0xkUPcgzfbjAM4X7yefAXqJk1rDiWEYWDo5YjLDn6ANxfkz4ZBlGn
	0unNFhNAxq4Jg2Iehply4WhpzFYLp/hB/4R5ic9HUAHACIDXGioVsDZiQ0exRgZzR/7Rs3Qn8A3
	khsPbyrTDFM6qCnmp/dHBtji+cm6ldnp5uKIEXO/iQbZmEXKRLnKOKmvlRbhRHH1dAH0ciPxpIK
	Geb8ZtAoD6vMSphfGMrBZKkku02zKrYkjxVJ2QqjbEiezF15gt2XMHEYM2MU/PZG0C5twr+H7PU
	EzWppYq27qRt0gAypIbdFzWoJL4kbXuqcYn1chJrcymbwhT/riQG5LnAxq7H91T1SbyFtFjiB8K
	QhZNSvBBf+nx+KJlAhM1zQX3E4nC3tfMb5MAH8JlgjKl1OTpj4MAJ+aymrhiv+i/++fYHODAVYG
	4sFAsIRM9D6q4TJdxCDw==
X-Google-Smtp-Source: AGHT+IGkkRHdqsA/RGmOJOb0lSWl79A0WC+FgmTyp4EnWZ/O9X/+bD+9e3bZGVYDrwZXwltem7PDAQ==
X-Received: by 2002:a05:600c:3115:b0:477:9f34:17b8 with SMTP id 5b1f17b1804b1-47d7f06cfd2mr34391385e9.1.1767699908564;
        Tue, 06 Jan 2026 03:45:08 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:08 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 19/24] can: rcar_canfd: Use devm_clk_get_optional() for RAM clk
Date: Tue,  6 Jan 2026 11:44:42 +0000
Message-ID: <20260106114458.122333-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21351

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit eda3d6c8d784835cec86f42b3f8118c9eb0cc58c ]

Replace devm_clk_get_optional_enabled()->devm_clk_get_optional() as the
RAM clk needs to be enabled in resume for proper operation in STR mode
for RZ/G3E SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251124102837.106973-4-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 246aae427582..1abc7624120e 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -468,6 +468,7 @@ struct rcar_canfd_global {
 	struct platform_device *pdev;	/* Respective platform device */
 	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
+	struct clk *clk_ram;		/* Clock RAM */
 	unsigned long channels_mask;	/* Enabled channels mask */
 	bool extclk;			/* CANFD or Ext clock */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
@@ -1984,7 +1985,6 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
-	struct clk *clk_ram;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2074,10 +2074,10 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		gpriv->extclk = gpriv->info->external_clk;
 	}
 
-	clk_ram = devm_clk_get_optional_enabled(dev, "ram_clk");
-	if (IS_ERR(clk_ram))
-		return dev_err_probe(dev, PTR_ERR(clk_ram),
-				     "cannot get enabled ram clock\n");
+	gpriv->clk_ram = devm_clk_get_optional(dev, "ram_clk");
+	if (IS_ERR(gpriv->clk_ram))
+		return dev_err_probe(dev, PTR_ERR(gpriv->clk_ram),
+				     "cannot get ram clock\n");
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
@@ -2143,10 +2143,18 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		goto fail_reset;
 	}
 
+	/* Enable RAM clock  */
+	err = clk_prepare_enable(gpriv->clk_ram);
+	if (err) {
+		dev_err(dev, "failed to enable RAM clock: %pe\n",
+			ERR_PTR(err));
+		goto fail_clk;
+	}
+
 	err = rcar_canfd_reset_controller(gpriv);
 	if (err) {
 		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
-		goto fail_clk;
+		goto fail_ram_clk;
 	}
 
 	/* Controller in Global reset & Channel reset mode */
@@ -2198,6 +2206,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
 	rcar_canfd_disable_global_interrupts(gpriv);
+fail_ram_clk:
+	clk_disable_unprepare(gpriv->clk_ram);
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
@@ -2222,6 +2232,7 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
+	clk_disable_unprepare(gpriv->clk_ram);
 	clk_disable_unprepare(gpriv->clkp);
 	reset_control_assert(gpriv->rstc2);
 	reset_control_assert(gpriv->rstc1);
-- 
2.43.0


