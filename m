Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326C6C5518F
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 14:58:39 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45076.1785769115683607860
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2026 07:58:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=WBa6nV3h;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4980dc26022so14043365e9.1
        for <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785769114; x=1786373914; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WV2Rxm9XeHXZXuR+NDfwoDJ+oABhwQmS/kR0E9z9yus=;
        b=WBa6nV3hsKMkfmAMUwpdWDSq2oRxIBAHdj+WRoQMR4RlYwY/AH5luOlQVlxHbaTX8M
         I+Qphd5tpS2cpdGQE0oEnJGAF6ZcICI/+Z0tu1hFmOcCjqofeevbrzM5I7PoXKHBdBgH
         x8R0WiIxhC18/TGw+uC1jc3jo/vQG/5LKhXJF9OGW9Wffx3MvV9V9yZlA7/7yEIOO/uv
         Faw2wju5Ss7lsZww4V/Zbab9G47d9mFx7SN4nJBvrYE9eV3AbkITA4xnntgzCY17cFDV
         PqALJycFceeFWKGCoM9Gwzdjfbk8TcLErjzkOOanGvg8j3Z9zCluIR0qmdc/kJMts6aX
         kLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769114; x=1786373914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WV2Rxm9XeHXZXuR+NDfwoDJ+oABhwQmS/kR0E9z9yus=;
        b=qs4Zejjr9C/PLeggnPW3B9QaddtkJUf4x24qEm+yiZAm3xG+UwtqQYNOwpkBfLH29P
         d+C4oivVuc9cU2JIpl9FXzgssY3arlEpBdkI2/LCpMB0eV0p57ynIc36/fC8V8ENQ/Ch
         Uhin72XihvupLEm7bktTHr9glUaBONl782RNC2ylLFwesxSbjEjfyiFQ3gkWT0B92mJf
         ADvszD/IiaKDimY1Ol/73oRMb2AsTPdW8eH1iJONhCXhAsn5Pz9Bx/UaXW6/DZzrSsJF
         EVC0dltAJgV7IOpcVYnoCB6rGB6pJdn+Ch2xCE8Oda8crBQ/dbSRp2qbE1MjjcZFWe+s
         z9aQ==
X-Gm-Message-State: AOJu0YxLX9kOxncE0zMe3+Ty0vMQ/LsGU4pdmASgjHiQYPMLyXgDrSrB
	emZVKkhkyrWkf/fs4eKwr8uXB6psu/U1YbDswBVE1Qw95jAZ4iVe2eCv6nVw7g==
X-Gm-Gg: AR+sD124l1u43HEW+dX6QfWcBEn0yBf3QD8XvUMdyyAI7bLeor90dPWg21MHa+18kJw
	FMmjrxXRpgkKXX9xf33eI82gLJk+WejxmwpxkNth7Y9LFPFyn3TkStzxEkkaY2adMiYq+B9S/Oa
	OiPDP/6YIXalF8bJ8O/BIVA7onL8LsMA4CpthBTgzmSy6wPXW+kybCsQrSiLTxPdqMGYIqCrZJ6
	wmRScJyVT750feZkHolHaKkACFk+CbHj7J6986hxfZEmkKqc9jQT7BDCra8jjuxJH0FQiv3Kgmf
	HFUPL3HL6to21ZYChkGqPsFBi3Pl4Q5GP6H4toFT6AKERu0i14S1IdsYHety72zVS3PTp8rl5d3
	0PS7ZCPiuNIOagET5roUULLXJjXBwVLk5gXuxznKSEhSPYIQb9Apy0blHdh9uWqZap1NOHycYps
	EqZlbDoysVBoz4K8qJ12AhabD9xZ+6v2JyRsh7AE1J+6ME24YeiKxBG+QqX9BuosDSEPYb
X-Received: by 2002:a05:600c:6092:b0:497:ff28:6deb with SMTP id 5b1f17b1804b1-4980c64b8bfmr270718075e9.11.1785769113824;
        Mon, 03 Aug 2026 07:58:33 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:ff9b:eff9:a8e1:4fd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b7afe6sm224754315e9.0.2026.08.03.07.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:58:33 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 5/7] dt-bindings: watchdog: factor out RZ/G2L watchdog
