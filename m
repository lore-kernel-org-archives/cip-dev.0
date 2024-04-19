Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93E8C071DB
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:07 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.15295.1713514685724273183
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=R3GI+NDC;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-571c22d9de4so1689078a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514684; x=1714119484; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXqYr5ZuKUQXxTAfuTtg9D0Uff2e9IEyxaEHNRITfj4=;
        b=R3GI+NDCgmBiimS06wVi/9Q9khxaUiXcPVNItHdvAv03MXsl0YF/oMAtwEleIjfRZT
         VRii2N1tR1wIg5AY3zr943JC3GDel5qZ/NrmtjXfXAkGLHTyFVRm4dT6WOKvRRmXVI6x
         M2Om3HUMSrr186g6Etf9hhXQAEUcU00Mx3/b1FR9ZzKgu9XhMfAodso5wLCD852efsge
         R9QvPwR7zeVLhlPpgImbnp0c/1bgTj9Bn5V7ReFFH1aIaqr1DSzT47mr2KeVFXU+c/1o
         7L++CETiSLhCbzc72pQaFbger0PULbsYo3KYfC1/2w3mDYBPi6crshBiDXPjyz5rP9/d
         NCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514684; x=1714119484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXqYr5ZuKUQXxTAfuTtg9D0Uff2e9IEyxaEHNRITfj4=;
        b=m76Jyz1/wydEbT1ckzbKz6ziM3tQxjMB0hXMA49GDrkJfpHNvbGy8J7IDVmKNTap/h
         yWBT2njnqpHmepWuiQ4tSLGPyOEo/YIUVJYT9KBVDiK0H7m5C9v4dz2ECGhqf5+RBUkz
         aUBAPQ0uEnfCh51wO5QX4Gy0AL2AiM/AFMQedMUSmmph8eszi+b7JlzwPbA3mFv1AS/S
         nuGX2o1TdX0tBxNKrO3GqM0zYjbjFpS43CHadmvZE36fceHJy8tVDCLesecki967X4e0
         5s8CJcRG97qBuRodyutFl/1hGYANRHZJhJckZjnKvqwYPtMXEVt7KT8oTzToWg1s8UrM
         ZsFQ==
X-Gm-Message-State: AOJu0YyQMciNY7q9T9jEJZJ/SSUVzoOnGk/Ku88XMfDdbWqk5sjoi4qF
	7yfG303+rXIilm5vtcsXU6jqQ/1Q4tGGmm6OOnGaR17J2RsY69pq26aUYEV1k8EWsqTUhmacx9d
	M
X-Google-Smtp-Source: AGHT+IHzDklpuS989L+SO6suE9CcC8qHA4UUBd+RHVEJHnxD+btNAR7yjlf8mlP2lO2y6oiB7bnibg==
X-Received: by 2002:a17:906:f90d:b0:a4e:6f0d:c53b with SMTP id lc13-20020a170906f90d00b00a4e6f0dc53bmr1034331ejb.35.1713514684062;
        Fri, 19 Apr 2024 01:18:04 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:03 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 13/53] clk: renesas: rzg2l: Simplify .determine_rate()
Date: Fri, 19 Apr 2024 11:17:02 +0300
Message-Id: <20240419081742.3496709-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15600

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


