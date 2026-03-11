Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76058104BEC2
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:06 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17643.1773223502175671135
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BWPag/Xu;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so5330330f8f.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223500; x=1773828300; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhfPXVNj7HLMqBc7igiXpm4m3wmAzCowQ1W9dfGizE0=;
        b=BWPag/XudoED5xB0I6M0559c96MDL9zhMxRtLBADSj4as2bQsSoh6nmXP93y8WMo6n
         eZ1HN8hNYIwqjcMq8GSBrrVzdM70k8pLXlPUzg5rje+7bc8+fmZ7Pbwd7rU+KR/87fmI
         MRtVv3i66+YWUA4MhJPpGx7xGvQ9IMe/tbczh3/O4GQgBHIQ1durk34Emk1IihsOnA/O
         +YD4yyHRiKrnFVp0WnaWogy99JhFoTQBugNo7Rfm3xVO/seNx5+0ZLxTmfU+eo+QXaKj
         eeDukS/lvZcKGACw99pIQBb5ta3XnAVyMorpoMCu/bF/bQiG6hyqJpVRMRKes03R/Z5Q
         3CmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223500; x=1773828300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RhfPXVNj7HLMqBc7igiXpm4m3wmAzCowQ1W9dfGizE0=;
        b=rG8Bwzt3uPJBUrRJZzTFBsVg3925ID93TOLbfjI91CXwYphx455bwWcjOea4uuuFgi
         si8cGlW4MuiRkL+XdM/bGOY3QCtpIUZeRdTCZTPMhE5cOEqgsWT0NMuJfUpO7gfEnvtN
         proLRmp/LpDbBB3UTbWpkU/YpZc8CTvFfiDFE3vDEa3ayqIqSj+VISWx4coEtT0iw4k1
         RFhlssSjExxRMC6ae3oSIAGtymt6PA7JFOaOI2EtR1WoBXt+Q3xgsCoash3Zu7AvZX1p
         sjS5dTcaz1bHrFNpMQDv3Ys+VDIJtE5YthxqX5qdu+HUSBRyvybNBHGhWVpKNAywlZYd
         xfSQ==
X-Gm-Message-State: AOJu0YyE4oI+DoSh/IZNOp1McyYuBCdE5x93bMQtKMdDRxOLpX0HVxdi
	wo+1yCbIKPcX3iVDsCqjtWPGc24F3xGfJvqf1qKWIfCAUNvIebXDizHAtfxiUQ==
X-Gm-Gg: ATEYQzzesq7z8QsRxF5uh9nNmMpc+TPaNY0D9uCs/6b1iFhV7tCqlOFC2c2XXfCsP6d
	vZBDgp4D341Te8QjFKOiPV1ONKE7BA8fsci1V9bU6WMCOlDR7AL7aavvt4w9dQlhKYLbTF+zbDR
	owZL9u5AuQ2ZeVohennlJ5jt8QWlmEje8a2O3ARqUiYoCNIRivgMG3qwYtP6AXfU4A+Et5TJTQk
	4hrnRPq/debMENvg6ASR6KHZz6QrlondleennaFqUM95Vk5bP+4qvHXnhXJ1fFdoI1vkiaN6lGk
	TGJNaEETJaLStZKRsGOPI1dygbVgTlWr6j1GocWxl/S1+qFxuqp37HrFj6u//08AFYiEKC0tzKd
	y4FL+aJNu+cclLjgtmtuZRXqN6dKAXSaBjiI0At9/9dI5JCUzsW8h3nkA8US184Gx4BnAF8Mk05
	fYCFhv4MDdS0DNqHkX2i4wBH2XZSqNVxE=
X-Received: by 2002:a05:6000:18a6:b0:439:be2e:7339 with SMTP id ffacd0b85a97d-439f81f3de9mr3837057f8f.8.1773223500133;
        Wed, 11 Mar 2026 03:05:00 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:04:59 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 02/27] dt-bindings: serial: renesas,rsci: Document RZ/G3E support
Date: Wed, 11 Mar 2026 10:04:21 +0000
Message-ID: <20260311100458.162447-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22248

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 0774c43c006bf6e411514920cc57a42abe9374c1 ]

Add documentation for the serial communication interface (RSCI) found on
the Renesas RZ/G3E (R9A09G047) SoC. The RSCI IP on this SoC is identical
to that on the RZ/T2H (R9A09G077) SoC, but it has a 32-stage FIFO compared
to 16 on RZ/T2H. It supports both FIFO and non-FIFO mode operation. RZ/G3E
has 6 clocks(5 module clocks + 1 external clock) compared to 3 clocks
(2 module clocks + 1 external clock) on RZ/T2H, and it has multiple resets.
It has 6 interrupts compared to 4 on RZ/T2H.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-2-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/serial/renesas,rsci.yaml         | 99 ++++++++++++++++---
 1 file changed, 88 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index 6b1f827a335b..1f8cee8171de 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -10,46 +10,72 @@ maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
   - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
 
-allOf:
-  - $ref: serial.yaml#
-
 properties:
   compatible:
     oneOf:
-      - items:
-          - const: renesas,r9a09g087-rsci # RZ/N2H
-          - const: renesas,r9a09g077-rsci # RZ/T2H
+      - enum:
+          - renesas,r9a09g047-rsci # RZ/G3E
+          - renesas,r9a09g077-rsci # RZ/T2H
 
       - items:
+          - const: renesas,r9a09g087-rsci # RZ/N2H
           - const: renesas,r9a09g077-rsci # RZ/T2H
 
   reg:
     maxItems: 1
 
   interrupts:
+    minItems: 4
     items:
       - description: Error interrupt
       - description: Receive buffer full interrupt
       - description: Transmit buffer empty interrupt
       - description: Transmit end interrupt
+      - description: Active edge detection interrupt
+      - description: Break field detection interrupt
 
   interrupt-names:
+    minItems: 4
     items:
       - const: eri
       - const: rxi
       - const: txi
       - const: tei
+      - const: aed
+      - const: bfd
 
   clocks:
     minItems: 2
-    maxItems: 3
+    maxItems: 6
 
   clock-names:
-    minItems: 2
+    oneOf:
+      - items:
+          - const: operation
+          - const: bus
+          - const: sck # optional external clock input
+
+        minItems: 2
+
+      - items:
+          - const: pclk
+          - const: tclk
+          - const: tclk_div4
+          - const: tclk_div16
+          - const: tclk_div64
+          - const: sck # optional external clock input
+
+        minItems: 5
+
+  resets:
     items:
-      - const: operation
-      - const: bus
-      - const: sck # optional external clock input
+      - description: Input for resetting the APB clock
+      - description: Input for resetting TCLK
+
+  reset-names:
+    items:
+      - const: presetn
+      - const: tresetn
 
   power-domains:
     maxItems: 1
@@ -62,6 +88,57 @@ required:
   - clock-names
   - power-domains
 
+allOf:
+  - $ref: serial.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-rsci
+    then:
+      properties:
+        interrupts:
+          maxItems: 4
+
+        interrupt-names:
+          maxItems: 4
+
+        clocks:
+          minItems: 2
+          maxItems: 3
+
+        clock-names:
+          minItems: 2
+          maxItems: 3
+
+        resets: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-rsci
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+
+        interrupt-names:
+          minItems: 6
+
+        clocks:
+          minItems: 5
+          maxItems: 6
+
+        clock-names:
+          minItems: 5
+          maxItems: 6
+
+      required:
+        - resets
+        - reset-names
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


