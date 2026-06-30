Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50879C44507
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:08 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19438.1782820140422876413
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:49:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lMWiIQ6f;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-471eeac43bfso2832232f8f.3
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820139; x=1783424939; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LBnZBFLV5i9w3DPp2VEfw9Luna30kOn39rIVjSNOdw=;
        b=lMWiIQ6fuDFWiNtMWBHEWc70YqJ+MB/N1M4moRKdlJB/apYA2aiOePvvbVmwc/gBvT
         MWMFeyNczs2Uz7P8FJLOYvnjShRqy1NcYyrcXEc+uvkfGw40SXvAQ8bSqqD3VTenHDqC
         2b/YQKXPNBf2KBynZIK5C8lGF9HjeLCqSI9+WIX6/4pOqTLfH5TXP7eIHqW3pTXgJ449
         yMsaJ9BJbOTusU+Y1TfKJOKUwPT3XkpW3DEkJ2jZb6O+vQs91wLOeo9aRIZsYUHCzxkV
         BW9kMa/k5dwyU6IwAvBCU1ENxO9HMDF4nGAfYXaGMQmrOkkV0JPwDskFjqruyLX6oVBx
         dEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820139; x=1783424939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LBnZBFLV5i9w3DPp2VEfw9Luna30kOn39rIVjSNOdw=;
        b=MdMS1ubi29pYLsi5jjkg295DDq78AilfEYie6XDc3XXeKeLjwLXaccSVbzbIyye8Js
         do8/1MZ74IAoFNiEROwSLTiqgXD9Eik2wIlUoUm5Gl9MJXj3ZxvF1jO7v7Lg2MS+z9sY
         12RHnGyDr5whr7Yz1t9zYqkIzBtBNyJ1waR3RC5WenjsorGkhd0HdqtvpbHUnU//o6cs
         9gpuH3V0j7TSlrC6iHDSE87+GhhtFu55RUluMOcCa1vtP/Q1b08zSseOJ/uMx2boSL5q
         NpKb+uaUoqxtFrsxeDcxMKngVLde+Pa4Yc6iiupk93BkKybqRnzZ9ecQT8YDR0b3ufto
         PNPw==
X-Gm-Message-State: AOJu0YzFjrHxnvlIbm0SG2kzSBbbjid2wvc+lZTMANLIuTfgV8GI8xIK
	U6svxXniDVirfNAxNkwcOMtFKZXSQ2mAut4wG8XB40Y2qcsVQyf2z0m1Wfd4h5mY
X-Gm-Gg: AfdE7cmQtT4KTAQnWoBwFeCVcxZuXg4S/S7uFyThBZMRg244rnPNw1fuGKNYdpp8aOi
	FqhxPoBquaBPRMn7y8Ft/Kr1X9huI9YouMzeH3V3H+IKU60QlaQWLoQh1+PnX4VyIKcDGe8vBrn
	XJpwes+sXh7tam1AyblzCrrp8x5lGGRPjd4CDdjGg4LW5/OGiJgadRYbhSKtOKClW+lu9Akpfbt
	MeaBzIFP8RF1+XLaA7CcXfqpJgVnFIrIgrb+GUO0c/OkO/MehM15I+zWds3FEDmnZrkLcgl4GqB
	4h+QI63ckU74kuIcUMmanCJfJPHjj6DaZV1yvQ4QzZ6q9KKVpgOodQjO1lRZctJ8SFynKUNVoeY
	4XXoHsJc0T8yZWY6k4LbeMahRx7yfDvhPfAneQ2RR9NtV/gOqw3A5kjVzNB4NmzDR1qMaQEV1r1
	gGjRiQ4dBG/h41y4EGPzvisVNal3W1bIROrLcJFw==
X-Received: by 2002:a5d:5d89:0:b0:475:f0c2:75a5 with SMTP id ffacd0b85a97d-4765ad5e41bmr174742f8f.54.1782820138625;
        Tue, 30 Jun 2026 04:48:58 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:58 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 29/39] clk: renesas: r9a08g046: Add I2C clocks and resets
Date: Tue, 30 Jun 2026 12:47:48 +0100
Message-ID: <20260630114813.92739-30-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23353

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit f34ad4b0b4678d20697f93a79f013d0b6b1d7136 ]

Add I2C{0..3} clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260330132349.149391-6-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g046-cpg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g046-cpg.c b/drivers/clk/renesas/r9a08g046-cpg.c
index 962094157cab..ce9503c3cfd1 100644
--- a/drivers/clk/renesas/r9a08g046-cpg.c
+++ b/drivers/clk/renesas/r9a08g046-cpg.c
@@ -262,6 +262,14 @@ static const struct rzg2l_mod_clk r9a08g046_mod_clks[] = {
 					MSTOP(BUS_PERI_COM, BIT(3))),
 	DEF_COUPLED("eth1_rx_i_rmii",	R9A08G046_ETH1_CLK_RX_I_RMII, R9A08G046_CLK_ETHRX11, 0x57c, 13,
 					MSTOP(BUS_PERI_COM, BIT(3))),
+	DEF_MOD("i2c0_pclk",		R9A08G046_I2C0_PCLK, R9A08G046_CLK_P0, 0x580, 0,
+					MSTOP(BUS_MCPU2, BIT(10))),
+	DEF_MOD("i2c1_pclk",		R9A08G046_I2C1_PCLK, R9A08G046_CLK_P0, 0x580, 1,
+					MSTOP(BUS_MCPU2, BIT(11))),
+	DEF_MOD("i2c2_pclk",		R9A08G046_I2C2_PCLK, R9A08G046_CLK_P0, 0x580, 2,
+					MSTOP(BUS_MCPU2, BIT(12))),
+	DEF_MOD("i2c3_pclk",		R9A08G046_I2C3_PCLK, R9A08G046_CLK_P0, 0x580, 3,
+					MSTOP(BUS_MCPU2, BIT(13))),
 	DEF_MOD("scif0_clk_pck",	R9A08G046_SCIF0_CLK_PCK, R9A08G046_CLK_P0, 0x584, 0,
 					MSTOP(BUS_MCPU2, BIT(1))),
 	DEF_MOD("scif1_clk_pck",	R9A08G046_SCIF1_CLK_PCK, R9A08G046_CLK_P0, 0x584, 1,
@@ -287,6 +295,10 @@ static const struct rzg2l_reset r9a08g046_resets[] = {
 	DEF_RST(R9A08G046_WDT0_PRESETN, 0x848, 0),
 	DEF_RST(R9A08G046_ETH0_ARESET_N, 0x87c, 0),
 	DEF_RST(R9A08G046_ETH1_ARESET_N, 0x87c, 1),
+	DEF_RST(R9A08G046_I2C0_MRST, 0x880, 0),
+	DEF_RST(R9A08G046_I2C1_MRST, 0x880, 1),
+	DEF_RST(R9A08G046_I2C2_MRST, 0x880, 2),
+	DEF_RST(R9A08G046_I2C3_MRST, 0x880, 3),
 	DEF_RST(R9A08G046_SCIF0_RST_SYSTEM_N, 0x884, 0),
 	DEF_RST(R9A08G046_SCIF1_RST_SYSTEM_N, 0x884, 1),
 	DEF_RST(R9A08G046_SCIF2_RST_SYSTEM_N, 0x884, 2),
-- 
2.43.0


