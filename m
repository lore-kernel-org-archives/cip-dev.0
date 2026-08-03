Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D44C55843
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 14:58:39 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44980.1785769115281143997
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2026 07:58:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VptDyelc;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495437bb891so18499725e9.1
        for <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785769113; x=1786373913; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGdxIqi9XT7g46V7tIMWMIw62jOXEUsmWOphFt8U1k8=;
        b=VptDyelcJt/YBFuRQLceqqUUWwqwzuRqaLc1ypwff7TEyRvPbRmorGv7dXvB1MY2UT
         CfVKQuGt8auCZ5db5OIxrmBc9914NSXyvevAMor0lmddyZMmGeBTpE8N+xq5OcZh+Nv9
         fN2iXNPOMWmjeufWAkSxWQDQ8/lUydFbdxL9E6byYJZWddh+QsmZKYnEq6bc80QF5HWi
         qQnxBUwFu9+yPczx3P8CLQKfraqzQ4ivGQWk8wo2CA9inFgjd6yml2HDgw8rqcMThgs6
         XC/bjsmYIFGrwDFlenQ7l4SFOC9LWI3tie7xEr6OtldVmZnQOzBtjQN/OmA9R5Fo3EMt
         /wuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769113; x=1786373913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gGdxIqi9XT7g46V7tIMWMIw62jOXEUsmWOphFt8U1k8=;
        b=antxqvPTVlRZgBfgDCrxSlj16tEXJexekxgqanPCB0SE8TE85m25jLaPRJoTrGXS9h
         M9leRUgpU0fUnNcZJtV0JcCSDL7GB3xa4r3i3S++6hxteNEfxA1AQGsiwzf7ngyTj6NI
         nsIMFd8ydo5dsP8dyc9mYfesI6zTKRRFNy8dY/8D5zUd0knAjZH0zCbJJ2M82F4EHGFI
         0xbykMGC3lw6+YP/IDC6oEUNsw7So/NpEIUtpMwczV6JfRWtYqfZyFHMzx7qA1wa1rZX
         OBZpCq5rSGuV85y91OM/3T2/Dt51oY1tWINpkncpJ0/DVmCYW+19OlwnQRcQr3ngSNbJ
         E9jw==
X-Gm-Message-State: AOJu0YyWY1tEowMiCP0QgDSYyESnj8ZR9vBF1Mb8hTXYCN9cYepbELXe
	D5mMGjh3YYNVciqwlpyABJWxYvTE2Y/oxcBwDTwe/egt1COyTfkY9dC3pXVefw==
X-Gm-Gg: AR+sD10GvyIa0w7eWfBBgu1Mkox5ki0UGNVCFRRapBkFqqaERC0Es/zAhd9G8GS8T78
	i20MRipntGH9VecgVQhcZN7buDPYjiFFFyMqP2JejB3yQHCkzGcAGJMv2jj8vB8o2Ywa2FXi2kQ
	OfLR7Qeyl3Gg8vjf6HQlkwRT6JCs9tcXkmDcxYzHf8X65YB91xb5TK/qGQZcobG/yJbqvcRQhmq
	o3SnT3KoEQe2UFJ63KeB44MBaNhJngc9QkjCNOt7rQnVnBdOuzpTZP/a222vWvD/OOOZCz/dEXd
	u1SuAuCUMAJO+0BVtSIliDzu6svLZZqIMxP/Yr0SCEM5zagVxqMZDaOoSSjEiaDU66GSYVJAkEv
	Nc1Kpkf3+ezm9h6xZKffi73tF36Hg+EvOZ/3tS5fRfcJzhC0NZbBVqX0f/ULXslV5vzAIURCH8H
	W7/V8aZfvnMxEftnz4LWTh44xufBIrV4tS4AI6DYZUPutzTdjOazA4wEgUezoIqpjlEUcI
X-Received: by 2002:a05:600c:46c3:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-4980eb8d081mr176490445e9.1.1785769113370;
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
Subject: [PATCH 6.12.y-cip 4/7] dt-bindings: watchdog: factor out RZ/N1 watchdog
Date: Mon,  3 Aug 2026 15:58:20 +0100
Message-ID: <20260803145831.91924-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
References: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 14:58:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23858

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit a3e32b41c2ca023f809b3897c537a1aef62046b1 ]

Renesas created different watchdog IPs but they are all handled in the
same binding documentation. This leads to a lot of conditional handling
which makes it unnecessarily hard to add new items. Factor out the RZ/N1
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
 .../bindings/watchdog/renesas,rzn1-wdt.yaml   | 50 +++++++++++++++++++
 .../bindings/watchdog/renesas,wdt.yaml        |  6 ---
 2 files changed, 50 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml
new file mode 100644
index 000000000000..7e3ee533cd56
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/renesas,rzn1-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/N1 Watchdog Timer (WDT) Controller
+
+maintainers:
+  - Wolfram Sang <wsa+renesas@sang-engineering.com>
+
+properties:
+  compatible:
+    items:
+      - const: renesas,r9a06g032-wdt # RZ/N1D
+      - const: renesas,rzn1-wdt      # RZ/N1
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
+  - interrupts
+  - clocks
+
+allOf:
+  - $ref: watchdog.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a06g032-sysctrl.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    watchdog@40008000 {
+            compatible = "renesas,r9a06g032-wdt", "renesas,rzn1-wdt";
+            reg = <0x40008000 0x1000>;
+            interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
+            clocks = <&sysctrl R9A06G032_CLK_WATCHDOG>;
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 8a25e0c6271f..12ba07781763 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -13,11 +13,6 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - items:
-          - enum:
-              - renesas,r9a06g032-wdt    # RZ/N1D
-          - const: renesas,rzn1-wdt      # RZ/N1
-
       - items:
           - enum:
               - renesas,r9a07g043-wdt    # RZ/G2UL and RZ/Five
@@ -134,7 +129,6 @@ allOf:
             contains:
               enum:
                 - renesas,r9a09g077-wdt
-                - renesas,rzn1-wdt
     then:
       required:
         - power-domains
-- 
2.43.0


