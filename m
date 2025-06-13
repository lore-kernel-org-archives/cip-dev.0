Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BB1C71155
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:30 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.7125.1749809789390646892
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=J5uB0RJt;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad93ff9f714so332836666b.2
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809788; x=1750414588; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/eZ5Yg1cbJDx4t7uQsJFZXvrI4aY6vJl6wYpwlNk9U=;
        b=J5uB0RJtJp9u2YI5mqfWhviTMxfrGWiC/u4QB+3ZXV24kNjxFFngAIdJ8l9l/k6bch
         ritW310ayY0Rpy+ZDX3VqLS5Mr3Am+NYjA2RW7Cv3F3PX9adYD+QX+IpkEESPKshC+n1
         2pFHfm1W2BFfKVqHd4kfgUhNxQgy5ky/3nNJnu4+IIttY2//IHZomaJlwQkeKrmCOfyU
         7/tRwoEUJ7kNJZAj62ZzqL6RYe8jA1zDnSPuvV/9fBnwnxQQroLudvNQ5sk7Nfb7rsSw
         KVXwXYMcmL/nt3dSMAHBtf1Zh5/K7ErsmXMN8dijrQWoY6AOD1oCtvG+xjzri9E68/Gx
         uXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809788; x=1750414588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/eZ5Yg1cbJDx4t7uQsJFZXvrI4aY6vJl6wYpwlNk9U=;
        b=NZZdFXt7IdV48n7MtOax3gb75DJp/1IF91W/bQIkE1RrnYv1H4l+kaglOD/SMUip+p
         3ja+qJs5YafqqJlAHR0PjLuiK4midfvDKsYDVaxAM/AOsv4mn7HhUuZthKhr0N0MmZhs
         jpQ5cNGoVr6f0mJ7Pjgffcd6fEB9KmSdzYkKGo2ZpRgkoOr7SIffHd5Ic/pUqvS7Onfu
         Is9EO1zu1uLZTs42mtZ/kRKK6mvZ/95z5Z7NTWHcLfWDt0Io+bWViz7EaEy48b2ujafb
         SBbu5bUhi/XTTrGeqi2OGnkeFUuARFKjq+uszOB9pi8d5roLRob4YHUqx5fofQtIcHwA
         mVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmV1dZrM+KCAopixaIoqnRlC4WWIbdefSK+arbpihkf/vHtDatxZTf0X6MDuWguP4F2lopLa0w@lists.cip-project.org
X-Gm-Message-State: AOJu0YyEAlb0d7mQmNgoLqW4ERIYt+/z45qDrgGxL8zgk1EpxhhXNVE+
	aMpm0oH90EEG4Cf72VTp7b3OHFVp8LsP3ifUXAtCO3dj+ZTodjRpqiE7OjHt4tJNhzQ=
X-Gm-Gg: ASbGncsNpNZEPgwIuWYBXKDIGHJbDlj/5dy0UAvLsjbRYBYJHnPHPEuFzODK7LMvQxe
	y+VmHzKMn0IHhipvpdlEEaUuBg08eTTkIZFnaSh6MClHRfEIGrLDwPwR0m1wyWNqtG/CaP+++It
	vwzSsS/oWgd4T+6olswk4/CVb+XFljIG+J1nTbCXMSutqFEp2vX1Q+6R34yq+dyhYGpAiFCKR2k
	GE15O2u9ZdapgL/pOAY3mOZpxiM3Lg+44HcPwVBihwOFRTUswrdXgAjoEB5z2u95U4LandETBvs
	TtAICH5f9qZxK/O2ca8liwfMsh3rNHo8/7P4UVFP6FhtjA5TVXdstfVzNz5Io5jLij+stQStxVi
	Dvunanf6s55ZC4IUX
X-Google-Smtp-Source: AGHT+IHx+E6e54Z09/WqC7GJhl+OGaU0XvDKtMD9y1PsFydl5UpwHRpgzgGl4GzeG5rk+cQTKtbWcg==
X-Received: by 2002:a17:907:3f1c:b0:adb:4143:4c8 with SMTP id a640c23a62f3a-adec5598041mr216310666b.8.1749809787644;
        Fri, 13 Jun 2025 03:16:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:27 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 11/14] dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
Date: Fri, 13 Jun 2025 13:16:10 +0300
Message-ID: <20250613101613.296649-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19080

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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 37 +++++++++++++------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index ba86c7b7d622..40341d541726 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -17,12 +17,15 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043-adc   # RZ/G2UL and RZ/Five
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
@@ -68,7 +74,7 @@ required:
   - reset-names
 
 patternProperties:
-  "^channel@[0-7]$":
+  "^channel@[0-8]$":
     $ref: adc.yaml
     type: object
     description: |
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


