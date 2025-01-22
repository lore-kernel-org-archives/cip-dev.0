Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC66C0218D
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:52:50 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.41909.1737546765161151298
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=W6wMJNm/;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso47324905e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546763; x=1738151563; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjtRyfTgZS3PaUggTQ0LoCLu4U5xv/Jge0GwFBL9qQY=;
        b=W6wMJNm/Zr7Xi9IMRw9FZaGaYlJziOS77LF4S1tNYJNsKhw+d5zBrTw6bJf8kLS20M
         hlm4jV17J8WIQJPXi04iaJr0g/t670/lYhPXJxWRoYXynKIT0UdInfxVUl2Q8gbXc1aU
         rSmXwt5IncetHTuZANJIXFki2NF7N6JicWkNWQUQ9oebZ9fSR05vm5vnk3q6o/J51Ekk
         sPBtvX8F8OMELV77Kv5xC/8ZkS0THJSVEGg5+ZTN81q86IZ8o6T0lq82TxuggSSF9phV
         3fnJA4fdGhi3Ud1u+7dFUv/OvyJ8EIdVx6ctxT91jPqzWBVDHAU0KaXvOXVI+FiZ7blo
         zB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546763; x=1738151563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjtRyfTgZS3PaUggTQ0LoCLu4U5xv/Jge0GwFBL9qQY=;
        b=Lxue+3F8+6kQEhZeRuq4lIYRchEtsAmc+pfSOmvkX3eAg5UFr/sQL40S8cGCwNbUt6
         d72f9uQx/fz1MR1r22spPoIvZsi0chmUkNNMv77wPoWI3mZMBJh/pwW0Cxg+RpFoz3JW
         PoB+yCCsbiW+66cEdq6q8O24TQpFZMLFtzE4eCJ78p3JiMTvR/Vip8c6I0fxsLyuAcfD
         t4YVEPrpzhQH+uSn7zqgDiSUymrjelw5Bbzs5KSOG28rxLYeFhTOwrPokjgioGxka7vT
         kTcdUy0oICEO7m7/bAPmoTz9LR/RjdY5hQ079zspScYsOx+trWrs9l92tso2rzdz5XCH
         0pHg==
X-Forwarded-Encrypted: i=1; AJvYcCWCz8KlG7G+C8IzBw5MNjPJkOcrEPSCXlgAeQTMHrQRAhfZmEriPCoU0XIbV3HoFGjZAulsevEM@lists.cip-project.org
X-Gm-Message-State: AOJu0YzipIaBZvpW8vrUrOVfB5Caw0+JX/Rb8KzbKF2K94WDd8m24prF
	hkP0adi94xzDpGLrSzoxleOARgsltvMAYw7Gc0s6GPUCxPzOcIDDeDS6/7tfE0w=
X-Gm-Gg: ASbGncuB/AyucaHw4wA+yG6bNhc3WkWKZ6Gg6dnqSa8lO6u3YaryCZ9GvxEJyOj5TZo
	dm9pAnlSbXNICmklsWLQuElxXaVh/2pz7X5J8bgDx3hCNdwRYhoRE/ehjUNfWZsiE9py6aiMdHt
	BEB/r4SAH9TJdN56pT4DKMSggtqu3Sp4Q6qrRh6JDR2/3HkPGKxGkzIR7GGi29Zn36YHbQOEkxj
	ke+o+v+f42B+livPtzq6Zt77Nu+z/1x+DfpT8Sk0XTa87kyYuMC4aKn60/m6HEiVg8lpNS0KXJs
	3rP82almsfUIQXH8a4CQRU4=
X-Google-Smtp-Source: AGHT+IHkGoSnVwHPLEr4UKyS0eMUACjt9+/RQztSb8FS4Gk5vDuJmKG2FsjsdglG5HBxhMjBQoy/CA==
X-Received: by 2002:a05:600c:1e23:b0:434:f335:83b with SMTP id 5b1f17b1804b1-4389fa653e9mr183992365e9.5.1737546763623;
        Wed, 22 Jan 2025 03:52:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:42 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 09/16] dt-bindings: rtc: renesas,rzg3s-rtc: Document the Renesas RTCA-3 IP
Date: Wed, 22 Jan 2025 13:52:23 +0200
Message-ID: <20250122115230.2885344-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:52:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17587

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


