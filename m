Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5188BC4450C
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:57 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19079.1782820136049409656
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Heo7tNef;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493a54b80a5so35458975e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820134; x=1783424934; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYhNRzKGREFIFFpm6L2+Qqqx9E07KoJkFAi1uC1NTMU=;
        b=Heo7tNefOKhdvpnvncC8XuioPrHpE9CAgFVzoGq5ebqbbthYsYU+mRtHKXAoJWjWjh
         VhJwhXyEGniXv4fGpTc4GBBswVT2Umd5v54A1KfRDjFWKVWfuJl350uxM2g0Z51n4Nez
         3I1RolJEgUyI0PKFipkjconzRMzLb++rCCIvyPOBmbYNh9h5Om3OpkeGfiF1M6oCY7m1
         c8n6/S67f4v5v4opn/v5dGwGo5ghU2ZYRsJbP3FUMcctWCRrYhaqp7OYw5j1A1QRUyD5
         9b9Ar/0xtPt5nFCf2ObbMACKSgp2Zfio8gyhIIo3TfFFknBxFVNFekXnwlUuO94zYfao
         jAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820134; x=1783424934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cYhNRzKGREFIFFpm6L2+Qqqx9E07KoJkFAi1uC1NTMU=;
        b=qcEDlUg2iP729YBHS1OM5sZCFWTWqiX/04OpEaSPi8hmqvBOCSAWDRxlLrKJKFU4dJ
         RXaaft5Dt2j/pECTBMNvCm64krJVnrFhhJKeVhX9esWZcxSzuBRi2BfTVNrJhi24Gtgn
         l+H1jSXfF+2twTYJDdyLx/FAud9IM8aYUwnlwHAxMkMkrGLmjMKnczUNK8r9sdKGIcJo
         pI7UB+CDBBrQnPreXbHIOFWyhXUgwdMgxaWe4Q6ORFFt+BNNOumfsPuSYwfRtjB0+6LG
         SHMBhI61uH8DUsHD9jzK2DXrgZoe6FlBKRNjlum58m57CMcGidPMOexuXTFYrMRZ6r6k
         93ng==
X-Gm-Message-State: AOJu0YyPaNNEpafyoKqlt4Ova9J58sa3GIo2xW5x/wL2ZQxdBZxpMPGa
	xGpddxBfQ22n0TiI83thD2onOAfJOzdgph7ld5nySyk0rDHBcIX2xouNOseXVk8i
X-Gm-Gg: AfdE7clkQ54/ETZP64Dvw2qeR1hIgP2BGeg4QgdA8pngCySHw6nSJ0niKiXwNxJy6gS
	8/CmqpfbUvAkkn+LOku8txpKlLLrPIgAFnXF7zQPCYH67ETztbNOS7xLz0vu3kt8fxWjfvvtzmr
	3VY35NXsc9uCt9lYO5aq9vb6PAmFc+UOw4fc6xyjer4p6ZrzX+4kOYhlZk/xf5YcLGZGfjHre3F
	pz/6OOGG77Oe/O3nXqO9uAvWr4pswuLD5kmuiCE4zDj3MpTonZyMj84xBXEQEdkduMbyv0XO1qO
	s3zZgQwiynZE29n9bSs09MT3y9y9OJtgYWmcuYZqSmEvaUGiiE5CLjGMEX7EYpucNMUd0BGOA0m
	HqTw40yYB3Gc/phVV5i8CmbOKLxW4F/JhpKzRzq1DPUa2/W4aNZgXyC5fzUumZs1Gs3hcgTGRU9
	V5wP7YngjrJVi0TgDs+MIY7pwlLzhcaqR9u/jCQw==
X-Received: by 2002:adf:f10d:0:b0:46e:8226:96b1 with SMTP id ffacd0b85a97d-47553ab52c2mr3296141f8f.42.1782820134229;
        Tue, 30 Jun 2026 04:48:54 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:53 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 23/39] clk: renesas: r8a08g046: Add support for PLL6
Date: Tue, 30 Jun 2026 12:47:42 +0100
Message-ID: <20260630114813.92739-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23347

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit f232745679fe1b8dfc545d2bbb4b5cd1c50b323 ]

Add support for the PLL6 clk by registering it with rzg2l-cpg driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260326110648.29389-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g046-cpg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g046-cpg.c b/drivers/clk/renesas/r9a08g046-cpg.c
index 6759957980f2..fed9607af216 100644
--- a/drivers/clk/renesas/r9a08g046-cpg.c
+++ b/drivers/clk/renesas/r9a08g046-cpg.c
@@ -29,6 +29,9 @@
 #define G3L_DIVPL2B_STS		DDIV_PACK(G3L_CLKDIVSTATUS, 5, 1)
 #define G3L_DIVPL3A_STS		DDIV_PACK(G3L_CLKDIVSTATUS, 8, 1)
 
+/* PLL 1/4/6/7 configuration registers macro. */
+#define G3L_PLL1467_CONF(clk1, clk2, setting)	((clk1) << 22 | (clk2) << 12 | (setting))
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A08G046_USB_SCLK,
@@ -45,6 +48,7 @@ enum clk_ids {
 	CLK_PLL2_DIV2,
 	CLK_PLL3,
 	CLK_PLL3_DIV2,
+	CLK_PLL6,
 
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -78,6 +82,8 @@ static const struct cpg_core_clk r9a08g046_core_clks[] __initconst = {
 	/* Internal Core Clocks */
 	DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
 	DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
+	DEF_G3L_PLL(".pll6", CLK_PLL6, CLK_EXTAL, G3L_PLL1467_CONF(0x54, 0x58, 0),
+		    500000000UL),
 	DEF_FIXED(".pll2_div2", CLK_PLL2_DIV2, CLK_PLL2, 1, 2),
 	DEF_FIXED(".pll3_div2", CLK_PLL3_DIV2, CLK_PLL3, 1, 2),
 
-- 
2.43.0


