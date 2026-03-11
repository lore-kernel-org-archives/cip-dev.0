Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F19104BEDB
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:17 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17318.1773223502746005610
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iTeDjJzB;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439baf33150so692815f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223501; x=1773828301; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxCeIhaTL97e0F40IJFds4s8ySSRnlrm9C9A6LIY3kI=;
        b=iTeDjJzBTxRKxORrIRrPz1+bYpx6pW7GDjA3Y3f2Oq4kA85H0bL97XYl2/4UIkWj7R
         jSROS6VfauYZWo5iGxNzYXve/lWJ+kjWp3cecd78PPXn70ooSdgMAblKmkqaZ0pJ1Ee+
         vHZpLLs843cYfyAev/ub7cWuaKSxY9UOKNtljFBsZ3uZxwLSHj8UWWfQCvtx3nTte3Du
         pgpABaB6+4I9ZB1vkLdOQmF5XdigeAGsEc2LSx0I9+1JFfuC6YekZfLhZ4sGsXYfpKLA
         yh17dyjoNwaCBT+ETxVJ/6wYeSflfTbrrHf+1a94EfxpKiub5J7w3I/YqABmDHV3mbTg
         ppLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223501; x=1773828301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lxCeIhaTL97e0F40IJFds4s8ySSRnlrm9C9A6LIY3kI=;
        b=Wc9GNnZsMWHzRuOh//w7DnxAD6D70/cnj/msdnAM7RkACK69fOUMru06tzwTpvZSjv
         h5kOoMMXnh0bJnuM8w/9JNjlAm1UyLMBA570NtEdXSdS5hrMy1K4dSCTVWCYp75h06ni
         x4C8NQDKU2ZBxy+FSLDqMGyF4WKUaVHy8AVyqkxxgxE1jz4ptFvmuCPOTxR7RF+cU34g
         /TIwfCN0bNcLTbhRtAT0L/3ET2WAlWLnng90rDed9+7H2b8VC5fjRDbRLTe8PlGfq+UX
         Z6zSAG4VKE0j2YonqvcMIC0kfsDOO4iFMlVLY9182VAxN0rndMH5K4oz8A4lFYNYtoGM
         kLyQ==
X-Gm-Message-State: AOJu0Yy2zyYM+11w+BqgZQ2aHbAXojmfYAzjw4wnwV+5Lh+5VuwhOcx4
	O/GUXoBB65GtUJHcjT7jIrmwTv0WbUUXJxK+7JP4J7mT2qCHwB40xnzjX5bt0A==
X-Gm-Gg: ATEYQzzlRos9j+EKCzN0KTpHgmf8UFtzMeG6C8MZmAxQzTY/Ey/flI8UmfG/lWW2Di4
	zmAth8bino05CUDoNrj95NNQWfEpNLQkdIKPJV/X5mYbcxePhKuMIkOdgN5OCOFSow5BJYb571l
	jOVnQGCfiZKZJp61C7+kyOa3aYzill+IcNm1s3nGXTeyNEp4Jt6hwto4VLOWnzMAQUOg66LTA8v
	N3Z6ZFrEejtKgHZ15x/7UYxG3FGVvJwX4qltoGRjLQeFy3v2RhC2nrC+YDH47k7XaYHbwt4C3gX
	wAvsgiE8vdKIBQhH+HT2XOiLAKieUjYxcgxba9NKZePKQVivAcnFcxtWKCIGZcgR9iKifpLvhuQ
	Q+s50db0unCHxevKgsvcUty0aj6kyJJZdPBO37j3jjx0l66ZtAyEfuRWPQeQN3l0SspEviKOCNd
	EIDsEI0E+kvSkKu60+dHZ4xr6KBqEhC90=
X-Received: by 2002:a05:6000:2584:b0:439:d084:9e48 with SMTP id ffacd0b85a97d-439eff12b5fmr12000616f8f.5.1773223500759;
        Wed, 11 Mar 2026 03:05:00 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:00 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 03/27] clk: renesas: r9a09g047: Add RSCI clocks/resets
Date: Wed, 11 Mar 2026 10:04:22 +0000
Message-ID: <20260311100458.162447-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22249

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit c6b63d54c6f8d81e72c8b9b8e8d1cb5ada03c5dd ]

