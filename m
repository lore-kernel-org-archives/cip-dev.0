Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E553C071DB
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:48 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.15287.1713514726477293438
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=TB5K4gZt;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5171a529224so2058163e87.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514724; x=1714119524; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twF8Fz1TD6lEJUyhAE+KgRBeBnWdS32dnWGwjxq8r2g=;
        b=TB5K4gZtT4acSTf9XoMBgEBRbbCOmotQ0u0RLuqKdeldtHaABpazniPMsXcoVA2eZ3
         tCKtG6R6vN1v/t1OtpaPm5C7UOLcm4S7SrkKE0/mgc7cZXJrG0lzZnw950XlVlYVKjOx
         WnJtzKE98IyJb/tBQyHuQk+7dMDcN6I6jjLfuEPuCT20PYaQxQBEFXCla07DJUEQCUMF
         g254A4QsYzGqeUj9PeLcY3nDzdRSrepZfxYlFauv1XKXGAz+HYBSMdDmQRXAutwbfgXw
         onWml+1Fkwy2lIAKdXZU6/TNk9hGlDRRsxqpS828PtsIPbISPVDfhGyBzgmQ4x3oHk+w
         yCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514724; x=1714119524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twF8Fz1TD6lEJUyhAE+KgRBeBnWdS32dnWGwjxq8r2g=;
        b=KiwVVs53prOPzKtK1lXS5NIItmDM0/Okje0Am3QqmvJEenDUweKGc0baf3IlXAM+u+
         mJaRQj/uJ7pNTu0n/rLnho6PlQzWtHYERVLq/1ZK8vZ/o31Md1a/QHDWwNCsDVWlk9Kx
         P11L2plUd5NkyXpeIext3fvA3O1jZnsJbx8uIi1vUt0XJrk+xnlzBxJmajTEaVpXiTwk
         beQZEJnO3iX3UEK7SBbn35nufKMhguhp+2aZGS+v+7I5bd/qkFYUk81MVLZdhFw+lJ4X
         ArROGDox0ani+4wmgqzQmR9xx7ScwIoEDiXwDqCBk55E2IFayctCcvHFlyEma8UkYkaR
         QbyA==
X-Gm-Message-State: AOJu0YyxD2Gl5ZJzk8BouNBzYZv5a94WIMzqhZITlJcewex8xQIAQIpf
	xxDQ9pIkLmmZpVYcDTn9c9LU0U9Kuo342tRrHMtBxdUPWQNs3Z9RuFb+WtiHRaI=
X-Google-Smtp-Source: AGHT+IFWabdaMKj6ZGQjkI9PC++1fVM/eKVJKou0QGXgb8qep5mf7glvi/Iyp1AjU9YYZJFJXnmiJw==
X-Received: by 2002:ac2:5626:0:b0:516:10be:d7a9 with SMTP id b6-20020ac25626000000b0051610bed7a9mr772607lff.30.1713514724646;
        Fri, 19 Apr 2024 01:18:44 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 40/53] dt-bindings: mmc: renesas,sdhi: Document RZ/G3S support
Date: Fri, 19 Apr 2024 11:17:29 +0300
Message-Id: <20240419081742.3496709-41-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15627

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 3b7eee6aae0b3212183fa63a4ae7887924218987 upstream.

Document support for the SD Card/MMC interface on the Renesas
RZ/G3S (R9A08G045) SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230912045157.177966-32-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[claudiu.beznea: fixed conflict in allOf section]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 91aa9b84d23f..6588b5d0f2ac 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -59,6 +59,7 @@ properties:
               - renesas,sdhi-r9a07g043 # RZ/G2UL
               - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
               - renesas,sdhi-r9a07g054 # RZ/V2L
+              - renesas,sdhi-r9a08g045 # RZ/G3S
               - renesas,sdhi-r9a09g011 # RZ/V2M
           - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
 
@@ -113,6 +114,7 @@ allOf:
               - renesas,sdhi-r9a07g043
               - renesas,sdhi-r9a07g044
               - renesas,sdhi-r9a07g054
+              - renesas,sdhi-r9a08g045
     then:
       properties:
         clocks:
-- 
2.39.2


