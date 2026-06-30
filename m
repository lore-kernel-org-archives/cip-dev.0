Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD8AC43327
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:36 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19065.1782820113577823166
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=OBt9YQuj;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4720f3bf164so298747f8f.1
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820112; x=1783424912; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loGB6/7AS0H/JYXAU3fdfnkjmPYDugpytFjlWsS/maM=;
        b=OBt9YQujJXo5Yu7H0Rd3Bj8NLjiQ/fDBCzA5CCaM3XPmRPPNCQQamRLMO2ZbVEZP1h
         5TwQD8EtdpmnAdbxcLhVd0IfNobQ+U4hCsd58oUlMg8D1oReWFHHkzUAwjxKo8MiTbjF
         H8i4bTwsmzbwW0IrjWnYVWLmLdifOUp3b1u5BQ6RZ/EGQ6cUg9Q21WpKg2pzT8xt77RU
         0K4B++X2v00kN1uKbLv+0gtxc9dCBwB0GIJt9snNvAEvx4E4/InZI8BzpE6NEI1doGMe
         NsIHnrSfqKgY2w+93Ih6YZmeWilwl2QTHzU4LEpoJyZ9AuXeF0BDcn6Qhuw6iKi3BU4f
         8JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820112; x=1783424912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=loGB6/7AS0H/JYXAU3fdfnkjmPYDugpytFjlWsS/maM=;
        b=J/lQjPUe8Y915Ik3QsK4P+/+0E16VWqo9i6yx6KaneQgQXQ31Yql8yGlMTtN7rfny9
         T0EMBPrYEgx/fg0TzbPBHWM+8Ndj9IAmKDm9Xaj3vInE7AI7d2tX3u2guZ0EkUYL6+Hp
         hi7AzkRdBAraTr/pX/2Y3Fqnaevi3aMbKSTrPNF8rSI66KWhf4yMgXjYVoRPM0aO9CLi
         gf7+0yk3kkyrRR8aWZ+K9NYxZxinTvwxROgUjbjRwb4pTyuR/3E6/ViDaxaHj3YTHGIF
         ls8G/SDo/Sz+S1lpAvOAFy8CrzHgVpycpm1PV4UYufkx2SQtg33yBpVdbX4Eh08ppavi
         GCzg==
X-Gm-Message-State: AOJu0Yy8ezsPr2U6mLFQZAXa8YpmjI2Va4n9ktDNiqSJYaXw8a9s1sDP
	65baSCC2UB0U7/XiOaj4uqsydMEf++pN8BbtxskgJxftMGjgiIFe4N2+IAf8j+zX
X-Gm-Gg: AfdE7cnUDukqZDiZQQZQ9lazNYdZbPnwsG6JhbwNIE9WquopxNavdEhNFJ2NqtWqxEX
	HGis8rQMebh+soHn3BNeG+lKm6D7SzTXZQnwLXfMzQbheIs+6+wtct0pHoMOeXlXPwQvOlSbG3G
	YzMu3fQ+s1fmHCRwCODKx71wZnbrdo/Ni6A8d21cEz1OJO+4+hxMKu6VOpCC/yhItGN/nPGPrvs
	9g8Yne+KhfWkm6I8De0ZxWwYC0rX/o5vRgSJ9qGuE8pyCHYD5FAKAx/28FKwERXEHohBwMsSRcG
	5BRmZvVW9bwQ5hsToKc0SlrwQTCZPTHzGbPRSRsLd9pWWqrIK1LGJUsf6JXBmxvVLOr9NevE+7d
	49vdTA5UK423lIIPjVL/UQzRVbtkVP7i9c/EsRlTGEeRx/ZMnxnU6NKpdpHJgAW5nKw6r2e0Qqa
	ET7BiNncWUqiOGKdpDviAngYgmG+YSU689+2B7nw==
X-Received: by 2002:a5d:584e:0:b0:46e:6959:35a7 with SMTP id ffacd0b85a97d-475f6e773f8mr1969750f8f.22.1782820111567;
        Tue, 30 Jun 2026 04:48:31 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:27 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/39] dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L SoC
Date: Tue, 30 Jun 2026 12:47:21 +0100
Message-ID: <20260630114813.92739-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23326

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 3ac2aa31b489eb4e0e820757f336aa1ad41ed0e2 ]