Add RSCI clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251027154615.115759-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 126 ++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a09g047-cpg.c
index 4e8881e0006b..c791b3d47f16 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -44,6 +44,9 @@ enum clk_ids {
 	CLK_PLLCLN_DIV8,
 	CLK_PLLCLN_DIV16,
 	CLK_PLLCLN_DIV20,
+	CLK_PLLCLN_DIV64,
+	CLK_PLLCLN_DIV256,
+	CLK_PLLCLN_DIV1024,
 	CLK_PLLDTY_ACPU,
 	CLK_PLLDTY_ACPU_DIV2,
 	CLK_PLLDTY_ACPU_DIV4,
@@ -142,6 +145,9 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __initconst = {
 	DEF_FIXED(".pllcln_div8", CLK_PLLCLN_DIV8, CLK_PLLCLN, 1, 8),
 	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
 	DEF_FIXED(".pllcln_div20", CLK_PLLCLN_DIV20, CLK_PLLCLN, 1, 20),
+	DEF_FIXED(".pllcln_div64", CLK_PLLCLN_DIV64, CLK_PLLCLN, 1, 64),
+	DEF_FIXED(".pllcln_div256", CLK_PLLCLN_DIV256, CLK_PLLCLN, 1, 256),
+	DEF_FIXED(".pllcln_div1024", CLK_PLLCLN_DIV1024, CLK_PLLCLN, 1, 1024),
 
 	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dtable_2_64),
 	DEF_FIXED(".plldty_acpu_div2", CLK_PLLDTY_ACPU_DIV2, CLK_PLLDTY_ACPU, 1, 2),
@@ -210,6 +216,106 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst = {
 						BUS_MSTOP(5, BIT(13))),
 	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18,
 						BUS_MSTOP(5, BIT(13))),
