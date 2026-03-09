Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91239F3C273
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:25:57 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15640.1773066353639838531
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:25:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aWg47QGa;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b9b1900bso5988504f8f.1
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066352; x=1773671152; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhfPXVNj7HLMqBc7igiXpm4m3wmAzCowQ1W9dfGizE0=;
        b=aWg47QGa8fy86zmm8AEOdjNRT/68blP4ejkxpqUggreHB9R+6ton/brnjW9Zo2/PJ8
         DVTSc7dAzB694rw5Dj7M9HETpqcFD+4aG0bH+N3M12yaVOD5A6KYp8NSiZezOE7Hy9Vx
         8M/hogv4uwaXUa8S96n31fY1dCD+0yh9xet/jJ9gadiCSFTMxunISHnCGh1zELv7xt9T
         84Yv9+1GdmsEo/OK8XSl/RNNxULES/XGW811WSaNpHPDSPR8HD6CsCkwS2eYM3Ji/1cp
         s3EjusG5w8Xj6lCCkynvLGQwQkcPZ8/I6df0MZUx4duikqwSKk78z5+sw321cb0JVI1b
         uEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066352; x=1773671152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RhfPXVNj7HLMqBc7igiXpm4m3wmAzCowQ1W9dfGizE0=;
        b=IkWjroO827spqG+iRkBDM4jXWTsGnE6+peUsdxIa+GSAlnJgnBjElA0jkFr3VNE2c1
         vNEcybMt1iEGuSa7H5+amF6TFwuNeqySae+Xc698/q3EKqq0RqGHzPWzEtg6cXIVdPCe
         sjm28Jh+t0tFhnXL5VEotdsh6FsZ0VsyJJVr26uQJmNwtxJDBeUPKCW+lgZgJpFSfmtu
         cXniQGVUCQ4/HXt8ISbkGoHI0+rakW3gLGjfxqPaHXdvLtaLCn+K/LheIcHAfnWL7uIm
         EitXKlMbkX4jr/W+K+xBgAQ/RQs6r+O3d0kkuLT0loP61ETrBsM/Q6WqMYLsmPVG9bg/
         /Lkw==
X-Gm-Message-State: AOJu0YzoUHbRSx5XDBmXMwnLMbwrQf3wK+jkKGmfsbvBJhG7dcpFqcmD
	16OSbJEKQUFVSTTwh3doYjibgtLO34vOq556xMWIbmp5iIqKb3K7mgr+5amDCw==
X-Gm-Gg: ATEYQzzLmhnQvn/lbCTZ2DejRsC2FkI/qJr3s0SBx42a82XvqsTQ7h7U7cJTMn0Iary
	GkEfb803ArDZ9MLC1hWLRvnam8sfnR5QR+/KHi14ujWP5yMF6+ql0/qIVdE5VgeeMKW3dkLY8mY
	8X1FNmlrHMdWkkvPOkX1zNdAOxEwD1z5Bdm1xifKbbXd6vmwvzKiNSnTjUMKSRm/xoXSfKF8cnk
	Xve5rcbkgDkhdcPcDVLZ62ZYE1pvE4TqaImdg5KOeJiIzrZGZZRwNRsaVNP7vi6CsoKBGzRjdyN
	5+23SFDlG4lsxrgPjCmLIpurGBvRwZvmTVPJ8j6DUIlx2MMi6f4HfdAMWzEPCiKzQ8KIX/1quL7
	CdwGUuakcD6K6wJyTejWWuREP3c+/PWe557UkTsVutEKDmcYQEyIiO0rDKS5Ew1QYxaiwAsjCP8
	rukxDbnlJ2YwnTOthmYPk6iT9WdKHeIJ4=
X-Received: by 2002:a5d:64c9:0:b0:439:af42:c282 with SMTP id ffacd0b85a97d-439da8a37a2mr19622417f8f.58.1773066351632;
        Mon, 09 Mar 2026 07:25:51 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:25:51 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/29] dt-bindings: serial: renesas,rsci: Document RZ/G3E support
Date: Mon,  9 Mar 2026 14:25:02 +0000
Message-ID: <20260309142549.987737-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:25:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22170

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


