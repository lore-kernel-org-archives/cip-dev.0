Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4219DC41513
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:00 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web11.18415.1713526735005983210
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:38:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=V8nOXW7r;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e4a148aeeso871521a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526733; x=1714131533; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXqYr5ZuKUQXxTAfuTtg9D0Uff2e9IEyxaEHNRITfj4=;
        b=V8nOXW7rbpgLJhHKiTuIB0Ov/qLGS6BzscbmlEwSAKzQ6eRNtkNtznvOGiaj3baHrA
         bkmsJ7fmTYH6ucYBar3SvOXGryj5yKJkE64LHpBt7RSkjwUAA/kxlKHLmNPxZzGyhsvz
         HqdlXszwJ0E4U8FDj2I491TdyaSFa9PmU6fdKVqkUonJdXDCysLQYa0DET2YE+A2dky/
         KIemN/EOl2LKe2bcNHnxJkmlyKDMF17KsAow/O5GfZqpr5yObOVXX3+9+nVhjinnxMDt
         XGCBs6R/WVKML3Ixz7Nslq9MrN+d5jxS9ZH7unD6s0o3dNs98nP+cDXzTWqXlkrASA9H
         YThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526733; x=1714131533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXqYr5ZuKUQXxTAfuTtg9D0Uff2e9IEyxaEHNRITfj4=;
        b=diVdc0/ut7hoBHZ+rf1PWQfgd4EKmNGNGGLjnLkJD3p0hs7jZsUuofjBtlLyDNnMqf
         IoWoXrRVg9oSEngixcexxinsOaE6uHMFGCxMGAKD99Ns582O8VqxlzHaTQ46g5RlBnhM
         wqtCnHsvgVnWMW/6J88AWbvpYARwzgvxWG5989bQno6md83re1BALGLU00bSf0vinlsI
         zH+h6y1Ka9eVn28c/gkGQ1cOPvnsh8v1r9UjAQy6C4jqFJ2W5H+2eltAqxsx45gZsYRE
         S69AooDSUbeboFPqC6nENA84C4rGnrIih9mcl9zKKrkmzi29qtZugwWoyr1Gf/LDD6M8
         VFtA==
X-Gm-Message-State: AOJu0YzvvSrX3QcBEFaREZr6ib/AMmmDZW5dSIn7A29ZZHSejxeQ8ihI
	B5Qjy08nIwlWOk3idMAQXnvEG6ZUwNSFauQfEM1oCD5Asdqqfv2yL1+HsE33kH4=
X-Google-Smtp-Source: AGHT+IEnjpsiDIos36NuwGBqlbkWgZtYQ61BXO4mMAa62QTxKvpACu98jv77UuvDHztHEY80kPUyww==
X-Received: by 2002:a50:cd82:0:b0:56e:64b:8733 with SMTP id p2-20020a50cd82000000b0056e064b8733mr1474616edi.40.1713526733469;
        Fri, 19 Apr 2024 04:38:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:38:53 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 06/44] clk: renesas: rzg2l: Simplify .determine_rate()
Date: Fri, 19 Apr 2024 14:38:04 +0300
Message-Id: <20240419113842.3675543-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15657

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit bbceb13ce2c7b084bbbf2463ac8ac2b1f2bd2949 upstream.

rzg2l_cpg_sd_clk_mux_determine_rate() is the same as
__clk_mux_determine_rate_closest(), so use the latter to save some LoC.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/fed02e0325275df84e2d76f8c481e40e7023cbd9.1688760372.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index cf6337fa5e7a..43dcea9f7ed1 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -182,12 +182,6 @@ rzg2l_cpg_mux_clk_register(const struct cpg_core_clk *core,
 	return clk_hw->clk;
 }
 
-static int rzg2l_cpg_sd_clk_mux_determine_rate(struct clk_hw *hw,
-					       struct clk_rate_request *req)
-{
-	return clk_mux_determine_rate_flags(hw, req, CLK_MUX_ROUND_CLOSEST);
-}
-
 static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct sd_hw_data *hwdata = to_sd_hw_data(hw);
@@ -250,7 +244,7 @@ static u8 rzg2l_cpg_sd_clk_mux_get_parent(struct clk_hw *hw)
 }
 
 static const struct clk_ops rzg2l_cpg_sd_clk_mux_ops = {
-	.determine_rate = rzg2l_cpg_sd_clk_mux_determine_rate,
+	.determine_rate = __clk_mux_determine_rate_closest,
 	.set_parent	= rzg2l_cpg_sd_clk_mux_set_parent,
 	.get_parent	= rzg2l_cpg_sd_clk_mux_get_parent,
 };
-- 
2.39.2


