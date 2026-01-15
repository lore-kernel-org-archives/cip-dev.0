Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8405DD33A18
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:34:11 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31273.1768466042985040853
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:34:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=gIlo/su2;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8765b7f4c0so111584366b.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466041; x=1769070841; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQRi0w7/F0eBzGT0Id8epD7eZdOUXbrU1HlqPRSFV8I=;
        b=gIlo/su2szx+OzAE8cMSTK7nd7OVo+RmC1UIKs2t2uvb/c3P9IXvFZKuI0o6Hakmca
         srJwsLsxVDEpmaMsfx0HA17d1Js5dxPu2rhHIdxSqCLUBA8SvjVrIJ3KdwiVIw5Sbswo
         BtK6oj11xAR5HfaCO2LuGZMhf9Pw8x7gxmxFkxO5EW0hrA+X42XMMO+qXxsFOz49/u+W
         mReQLjONgVJJVLrjWVuTCSx1XlnDOq8JXwOFNZ8Xiy1IyzsrvVAqQxwcJWMZ4qNwFx1m
         NxukMP9au8jncVUCAoBlA1QCYEQGCIgNm3iS5SfexsUls93w3rAvFLqaOfqeRE9N2m0J
         pTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466041; x=1769070841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQRi0w7/F0eBzGT0Id8epD7eZdOUXbrU1HlqPRSFV8I=;
        b=rbkp++ADj7hiOI6JK/DMSesp9l1kbG3o0klNU4WHAm/2jO8Tfzo7R449DoFXkgfB9/
         NFHk1dTeRZlxIWSrp8i2nr6swELHE/TEqtuayOKpjI4Ijm+kgqAIVria7+6a+Blbezi9
         axstZWfXMUS6IBhQ6wSmBWoDDBFmzPLv1W/ahFFvPeXN0hWcYtADY+3R9gNDsqlN+Ur4
         1ht7VwJaUU1v+62cvEEdwHO+yEUNAibvxrZGdvpIyh+HA2HXm5bpZWKdtd5/qgGldKQn
         BghPBsTfRjXkjD9aAptcOAROkm3B8xE+NmjcY58Q2YvYkcCGLb8sRGVRr9FngCdlqGrl
         UeVQ==
X-Gm-Message-State: AOJu0YxaHLI0a/XsSUj2Ws8StQsajx3hEDB39UlbB4e4m/Y4v8ueoHad
	fi6p0IXBYn7hUVjsauRAIYL+ASkI3vR1uAbEqizZ+bcQmKuFx49zw3EXReI5ZPrqLGg=
X-Gm-Gg: AY/fxX5fsSP3LtvtbIqRJS9dh1U1yQUaSPZP3mRBZ8wWd18Hku+Uheb785N9/uraD//
	kj7+Neep4Pv/RwEm78qWK3GazV83xMgKEOQyUr4qraIXQvN0/aXNIABYTIPgmFO1zyVm0tI4l5U
	BovvOKyNdusB0GTepnPQBhhBmvxEOa4V/UAGkRyDFOnEUxt4EM/pLeTDge4WRJeH1YYQ2TLXE0V
	JcdvmJkYskU803IPCSPyGDDjt6UhdFYikKsU0ZxQ6clAReSnj2zCNnbeZByOBDpZtQ6Z+RwscBx
	fX4R5TnTUK0oX3+uXBLQu5NVIbI0O9HN4S/XipZiw9lSojWso45uw3elPLUC5zMd1UwKQ0trQ2S
	vYSA/yz9IboIA1PmDCWmTury2Rg4zhA0J+v2RZLFlgxjRqs3IEAwpOG8zqO4A+dY3ZwRBpkWJDA
	0IYPW0ukiup5Ew7dxmrvCvqfm1INNnAA0UOyR4J6OtzFTPU71ZuXoAKZeCxQkITjvzhA==
X-Received: by 2002:a17:907:a08a:b0:b87:31d1:4131 with SMTP id a640c23a62f3a-b87612dc12amr476943066b.60.1768466041325;
        Thu, 15 Jan 2026 00:34:01 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:34:00 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 15/18] clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
Date: Thu, 15 Jan 2026 10:33:29 +0200
Message-ID: <20260115083332.1063820-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:34:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21576

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0ab2d84f94dae48c3e7605cdc99dbb4e7c7b206a upstream.

If MSTOP is not added for both clocks in a coupled pair, and the clocks
are not disabled in the reverse order of their enable sequence, the MSTOP
may remain enabled when disabling the clocks.

This happens because rzg2l_mod_clock_endisable() executes for coupled
clocks only when a single clock from the pair is enabled. If one clock has
no MSTOP defined, it can result in the MSTOP configuration being left
active when the clocks are disabled out of order (i.e., not in the reverse
order of enabling).

Fixes: c49695952746 ("clk: renesas: r9a08g045: Drop power domain instantiation")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250704134328.3614317-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 4351bae7b8bd..87c79df6406b 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -247,11 +247,13 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 					MSTOP(BUS_MCPU1, BIT(13))),
 	DEF_COUPLED("eth0_axi",		R9A08G045_ETH0_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 0,
 					MSTOP(BUS_PERI_COM, BIT(2))),
-	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0, 0),
+	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0,
+					MSTOP(BUS_PERI_COM, BIT(2))),
 	DEF_MOD("eth0_refclk",		R9A08G045_ETH0_REFCLK, R9A08G045_CLK_HP, 0x57c, 8, 0),
 	DEF_COUPLED("eth1_axi",		R9A08G045_ETH1_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 1,
 					MSTOP(BUS_PERI_COM, BIT(3))),
-	DEF_COUPLED("eth1_chi",		R9A08G045_ETH1_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 1, 0),
+	DEF_COUPLED("eth1_chi",		R9A08G045_ETH1_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 1,
+					MSTOP(BUS_PERI_COM, BIT(3))),
 	DEF_MOD("eth1_refclk",		R9A08G045_ETH1_REFCLK, R9A08G045_CLK_HP, 0x57c, 9, 0),
 	DEF_MOD("i2c0_pclk",		R9A08G045_I2C0_PCLK, R9A08G045_CLK_P0, 0x580, 0,
 					MSTOP(BUS_MCPU2, BIT(10))),
-- 
2.43.0


