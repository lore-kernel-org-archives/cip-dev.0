Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B26C55838
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 14:58:39 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44978.1785769114850512312
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2026 07:58:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=eZAVBaXG;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4955158f26aso15205895e9.3
        for <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785769113; x=1786373913; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gZ01bU9+RTEjsEc+NhxggyVqD8gmVZLpubMSG3sw9PI=;
        b=eZAVBaXGS+JfpfV6cMpz5xPdFNhQuR8NXkcwuQrCEGLPU0tODIZhxUVn/52lFSSQHo
         WNPwk4hTUwkaFHdFSTlZYg6//1PqOf2wCDaBo7AI46QjDbgZxzwLJpNIZ/jDMLt6QrC8
         memk0QduZzqcd6ZgQHiHzie5Z5aiPV+Sl0w3LfTWH5KfXLLq59KgohmE0A4mzt49MbJz
         tUsTutszHHre0tBgrVPR0A7u4dNJpBBOGr8Al28P0QWAb30OkDv826e5LcdnTP11tXSe
         r+HXH7s/bQgD0baREXZksO1qvYc+YkogKyETDu2P6G0whVJX8rxNV3Ln0ll6eiAAqo8t
         OH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769113; x=1786373913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gZ01bU9+RTEjsEc+NhxggyVqD8gmVZLpubMSG3sw9PI=;
        b=KWpIqDD2+bUy+r0EYZHf7R0u7D+PpEqN5MMpKJPZEck6CkY3UWFgQIaLi3zzR52jMh
         slZ0RCYa2KlHwzxM2JguecRBplgxI+ropPduKI4db0+/Tsgd2xSAITibgGgavXlltskN
         e9J83dPZkavIHVEprvgBCnm4CjqsAw1/yIhIANSt4jkZno/6WWmUltovoGbKEzGUkCeG
         ol0pKRC7qNpufBGtGt5biJ3foE3ILhS/5S0u0mDnYb8Rab5MNnbBycB1HfjZ+Xn9d6h0
         wkZAC1FnpQwGBI8BDR3VzUgnBD5/925fNJzCDPxrYtO8CXFpmxyzumWSVDMLV2t/xPPB
         sbhg==
X-Gm-Message-State: AOJu0YwtEwpLtbD2bMeVPL+7ITnyxn9hXl0xbOjv5e7094kBnd5TJYoL
	vRwMInj+jYskXZrVCQdTTlhBJRFm70s5XmATKeIJCsXFVcJasHNRnF5FyL7b+w==
X-Gm-Gg: AR+sD13w73eEHjKZH+a39XVeLNivhImULi6Er2Q4nvHoUr0ZTdcWEj28UTl9gMHBFw4
	rL3J8FjsUv4hTntVW3LzBwwDm8leDYNv+2CGaycYRVjHNsyaTkoFO6ts+PwfSfMbAQ0ZsP6ICXf
	gCogSG2sKmj4MaWqot3fnl5nzOZRzRtAt+8kwT74DToRPrCovQW6dGiyU8srN4SbA8GTR9ReHq1
	NcIvsPB3DQCn1+kJlOMLAunTIztJYbg4TSxlTcc0TpxAiexFsqdJEvuS7+eqb6IbpccbKug9SLR
	mnq/pt6ZZ9xDgCTahVztdx3E3jafoEexjUu8VLM1am3XKIDVbLIOGZ0T/heT35UZko58qrgWEET
	G6advDSXajsCojNHHfSre6YYnLeECR80h4v5srL/4FkgPd03PVMRqsNAltMqkAuYjKg42Znxbtq
	vpCK1/oqDeywmUZV8KGc+Z3OMMzT9tdSvVaTISM/fESFYdTTq+UCAk7YVjHe8vk8Wu3tFQQVZUM
	ChTyAc=
X-Received: by 2002:a05:600c:2294:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-4980c67af97mr191759485e9.15.1785769113000;
        Mon, 03 Aug 2026 07:58:33 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:ff9b:eff9:a8e1:4fd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b7afe6sm224754315e9.0.2026.08.03.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:58:32 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 3/7] dt-bindings: watchdog: factor out RZ/A watchdog
Date: Mon,  3 Aug 2026 15:58:19 +0100
Message-ID: <20260803145831.91924-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
References: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 14:58:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23857

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 055f0576e82a732bd5f8d2dd06ecad21eac13b59 ]

Renesas created different watchdog IPs but they are all handled in the
same binding documentation. This leads to a lot of conditional handling
which makes it unnecessarily hard to add new items. Factor out the RZ/A
watchdog to make handling easier.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/watchdog/renesas,rza-wdt.yaml    | 51 +++++++++++++++++++
 .../bindings/watchdog/renesas,wdt.yaml        |  7 ---
 2 files changed, 51 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas,rza-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,rza-wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,rza-wdt.yaml
new file mode 100644
index 000000000000..ba922c3f7b10
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/renesas,rza-wdt.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/renesas,rza-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/A Watchdog Timer (WDT) Controller
+
+maintainers:
+  - Wolfram Sang <wsa+renesas@sang-engineering.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r7s72100-wdt     # RZ/A1
+          - renesas,r7s9210-wdt      # RZ/A2
+      - const: renesas,rza-wdt       # RZ/A
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  timeout-sec: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+allOf:
+  - $ref: watchdog.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r7s72100-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    watchdog@fcfe0000 {
+            compatible = "renesas,r7s72100-wdt", "renesas,rza-wdt";
+            reg = <0xfcfe0000 0x6>;
+            interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&p0_clk>;
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index b6e60162c263..8a25e0c6271f 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -13,12 +13,6 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - items:
-          - enum:
-              - renesas,r7s72100-wdt     # RZ/A1
-              - renesas,r7s9210-wdt      # RZ/A2
-          - const: renesas,rza-wdt       # RZ/A
-
       - items:
           - enum:
               - renesas,r9a06g032-wdt    # RZ/N1D
@@ -140,7 +134,6 @@ allOf:
             contains:
               enum:
                 - renesas,r9a09g077-wdt
-                - renesas,rza-wdt
                 - renesas,rzn1-wdt
     then:
       required:
-- 
2.43.0