+	DEF_MOD("rsci0_pclk",			CLK_PLLCLN_DIV16, 5, 13, 2, 29,
+						BUS_MSTOP(11, BIT(3))),
+	DEF_MOD("rsci0_tclk",			CLK_PLLCLN_DIV16, 5, 14, 2, 30,
+						BUS_MSTOP(11, BIT(3))),
+	DEF_MOD("rsci0_ps_ps3_n",		CLK_PLLCLN_DIV1024, 5, 15, 2, 31,
+						BUS_MSTOP(11, BIT(3))),
+	DEF_MOD("rsci0_ps_ps2_n",		CLK_PLLCLN_DIV256, 6, 0, 3, 0,
+						BUS_MSTOP(11, BIT(3))),
+	DEF_MOD("rsci0_ps_ps1_n",		CLK_PLLCLN_DIV64, 6, 1, 3, 1,
+						BUS_MSTOP(11, BIT(3))),
+	DEF_MOD("rsci1_pclk",			CLK_PLLCLN_DIV16, 6, 2, 3, 2,
+						BUS_MSTOP(11, BIT(4))),
+	DEF_MOD("rsci1_tclk",			CLK_PLLCLN_DIV16, 6, 3, 3, 3,
+						BUS_MSTOP(11, BIT(4))),
+	DEF_MOD("rsci1_ps_ps3_n",		CLK_PLLCLN_DIV1024, 6, 4, 3, 4,
+						BUS_MSTOP(11, BIT(4))),
+	DEF_MOD("rsci1_ps_ps2_n",		CLK_PLLCLN_DIV256, 6, 5, 3, 5,
+						BUS_MSTOP(11, BIT(4))),
+	DEF_MOD("rsci1_ps_ps1_n",		CLK_PLLCLN_DIV64, 6, 6, 3, 6,
+						BUS_MSTOP(11, BIT(4))),
+	DEF_MOD("rsci2_pclk",			CLK_PLLCLN_DIV16, 6, 7, 3, 7,
+						BUS_MSTOP(11, BIT(5))),
+	DEF_MOD("rsci2_tclk",			CLK_PLLCLN_DIV16, 6, 8, 3, 8,
+						BUS_MSTOP(11, BIT(5))),
+	DEF_MOD("rsci2_ps_ps3_n",		CLK_PLLCLN_DIV1024, 6, 9, 3, 9,
+						BUS_MSTOP(11, BIT(5))),
+	DEF_MOD("rsci2_ps_ps2_n",		CLK_PLLCLN_DIV256, 6, 10, 3, 10,
+						BUS_MSTOP(11, BIT(5))),
+	DEF_MOD("rsci2_ps_ps1_n",		CLK_PLLCLN_DIV64, 6, 11, 3, 11,
+						BUS_MSTOP(11, BIT(5))),
+	DEF_MOD("rsci3_pclk",			CLK_PLLCLN_DIV16, 6, 12, 3, 12,
+						BUS_MSTOP(11, BIT(6))),
+	DEF_MOD("rsci3_tclk",			CLK_PLLCLN_DIV16, 6, 13, 3, 13,
+						BUS_MSTOP(11, BIT(6))),
+	DEF_MOD("rsci3_ps_ps3_n",		CLK_PLLCLN_DIV1024, 6, 14, 3, 14,
+						BUS_MSTOP(11, BIT(6))),
+	DEF_MOD("rsci3_ps_ps2_n",		CLK_PLLCLN_DIV256, 6, 15, 3, 15,
+						BUS_MSTOP(11, BIT(6))),
+	DEF_MOD("rsci3_ps_ps1_n",		CLK_PLLCLN_DIV64, 7, 0, 3, 16,
+						BUS_MSTOP(11, BIT(6))),
+	DEF_MOD("rsci4_pclk",			CLK_PLLCLN_DIV16, 7, 1, 3, 17,
+						BUS_MSTOP(11, BIT(7))),
+	DEF_MOD("rsci4_tclk",			CLK_PLLCLN_DIV16, 7, 2, 3, 18,
+						BUS_MSTOP(11, BIT(7))),
+	DEF_MOD("rsci4_ps_ps3_n",		CLK_PLLCLN_DIV1024, 7, 3, 3, 19,
+						BUS_MSTOP(11, BIT(7))),
+	DEF_MOD("rsci4_ps_ps2_n",		CLK_PLLCLN_DIV256, 7, 4, 3, 20,
+						BUS_MSTOP(11, BIT(7))),
+	DEF_MOD("rsci4_ps_ps1_n",		CLK_PLLCLN_DIV64, 7, 5, 3, 21,
+						BUS_MSTOP(11, BIT(7))),
+	DEF_MOD("rsci5_pclk",			CLK_PLLCLN_DIV16, 7, 6, 3, 22,
+						BUS_MSTOP(11, BIT(8))),
+	DEF_MOD("rsci5_tclk",			CLK_PLLCLN_DIV16, 7, 7, 3, 23,
+						BUS_MSTOP(11, BIT(8))),
+	DEF_MOD("rsci5_ps_ps3_n",		CLK_PLLCLN_DIV1024, 7, 8, 3, 24,
+						BUS_MSTOP(11, BIT(8))),
+	DEF_MOD("rsci5_ps_ps2_n",		CLK_PLLCLN_DIV256, 7, 9, 3, 25,
+						BUS_MSTOP(11, BIT(8))),
+	DEF_MOD("rsci5_ps_ps1_n",		CLK_PLLCLN_DIV64, 7, 10, 3, 26,
+						BUS_MSTOP(11, BIT(8))),
+	DEF_MOD("rsci6_pclk",			CLK_PLLCLN_DIV16, 7, 11, 3, 27,
+						BUS_MSTOP(11, BIT(9))),
+	DEF_MOD("rsci6_tclk",			CLK_PLLCLN_DIV16, 7, 12, 3, 28,
+						BUS_MSTOP(11, BIT(9))),
+	DEF_MOD("rsci6_ps_ps3_n",		CLK_PLLCLN_DIV1024, 7, 13, 3, 29,
+						BUS_MSTOP(11, BIT(9))),
+	DEF_MOD("rsci6_ps_ps2_n",		CLK_PLLCLN_DIV256, 7, 14, 3, 30,
+						BUS_MSTOP(11, BIT(9))),
+	DEF_MOD("rsci6_ps_ps1_n",		CLK_PLLCLN_DIV64, 7, 15, 3, 31,
+						BUS_MSTOP(11, BIT(9))),
+	DEF_MOD("rsci7_pclk",			CLK_PLLCLN_DIV16, 8, 0, 4, 0,
+						BUS_MSTOP(11, BIT(10))),
+	DEF_MOD("rsci7_tclk",			CLK_PLLCLN_DIV16, 8, 1, 4, 1,
+						BUS_MSTOP(11, BIT(10))),
+	DEF_MOD("rsci7_ps_ps3_n",		CLK_PLLCLN_DIV1024, 8, 2, 4, 2,
+						BUS_MSTOP(11, BIT(10))),
+	DEF_MOD("rsci7_ps_ps2_n",		CLK_PLLCLN_DIV256, 8, 3, 4, 3,
+						BUS_MSTOP(11, BIT(10))),
+	DEF_MOD("rsci7_ps_ps1_n",		CLK_PLLCLN_DIV64, 8, 4, 4, 4,
+						BUS_MSTOP(11, BIT(10))),
+	DEF_MOD("rsci8_pclk",			CLK_PLLCLN_DIV16, 8, 5, 4, 5,
+						BUS_MSTOP(11, BIT(11))),
+	DEF_MOD("rsci8_tclk",			CLK_PLLCLN_DIV16, 8, 6, 4, 6,
+						BUS_MSTOP(11, BIT(11))),
+	DEF_MOD("rsci8_ps_ps3_n",		CLK_PLLCLN_DIV1024, 8, 7, 4, 7,
+						BUS_MSTOP(11, BIT(11))),
+	DEF_MOD("rsci8_ps_ps2_n",		CLK_PLLCLN_DIV256, 8, 8, 4, 8,
+						BUS_MSTOP(11, BIT(11))),
+	DEF_MOD("rsci8_ps_ps1_n",		CLK_PLLCLN_DIV64, 8, 9, 4, 9,
+						BUS_MSTOP(11, BIT(11))),
+	DEF_MOD("rsci9_pclk",			CLK_PLLCLN_DIV16, 8, 10, 4, 10,
+						BUS_MSTOP(11, BIT(12))),
+	DEF_MOD("rsci9_tclk",			CLK_PLLCLN_DIV16, 8, 11, 4, 11,
+						BUS_MSTOP(11, BIT(12))),
+	DEF_MOD("rsci9_ps_ps3_n",		CLK_PLLCLN_DIV1024, 8, 12, 4, 12,
+						BUS_MSTOP(11, BIT(12))),
+	DEF_MOD("rsci9_ps_ps2_n",		CLK_PLLCLN_DIV256, 8, 13, 4, 13,
+						BUS_MSTOP(11, BIT(12))),
+	DEF_MOD("rsci9_ps_ps1_n",		CLK_PLLCLN_DIV64, 8, 14, 4, 14,
+						BUS_MSTOP(11, BIT(12))),
 	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
 						BUS_MSTOP(3, BIT(14))),
 	DEF_MOD("i3c_0_pclkrw",			CLK_PLLCLN_DIV16, 9, 0, 4, 16,
@@ -325,6 +431,26 @@ static const struct rzv2h_reset r9a09g047_resets[] __initconst = {
 	DEF_RST(7, 6, 3, 7),		/* WDT_1_RESET */
 	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
 	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
+	DEF_RST(8, 1, 3, 18),		/* RSCI0_PRESETN */
+	DEF_RST(8, 2, 3, 19),		/* RSCI0_TRESETN */
+	DEF_RST(8, 3, 3, 20),		/* RSCI1_PRESETN */
+	DEF_RST(8, 4, 3, 21),		/* RSCI1_TRESETN */
+	DEF_RST(8, 5, 3, 22),		/* RSCI2_PRESETN */
+	DEF_RST(8, 6, 3, 23),		/* RSCI2_TRESETN */
+	DEF_RST(8, 7, 3, 24),		/* RSCI3_PRESETN */
+	DEF_RST(8, 8, 3, 25),		/* RSCI3_TRESETN */
+	DEF_RST(8, 9, 3, 26),		/* RSCI4_PRESETN */
+	DEF_RST(8, 10, 3, 27),		/* RSCI4_TRESETN */
+	DEF_RST(8, 11, 3, 28),		/* RSCI5_PRESETN */
+	DEF_RST(8, 12, 3, 29),		/* RSCI5_TRESETN */
+	DEF_RST(8, 13, 3, 30),		/* RSCI6_PRESETN */
+	DEF_RST(8, 14, 3, 31),		/* RSCI6_TRESETN */
+	DEF_RST(8, 15, 4, 0),		/* RSCI7_PRESETN */
+	DEF_RST(9, 0, 4, 1),		/* RSCI7_TRESETN */
+	DEF_RST(9, 1, 4, 2),		/* RSCI8_PRESETN */
+	DEF_RST(9, 2, 4, 3),		/* RSCI8_TRESETN */
+	DEF_RST(9, 3, 4, 4),		/* RSCI9_PRESETN */
+	DEF_RST(9, 4, 4, 5),		/* RSCI9_TRESETN */
 	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
 	DEF_RST(9, 6, 4, 7),		/* I3C_0_PRESETN */
 	DEF_RST(9, 7, 4, 8),		/* I3C_0_TRESETN */
-- 
2.43.0


