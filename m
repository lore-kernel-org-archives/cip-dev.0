Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F166DC27C75
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:40 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web11.42969.1717769253984221579
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=XXWUsrXF;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.182, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaad2c670aso22870521fa.1
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769252; x=1718374052; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuFrhNWP6t8VQyXp9dFcTbfifanXPHZ8V/2rNC+tFpM=;
        b=XXWUsrXFlgDYgxJNia1WVYd4ALCszJwrNJlU/bPawfh/ONhHz0oKvmT5il5d6kU/nF
         VokZ2ZtxRnRsAqQz3pAm0C+V33//a+uzJ+0gLLhkTx0bYLsrWH+bKV5zm2Y5HXEEVn5v
         sxZJfDojbrOykgt8UdkoS2TSrFrWt3N3On3rUYpqX38MHhsXkKCzl4OW4cUHs7yZ2zbh
         2UXQndGe7GcB5ZVB4ewkcjya9ebv/8ireAEEGKPpn4GzvqcIJCeSGiKgkY/RnCrD2ONx
         WkAQKNzEeRFE2u7RwXzzNu9L/Xp9goOi/g5bOU3EaH+iUfg7Z4hRfiDstkxDQLPtpLUu
         BBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769252; x=1718374052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuFrhNWP6t8VQyXp9dFcTbfifanXPHZ8V/2rNC+tFpM=;
        b=mRYr0pGt75KiabTcrH8pw6fKrpVvzoMX7/qRm56sehRF410P7bcaQxLmH3MTYaEPJO
         uxYMgXtWUzUXacPCQZpiXcVjH14c5UqhZ0DZviv30zGWy2/4b6v1/t7wQWsLNPtIGMIy
         I/+KBHoLhGq8re/WHbJiQxwzCoamcBHgXBom1vzDrbwR322wMXNOcJX9zt8j+mZPBkFp
         U+CZOhXWnQ1O7V4rIDUVA9iyaXQMczdhQbqhOp5rFVua+UWb5Spy2L/OKpIEecesn+53
         KaNmyxRE2pCmzaC/UK/RwBuG+oszgEW2b/bmCQEQzbv0vNjBA/+N2c8E57UFM9tnceBV
         vnDg==
X-Gm-Message-State: AOJu0Ywozvd7LVqVE49h0ZClLpcIDWqhDELwh1v8BBx3+g5A8taxvOxM
	KrPGw7RWqVCgePHp/3Fq0fBuXRMlu3BcRMj9Ko0bjdPX1qWIUayA6jz4dVu33ARdzZhZ1tCg5II
	D
X-Google-Smtp-Source: AGHT+IEiR3Ud+qHjIuiJhAOf2VBuN0JZDbkM++HWpjJU6CeWiq/jGM7XwXvYXz31JRwo8hFFjFChcA==
X-Received: by 2002:a2e:a309:0:b0:2ea:e00d:cd48 with SMTP id 38308e7fff4ca-2eae00dd3c5mr12541311fa.9.1717769252190;
        Fri, 07 Jun 2024 07:07:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:31 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 13/19] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G2UL SoC
Date: Fri,  7 Jun 2024 17:07:05 +0300
Message-Id: <20240607140711.2497286-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16154

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit db712c0089bd8e9e47c286ed772d86fb187d0854 upstream.

Document RZ/G2UL (R9A07G043U) IRQC bindings. The IRQC block on RZ/G2UL SoC
is almost identical to one found on the RZ/G2L SoC the only difference
being it can support BUS_ERR_INT for which it has additional registers.
Hence new generic compatible string "renesas,r9a07g043u-irqc" is added
for RZ/G2UL SoC.

Now that we have additional interrupt for RZ/G2UL and RZ/Five SoC
interrupt-names property is added so that we can parse them based on
names.

While at it updated the example node to four spaces and added
interrupt-names property.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20231006121058.13890-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../renesas,rzg2l-irqc.yaml                   | 225 +++++++++++++-----
 1 file changed, 170 insertions(+), 55 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index ea7db3618b23..2ef3081eaaf3 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -19,13 +19,11 @@ description: |
     - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
       stand-up edge detection interrupts)
 
-allOf:
-  - $ref: /schemas/interrupt-controller.yaml#
-
 properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043u-irqc   # RZ/G2UL
           - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
           - renesas,r9a07g054-irqc    # RZ/V2L
       - const: renesas,rzg2l-irqc
