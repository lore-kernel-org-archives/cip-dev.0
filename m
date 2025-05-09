Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFAAC3ABCB
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:23 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.10322.1746783139564289610
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=U9UNhwfN;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5fc7edf00b2so2352813a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783138; x=1747387938; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0rPrF1Xp7Sj94nl1jmUvelkvR9t+xR4tInzpWBmp1Y=;
        b=U9UNhwfN+hWnw2/Pe2KVDzlczqxwJtDUKPJWw2wZHVAnmebnUNfHUJgZbvi9kXREC1
         oBcJSJy7yZfaiLsn+1sheF8iIspAO+ds9isz5hDRjfs1uU8EKLrcVJyTaCO+qVq3A10e
         mwFy/8axTawRVnWEXB/daqX8WpTWzvwKLrDztGDQZaA7Amd5XdLOytczyYAlZo9BforB
         mZ+QreGlKbmiFcUYWoMtUfYXduqv2bp8ZFiL+e/jK6WrNromCIxJbv23lo+yPGb+PJ7J
         BiNPtA1exl3LZEjryf86QXPSuN1sY1ercHcxH+6C/su0jXiHjDukjKELLcCMEUFImFvF
         1UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783138; x=1747387938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0rPrF1Xp7Sj94nl1jmUvelkvR9t+xR4tInzpWBmp1Y=;
        b=Ijo0wsra5XhubAobIgoABxTrgVYQ4rXDHDNMNocZaacBVdt4dJbsMAyD1L+GUixurj
         EEmDjWfOZ6EnZv9B1Dpd+svc2Je+byqIx0XkU2w/y3WdtlRiwgjuwXLwefdAiJ3x0Eyu
         CIEyOt3l96mnBR6jFMsyeWiZeVB8ZtgwEPt1mu6cUnAY+4QEios+cHMwzlWy8lhvcCv7
         WDkHXTmDuGGTW43ZeDr6F1yLVw07HnuJqwU37A/8DMShEsqduAksPkfCM6UTxTh8P3gv
         Fdi+ZqEj9fGpBCok/F2ixbpJf9lOxio03ZSPWgfaknBxQc0HtC6mz7Zd7ScyU9MmG6TU
         +kvA==
X-Forwarded-Encrypted: i=1; AJvYcCXrTfdVYVdlQnTuEPZCdcYX1S3yucRvfShlz93Zx8k1Iaoinb/V0VCq6yT/MwCGj7Po55rc3vL9@lists.cip-project.org
X-Gm-Message-State: AOJu0YzgJ4+mTn3zPhDu5K89lcPUCXxVxk6M0S3gABtSYX2sIeSiL83B
	3EotvI4Kh/6CmULsP59JHg41iNY+c9H7Sy1LOucHj9fup8ECA6HqrB6a6YHbDR8=
X-Gm-Gg: ASbGncvY2y0aNpG1aeWijQSk3Eu+u6V0AKmHInnIM+lbb3vnAnNUM3sc2CKayCjlAcz
	drOre1rBhguox2ZdDCs76fb2w5a3YxS0pgDybx04/xY0//y/3xCCPDGGkwr9DCrxq3khb3keT1M
	kuWH1bSqs9/sKdE3wSfgqZpbCRrO3dfXiniFdlMfTIdiSWW0I5/VArFYk35oy/mW1xMt8V9nY6Z
	zHr39QWzxw8i5eQ1mi107WWh8EHNukZj+xNNWovJ87xUozpIMN0EFnthqrdr6i3Zfx5nO6Vg4Ns
	bO9P1mQ2EZVZt4rJaE9UxNcjkuG2Xyt9n829r11jFJ68aEzKaHuY1HPJ3zKxn9zPUuvcK2tI4fD
	Y1oSl
X-Google-Smtp-Source: AGHT+IG5O5AJ5m/vmYFnQjw32zDIbWJ0KNR0D3xQyzyyEQtDqOIlrVpgEff0P1+dr+rzOrORVFt1Jw==
X-Received: by 2002:a05:6402:5187:b0:5f5:6299:ad68 with SMTP id 4fb4d7f45d1cf-5fca0759ac0mr2007453a12.11.1746783137902;
        Fri, 09 May 2025 02:32:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 10/29] ASoC: renesas: rz-ssi: Remove pdev member of struct rz_ssi_priv
Date: Fri,  9 May 2025 12:31:44 +0300
Message-ID: <20250509093203.4014750-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18797

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a73710a25808a585a2bf0a8325eb16fd6a2f370c upstream.

Remove the pdev member of struct rz_ssi_priv as it is not used.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-8-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 97147faa6b2f..bcb9656853d5 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -99,7 +99,6 @@ struct rz_ssi_stream {
 
 struct rz_ssi_priv {
 	void __iomem *base;
-	struct platform_device *pdev;
 	struct reset_control *rstc;
 	struct device *dev;
 	struct clk *sfr_clk;
@@ -1047,7 +1046,6 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	if (!ssi)
 		return -ENOMEM;
 
-	ssi->pdev = pdev;
 	ssi->dev = &pdev->dev;
 	ssi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ssi->base))
-- 
2.43.0


