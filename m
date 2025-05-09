Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E607C3ABCB
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:25 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web10.10422.1746783319842598206
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=OaINrIhx;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so269385866b.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783318; x=1747388118; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQLXyNukyIBI9I/zWyAo2drDeTXXERid8JiX+hrrqa0=;
        b=OaINrIhxZwWLIEFNrLw6DiFsQ1M6XUzKCFJKu85U/o4uEMorchlBZllxWPvnBClQY2
         s1JEAoHOhUncfGFpjgzDxubiFA4BzNVt+l1cgA2Kaw6iJHdZ8TAL3gp1FTl91R8xMozP
         mapHLVZW68g6wz5cTTdWybD6ZiieMBTmn8ZNj9i/Khsckmm+VkZD1Zyk/L3SPFHdwh2p
         +7kgVHD/tLXVHUkXM24RxCtDXt1kkNIIZpKhXUQz1k6AZbzjmkx9DXpNLgTk6WLDq3f9
         U2Eorsmb3U0gC18r94p30PZ+f9oEdmT/8kfWFpBe3b9B1IqCPqmFhzLkFpbtMhxt6Ccv
         enFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783318; x=1747388118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQLXyNukyIBI9I/zWyAo2drDeTXXERid8JiX+hrrqa0=;
        b=MklluYjZnD1VcPf03hTndbtwpXcAgJpvwT8grAy9wN2DuZ4xYHY6gA3eXVymESEVQl
         y8X6Aa05Ur6guMua9tk9OgthuUy/20NLLbRH+s0GJZZpArMHcWLxGncpnx/yojRzDSTd
         p4o3bbn/2zPX9OHetlYxVyqysN0phWYOy7BBCX+kxOCriTelOm3d7cAX74mxZd+kvygd
         ruL4iZNzmCuBTxXLZVzzr7KbxWvK1EmqOGfhp6b9BPZJNNChM25hSYhYnudZGsB0GGfT
         PLSEstPajxFuI2qQwqZfRIRGbeEO9ABuREkZyuBK6rE1txddFRysII3zwusTX4hSWIqo
         0cLw==
X-Forwarded-Encrypted: i=1; AJvYcCUMv7l44VYI45HLvQeQQXpWFxf51LQ3LQVsRz5v+d3iCtT7KCckNO6sHfnBAzx+OrQxp12oE9ql@lists.cip-project.org
X-Gm-Message-State: AOJu0YyVVYd0o8QSmzBe6qc5eCa4N9xMC2GxjrMWztV/mz42YpuR58cv
	8DRUl2AIGStjwXpC99jAfMPg5TEcDZ39FNlFI6ao08kTnG0PW2CJYsGQyWB1PQdWBQ9tvsnbkFU
	f
X-Gm-Gg: ASbGnctvOQqU8PL3hZipI91l+E7XlAvbj9Vi0wymvJoS4VJ3eCJZx9gsLPdi7vS3ZGd
	c+zbZQH89tWZiGC85IwGIdgX5otCiLesCH7CzsYQl0LQwCQE4RtD0Ui7OkRnLQSBNC33buX1r6K
	aXENbqRdQ9S09f+L9QDVhRiC9SVzP0xsJqDAyZ8LiXP20hP0oG7VnV6Y+pOWVIiqZhtWsgRKL2h
	2DlmJ4UIxOe49nWvw6lrqWFJ7QNBLavv5WuavYcvej105VFffo7vJjvZpD7OFmxaU03gk8d6e0h
	CrFcD4o0RfMSvXgDqfhvjz+afmPCmZHFtxfgxQ3vwVX0aNDNEUP1OqpbK+z+kMCblwl7YQ==
X-Google-Smtp-Source: AGHT+IHJcYsNZn1ora15faLNEh6IniOaZCyDqZG5/bwg34tsNE/WeLZGwf0TkLpJ4hC5oKRJE3hs8A==
X-Received: by 2002:a17:907:3f20:b0:ac7:c7cd:ac39 with SMTP id a640c23a62f3a-ad218f0f2eamr279536666b.24.1746783318233;
        Fri, 09 May 2025 02:35:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 24/37] ASoC: renesas: rz-ssi: Rely on the ASoC subsystem to runtime resume/suspend the SSI
Date: Fri,  9 May 2025 12:34:29 +0300
Message-ID: <20250509093442.4015145-25-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18876

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e8fcf25f562891d5c0734d4f49c44bb6aa72bc15 upstream.

The ASoC subsystem takes care of runtime resume/suspend the audio
devices when needed. Just enable the runtime PM on the SSI driver and
let the subsystem runtime resume/suspend it. While at it use directly
the devm_pm_runtime_enable().

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-14-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 042ecd20006c..64b1c47375e3 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1149,11 +1149,10 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	}
 
 	reset_control_deassert(ssi->rstc);
-	pm_runtime_enable(dev);
-	ret = pm_runtime_resume_and_get(dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret < 0) {
-		dev_err(dev, "pm_runtime_resume_and_get failed\n");
-		goto err_pm;
+		dev_err(dev, "Failed to enable runtime PM!\n");
+		goto err_reset;
 	}
 
 	ret = devm_snd_soc_register_component(dev, &rz_ssi_soc_component,
@@ -1161,15 +1160,12 @@ static int rz_ssi_probe(struct platform_device *pdev)
 					      ARRAY_SIZE(rz_ssi_soc_dai));
 	if (ret < 0) {
 		dev_err(dev, "failed to register snd component\n");
-		goto err_pm_put;
+		goto err_reset;
 	}
 
 	return 0;
 
-err_pm_put:
-	pm_runtime_put(dev);
-err_pm:
-	pm_runtime_disable(dev);
+err_reset:
 	reset_control_assert(ssi->rstc);
 err_release_dma_chs:
 	rz_ssi_release_dma_channels(ssi);
@@ -1183,8 +1179,6 @@ static int rz_ssi_remove(struct platform_device *pdev)
 
 	rz_ssi_release_dma_channels(ssi);
 
-	pm_runtime_put(ssi->dev);
-	pm_runtime_disable(ssi->dev);
 	reset_control_assert(ssi->rstc);
 
 	return 0;
-- 
2.43.0