Date: Mon,  3 Aug 2026 15:58:21 +0100
Message-ID: <20260803145831.91924-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
References: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 14:58:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23859

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 909c8ea1ad018a4a419ae8c0fb80439eb3ea94c0 ]

Renesas created different watchdog IPs but they are all handled in the
same binding documentation. This leads to a lot of conditional handling
which makes it unnecessarily hard to add new items. Factor out the
RZ/G2L watchdog to make handling easier.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/watchdog/renesas,rzg2l-wdt.yaml  | 111 ++++++++++++++++++
 .../bindings/watchdog/renesas,wdt.yaml        |  45 +------
 2 files changed, 112 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas,rzg2l-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,rzg2l-wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,rzg2l-wdt.yaml
new file mode 100644
index 000000000000..a4d06c9c8b86
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/renesas,rzg2l-wdt.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/renesas,rzg2l-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L Watchdog Timer (WDT) Controller
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043-wdt    # RZ/G2UL and RZ/Five
+              - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
+              - renesas,r9a07g054-wdt    # RZ/V2L
+              - renesas,r9a08g045-wdt    # RZ/G3S
+          - const: renesas,rzg2l-wdt
+
+      - items:
+          - const: renesas,r9a09g011-wdt # RZ/V2M
+          - const: renesas,rzv2m-wdt     # RZ/V2M
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: Timeout
+      - description: Parity error
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: wdt
+      - const: perrout
+
+  clocks:
+    items:
+      - description: Register access clock
+      - description: Main clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: oscclk
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  timeout-sec: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+
+allOf:
+  - $ref: watchdog.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rzg2l-wdt
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+        interrupt-names:
+          minItems: 2
+      required:
+        - interrupt-names
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          maxItems: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    watchdog@12800800 {
+            compatible = "renesas,r9a07g044-wdt",
+                         "renesas,rzg2l-wdt";
+            reg = <0x12800800 0x400>;
+            clocks = <&cpg CPG_MOD R9A07G044_WDT0_PCLK>,
+                     <&cpg CPG_MOD R9A07G044_WDT0_CLK>;
+            clock-names = "pclk", "oscclk";
+            interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "wdt", "perrout";
+            resets = <&cpg R9A07G044_WDT0_PRESETN>;
+            power-domains = <&cpg>;
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 12ba07781763..2a15c012fd67 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -13,19 +13,6 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - items:
-          - enum:
-              - renesas,r9a07g043-wdt    # RZ/G2UL and RZ/Five
-              - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
-              - renesas,r9a07g054-wdt    # RZ/V2L
-              - renesas,r9a08g045-wdt    # RZ/G3S
-          - const: renesas,rzg2l-wdt
-
-      - items:
-          - enum:
-              - renesas,r9a09g011-wdt    # RZ/V2M
-          - const: renesas,rzv2m-wdt     # RZ/V2M
-
       - items:
           - enum:
               - renesas,r8a7742-wdt      # RZ/G1H
@@ -83,16 +70,7 @@ properties:
     maxItems: 2
 
   interrupts:
-    minItems: 1
-    items:
-      - description: Timeout
-      - description: Parity error
-
-  interrupt-names:
-    minItems: 1
-    items:
-      - const: wdt
-      - const: perrout
+    maxItems: 1
 
   clocks:
     minItems: 1
@@ -140,8 +118,6 @@ allOf:
           contains:
             enum:
               - renesas,r9a09g057-wdt
-              - renesas,rzg2l-wdt
-              - renesas,rzv2m-wdt
     then:
       properties:
         clocks:
@@ -155,25 +131,6 @@ allOf:
         clocks:
           maxItems: 1
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - renesas,rzg2l-wdt
-    then:
-      properties:
-        interrupts:
-          minItems: 2
-        interrupt-names:
-          minItems: 2
-      required:
-        - interrupt-names
-    else:
-      properties:
-        interrupts:
-          maxItems: 1
-
   - if:
       properties:
         compatible:
-- 
2.43.0


