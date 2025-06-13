Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E57C71148
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:20 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.7053.1749809715218128396
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=VIWJe/OJ;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so2923893a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809714; x=1750414514; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iMgYN9YdiPjwLLhZCghoZ6BbaSl/+Ow+a4L/whjuEU=;
        b=VIWJe/OJ+Ifp0arI7/WnkUukFQZ70NMXj9MmVMGfLAJEpTNQ92kE9ZkXU8kvzoFHXl
         xeokfQcNWff1GK77tzWnRMy7Kx9wHSQpRaimInqnOdyLzBpCWJzSCo6hL1/XjKqDlakM
         Lt01ehAYKcfrvvq4EIT1eSMmGpEf4DuH/9yMBU5hKTvqSjZSijiQ7devo1CGK/9+y7Ua
         ZmjQS1JDBlbMN/ga83KvgP+ciSLAQ3eZNuzorL+844BVhWfqELWdPCDHjFP4DxyGyFny
         4lXumyPaZGUoM0UkX8IrRGndYqx3yRonhAFHhLjusRmyTQeEMeTjCELfNLu53WfQmYug
         LJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809714; x=1750414514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iMgYN9YdiPjwLLhZCghoZ6BbaSl/+Ow+a4L/whjuEU=;
        b=AmQIfQkrmQGgEYBOdvu8n10BBGJnKcxwI2m/d7mengaqjk85WinOVfiMwRF3gcrSzB
         NNq9Kn9P8PPzRfGGrY4eepXaqsY4exbIkWwt6pERW30VguhcpyuXeSgsDve0ep05FmR0
         Hqvp/L+etygn/taz8gk+HGcHPXUHr1egBnMbKaOZFHgLZvdPjGMzxPNC3PAv+cFctOWR
         mCVMgovxHLJlGaX9YzkmQ27v3dyEV2PyWDEDXoCUPQ7yeAZlQAtClZFPNViQLO3OniyN
         V3ca3tEoXa3VKQa3MWerP5L4XBLRFegKi1qmhEkebzlQhJhxjohcTvr9aq/tfkEU9YVD
         G7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3K8usBZFm3knwEQlmpqnd6l0vKCzqFluuKPDBr8AhlUYEjGniCqbi8g9Nj7HMVYeoo00sJz2N@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz5VsarSuoY5Q2B7G2OmgrcojzpxG01K8lNQqj/VSPtInyltypE
	A8CXY+FcWApo31zJdul+JOyalCjDNkv6BhAg544++WzXWS0JeSLFHiN0DglngB6kIZQ=
X-Gm-Gg: ASbGncv8mYe6Nu6Be7/OHMY461FvY+yoA/fb3O09TBVcocogwb6qI7Kw3uYZUsddjTf
	moHRtj5T8lLmhNCdiNAe1xXjPgCGsekSEqwHKsuzJyMV8yaIGY5OB5D0r8j+g44y9YAfkxkFduF
	noAlsmjLKpe152nre6A2Bguuezi0Rj3n7iHEu+om0BfjFhVow6BXbDEKzoQd0Bk5bEjezL/LLc+
	283Pzib3Hl7PzuJlJ0GbrMGwBy0PNMWehPbXAkNaCgd8JNLGgkoG74DjPLAgtdsiv1wxHBKys3H
	Rag7Voq8+YkEHck0Jr4I/bc2345TfmlzL/XxQEjznZlasZaJXpeVRlv9tfhfVX/49HSxbYhG5xb
	oP8qypxSMcJ0qeRlQ
X-Google-Smtp-Source: AGHT+IHJb/svA6J6ljte7lM2PMpQofTOl91M23riZX5GKKlzBNiLhC/qHIKK4MuHZD8YJ0ieZ42d6Q==
X-Received: by 2002:a17:907:70b:b0:add:deb1:d84d with SMTP id a640c23a62f3a-adec5583fe7mr246748966b.1.1749809713576;
        Fri, 13 Jun 2025 03:15:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159377sm105101466b.9.2025.06.13.03.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 09/12] dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
Date: Fri, 13 Jun 2025 13:14:58 +0300
Message-ID: <20250613101501.262091-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19050

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 4af77feab3a2d489e2c7390e8d31b2f88d0b3db6 upstream.

Document the ADC IP available on the RZ/G3S SoC. The ADC IP on the RZ/G3S
differs slightly from the one found on the RZ/G2L. The identified
differences are as follows:
- different number of channels (one being used for temperature conversion);
  consequently, various registers differ; the temperature channel
  support was not available for the RZ/G2L variant; the #io-channel-cells
  property was added to be able to request the temperature channel from
  the thermal driver
- different default sampling periods
- the RZ/G3S variant lacks the ADVIC register.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-13-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[claudiu.beznea: fixed conflict in compatible and allOf sections by keeping
 the code from this patch]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 39 +++++++++++++------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index 61c6157cf5a9..40341d541726 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -17,12 +17,15 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043-adc   # RZ/G2UL
-          - renesas,r9a07g044-adc   # RZ/G2L
-          - renesas,r9a07g054-adc   # RZ/V2L
-      - const: renesas,rzg2l-adc
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043-adc   # RZ/G2UL and RZ/Five
+              - renesas,r9a07g044-adc   # RZ/G2L
+              - renesas,r9a07g054-adc   # RZ/V2L
+          - const: renesas,rzg2l-adc
+      - items:
+          - const: renesas,r9a08g045-adc  # RZ/G3S
 
   reg:
     maxItems: 1
@@ -57,6 +60,9 @@ properties:
   '#size-cells':
     const: 0
 
+  "#io-channel-cells":
+    const: 1
+
 required:
   - compatible
   - reg
@@ -68,8 +74,8 @@ required:
   - reset-names
 
 patternProperties:
-  "^channel@[0-7]$":
-    $ref: "adc.yaml"
+  "^channel@[0-8]$":
+    $ref: adc.yaml
     type: object
     description: |
       Represents the external channels which are connected to the ADC.
@@ -78,6 +84,8 @@ patternProperties:
       reg:
         description: |
           The channel number.
+        minimum: 0
+        maximum: 8
 
     required:
       - reg
@@ -92,18 +100,25 @@ allOf:
             const: renesas,r9a07g043-adc
     then:
       patternProperties:
-        "^channel@[2-7]$": false
+        "^channel@[2-8]$": false
         "^channel@[0-1]$":
           properties:
             reg:
-              minimum: 0
               maximum: 1
-    else:
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a07g044-adc
+              - renesas,r9a07g054-adc
+    then:
       patternProperties:
+        "^channel@[8]$": false
         "^channel@[0-7]$":
           properties:
             reg:
-              minimum: 0
               maximum: 7
 
 additionalProperties: false
-- 
2.43.0