Add device tree binding support for the Gigabit Ethernet (GBETH) IP on
Renesas RZ/G3L SoC. This SoC uses different Synopsys DesignWare MAC
version 5.30 compared to RZ/G3E.

RZ/G3L requires an extra clock compared to RZ/G3E and has pps interrupts.

Add a new compatible string "renesas,r9a08g046-gbeth" for RZ/G3L SoC and
update the schema to handle hardware differences between SoC variants.

Extend the base snps,dwmac.yaml schema to accommodate the PPS interrupts.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20260131161250.5047-2-biju.das.jz@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/net/renesas,rzv2h-gbeth.yaml     | 77 ++++++++++++++++---
 .../devicetree/bindings/net/snps,dwmac.yaml   |  3 +
 2 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
index bd53ab300f50..fb60f745a1ff 100644
--- a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
@@ -26,6 +26,9 @@ select:
 properties:
   compatible:
     oneOf:
+      - items:
+          - const: renesas,r9a08g046-gbeth # RZ/G3L
+          - const: snps,dwmac-5.30a
       - items:
           - enum:
               - renesas,r9a09g047-gbeth # RZ/G3E
@@ -47,13 +50,17 @@ properties:
   clocks:
     oneOf:
       - items:
-          - description: CSR clock
-          - description: AXI system clock
+          - description: CSR/Register access clock
+          - description: AXI system/Main clock
           - description: PTP clock
           - description: TX clock
           - description: RX clock
           - description: TX clock phase-shifted by 180 degrees
           - description: RX clock phase-shifted by 180 degrees
+          - description: RMII clock
+
+        minItems: 7
+
       - items:
           - description: CSR clock
           - description: AXI system clock
@@ -69,6 +76,10 @@ properties:
           - const: rx
           - const: tx-180
           - const: rx-180
+          - const: rmii
+
+        minItems: 7
+
       - items:
           - const: stmmaceth
           - const: pclk
@@ -88,6 +99,22 @@ properties:
           - const: tx-queue-1
           - const: tx-queue-2
           - const: tx-queue-3
+      - items:
+          - const: macirq
+          - const: eth_wake_irq
+          - const: eth_lpi
+          - const: rx-queue-0
+          - const: rx-queue-1
+          - const: rx-queue-2
+          - const: rx-queue-3
+          - const: tx-queue-0
+          - const: tx-queue-1
+          - const: tx-queue-2
+          - const: tx-queue-3
+          - const: ptp-pps-0
+          - const: ptp-pps-1
+          - const: ptp-pps-2
+          - const: ptp-pps-3
       - items:
           - const: macirq
           - const: eth_wake_irq
@@ -135,6 +162,27 @@ required:
 allOf:
   - $ref: snps,dwmac.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g046-gbeth
+    then:
+      properties:
+        clocks:
+          minItems: 8
+
+        clock-names:
+          minItems: 8
+
+        interrupts:
+          minItems: 15
+          maxItems: 15
+
+        interrupt-names:
+          minItems: 15
+          maxItems: 15
+
   - if:
       properties:
         compatible:
@@ -163,12 +211,26 @@ allOf:
       required:
         - reset-names
     else:
+      properties:
+        resets:
+          maxItems: 1
+
+        pcs-handle: false
+
+        reset-names: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rzv2h-gbeth
+    then:
       properties:
         clocks:
-          minItems: 7
+          maxItems: 7
 
         clock-names:
-          minItems: 7
+          maxItems: 7
 
         interrupts:
           minItems: 11
@@ -178,13 +240,6 @@ allOf:
           minItems: 11
           maxItems: 11
 
-        resets:
-          maxItems: 1
-
-        pcs-handle: false
-
-        reset-names: false
-
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 68f8da626d47..4ae68ab70dee 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -71,6 +71,7 @@ properties:
         - qcom,sc8280xp-ethqos
         - qcom,sm8150-ethqos
         - renesas,r9a06g032-gmac
+        - renesas,r9a08g046-gbeth
         - renesas,r9a09g077-gbeth
         - renesas,rzn1-gmac
         - renesas,rzv2h-gbeth
@@ -127,6 +128,8 @@ properties:
           pattern: '^rx-queue-[0-7]$'
         - description: Per channel transmit completion interrupt
           pattern: '^tx-queue-[0-7]$'
+        - description: PPS interrupt
+          pattern: '^ptp-pps-[0-3]$'
 
   clocks:
     minItems: 1
-- 
2.43.0


