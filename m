Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9691C071DB
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:40 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web10.18464.1713526774855382982
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=aHHU7wLx;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a55692e09c9so108374266b.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526773; x=1714131573; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeiYfGZBYEWidDaeYubrCY4oZAZaK9BfGnFQ6K+iWRU=;
        b=aHHU7wLxysVP+yWFHzPnH+/0CFk9KELQryywtTL60cb9R7hBWrfaUhuvPTREI3Bkr6
         CetH3EIosYNL981hPUzanAonw1vPdSNctDZhtjRdWtZxeG+fO7tVu+96fFloi9F/kaV2
         sZBll8PRDuWd7Hy2mtRPRgBf7EGQp2Zuzzt1QTvqhjMV9YPMa2esxLEDtHd9woWbGDR4
         L1SbB9V3qqUDjiECNMjK7yMT5JbQyN60CfFQmPo2+HrJqsR+xlrl237hYOZidiaZI+QU
         EeQv/zfh3Re0v4jC6pocOi8qO7fd5lFeLZXGU0kBb4MfbyKjZD+ilg3/P8wzRoL5oFGF
         vVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526773; x=1714131573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeiYfGZBYEWidDaeYubrCY4oZAZaK9BfGnFQ6K+iWRU=;
        b=AgdIjec/etVWVNnmdQrGw9MfMZ3Ap7TBiz5+Clo7cPoIPvsZU1rmmPeHHlGz0p1COE
         ztUj0F++Yyx3OPIWuOiENIhqAYCgWMbF7QktP+6VwZ5ybW7ks8DyQsdFZl3/GOdTF+lw
         sdawk3fQ6wTKXOq3cTpfbtWSwDD5F15G09z6DBJ565hB4i3XjAMUNPSR00RJtZSBFm3M
         A/gRs0uao7uO3DWoXANLOrncc/psTJmbH5tispVbo1LB7zuoX8+J9v2aU03tSHu+VAdf
         ADb8vxD8IIy7+6Ag7x03sPv/pgdyZlQsS2YnidbbhQCNrOqnX7a4BMKFGb8XcTOVv94f
         7s+w==
X-Gm-Message-State: AOJu0YwlrUbn0Tdgmep0DClQfF8UCuRWTLXrNh5yRuj6ASniXLXwVM0F
	PYKAeOJiWGAVkmRxuHjHlukP5mH2DK1HERmCcTPsdpqCcvMbmxHwvDBby0xxLXc=
X-Google-Smtp-Source: AGHT+IGyNoMElCaZwS3zEgtOTDvfkfvvdIJdibcN0Ed00c98BK2HyeRi+dR2av+zTkYgtRxe2Z0qqw==
X-Received: by 2002:a50:8e5b:0:b0:56e:ddc:17ad with SMTP id 27-20020a508e5b000000b0056e0ddc17admr1698424edx.30.1713526773270;
        Fri, 19 Apr 2024 04:39:33 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:32 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 33/44] dt-bindings: soc: renesas: Document RZ/G3S SMARC SoM
Date: Fri, 19 Apr 2024 14:38:31 +0300
Message-Id: <20240419113842.3675543-34-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15684

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1c3be6ca72293723e009a29fbe90385fa047e5ee upstream.

Document the Renesas RZ/G3S SMARC SoM board which is based on the
Renesas RZ/G3S (R9A08G045S33) SoC.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-24-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 7d75117b401e..42753f4f7442 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -472,6 +472,12 @@ properties:
               - renesas,r9a08g045s33 # PCIe support
           - const: renesas,r9a08g045
 
+      - description: RZ/G3S SMARC Module (SoM)
+        items:
+          - const: renesas,rzg3s-smarcm # RZ/G3S SMARC Module (SoM)
+          - const: renesas,r9a08g045s33 # PCIe support
+          - const: renesas,r9a08g045
+
 additionalProperties: true
 
 ...
-- 
2.39.2


