Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD467C04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:40 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web10.18463.1713526773525416023
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Rb7aXbj9;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso2757067a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526772; x=1714131572; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvKIjrvktcPrYt8NnQbqeCZXz3n2Aib2fjTtzSJKvww=;
        b=Rb7aXbj97I5l8Ec1N/xLdJE6MS0obQAD6pGFpopZtqjhBnKSRxldrYqGjs0Hasoi3P
         3SZjUfdOvnO138r5Vx3/ZyFeu2SYxSbd/nohMEeEJFKw8SrZpha2cU9AL/WeP13fLm/M
         tTFKl5gerBXbH3BcAJvM0qQjQlGs70jvqRxJVGAp+YpBwjrmNj7YtaVLeahkLhfpHSLX
         BXqARiyCQC8BqMFNqXqjPJB+y+mBMINlO/3G+rrWu5I8uHhPfgsQm9WEpIGI1WAXzbQP
         oDSJh66zDyE0rpR/BneJX/SxRa8jd0Wdi8vDvdOkBHAvc8jBEDYSEdPvEWw8Cehv7h74
         lL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526772; x=1714131572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvKIjrvktcPrYt8NnQbqeCZXz3n2Aib2fjTtzSJKvww=;
        b=ID1n4DyQydg4SS2i1qIK8Oq6ztB1blgZ7zPriqP8IlUl6MPrETKxM9PbsVeBFYNAvE
         uU1eOUBPeKj1uZiun5pp7URRgdQWqJxQM85M74tidYBTdNhgV3io6sst8DOpdth4pZ54
         hsVQSqcTNHPSR36G4KK4f2NCNxcHZnMH9ibYnBa/3el9B4xHOwQuP/ms7ZuCHD70dwk8
         lV5r9YCLssbWkPbZUj08Liim/6K+kQP/NBYWPPCjcMLgXXhPeUJ36wnOR98nPIBp36c3
         Nn2yHP2YqP/Df1IyGOzGjGbU751p0Oi5EX9q63CDcp5136pywA0qK6Qc19hAuTKKOA/Z
         ouMw==
X-Gm-Message-State: AOJu0YzM+H/xHm8NvjYSTUBCoaAdN9KWofgnTlMF90l0ii2niGL7uAvH
	bjQhadoYtKsDYODeso7Qy940epsjoRiAG5IboMRgztOpwA0XZvPKSf2eajXhmTo=
X-Google-Smtp-Source: AGHT+IH3fLtLGCYFwD9ER9NU/g5B6fuXsaDxaWLGoLHTVvB2giNP3pBsehNJZv3YwwDmg8D3En0ZBQ==
X-Received: by 2002:a50:9508:0:b0:56e:2e9b:1341 with SMTP id u8-20020a509508000000b0056e2e9b1341mr1237633eda.38.1713526771930;
        Fri, 19 Apr 2024 04:39:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:31 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 32/44] dt-bindings: serial: renesas,scif: document r9a08g045 support
Date: Fri, 19 Apr 2024 14:38:30 +0300
Message-Id: <20240419113842.3675543-33-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15683

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 8e3c825288c6a091e3e80edcebe746b927dd1f73 upstream.

Document support for the Serial Communication Interface with FIFO (SCIF)
available in the Renesas RZ/G3S (R9A08G045) SoC. SCIF interface in
Renesas RZ/G3S is similar to the one available in RZ/G2L.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231006103959.197485-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 52c094873863..1b5b6ce6de0d 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -78,6 +78,7 @@ properties:
           - enum:
               - renesas,scif-r9a07g043      # RZ/G2UL and RZ/Five
               - renesas,scif-r9a07g054      # RZ/V2L
+              - renesas,scif-r9a08g045      # RZ/G3S
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
   reg:
-- 
2.39.2


