Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA7FD5B16E
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 12:53:25 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47619.1765803200560797884
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 04:53:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gOb5xawJ;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso2038543f8f.3
        for <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 04:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765803199; x=1766407999; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R12dSYZvC9sz7RhZcWtm5kZdAR8sqtd/PybNROXWq2o=;
        b=gOb5xawJwL6cxm2VSiWL/0E5pani4/bEd3nDkn1amriAp1k0kG6rqAYbXU+2/BaTnJ
         apgd7x9EO2BoUtrapZ1uwP8sxhxziE+H232CLFhNjR3A39LyOfth1Ymu37oxeaKQuDbb
         zw4n0xkYHcGrQwiJM6qP6nUM05HoBHwrCBBEWNYInE/QuKR6Qmt9w5OAcKLQF2spn1Rh
         m14gsuYqWRbKFTbHqb7OgZGexX/Emi0mf3QYGCZHPGkRGNzVPrnrOC7TgaYiY3mIyHCD
         d3yR3L6cCEw1rWTjQWjZaGVXbhG+LFBDHiKl5bAqJNGOthK0O79lF1//a9pCB5Y/zB1S
         rSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765803199; x=1766407999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R12dSYZvC9sz7RhZcWtm5kZdAR8sqtd/PybNROXWq2o=;
        b=qv/JwnnqsUIVihOwgIshcIzHT1GJ4USVhkLo0OTnRdbIy2sTbc6CCYeqUXqPkPaoeg
         E0KarPLNQF+Svmc1ati6MGoVnqSvRSKsPc63RztU9HP0E/fraFXnrGnNMtOBzB0kVFlO
         KIodQmm1e5A1qWrv079aZ8amdi2gpZkr470No2l8noQYmzNMFfcNW1/iYLc9dKcUsAzo
         fRsTDRaoIDfwH0Z8vzj+yGm9wVe90VXx9WNLdSqg1lYGM+bIG5ZZnLDbg+2cwcWjS87y
         ENZP+Kh6HWFhOnQDsAdPp/jYXUs2Ul/IlqMgIRb3b8DdqbgYfhpR23Df3WkEDJUWz3+0
         ySow==
X-Gm-Message-State: AOJu0YxTOdTbNEYnUpNW2SGxR3r9Uvcktr669f0f2EgdZF2XRTz4xxRk
	9OnjTDmK9oCQZhA3WlFVyMMLknYB1ZJL80u62ENBa2WKHPEd9wkkcTp12EexRg==
X-Gm-Gg: AY/fxX5YzSBwVHCznr0K8amfaBFRos7D5cVCQYsQ77w1DT67D+9n8XHgSiJwzrx+lZO
	7sFFoiEP0wAJyDkdUzrOeESlp49vMdsKe7RIvDEugZZf//txp5EcW0tAkVD+O9ZBNwnmMHq2Jr6
	DDxL847tNzu1kUN+gM1RC2J8LxQjNlFvQ1Ytn66+VJ+S32h/+5aPJj2cSxrUMXMJc/B9Kfq+fda
	J9aFq9cNI3ZP6Lr/QUsZZEsU9MSDe/ZqIykr5w6j446+YHLhgMzqbXNSKhiAR/bGdL2KkGrWiZa
	Vwq7BNzn8+ptWjD7HUAZU7NUj0QHcy+OGVl1xmWq22aKj5VTs8TiZeIDBDZd0CTQ155Jl3oBlsS
	FtC1Cw4xP4TldbbxlwFE7SEQlzomASAofR7m2CfYIZB2F5wGYvsJ3Nrjk0oV3yZQ49GMUFObx24
	uYrZNo2XQuRRILQfcAFUZAXpuHfCopC7VKd3E=
X-Google-Smtp-Source: AGHT+IGWwdScCPYLRFCt+MaQx/HUwuKRam6VuvP/QSF1vALh9UD024zfPx+0JO9Uk/o/Fy7uEpKVhQ==
X-Received: by 2002:a05:6000:2f83:b0:42b:4233:1d6 with SMTP id ffacd0b85a97d-42fb46e48b3mr9814847f8f.34.1765803198612;
        Mon, 15 Dec 2025 04:53:18 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:73b2:9197:2aa3:716f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f268d459sm13820577f8f.32.2025.12.15.04.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 04:53:18 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/3] mmc: renesas_sdhi: Enable 64-bit polling mode
Date: Mon, 15 Dec 2025 12:53:01 +0000
Message-ID: <20251215125316.137879-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215125316.137879-1-biju.das.jz@bp.renesas.com>
References: <20251215125316.137879-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 12:53:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21058

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 709fe7aa5aaf8047b528561a0082db8a3a29010c ]

Enable 64-bit polling mode for R-Car gen3 and RZ/G2L SoCs.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250730164618.233117-3-biju.das.jz@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index c6ddfe8215c7..17d693ba90b1 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -109,7 +109,8 @@ static const struct renesas_sdhi_of_data of_rza2_compatible = {
 
 static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
-			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
+			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
+			  TMIO_MMC_64BIT_DATA_PORT,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
-- 
2.43.0


