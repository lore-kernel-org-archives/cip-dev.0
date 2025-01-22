Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64740C0218F
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:51:40 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.41873.1737546693642615292
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:51:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=IywmWmdl;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso48680665e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546692; x=1738151492; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjtRyfTgZS3PaUggTQ0LoCLu4U5xv/Jge0GwFBL9qQY=;
        b=IywmWmdlKdmXrbOwXARpTSeSbOpVM9LsBQ1w+VkeZHz5AbNcIob8P6CngbZT5CeBe1
         yhvxCwaF3hqLDYGP5Of0QtZ9SVN9HZ+BGIVnkw+ICwCDrGDVfxlIAebUhAhfv7YkSxPM
         LV5ITK7BIUNTMPSTyo+FlP8SfqIC1SRU9OkvonpEcYdFNfiq7eIdciLcYf6b+w3edX0y
         +UMahClBnEmfY3Adwj6lkxcQkssUoXIpJ7rWeNPsrImENWM3O942TRVikRRq8lBdXJhX
         One1Z4kwEP4aXX0G1tihiuz/XKiLs8ebpEFDeuwktVWMDI5omfpPZkuBNJpowPHymM4l
         ZCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546692; x=1738151492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjtRyfTgZS3PaUggTQ0LoCLu4U5xv/Jge0GwFBL9qQY=;
        b=YnrBoj2hlgSZci4ThjNz7+4xHOAlyZSs5Ak+IdZXvJLjhi8Hmhm4Uq/NwRg6arxEkX
         /s1Db2bs7FIW3GW66aPlYl+4DdXc+6RAusaQCXV/Au9f8+3k357y+87WCKkjjgyVfhkm
         trgvk1b+1KGlAV4wKdmZt25e+NC+m54FH4A4d2rFM6A8GnJdWSH8GEfTBxG1qrxy1tOW
         xkKcMni82qBX+CDQz/UuZrDubRUuwqpF5kUXyW/Gn3nNwRPduFGcgm8z5khuedu2WKPz
         oiy1NJelwy/RfytxOKhHcFwvBc63jehkP+6LfyIwCd2tmcFsYKxEpJz+sEYRMYaDFgVt
         Qbfw==
X-Forwarded-Encrypted: i=1; AJvYcCUmEonqmU0tDM6Xgy6s5yCVA5hOYcyVzqzzj8gczdoZ2g12ir5YhqqFGEW/PcoW9HtNAERUARiS@lists.cip-project.org
X-Gm-Message-State: AOJu0YzcPaUx+ztP2YeySlqkiQcZAE78pDux3JWI9N5bl/RgSN0M6BBi
	jUN8S5t42KERhndgcj9TYbiL7iwUgV3ODRTEH9AvWKUrFFedP+vg8Ra3EgILNmfDZRH/KUstTc5
	I
X-Gm-Gg: ASbGnctacYNbef6tom5gzipi6j55aeUg2BEz0pI4fHKcD8xbrEdxMsRRsQBdeM5WD77
	Cgy0dPqU42pMacWw5RI89GRedluL7FWMwoaB+ZuUZuQMwAodFyhHByIdgU1YNrW0ErSJgSNevaW
	cUQmSr/2rj6IsDqcXnIrFLqcI6Bm0drBFHCkgkxE+CpzN3+d2OlE6LBSozVCkm8ZYbtuMbt5SiH
	8wOWyYFm2336Zd2n21rwjg8WB3Oe8gjLbKTsqm9h9Qli03O5GGdA/EEMPyLx8qKlnVI2To0ZW/F
	MHYCmjDlkznoIVHXYaJcb60=
X-Google-Smtp-Source: AGHT+IHSEQdmq4FDN+t5dJr+rD7z/rV0BOLRL+Ogd8JbqV0tW2xAKvJtFB/0ZJmL+Yc8rd2wDTqzFQ==
X-Received: by 2002:a05:600c:46c5:b0:434:a4b3:5ebe with SMTP id 5b1f17b1804b1-438914297c0mr190529085e9.24.1737546692008;
        Wed, 22 Jan 2025 03:51:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm21474765e9.21.2025.01.22.03.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:51:30 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 07/14] dt-bindings: rtc: renesas,rzg3s-rtc: Document the Renesas RTCA-3 IP
Date: Wed, 22 Jan 2025 13:51:12 +0200
Message-ID: <20250122115120.2885015-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:51:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17570

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