@@ -45,7 +43,96 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 41
+    minItems: 41
+    items:
+      - description: NMI interrupt
+      - description: IRQ0 interrupt
+      - description: IRQ1 interrupt
+      - description: IRQ2 interrupt
+      - description: IRQ3 interrupt
+      - description: IRQ4 interrupt
+      - description: IRQ5 interrupt
+      - description: IRQ6 interrupt
+      - description: IRQ7 interrupt
+      - description: GPIO interrupt, TINT0
+      - description: GPIO interrupt, TINT1
+      - description: GPIO interrupt, TINT2
+      - description: GPIO interrupt, TINT3
+      - description: GPIO interrupt, TINT4
+      - description: GPIO interrupt, TINT5
+      - description: GPIO interrupt, TINT6
+      - description: GPIO interrupt, TINT7
+      - description: GPIO interrupt, TINT8
+      - description: GPIO interrupt, TINT9
+      - description: GPIO interrupt, TINT10
+      - description: GPIO interrupt, TINT11
+      - description: GPIO interrupt, TINT12
+      - description: GPIO interrupt, TINT13
+      - description: GPIO interrupt, TINT14
+      - description: GPIO interrupt, TINT15
+      - description: GPIO interrupt, TINT16
+      - description: GPIO interrupt, TINT17
+      - description: GPIO interrupt, TINT18
+      - description: GPIO interrupt, TINT19
+      - description: GPIO interrupt, TINT20
+      - description: GPIO interrupt, TINT21
+      - description: GPIO interrupt, TINT22
+      - description: GPIO interrupt, TINT23
+      - description: GPIO interrupt, TINT24
+      - description: GPIO interrupt, TINT25
+      - description: GPIO interrupt, TINT26
+      - description: GPIO interrupt, TINT27
+      - description: GPIO interrupt, TINT28
+      - description: GPIO interrupt, TINT29
+      - description: GPIO interrupt, TINT30
+      - description: GPIO interrupt, TINT31
+      - description: Bus error interrupt
+
+  interrupt-names:
+    minItems: 41
+    items:
+      - const: nmi
+      - const: irq0
+      - const: irq1
+      - const: irq2
+      - const: irq3
+      - const: irq4
+      - const: irq5
+      - const: irq6
+      - const: irq7
+      - const: tint0
+      - const: tint1
+      - const: tint2
+      - const: tint3
+      - const: tint4
+      - const: tint5
+      - const: tint6
+      - const: tint7
+      - const: tint8
+      - const: tint9
+      - const: tint10
+      - const: tint11
+      - const: tint12
+      - const: tint13
+      - const: tint14
+      - const: tint15
+      - const: tint16
+      - const: tint17
+      - const: tint18
+      - const: tint19
+      - const: tint20
+      - const: tint21
+      - const: tint22
+      - const: tint23
+      - const: tint24
+      - const: tint25
+      - const: tint26
+      - const: tint27
+      - const: tint28
+      - const: tint29
+      - const: tint30
+      - const: tint31
+      - const: bus-err
 
   clocks:
     maxItems: 2
@@ -73,6 +160,23 @@ required:
   - power-domains
   - resets
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a07g043u-irqc
+    then:
+      properties:
+        interrupts:
+          minItems: 42
+        interrupt-names:
+          minItems: 42
+      required:
+        - interrupt-names
+
 unevaluatedProperties: false
 
 examples:
@@ -81,55 +185,66 @@ examples:
     #include <dt-bindings/clock/r9a07g044-cpg.h>
 
     irqc: interrupt-controller@110a0000 {
-            compatible = "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
-            reg = <0x110a0000 0x10000>;
-            #interrupt-cells = <2>;
-            #address-cells = <0>;
-            interrupt-controller;
-            interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
-                     <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
-            clock-names = "clk", "pclk";
-            power-domains = <&cpg>;
-            resets = <&cpg R9A07G044_IA55_RESETN>;
+        compatible = "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
+        reg = <0x110a0000 0x10000>;
+        #interrupt-cells = <2>;
+        #address-cells = <0>;
+        interrupt-controller;
+        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "nmi",
+                          "irq0", "irq1", "irq2", "irq3",
+                          "irq4", "irq5", "irq6", "irq7",
+                          "tint0", "tint1", "tint2", "tint3",
+                          "tint4", "tint5", "tint6", "tint7",
+                          "tint8", "tint9", "tint10", "tint11",
+                          "tint12", "tint13", "tint14", "tint15",
+                          "tint16", "tint17", "tint18", "tint19",
+                          "tint20", "tint21", "tint22", "tint23",
+                          "tint24", "tint25", "tint26", "tint27",
+                          "tint28", "tint29", "tint30", "tint31";
+        clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
+                 <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
+        clock-names = "clk", "pclk";
+        power-domains = <&cpg>;
+        resets = <&cpg R9A07G044_IA55_RESETN>;
     };
-- 
2.39.2


