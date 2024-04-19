Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A36FC41513
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:41 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web11.18444.1713526772311557892
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=LtoiSaWI;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.172, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso25285591fa.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526770; x=1714131570; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcJWuRkl3T7hCk0NxoYG4mcVRvor24amnM7NWKQwTkc=;
        b=LtoiSaWISpGoyNhyw4Pp4eFsCvZiQoZRiR5XqXjz3X3Vmvvf7djjdolgt+k4DYeDmp
         96gTdhsjNnq1Y1hSOQa9G/E6aXAZwb/90vsutZjoF36P6xJ0cbgHWzjQQTlTRm539KUt
         o47AcQ6rkJnWAFLcN06RPfBV8v80bTlUGZGjH6t/+6O6e8TRycmz3XlgnFOCloF9BIhk
         j/AtPnxbHNSEO/n9OwRTg6cHFCT/bKa+Knhv9U3mTkufgqiaugVNl+DnUjzjY9w1D9TV
         BzRHCDydsQ8H6u6o2523l3PRsThlt5+2/U1ZoosDz7vAfoKtbIg2Fide8iSXZnMJLqcR
         FjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526770; x=1714131570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcJWuRkl3T7hCk0NxoYG4mcVRvor24amnM7NWKQwTkc=;
        b=AdL+AiKauINZ96ESDWq2Z2zd7PD48xZGfcKOfxf+Lc9K/9+8+7Upwq6WN29lZA+jBV
         APj6uAvZOD1YFw3IxICUghM38OQRpv4ne5lvRGn6iyFVxEMs78r/y3iiBFLvQl3C/UWa
         ZhU/eF7WRCxPsAdwfA4QwHk87mbPAHKQk8RcJF+bcRjBYLp/XrWr1HEnyqFR65T3WWbC
         syzbfOHNRAXVkbYji1hLr8DNP8XLSf0uw3dkAWQoyHAelx4QM8VmhfyqEvaLCQUNTZpO
         IIA+Q9JRmBYQyvl7dSuAzQ6RfhLGMa/1vZExx3OD+1fA5c6wMoXSW2I0dpJwnax41QiA
         PDtg==
X-Gm-Message-State: AOJu0YyJvsda65WZ7yw9D2wqe8w9AkkOD9WqC86Jy1RMcA37LJj91Uqj
	rXDGU5ugnxPYvclR+1j2LvYC6OhXlfn1J0geyvGbT7r0t8RlD/az9NdCZ7jT/Rc=
X-Google-Smtp-Source: AGHT+IHGr1E4UJiRtA2vHMLyIMOaQIMlq/atJ7hUK0Snb4bWPYTNoZbVl4rKpQAjdh6xqDQ0jzgegQ==
X-Received: by 2002:a2e:2e18:0:b0:2da:e75:e755 with SMTP id u24-20020a2e2e18000000b002da0e75e755mr1597864lju.8.1713526770591;
        Fri, 19 Apr 2024 04:39:30 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:30 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 31/44] dt-bindings: mmc: renesas,sdhi: Document RZ/G3S support
Date: Fri, 19 Apr 2024 14:38:29 +0300
Message-Id: <20240419113842.3675543-32-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15682

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 3b7eee6aae0b3212183fa63a4ae7887924218987 upstream.

Document support for the SD Card/MMC interface on the Renesas
RZ/G3S (R9A08G045) SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230912045157.177966-32-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[claudiu.beznea: fixed conflict with renesas,sdhi-r9a09g011]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 1b9cf33e2cf1..d71cc993d5f0 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -59,6 +59,7 @@ properties:
               - renesas,sdhi-r9a07g043 # RZ/G2UL
               - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
               - renesas,sdhi-r9a07g054 # RZ/V2L
+              - renesas,sdhi-r9a08g045 # RZ/G3S
               - renesas,sdhi-r9a09g011 # RZ/V2M
           - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
       - items:
@@ -121,6 +122,7 @@ allOf:
               - renesas,sdhi-r9a07g043
               - renesas,sdhi-r9a07g044
               - renesas,sdhi-r9a07g054
+              - renesas,sdhi-r9a08g045
     then:
       properties:
         clocks:
-- 
2.39.2


