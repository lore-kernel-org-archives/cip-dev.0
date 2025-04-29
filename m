Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80647C3ABAB
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:57 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.20313.1745934475757160186
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lHnadd9A;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ace94273f0dso564264266b.3
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934474; x=1746539274; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipMW2Mhj4m6v0PbHAgVQtVt8Nlsc1+Zl3HR0Nh73Gi4=;
        b=lHnadd9AMCqfcbNPJe3PbX6EJ7sSmAxxABRwy0NKJDyspSK4gDb88oSxlUCmX3cjnL
         sMvCNzZ4Y4dZmDylg8gtt2TmdeftUqOIsQgEAB5bSb1PyasatmDcqjxX4OYNuCVt+gtc
         7W0KhGZ9bPC+Vf8siVinmjd6X6HoOKRznu+/PlAJrdhH3rPSMxTLunrcZY79jstXjhkF
         234eNPHEF77Jd0xWm41JDMxbBW+BQNFZ1o/uJrDIvY+mf0rEfRIvFjfkuTKuBaXmKY1o
         HxRYSHFFu8/eDku3r3cvmRx8tw2SU11tIeAW/BA0hmYQO01BlyfPgI+BAaM5JtEHNL9t
         PMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934474; x=1746539274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipMW2Mhj4m6v0PbHAgVQtVt8Nlsc1+Zl3HR0Nh73Gi4=;
        b=asRxhq7uy+MtboZqf1W5oI1gxFwKfE1XsrXAnD+CLTdKwqD+0C/0rwtyM+ou+6c6fs
         EWsDwHFLbZcFIEiilrGvr42VXRjMM9RhwLU08Gwvujq8Zxyw/w9+L1G4dcSNEks3osMr
         S8OE1xaw0f6T+C0aDv3AWr8fu7Tom0gjPaIjzMQszHuitaRJhDHwi4Wddk9ImZcwf6pG
         ZoZmrgCP9CwdcNYeNSO49+VWMYH+Z2n7pJM6HvSF3hTeEusW6fuQ9t1Qs2xApv9hcBf4
         ZBjZc44BllEuu3nCyZJttIi1eo2owO2S6b22dcK5DP1eA9XZsKpUnJi+8iRGSHIh8PfR
         krvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPNpvOS7L6RAf2e7GJiikYAq2gUaiTx4mFog/JdH2M8ymSI5ceAxjFW/DdwzwRXTYdiNFE7tfY@lists.cip-project.org
X-Gm-Message-State: AOJu0YwcZz7vthaA2+6ZzncFynu4E6G9Sm50e2zwbNqH3hb5ljeoMxZa
	cIve+eSLiQvNhtQJkoXeoUeYo11HJWZGyZoksGiOxlsM2plUDJH7d4rIN5/oZt0=
X-Gm-Gg: ASbGncuGXiSDkW228wge501r+rXy1/IXhi6/5As1DJjFrNR9jm/xF3F3Lg56ewc892t
	u3vEu1mrHU3V2hGrzQt14YW2ptIIdp/XfmbM5EqcqEEeAt0+VFS5L7hnZV9Mm9ztvrKY+wpNeXG
	5hGLUFngUVVN9TBGKWQZ0AU51J1dn+lsuGmTx58/shyogVJZFoSf/7kpusbCI8JB9Y1plhmDpM9
	w9AAGVsABrlT3pMa8b8rkKLtuT9Ks54/jhSPGLxrjcCf98mLdM3xJgVnUAqSWho3n1rb/wnBD8P
	db/Yf223chpenMPsFUTbs/YZ4mp7A8krFSsF3JX3Nxclf1uI39+ZgkEJpbcleQRw/LqMqhk=
X-Google-Smtp-Source: AGHT+IEGbf/0gXethjiqQjiM/gQeGxwYBAShQOb7+8s6xJgzQjWRDi1QQB2U9cEfcSSGP+KivqBlqg==
X-Received: by 2002:a17:907:7b9d:b0:acb:107c:7aed with SMTP id a640c23a62f3a-acec4f812d1mr380240366b.55.1745934474206;
        Tue, 29 Apr 2025 06:47:54 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:52 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 14/21] dt-bindings: i2c: renesas,riic: Document R9A09G057 support
Date: Tue, 29 Apr 2025 16:47:20 +0300
Message-ID: <20250429134727.2429662-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18727

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c1f39c62eb09fa2e692a9377295ecbd0740c0914 upstream.

Document support for the I2C Bus Interface (RIIC) available in the
Renesas RZ/V2H(P) (R9A09G057) SoC.

The RIIC interface in the Renesas RZ/V2H(P) differs from RZ/A in a
couple of ways:
- Register offsets for the RZ/V2H(P) SoC differ from those of the
  RZ/A SoC.
- RZ/V2H register access is limited to 8-bit, whereas RZ/A supports
  8/16/32-bit.
- RZ/V2H has bit differences in the slave address register.

To accommodate these differences, a new compatible string
"renesas,riic-r9a09g057" is added.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
[claudiu.beznea: fixed conflict by keeping the code from commit
 c1f39c62eb09fa2e692a9377295ecbd0740c0914 and dropping the RZ/Five
 string near the renesas,riic-r9a07g043 compatible]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../devicetree/bindings/i2c/renesas,riic.yaml | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
index 552db6c50e1d..f3f01ef2c62a 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -15,14 +15,17 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,riic-r7s72100   # RZ/A1H
-          - renesas,riic-r7s9210    # RZ/A2M
-          - renesas,riic-r9a07g043  # RZ/G2UL
-          - renesas,riic-r9a07g044  # RZ/G2{L,LC}
-          - renesas,riic-r9a07g054  # RZ/V2L
-      - const: renesas,riic-rz      # RZ/A or RZ/G2L
+    oneOf:
+      - items:
+          - enum:
+              - renesas,riic-r7s72100   # RZ/A1H
+              - renesas,riic-r7s9210    # RZ/A2M
+              - renesas,riic-r9a07g043  # RZ/G2UL
+              - renesas,riic-r9a07g044  # RZ/G2{L,LC}
+              - renesas,riic-r9a07g054  # RZ/V2L
+          - const: renesas,riic-rz      # RZ/A or RZ/G2L
+
+      - const: renesas,riic-r9a09g057   # RZ/V2H(P)
 
   reg:
     maxItems: 1
-- 
2.43.0


