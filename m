Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25499C44501
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:08 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19441.1782820142530976948
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:49:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=oYsd45Pc;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49270caa5c0so34739515e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820141; x=1783424941; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbX/K+tcZZ9DvnMUcqLbiUNQVe7XeloPVbtj7zc8a3U=;
        b=oYsd45PcRedksp2R7guNF9WvFt45vbuLVV170Oej7GcPOYc4cFaPTt1mFwbH7UKQ5I
         0m9clXG0u24cXJIRsJKIBU8Z4BSkRy2x40OLmfyJ/wj2/khByTGJUPyEgBw1bVurxJsV
         DZTLXX3xVoz4iVbBY7vzQQSgljdqnXGzRbCI26QGgsmnE2zzgokMVd6FiO0oOQKu+10d
         b2BFZP+1QwrCixPOSV6jSQRvPx3/CzLUxAAFkKPiDEodQ2/FNX8f9EyT3YlF/JVSB69P
         jERCfzh3yyYfDe2CENdyqiB/aNx3BkF+ciwUuM1inEkMtwettOGPaq/9hQbty9zUG060
         PJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820141; x=1783424941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TbX/K+tcZZ9DvnMUcqLbiUNQVe7XeloPVbtj7zc8a3U=;
        b=kYcGmWhQEQJL7LyZfIddokTMfhGejMJqdtzrEdr83CLor7g3VvZTn0n0dP0J/HiPh5
         ECw8Uz5fcb7J6S7CeUj3JUTEtHH5nfK+ixUbysXyyDQ5wd2YxLWsuE09IyUtxy1wIbeu
         5g7xyBgYzriYfRz8C4zfIWItaPYMlfTdJdRTNGP8PhFnhzhDnB8Iz69tv21WXHOXjTR6
         xyQFw60aaYGCLhT8/Nzd0l3Tmq9RDcdjQQ8BOpGEHMolIUS6a3b+UeInjM76Jfjq1izs
         UfTjDUSIY/PpMKa+v+ognEvzLFy0ZYL6bKvO86hXl1fMQ5fIVEHMkok/qP6LwqS8X82r
         W1fQ==
X-Gm-Message-State: AOJu0YwzvwnG9wTtEdwLAVMdmO1o5ptupJamevRj5ozbrv4SDhpX9725
	n90xhGO93iRG+1fr97ZV5JUmPafGr8DUiU1N4xWizz2rMeet7LEgcFbFR+x8UHrR
X-Gm-Gg: AfdE7cl4S41mSo6aCQTh0GhbTlWAofT5vIxJy94sKk5zsbqwKZh2K3LBDzg4j8ZSJit
	PJo5CGoraFUZ2s811yc07/GqL8Fk9IUKau+/tpuaYwE/3ZGS3fxT8ELcL2LBR47u3FtQ3cdgJZB
	DFZ5WWTCtvlCGyqn5+e3IYoQtgXZ3XAoVsLUikWO8b5X68BH/Jkb1FJIDxTnnREwoHYCHOaBMNI
	WGCOthqgeF3dJEnnuUmmIF3yIr+HHxFePUnAH2wPQJJCPez6yzs33bosRUqz0+BlPY22BQwsMJK
	+/lE3zr8f9KnqVF2EdjjeYyiwkYqDpLdjjGjbpCqmrrQMJx7Hm+71UT2Vi9tD4twH25YjCY31uw
	UlYXBBeACLXqGUHokVnAmlrzafxrKMFMi45aeOtYWCiSDxz4etsHTo5yIpy3zs2jXz2aA47Jwt2
	VsLP4wZoQWSqLdY/OgWjphZZ0ZZzBB1CiQplKEptg4Wfkon9fA
X-Received: by 2002:a05:600c:4745:b0:492:3316:4b34 with SMTP id 5b1f17b1804b1-493b827ea26mr46425955e9.2.1782820140707;
        Tue, 30 Jun 2026 04:49:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:49:00 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 32/39] clk: renesas: rzg2l: Refactor rzg3l_cpg_pll_clk_endisable()
Date: Tue, 30 Jun 2026 12:47:51 +0100
Message-ID: <20260630114813.92739-33-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23356

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 33cd08ac6200a8f96ff26183433affc10bead0ed ]

Reduce duplication by introducing mon_mask.
Eliminate an else branch by moving common parts into variable
pre-initializations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/9cda94b9b37c562a305f4dd6091fd71246764fd2.1777562043.git.geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 92b36c856f36..8d9cf13a1633 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1198,27 +1198,25 @@ static int rzg3l_cpg_pll_clk_endisable(struct clk_hw *hw, bool enable)
 {
 	struct pll_clk *pll_clk = to_pll(hw);
 	struct rzg2l_cpg_priv *priv = pll_clk->priv;
+	u32 mon_mask = RZG3L_PLL_MON_RESETB | RZG3L_PLL_MON_LOCK;
+	u32 val = RZG3L_PLL_STBY_RESETB_WEN;
 	u32 stby_offset, mon_offset;
-	u32 val, mon_val;
+	u32 mon_val = 0;
 	int ret;
 
 	stby_offset = RZG3L_PLL_STBY_OFFSET(pll_clk->conf);
 	mon_offset = RZG3L_PLL_MON_OFFSET(pll_clk->conf);
 
 	if (enable) {
-		val = RZG3L_PLL_STBY_RESETB_WEN | RZG3L_PLL_STBY_RESETB;
-		mon_val = RZG3L_PLL_MON_RESETB | RZG3L_PLL_MON_LOCK;
-	} else {
-		val = RZG3L_PLL_STBY_RESETB_WEN;
-		mon_val = 0;
+		val |= RZG3L_PLL_STBY_RESETB;
+		mon_val = mon_mask;
 	}
 
 	writel(val, priv->base + stby_offset);
 
 	/* ensure PLL is in normal/standby mode */
-	ret = readl_poll_timeout_atomic(priv->base + mon_offset, val, mon_val ==
-					(val & (RZG3L_PLL_MON_RESETB | RZG3L_PLL_MON_LOCK)),
-					10, 100);
+	ret = readl_poll_timeout_atomic(priv->base + mon_offset, val,
+					mon_val == (val & mon_mask), 10, 100);
 	if (ret)
 		dev_err(priv->dev, "Failed to %s PLL 0x%x/%pC\n", enable ?
 			"enable" : "disable", stby_offset, hw->clk);
-- 
2.43.0


