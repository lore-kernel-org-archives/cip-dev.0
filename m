Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D86C71148
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:00 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web11.7106.1749809753318585292
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=BdckwEn3;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso3723020a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809752; x=1750414552; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iMgYN9YdiPjwLLhZCghoZ6BbaSl/+Ow+a4L/whjuEU=;
        b=BdckwEn3QkaA1Q732tdvk+TFWycGXhO43NcnrZKO16AbOpVfIXCWXiwgBtlS5qmgBm
         BJ0bYeEDdJjDJCV+gvQWWE2bsQkt/1wbnuVuPi+MxubYa/bZf99PK0lPOywRWTCYMoUv
         2hAEYlbBFg0Rs/3R1Pq9QVq/fCKM1tbWtQ6p4jUi3nCuYcATxwBM1F4KGs1Vl2ePgvfw
         TbQTTpoEItCO5exQgAJ5sbL89FfFRedc+ARxBCBtbRTb4GFzMEmWIZUDfePzfau+Wp7L
         FEEfrKTyNjKaO2TyfbsTpCuqrCQpNa2aRkaCmzrlYRj+XKWjMDVDk0wP+96HbH5IDXNn
         zkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809752; x=1750414552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iMgYN9YdiPjwLLhZCghoZ6BbaSl/+Ow+a4L/whjuEU=;
        b=rgAIyBycF/7jdj9+TdbEpiyebjevS/EOsIvTPmTL0ZI1y9NPLg+kgcyU/fNlcI+TzO
         NDVXUiP9lER6YcxOuqPX6+dvIhq9XWjTRQw8zs+lBA/+raW85WygKrcPpPk7tbwNChMY
         VfdDji4gsG6wf1mKHu6n/eoTtirsHxRAgORwSQHeGyL7ekH7Jlon7bfhBwmTU+71kVt3
         d+o+82YSSxFbpFpybRn0AYmzCo4M+KxU3HiBLtbBrj6Yf6z5ueW+3tx5O0VCpg5np50C
         mx/6PgUSWC4Jo0Vlq82WVPgAkAb8QI1hL/Fogymk17uhIO3AQsaKZDQ4UY9xAZ10kQYz
         lYZA==
X-Forwarded-Encrypted: i=1; AJvYcCXzlXWYzWo2/9Zyg+c1hSJfO2xF/lAG3tkqcrr7PXPr4x0iYd0WgitzY9EYak11VeEWZ1+TvGXc@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw73vxg9YZsbL70IsSmjyQZu+f9T4Lf75Ma4QGvoHB674xIpEWf
	ChR/c7SXKMuryoDyv0v1ish/iPQuVLf0R/lFvWhD4MOXJqjA3nsjfG7AxvO79PBkV1o=
X-Gm-Gg: ASbGnct/pJCCXAQNXkfnBIqoWHwqLGbY9O+j8+eQGAB4DRwpv/o2i4H9CFKanteiEdr
	p8za1xVfmh9wQUWEzhc6wA906mLMQLGl5kAaNp/c4x7LGmoYMChGHQHPYJ0X7rYe9pcVumLF8lB
	FvY1N8QXG5p4XcRThv1CSIonlyoJbVbzJUsFmONLzY3Uapeuo/WRvahSVkRrv9UYkdfG8o+5gnq
	vu+Zh3/Jo+SrIbz57mOmj195s+BRnl4f4cejHmXI+5dkmLeP/9itbSvjhz+efdshNkK4uQLQ97i
	13ioGL/oc+hZr4AglnxROigOUIZ7S3gPIyQUcLIVConZ9ivAVR0utiRn1iNiBk4Q9cdnRXAZ6sQ
	6bTXrPK8oWd5fL63v
X-Google-Smtp-Source: AGHT+IFaTZYhzJ7Z0IG8iVngmlTsN/RB2pA2LU1Urw3x+kaugnC5CYVajmvY2oFQ2XS2PkoCvP/icQ==
X-Received: by 2002:a05:6402:5cb:b0:602:cfab:ea9a with SMTP id 4fb4d7f45d1cf-608b49de9eemr2269890a12.27.1749809751653;
        Fri, 13 Jun 2025 03:15:51 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:51 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 11/14] dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
Date: Fri, 13 Jun 2025 13:15:33 +0300
Message-ID: <20250613101537.279131-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19065

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


