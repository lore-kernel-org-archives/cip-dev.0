Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2111DC55184
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 14:58:39 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44981.1785769116183684167
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2026 07:58:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=SyT0I2ZW;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-496b7622a83so14508015e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785769114; x=1786373914; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q1hrO15zrKH9bWKUH34v7gt4TPszSFO3O/i18usnoVQ=;
        b=SyT0I2ZWNzBaA0Y+00c44TiAkURtMLJkVL6LS1MdFE2Z8a12bgx1VK+TTMMEEZxGKJ
         sE+PkvKTFoySofjLCQAeZeN9IgW3a+Ugc/mM3amrC7VuFc+8nDnGI0kjDmn+Y2R4QT2v
         SXdVrzJvg+dl80tK67+3eB++Bq0wKLxAEAMkM1sQgXZBC9rauqAJLmTjMb0n7ThQj+rb
         1+bj9XWPud8kxnnUGJKVcL/BRXC6kQl2WaFLDmIVg3nXMSrHeTeDSdh/bT1L5dnCoVxU
         /227Xff+QryPCtP0JmKjRgO4hfbd0zi7unqAmexJRrVVuy7lz5izi5TUUtxUpxmkgHcd
         D7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769114; x=1786373914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q1hrO15zrKH9bWKUH34v7gt4TPszSFO3O/i18usnoVQ=;
        b=KkiwDDJH3eDP7r7Bwx6jc2Hrvq7DaIkuvqkf2aDojv5Nb+WvXHhFkq38M5oc8T2ZYG
         w3OkXbKBW9uZbpNycVeR4tvVKvAz12h29BZnLFxP1T3m4fQDrykm+7m3nT6qa6dLxb4/
         1rUQjaUypybQdj21ZMyHXzYN1sKrxJ4THofyk/5lJ6zOP8ac1VnWKN64u2Y2GkZThdCi
         DliOfZpH9v+0JR6UGtR9oAwb3YdCXDNJyGwB+a5juEYgUN9XJ07wmSUV0VO/02CCePS2
         3NSeBp+yyjpUaShSeWb9AHVl3Mqu/a/9jIgd8wpoO/NhPSz0zU9yDqOwrCnUuSqOCQ+q
         cREQ==
X-Gm-Message-State: AOJu0YzVOk6lMU7aVHGXtbRkQrs9ZJBNQikSrl9+NB3Nd+BHHcKC2rMI
	n8TuDtolrihJ+eCIrQwooA+xw9tzCsIZaq+GYlwsPwMIc2LCYiDs+/QLNNDB7Q==
X-Gm-Gg: AR+sD10vjHRubfih2LDskfw5W+HLx2vV4+29dQ714nUQBoj7ZBgZEr6P7p+/Pyc5QrB
	598B3L5aeJAeZdZpR/RuZMXsNST4n9HfoDyq074gT9mRhhzOIaAAAEb4hn0Wgvq9oX4Tms1IT2Y
	4RaP+HH3imqhE/xK9VF4F38AvWfmbN+q9GKiRdFBvhqPmQSj6QyeHdJibqzn+bY6YcAf3O8jxqH
	HCEn+ksdtwZEHr0Pqy93Whtc+fdqyvCo0qJ1mjwn3KA2sZZKHrFgItLf/UcXxXPZOyV34MInBiD
	nDwS9bfaty2jdAb7aRPAVOrv/UqV6Tx9pNHb+fhraqoGUOnehxet++DHncKvqOX2w2KuFy0ATFL
	jjZm+6Kak1CD1/+MDlatGj0rdbgVRAAL87qaa3Eogozn+zG/ubR74NcF5I5u1q3Tdq42kWrBJZ3
	lTbqqa7jVXcPEEtUbJXz2cVUkwQlnMdPZpIfzJL24z8A5556oxpcIO0SB7BmXlwl7TSxRR
X-Received: by 2002:a05:600c:3f0d:b0:495:4cb6:71cc with SMTP id 5b1f17b1804b1-4980c66b530mr257510905e9.5.1785769114210;
        Mon, 03 Aug 2026 07:58:34 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:ff9b:eff9:a8e1:4fd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b7afe6sm224754315e9.0.2026.08.03.07.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:58:34 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 6/7] dt-bindings: watchdog: factor out RZ/V2H(P) watchdog
