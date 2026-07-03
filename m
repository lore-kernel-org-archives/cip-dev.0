Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB40C44502
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:17 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89978.1783073290203602162
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Hr8eQfH2;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c59f740cso2552705e9.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073288; x=1783678088; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfTYxrLyLT2LuYVzNRAbgi9grUsMBXO7MPtIu9BDkAY=;
        b=Hr8eQfH2AogGJW7C6R91fZC3CwNXFDx/VxGLqsuISBM8D+NwLpAbgVWTUyTsSHZ0eH
         4W+1hgFQOk1TUBy/z3SAlgo8hemOH/zzWNQOc+nbQoGG3nR6zZsN5YvMkLkvmICaw++/
         8idzZTk72I8HLbqMH/mI2TxWk3382ZbxocsPNqrpIxe73wHZTgcehErGd/QaPVjNU3IE
         PBTCzRb6SH9p8gMQMdK6GsczSS6A0TCFMWCuljjiUwDfJR4TD+NtIjv7SrIKlxR0OOsN
         kzKzplZphN1k8BAwZC/GyM09F0k3i3+LVBr/tQlUS3Wqkg+SDBlEp2la6Tc6MO/l/eaA
         bl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073288; x=1783678088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SfTYxrLyLT2LuYVzNRAbgi9grUsMBXO7MPtIu9BDkAY=;
        b=S8T530arJW86MUoMuBllpyqCHfCB/2Gjy8XzRrD96wKQd9UZJlNt56fU7ipZd1+eHh
         n3ESAIIvYFE61tFqF4ciCIgMsGQqsagIijTFp2sRNkZPIX12X534f7xHYC6jttxdevwg
         iD8nl3AVYYZoA4G0tpLmJD8t4Lt6ECsdNdKN1pqRjl8SG6mfx6PagVPnjHJZ+2Yhg7p+
         Cwgrr2IdQRBBMpNyt7U1NB/dpD8+fZMpJ8NQJqlOI2rJg+PNeLV4MUky1LQj4B8PoR0D
         lJwtuJTWS91u9ySDDfW9pFNGed8jDQSqzI1zOJwoKLDpg4A/hkSFy3GfX8G8gSUguYFY
         aalg==
X-Gm-Message-State: AOJu0YwHYSZ2UGYCbMEhyZVKhviGxBCtEgNm+Nru8qNXWvghn5eeEriF
	wM18fAJepo3z9zaqI5koV2PDwMSkAikbplB7TEpk/PiCVYBLzGR7j3ihN+N28qQL
X-Gm-Gg: AfdE7cnCI+OxdkxNI2Kb+iMNKNIhXaWFp43R2ohTIvqOvSq5VVt/zEdZRP+C6tIrs5V
	kKVwJobT5be1Hx7ob+n5P3IQwRJwcyOTShd/QXX5wfjp879ACOL2VCGtwSyZTnLFXQiXj742v2M
	OcJ5OUE4qDqX1/pTfRjndV1tZsE624mcYMLDymFtlD+g7bJ8Dw41CNxpwXDVbnztuev8ILvk/vU
	Zubs4LyVpRw17K57+qp3LNDIU2nYGZnWWuL9Xuq9A0NMNbEiKxRNIX1bDN+a4awgbEQUJCJibqu
	pP9SwNC7nrttroG0J6zRCDFZGts4+wyAfWOl9RJf0a2gruB3p3xlIKQJYDAMeqXqlyVzQb+L8ow
	w03qVEPlKuSHe2Oa8kXUR39n6NWHmgsybaCfSHQMg3PN1T2JdxsWbdvxzM31zCbeXp0KCJDQo1C
	lOrAifpm98/KI0wqEp7zQd
X-Received: by 2002:a05:600c:848d:b0:493:a7fd:15d6 with SMTP id 5b1f17b1804b1-493c2b49d54mr140014205e9.9.1783073288323;
        Fri, 03 Jul 2026 03:08:08 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:08 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 21/26] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3L SoC
Date: Fri,  3 Jul 2026 11:07:40 +0100
Message-ID: <20260703100756.238233-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23413

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 3aa78b828e5d68bc8231a70ed295bcc6227bc611 ]

Document RZ/G3L (R9A08G046) IRQC. The IRQC block on the RZ/G3L SoC is
nearly identical to that found on the RZ/G3S SoC, with the following
differences: it supports more external interrupts and GPT error
interrupts, and adds registers for GPT/MTU interrupt selection and shared
interrupt selection between external interrupt and TINT. A new compatible
string "renesas,r9a08g046-irqc" is therefore introduced for the RZ/G3L
SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-3-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../renesas,rzg2l-irqc.yaml                   | 43 ++++++++++++++++---
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index a0b57d808639..3a221e1800a0 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -30,7 +30,9 @@ properties:
               - renesas,r9a08g045-irqc     # RZ/G3S
           - const: renesas,rzg2l-irqc
 
-      - const: renesas,r9a07g043f-irqc     # RZ/Five
+      - enum:
+          - renesas,r9a07g043f-irqc    # RZ/Five
+          - renesas,r9a08g046-irqc     # RZ/G3L
 
   '#interrupt-cells':
     description: The first cell should contain a macro RZG2L_{NMI,IRQX} included in the
@@ -48,17 +50,17 @@ properties:
 
   interrupts:
     minItems: 45
-    maxItems: 48
+    maxItems: 61
 
   interrupt-names:
     minItems: 45
-    maxItems: 48
+    maxItems: 61
     items:
       oneOf:
         - description: NMI interrupt
           const: nmi
         - description: External IRQ interrupt
-          pattern: '^irq([0-7])$'
+          pattern: '^irq([0-9]|1[0-5])$'
         - description: GPIO interrupt
           pattern: '^tint([0-9]|1[0-9]|2[0-9]|3[0-1])$'
         - description: Bus error interrupt
@@ -75,6 +77,8 @@ properties:
           const: ec7tie2-1
         - description: ECCRAM1 error overflow interrupt
           const: ec7tiovf-1
+        - description: Integrated GPT Error interrupt
+          pattern: '^ovfunf([0-7])$'
 
   clocks:
     maxItems: 2
@@ -106,6 +110,24 @@ required:
 allOf:
   - $ref: /schemas/interrupt-controller.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a07g043f-irqc
+              - renesas,r9a07g043u-irqc
+              - renesas,r9a07g044-irqc
+              - renesas,r9a07g054-irqc
+    then:
+      properties:
+        interrupts:
+          minItems: 48
+          maxItems: 48
+        interrupt-names:
+          minItems: 48
+          maxItems: 48
+
   - if:
       properties:
         compatible:
@@ -118,12 +140,19 @@ allOf:
           maxItems: 45
         interrupt-names:
           maxItems: 45
-    else:
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a08g046-irqc
+    then:
       properties:
         interrupts:
-          minItems: 48
+          minItems: 61
         interrupt-names:
-          minItems: 48
+          minItems: 61
 
 unevaluatedProperties: false
 
-- 
2.43.0


