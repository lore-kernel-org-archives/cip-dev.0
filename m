Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2597C44507
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:56 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19077.1782820134823781837
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Rl/pQ7Ci;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4763b0c1dcdso222781f8f.2
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820133; x=1783424933; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I8M6VL17DeqUOpEJqmI6BiKIipai15iBl3EqWKrkkPE=;
        b=Rl/pQ7Ci8eYLoKgXa/DrLDUTWr1IlPCarbmUDwZ0f6kHLx3IgYPb/Ek2LPUqjso2Ad
         oddgIKFttzNx3CoKVrrH5RIoWEsmrt6RzDoZt6uZZlbkeOy0XYRCUGux4xHfa7NmhLRu
         cZ2RpPczPlU4DQ2PrFexbpFSLxZ9XT1ypagwzYW14ZDNKtVzczbiT8kHbqKO20dyLtot
         r3+OKhb0fFye8MDbDzM2o98k/+yX3QK0rTts3jOFYxuQaSSRc2yhS3/oYBsanXqfm4Hv
         eh1Pcq+jNqSL1DDZRAN2a9azrAqcLocVJLgUkPpgda6yV0NFLJEPLJeSiQc44cFVMgGz
         RzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820133; x=1783424933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I8M6VL17DeqUOpEJqmI6BiKIipai15iBl3EqWKrkkPE=;
        b=QyKH7T2/LPFgd1U0SnSwHQOZ5QJp2j1lb/vjmSb//mJHjQr4KHnRDPgud6xMUYRkXG
         UtatJa6piynzC6GNFXCKMRz2qsRts0/69Klyy8Ae46LEhF5MRWhF4Os/ogRW52ypJCCB
         T5n1ko9AHhNHe99SWRGk7/R2lW4SQh86U8kOcSGoYuEXhXqNAhnj0zBTqUVu2DZEPp4+
         cj/NZbBH//xpi9m3AQvN4jqBsldSGRSnVyEbORqUe8f+JT6hSL2pClvX9wXv4sVrEc1v
         ONlJt2vRef6U59DOtcVDLthAlbY/MyUrNd7os4XFUwFES1DDyzMd/u0bUVx1KKPJddQs
         1Xkg==
X-Gm-Message-State: AOJu0YwaDAzkfSY2Ek3bCf4K1LWW7Tq06Vh47+DezFMsFMoI3CDtMRBY
	A3wHiC6HP/uOSqAqKzYo//c+O0oAnEq6Tmnrn6RPE9glY1PhM1E4iLJ6KmqgQJRv
X-Gm-Gg: AfdE7cmMFcYxQ2aTNVILS+mOD+8MvWmW6WY5CThVdZDgXm+uVDspeZPT3TaCcjX2h+q
	NFNd1vpYSjpyB/SHyHLpII8zAErqwjoVc/VCKeQuHndiCJevTcxckPLfoKL6N5EgRWqrjh99uUc
	0Q6zC/0/y0k4W3v0fp01k0bC/wuUZ0iSfmpDh5WL9plmUNycx9JomlbdfZs06dorr5sSI/BuDCa
	RTTbU68lbYZVJqbWDMiIzdBxr3ZRhaIO3SpX1r3P1j9cyZ8WzVtruvD46F0087ni/0dxLAXWW1N
	hqrO4auSAhd0btBdGctJXzyJqNWofym+jPIBZFpWItjoKwmSGEElhBnhTWge/bSPMkFBac0y9v0
	7AcTWLOMO8Cp6uBCv0DfgoqDgD2e2yxhiksYS11Hom0+CR4ugzP3aDOdPqPRfc7b4BOw7s3H8Jt
	dwzHoSDvnYA2nLg5YC8vpvy2IdJKcqwXWAfeEnFg==
X-Received: by 2002:a05:6000:1866:b0:472:55a:ef90 with SMTP id ffacd0b85a97d-475506e9944mr4385267f8f.8.1782820132948;
        Tue, 30 Jun 2026 04:48:52 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:52 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 21/39] clk: renesas: rzg2l: Drop always-false check in rzg3s_cpg_pll_clk_recalc_rate()
Date: Tue, 30 Jun 2026 12:47:40 +0100
Message-ID: <20260630114813.92739-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23345

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 79b5d6970b4e5b7b7ee4d7fdb18e950086b72bde ]

Drop the unwanted check in rzg3s_cpg_pll_clk_recalc_rate() as the
function is SoC-specific.

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260326110648.29389-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 5ced73696efa..ac49eb8b4a30 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1108,9 +1108,6 @@ static unsigned long rzg3s_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 	u32 nir, nfr, mr, pr, val, setting;
 	u64 rate;
 
-	if (pll_clk->type != CLK_TYPE_G3S_PLL)
-		return parent_rate;
-
 	setting = GET_REG_SAMPLL_SETTING(pll_clk->conf);
 	if (setting) {
 		val = readl(priv->base + setting);
-- 
2.43.0


