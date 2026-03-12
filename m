Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717D9106704A
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 15:35:32 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24573.1773329727258985482
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 08:35:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IT0xUBUZ;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso11075945e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329725; x=1773934525; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDEndbC3j8Y3A9YsZbgJ42K2cz2UML7gfJjGLLPsrzg=;
        b=IT0xUBUZ1Yjm83yizc2+Y1Fuz1UKhuLxHQkpuj0hWqKycpQzZZPdu1v+PfTWlCpi9C
         WKOCHn/V94ZR3Nma9eEz5E6Ba/UwwGg19sPbxdFt+AL0lQ1Cf+OPEt8yaR5CTCyKa1Ld
         VAluKdx13ewUbnozfSWJt4WND2BN/RxIksITywhSVHxjJ56V1qSI1L5ezy4E7tBLgUpn
         rdFyxNrmQMNvSywIAajWXkINPGH/vhni3DzLrX3Wv27aHBfNOo9+OabqZHbMaJO3lfzc
         pT/8sbrJk/ypRfcKN3q8WwBmzCu1U5wiIIc7A5jbcrm5v/IG8+VWrWomeQA4m1W1i8qb
         FAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329725; x=1773934525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CDEndbC3j8Y3A9YsZbgJ42K2cz2UML7gfJjGLLPsrzg=;
        b=L1+quR2qc2wbwvhZCcR9kh5u9CspDeqpcFa9zRVS0V4zNyrrk80RLxv2dpPFOL4qAH
         QKMyA8q0t2YDvWhhuYbp+IunKLv7bao4fNunArdv676PINtr4YoLrVPG3UmYNbyzfH7P
         UCMDAxbC60Q4aRhhNCfkozWQljLWSJguF3VRkO9MSfLwjY5Z09nGjJTnk056UpwHw4wS
         U1uDJQjlcmbmRQhOMPm0OJkOrzwZxzYupbf55OixGOtutYClpWFN6kpFGjOQPQTNyZKu
         zyVysK7E05ZAq73xLEmzpdT1wSbJXYWCK/akeQLHKe4fnEQ7B5cjIm5z2VFUAp8c+sd+
         HDSQ==
X-Gm-Message-State: AOJu0YxOEwewNqQoP6IAM2LsYOzOpaQxoflXEdJOWB15ZHWi+PI8nCbV
	yu7c1wmmTYMCoy+GkH6cUtP4G3B/A38yi0AqxfruWJUZ/1boCUg+xc7W6+bUfw==
X-Gm-Gg: ATEYQzw4GJrNDvfZT58RduXVgbV/ozslU6CCpyL3m7KxbocZ93OC5+1x7Mv9xKyayDE
	4M1KL7FPQDV1hJlIkmg9zhm+8x3Q48CyWKBp/H4UWb+LBgdPC5gJLDtOhglDJNLd22HniPGAymx
	m+loGzfV6Wl/Ri/TVACGwhLY2EvjDCtH3DxAC+qTrGeQIkBWtkAOi4HKgGIAtGPQEjxwFIJfi1/
	g/hN4LBgDSO05NuYGIduNhxzXlYUVdAdHUq89h0Y3Gj4s0ylffFYpDlcfDzOiHE9jtZ7zcSUtGE
	JV1SB4BSnpL1kG02gnXkLjvk8cVqDQYhd7osHlqdmvcbnKPreOeZKy+la1co9ZdfPkllV4hCHt5
	64X6nnEE9UM8DSosdwxixcEjKFfcoZ8ExHfiqeGcyfpr0SSRnj78kxkWbE7pJ9JNZ3aTq33n4zz
	YkchCDEh1NFulsH2aCnslJJBU5vQT9u3xBpkkfKa8N9yQeGUU=
X-Received: by 2002:a05:600c:3e10:b0:483:badb:618f with SMTP id 5b1f17b1804b1-4854b11694dmr102507205e9.25.1773329725049;
        Thu, 12 Mar 2026 08:35:25 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm246968205e9.4.2026.03.12.08.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:35:24 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/11] clk: renesas: r9a09g047: Add USB3.0 clocks/resets
Date: Thu, 12 Mar 2026 15:35:07 +0000
Message-ID: <20260312153522.1131675-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 15:35:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22358

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 82e0aa95ec8cec76bec23146ad8effb5a09e6e92 ]

Add USB3.0 clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250909180803.140939-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a09g047-cpg.c
index c791b3d47f16..b112e436433a 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -16,7 +16,7 @@
 
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
-	LAST_DT_CORE_CLK = R9A09G047_GBETH_1_CLK_PTP_REF_I,
+	LAST_DT_CORE_CLK = R9A09G047_USB3_0_CLKCORE,
 
 	/* External Input Clocks */
 	CLK_AUDIO_EXTAL,
@@ -187,6 +187,8 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __initconst = {
 		  CLK_PLLETH_DIV_125_FIX, 1, 1),
 	DEF_FIXED("gbeth_1_clk_ptp_ref_i", R9A09G047_GBETH_1_CLK_PTP_REF_I,
 		  CLK_PLLETH_DIV_125_FIX, 1, 1),
+	DEF_FIXED("usb3_0_ref_alt_clk_p", R9A09G047_USB3_0_REF_ALT_CLK_P, CLK_QEXTAL, 1, 1),
+	DEF_FIXED("usb3_0_core_clk", R9A09G047_USB3_0_CLKCORE, CLK_QEXTAL, 1, 1),
 };
 
 static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst = {
@@ -378,6 +380,10 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst = {
 						BUS_MSTOP(8, BIT(4))),
 	DEF_MOD("sdhi_2_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 14, 5, 14,
 						BUS_MSTOP(8, BIT(4))),
+	DEF_MOD("usb3_0_aclk",			CLK_PLLDTY_DIV8, 10, 15, 5, 15,
+						BUS_MSTOP(7, BIT(12))),
+	DEF_MOD("usb3_0_pclk_usbtst",		CLK_PLLDTY_ACPU_DIV4, 11, 0, 5, 16,
+						BUS_MSTOP(7, BIT(14))),
 	DEF_MOD_MUX_EXTERNAL("gbeth_0_clk_tx_i", CLK_SMUX2_GBE0_TXCLK, 11, 8, 5, 24,
 						BUS_MSTOP(8, BIT(5)), 1),
 	DEF_MOD_MUX_EXTERNAL("gbeth_0_clk_rx_i", CLK_SMUX2_GBE0_RXCLK, 11, 9, 5, 25,
@@ -470,6 +476,7 @@ static const struct rzv2h_reset r9a09g047_resets[] __initconst = {
 	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
 	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
 	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
+	DEF_RST(10, 10, 4, 27),		/* USB3_0_ARESETN */
 	DEF_RST(11, 0, 5, 1),		/* GBETH_0_ARESETN_I */
 	DEF_RST(11, 1, 5, 2),		/* GBETH_1_ARESETN_I */
 	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
-- 
2.43.0