Date: Mon,  3 Aug 2026 15:58:22 +0100
Message-ID: <20260803145831.91924-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
References: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 14:58:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23860

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit fcba2855251ffc83ffbddc9e42a0430578691884 ]

Renesas created different watchdog IPs but they are all handled in the
same binding documentation. This leads to a lot of conditional handling
which makes it unnecessarily hard to add new items. Factor out the
RZ/V2H(P) watchdog to make handling easier.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../watchdog/renesas,r9a09g057-wdt.yaml       | 99 +++++++++++++++++++
 .../bindings/watchdog/renesas,wdt.yaml        | 97 +-----------------
 2 files changed, 104 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml
new file mode 100644
index 000000000000..099200c4f136
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/renesas,r9a09g057-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2H(P) Watchdog Timer (WDT) Controller
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a09g047-wdt # RZ/G3E
+              - renesas,r9a09g056-wdt # RZ/V2N
+          - const: renesas,r9a09g057-wdt # RZ/V2H(P)
+
+      - items:
+          - const: renesas,r9a09g087-wdt # RZ/N2H
+          - const: renesas,r9a09g077-wdt # RZ/T2H
+
+      - enum:
+          - renesas,r9a09g057-wdt    # RZ/V2H(P)
+          - renesas,r9a09g077-wdt    # RZ/T2H
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    minItems: 1
+    items:
+      - description: Register access clock
+      - description: Main clock
+
+  clock-names:
+    minItems: 1
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
+  - clocks
+  - clock-names
+  - power-domains
+
+allOf:
+  - $ref: watchdog.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-wdt
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
+        reg:
+          minItems: 2
+        resets: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a09g057-cpg.h>
+
+    watchdog@11c00400 {
+            compatible = "renesas,r9a09g057-wdt";
+            reg = <0x11c00400 0x400>;
+            clocks = <&cpg CPG_MOD 0x4b>, <&cpg CPG_MOD 0x4c>;
+            clock-names = "pclk", "oscclk";
+            resets = <&cpg 0x75>;
+            power-domains = <&cpg>;
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 2a15c012fd67..08ba128bf442 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -51,38 +51,14 @@ properties:
               - renesas,r8a779h0-wdt     # R-Car V4M
           - const: renesas,rcar-gen4-wdt # R-Car Gen4
 
-      - items:
-          - enum:
-              - renesas,r9a09g047-wdt # RZ/G3E
-              - renesas,r9a09g056-wdt # RZ/V2N
-          - const: renesas,r9a09g057-wdt # RZ/V2H(P)
-
-      - enum:
-          - renesas,r9a09g057-wdt    # RZ/V2H(P)
-          - renesas,r9a09g077-wdt    # RZ/T2H
-
-      - items:
-          - const: renesas,r9a09g087-wdt # RZ/N2H
-          - const: renesas,r9a09g077-wdt # RZ/T2H
-
   reg:
-    minItems: 1
-    maxItems: 2
+    maxItems: 1
 
   interrupts:
     maxItems: 1
 
   clocks:
-    minItems: 1
-    items:
-      - description: Register access clock
-      - description: Main clock
-
-  clock-names:
-    minItems: 1
-    items:
-      - const: pclk
-      - const: oscclk
+    maxItems: 1
 
   power-domains:
     maxItems: 1
@@ -96,76 +72,13 @@ required:
   - compatible
   - reg
   - clocks
+  - interrupts
+  - power-domains
+  - resets
 
 allOf:
   - $ref: watchdog.yaml#
 
-  - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              enum:
-                - renesas,r9a09g077-wdt
-    then:
-      required:
-        - power-domains
-        - resets
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - renesas,r9a09g057-wdt
-    then:
-      properties:
-        clocks:
-          minItems: 2
-        clock-names:
-          minItems: 2
-      required:
-        - clock-names
-    else:
-      properties:
-        clocks:
-          maxItems: 1
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - renesas,r9a09g057-wdt
-              - renesas,r9a09g077-wdt
-    then:
-      properties:
-        interrupts: false
-        interrupt-names: false
-    else:
-      required:
-        - interrupts
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: renesas,r9a09g077-wdt
-    then:
-      properties:
-        resets: false
-        clock-names:
-          maxItems: 1
-        reg:
-          minItems: 2
-      required:
-        - clock-names
-        - power-domains
-    else:
-      properties:
-        reg:
-          maxItems: 1
-
 additionalProperties: false
 
 examples:
-- 
2.43.0


