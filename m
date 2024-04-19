Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EC8C04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:17:57 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web10.15281.1713514671815579808
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:17:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=nUXL1ONO;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51abd9fcbf6so638075e87.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514670; x=1714119470; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N44mTATHDnjbI2lgGO1YblTU01V/FkQm4BHSFQHsSd4=;
        b=nUXL1ONOjY+OEL3+zL2Eq4rErRang8nfGXhYbOu4OeOclfnoCYEHKyxjHCXcSuRq8r
         JhAgidKV0/aXd2a1hklaj2cR2w36NSdNdp7xXsn+4962B6tQ49JhwhkPvgLzjyCL54RD
         1xJZOnp0hSFt4flW+9FotVLAz+0J0ImvxK+W9C4Eq3AB0BABAbwqXdHYgGOH11c3auhW
         SE6/+nwYmgbZPkd4WrhZrzoWmc8sTdFyp6+pW8Ss/27MCy3+tclWDhXsBfrF92uQ69CT
         1hX+hGURPcJHa4TKm2pYNTXmCDxYVsIaRtqEoQBtSyJh60AE0uLUjtN6SSc9+hGiQyfP
         hdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514670; x=1714119470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N44mTATHDnjbI2lgGO1YblTU01V/FkQm4BHSFQHsSd4=;
        b=aF3GImMYg+iYYkBJ7ylMmWvrP2MmhZbtHgEoEYQ7u0+QoHMrdKPA4wtf+QF/i5kWFZ
         MDWsh+vlM3qHqq4kztBO5lFW8pKIZnPRKIhPKzuErLF/P2syKOTsoIOEBbFfNRXrbR+g
         ztX28ZJAthaA7jwWfbuEPjdBlHRdwj8jA+7pvczirkBktWpBt1c7AV7TI4RIldqh+3FH
         NnpOxGQ4VAHL4sfPaLkrNj/johUhyRSHNJmzXZohCvqe62vqyr6ViNgcdVF1qBPdNG90
         p5L+b1kwXcNnJouwZs1wGvUFpNpgb0FkRCvG0i/XG/2UWYDuXnWqtG9IUNxLZ/+t1x+J
         fFHA==
X-Gm-Message-State: AOJu0YzaS6p9j7ViAMuh0sMMEZqSKfWg6RTZyl3cChYBNNeVZX0Grsw8
	R6ezmHXrVboeEWeJ0RksPrXQTuBuObu9mQCSCiFSAw4k3bYqbqy2GwEVKvpjFOs=
X-Google-Smtp-Source: AGHT+IG/LXcBSjrbZYNRYYuDADQb6gSzZZ398Ccu5VLB4Y64SupFhTxkURcTRAGLcLjvTFdJCemGxw==
X-Received: by 2002:ac2:5bcd:0:b0:515:9c73:e29a with SMTP id u13-20020ac25bcd000000b005159c73e29amr1020551lfn.66.1713514669741;
        Fri, 19 Apr 2024 01:17:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:17:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 03/53] clk: renesas: rzg2l: Trust value returned by hardware
Date: Fri, 19 Apr 2024 11:16:52 +0300
Message-Id: <20240419081742.3496709-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:17:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15590

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit bf51d3b2d048c312764a55d91d67a85ee5535e31 upstream.

The onitial value of the CPG_PL2SDHI_DSEL bits 0..1 or 4..6 is 01b.  The
hardware user's manual (r01uh0914ej0130-rzg2l-rzg2lc.pdf) specifies that
setting 0 is prohibited.  Hence rzg2l_cpg_sd_clk_mux_get_parent() should
just read CPG_PL2SDHI_DSEL, trust the value, and return the proper clock
parent index based on the value read.

Fixes: eaff33646f4cb ("clk: renesas: rzg2l: Add SDHI clk mux support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-5-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index fcbb0e2d2123..330aa67fdab2 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -242,14 +242,8 @@ static u8 rzg2l_cpg_sd_clk_mux_get_parent(struct clk_hw *hw)
 
 	val >>= GET_SHIFT(hwdata->conf);
 	val &= GENMASK(GET_WIDTH(hwdata->conf) - 1, 0);
-	if (val) {
-		val--;
-	} else {
-		/* Prohibited clk source, change it to 533 MHz(reset value) */
-		rzg2l_cpg_sd_clk_mux_set_parent(hw, 0);
-	}
 
-	return val;
+	return val ? val - 1 : 0;
 }
 
 static const struct clk_ops rzg2l_cpg_sd_clk_mux_ops = {
-- 
2.39.2


