Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F21DC0218F
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:31 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.7432.1737709223215616634
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=jsNrUqB7;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436345cc17bso12957225e9.0
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709221; x=1738314021; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjtRyfTgZS3PaUggTQ0LoCLu4U5xv/Jge0GwFBL9qQY=;
        b=jsNrUqB7dggUeIgz06VhdqA5g+XYTm8hsIKMXfjVg5RublDGWdsZBMGjk8L1c9THXo
         kppnyo1VsdoV/DaM068eFWE06M/scLuksM0qpOXvTz4svHAv61kszlvJdt5kYHcA9p5u
         m/VJDMxdfmnFv0Hjkr5Xy7ohe3JUpzXVezTnvY/+AsFlsRiX1bmc6tyM+n/9ab52OAA4
         i/ltF3phn3Vuu/l40jryx5wcy7/E3HVGCPsnE8dMuLXBEWRubewF4FBbUNANtb1onn31
         0hAgzpu890ib7ajydIsSBvBpR6ohtGGBw4u6xN0naHLXdoEop51KutdKmvjFF04cADcu
         QVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709221; x=1738314021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjtRyfTgZS3PaUggTQ0LoCLu4U5xv/Jge0GwFBL9qQY=;
        b=nooJELn8myNmDJoV1jvZIGQyElyRgTASL0ji3Nt3O0VYQxHx5ejmS2jOQyFhbe2Nzy
         He8nFuM/I32HX+olp/jjOdVqlYplzEW2T136ktBuIWWRDqkDWlM6YChhc1ri5qn3vq8I
         9/DrVjuOQ0ke7d3iFvjAkdSz0N0gqvS0zDmesqm78WfJF5MeHIaZKOuuz/i2fa5XKVcl
         xB0a9Wu9dj4D7gIbTHek/DEFNSQPOZjroi38DbMrtT4Qdkgz6WwFLD5hn+zZ1+QPRbch
         ex+iuU+yKX/3Ad+VSieGJkkMb3HtZEI1JabCTm/NGHxtoKdR43QQsISy9TwHu5Iu4viI
         vYog==
X-Forwarded-Encrypted: i=1; AJvYcCW9jS889JvLwarjmMPm19QT2LkHUN3mzXB9txD7YYzdLtqTl9MfJtMzv2s7DJMSuOdsvrxRVFP9@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy7f1m1YUARet+ycwQv0XUy9U/WcsdXaJ709nzgNy5sWcJZdUVf
	KgGnmV4Cd0U9lF4wJm5jvApD8yDP8yjY3qWJXdnLtDfzlgAkJj6COZ+p0dYBeeKM/BKaF2uDWkr
	9
X-Gm-Gg: ASbGncuVsIIzmfUV2dbfjuesDSYR60L1emdokXqK206zx6Mb4FryKvDGTK2FdQali6A
	DDC2gZUPfvYzKElP0Ar2f6Z7mkBixGBsssz3t23P6NPKfw6PZoXEOgxulQdA1Mj1j9a0ti+vGXQ
	S2dK00aMNSS51cxH4Aqieyk6RcfEMDBZ7SOhunePTBnAjH1EQ+qqEaIlZOtO0bedAJoPO81bIlA
	rqd59mjf7QKa8noqXqktBL4575cbGGuGzHhK+RC2iHinRdbEq4FJ75Otd9BRnVrY4jz1Y27ldaZ
	YhW4/e8R5HXqHnHvHm6X9yzj/z2reAD/oQ==
X-Google-Smtp-Source: AGHT+IHXHovEkXcq3uqX3e1HtimIBknbjs5HMoxnnp8KumiSlqVU9zbyFakcZNWYE7aV4ulkNkKdUA==
X-Received: by 2002:a05:600c:46ca:b0:434:a367:2bd9 with SMTP id 5b1f17b1804b1-438913dfd7fmr323573575e9.14.1737709221383;
        Fri, 24 Jan 2025 01:00:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f25csm19410935e9.1.2025.01.24.01.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:19 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip v2 07/14] dt-bindings: rtc: renesas,rzg3s-rtc: Document the Renesas RTCA-3 IP
Date: Fri, 24 Jan 2025 10:59:58 +0200
Message-ID: <20250124090008.1401077-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17629

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


