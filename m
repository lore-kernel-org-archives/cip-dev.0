Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78DEC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:07 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.15288.1713514678068009659
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:17:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=jue1o31w;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso2628282a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514676; x=1714119476; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mxQiFGudmJmuFDrvdRlBcknMkgRsLSPuJ4LCgFSjFk=;
        b=jue1o31wUHAnAhbvDSKoufD7YzwYFvorN3N8qnPV47AutKeNG08wO/Cc2+GC2Qgf/F
         N9+/LSxd2p6CG4X8O81EGp8FFqS5Aooa9Ab4771A3PqjidN4GsrjFHdZcKPExpvh1GYM
         O7SLoNsXrsHjLc3aKAqyKWttpQb+9IjCZ1nlL4jkY87vH4tTtZOAzLKaA2Irz4mH87tq
         /B+2myRuxpl6J+lf2UlWJ55hPKYY+OqgXAUe2gOgwmxeFkL/bm5+w6ngzmD1pHSpVptZ
         jZymso7r5na3eiuX67belHgsJiYIuw/TkT2RSgl1CGXzZs0ReIO0eGeNhaOAsMbAVFSB
         oI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514676; x=1714119476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mxQiFGudmJmuFDrvdRlBcknMkgRsLSPuJ4LCgFSjFk=;
        b=KY39mDXymP4o9er1xZ0p/NeFkcXV+4BnTLGzHKMfbJea0oK3xBF2iyzbUdynycqC5C
         5du6UfQMB72bOs3sdmV38Ti7F4R3RdHMkUalDT7u0yCsQpML6S2o7EepwIAiDtycWTJ0
         u6k3jhSCBUNS17/T5cKQxgVIGtrvdgkQdk9QPfKgRZLQ4uEnMDXttN+zXnGrcFa6Wat/
         YKEBWZ4zNTfcWoC1lA5PxLfUju3pyxBflqMW33iEDQLA5bT9ESdce5m44ccxqIepu7f3
         +TzyRLXPo1YNqkzRFztky0spXOlcWLADHMwXwKL9oSAyRyY8u6lUiQD/8EueloxSCzFm
         usXg==
X-Gm-Message-State: AOJu0YyqVNtk0cVOgdMFC9ZANnkaFhEaXex7tgArLHOLnjp7fg1tacgx
	hWaUJ8PZgKs2QgQbAuAhZ7ot17MNzrT6eiHIUl1XOCzvBvE0aG0prMsRYwRpV/4zf1eieCmyOQP
	a
X-Google-Smtp-Source: AGHT+IF0WKTG1s/MhhpNyaoo9bm4VpHuj/igwzb6sdraSAfAw71B+OVU6tdLAaa07ANXOBM802IVAg==
X-Received: by 2002:a17:906:6816:b0:a52:54d5:7915 with SMTP id k22-20020a170906681600b00a5254d57915mr1119881ejr.74.1713514676537;
        Fri, 19 Apr 2024 01:17:56 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:17:55 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 08/53] dt-bindings: soc: renesas: Document Renesas RZ/G3S SoC variants
Date: Fri, 19 Apr 2024 11:16:57 +0300
Message-Id: <20240419081742.3496709-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15595

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 9c57c4a9a45c04c19f38986c73847b756ceae237 upstream.

Document RZ/G3S (R9A08G045) SoC variants.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230912045157.177966-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 9f62712d3237..830121d7dd25 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -334,6 +334,12 @@ properties:
               - renesas,rzv2mevk2   # RZ/V2M Eval Board v2.0
           - const: renesas,r9a09g011
 
+      - description: RZ/G3S (R9A08G045)
+        items:
+          - enum:
+              - renesas,r9a08g045s33 # PCIe support
+          - const: renesas,r9a08g045
+
 additionalProperties: true
 
 ...
-- 
2.39.2


