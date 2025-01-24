Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C958C0218C
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:01:01 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web10.7453.1737709257970896227
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=nbA73IqC;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso302035566b.3
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709256; x=1738314056; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnLNZZyiCZVevgpKmltWagN5En4nuc4DObaUHjCsGpI=;
        b=nbA73IqC7g7+BHEKCjV7EUTJgnB1g9MrPNTFLPapiAk54Ut3cuqpMh/CH2xc1tsJDP
         vNihifB3aEtLcXpCaZrf4+tm7/Uq7LLVYxe8xl14MIjUBe/TiH4JgB8xr9mX6vsISQZF
         6OQC3yK02jczxdJB0HPem6qVTOuk73d2taKfPFGu2cGpDYzOSCDnQg2jFG3dpRq8eCdS
         nRSaBEpOlkZPRO9WOjhm9NABBGetUR+sP25fOPFztBUGl7xX+VisfffDeol/cHPlkhq4
         lmgX4YppRSrPOsg0Dg2+v1TV2wxIgSfAW/YenLCbYycyYOujb9G0cC2OHaXBbcH+2rnK
         nabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709256; x=1738314056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnLNZZyiCZVevgpKmltWagN5En4nuc4DObaUHjCsGpI=;
        b=WoUUIT9N0j1t8Cztax4fTOQq5nb3n6+SUeiSCDYIHQktIXUOQ3wQnYZ8ugrDmOPqMs
         N5JY5mg1SZivRFHdjuYvQQRRNSpHh2NSXUrza/SYTxRlD5XHJhIMRP0UC8Ef27GVAP9C
         kK4W27mcEaKqmey5qqYb9TsSQkfEXLLSI5wPQGuACUGrQiQAbEjEYZr+AQy50BejMeD0
         Fjl6azrv/WXi0wyIA4/2zls5ZltiARlyOLYMsSsllcLDVlzZBDpxd8aNiq4cvx4wnGd2
         T5GIozww2vwlqB1Ip7CxstJGlr/2hSe8PFe29dbmdDVB60/MG8Ar4Nz8QsetC3rq8jEX
         PmzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHK26UE/6seoWVsa2+QvrytL3/tVR5NPH/YLRH2NE6PktBj7uafObyOpogLuip+rpXngiRcd8N@lists.cip-project.org
X-Gm-Message-State: AOJu0YzJGCJ4cP11Ll2mvMJFBd8PgyEHe3BnngXUEao4BI/YhLsPXbKd
	FgZP1Opw+A/GRMzywvp+ozrPFrcLofszvLGAMZ3AQ4CfKJ1Qz48P1HZopKLKBzETkp5DJia3OES
	p
X-Gm-Gg: ASbGncu4rIW0qDEd1Vs1ZcZEVtxsPLBOR4wQBpqxTSBs5+HWyJsBodLtA7ge5bYml+a
	WG/Nme2NC1wDCOt5oeyy9NdhLvqU5wDrUBSnmJlCinjT5xwKG6e394oyBvzA9KixnAJzd8ez7F4
	0Hr8BGNIG+RLaUSFGJE3G5L6+HNG5u3E1gUMFFFmjTvezOHvx72lmEWzY5MGNe2weXXIMFph9cR
	ikHDRcDkkCLZo3lCIuqN+yjGwUKw7XbzKKAMzbiMzF0d5TKxv7jRgi5fWnYzDUGzAw16F/ZjPlV
	BUC9JEyoAdq/xlIrXqLd+wY3XbHLKndHsw==
X-Google-Smtp-Source: AGHT+IHVF5+2WhU0bbzyU34FGGntN43s/FvyoB6sJgqCvK3QNewgdAl5qk/lPg60SCQTEyy6hlnDiw==
X-Received: by 2002:a17:906:7956:b0:aac:2128:c89e with SMTP id a640c23a62f3a-ab38b3852abmr2609888066b.43.1737709256335;
        Fri, 24 Jan 2025 01:00:56 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:55 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 09/16] dt-bindings: rtc: renesas,rzg3s-rtc: Document the Renesas RTCA-3 IP
Date: Fri, 24 Jan 2025 11:00:34 +0200
Message-ID: <20250124090041.1401132-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:01:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17646

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 71c61a45c951eca67dd2cbc4de9cdd687ece4ead upstream.

Document the RTC IP (RTCA-3) available on the Renesas RZ/G3S SoC.
The RTC IP available on Renesas RZ/V2H is almost identical with the
one found on Renesas RZ/G3S (it misses the time capture functionality
which is not yet implemented on proposed driver). For this, added also a
generic compatible that will be used at the moment as fallback for both
RZ/G3S and RZ/V2H.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20241030110120.332802-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/rtc/renesas,rz-rtca3.yaml        | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml

diff --git a/Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml b/Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
new file mode 100644
index 000000000000..e70eeb66aa64
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/renesas,rz-rtca3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RTCA-3 Real Time Clock
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a08g045-rtca3 # RZ/G3S
+      - const: renesas,rz-rtca3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Alarm interrupt
+      - description: Periodic interrupt
+      - description: Carry interrupt
+
+  interrupt-names:
+    items:
+      - const: alarm
+      - const: period
+      - const: carry
+
+  clocks:
+    items:
+      - description: RTC bus clock
+      - description: RTC counter clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: counter
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: VBATTB module reset
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a08g045-cpg.h>
+    #include <dt-bindings/clock/renesas,r9a08g045-vbattb.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rtc@1004ec00 {
+        compatible = "renesas,r9a08g045-rtca3", "renesas,rz-rtca3";
+        reg = <0x1004ec00 0x400>;
+        interrupts = <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "alarm", "period", "carry";
+        clocks = <&cpg CPG_MOD R9A08G045_VBAT_BCLK>, <&vbattclk VBATTB_VBATTCLK>;
+        clock-names = "bus", "counter";
+        power-domains = <&cpg>;
+        resets = <&cpg R9A08G045_VBAT_BRESETN>;
+    };
-- 
2.43.0


