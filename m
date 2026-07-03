Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BE9C44501
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:28 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89965.1783076367521012316
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fPq2ID79;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c7902f47so2659105e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076365; x=1783681165; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEwGamAOSsV0Mf9ceRepGZmPMSbfJkrB0j8+6TbU0tg=;
        b=fPq2ID79Qzh+t3CtSXKkv/9OIMxYSNwejrFxZphpW14Kb3wckChIlQLE9mcLONmhN0
         lACnQfrUjR3WitSqVGG0iqk+3gd72ZywTdG77MzFQfRvXiOt9y3yrEaFYGQlXlXnm22E
         XsKJm5Wrb5oXdgJe3lOYwusH4JoSwofwoI4pxFAZpHZP8dqWcfBUpGCSytpL7jrOfBI+
         vO2IoqWC+Y/GIsBNvTPEW7EQVrqk10+IRf0YdGOeC0wMKKWSnMALGKrCLAJxZIkOzspV
         JLpOie+eaI7gbfI/68rTOI69ms0OosmywgSjH2YKsowuJ8I8H2T4yxVya76yQ89/k8nG
         G1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076365; x=1783681165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WEwGamAOSsV0Mf9ceRepGZmPMSbfJkrB0j8+6TbU0tg=;
        b=LTeyIwzKzFJpNA3n67mvPrWi2LpV5OWXYBY8LcAb9H2zi93jsOTIgvnJN5xXymas1/
         AVu831yJpekma8F48xSupT0RbZtLEKzDkoSjpmiMWw+jz4Ipix4TYS74nm2YeVKu4yGZ
         kdhAdb0S216q1PSNzlimYIcT9XT0vWokHgnzPCB4MX07vVCMWe4+mdvLZEOqCHYU6aQ0
         cbc9DejiV1cClHzpEHawC7XIdIE4nrPHpbWDz7jw2SsZuREMnPeYMIFRWVXfouPM6ZFh
         h+15enLThrP8A99uFmE+Qf8FSfq92KIRG/bX4Q26GfWDThdA9bjmcZEHILvfmEEhSPAA
         uKFg==
X-Gm-Message-State: AOJu0Yy152+3y7CAVLgThbL1/YIRh6p9NTvKdMbjIc5O+ztx7mmrzX1x
	haqfnjPzT5YqFJx3TBSneshqT5Q6kUbD2ZcgY5L7gJftd/s2k3qcFZaauoSUHE8W
X-Gm-Gg: AfdE7clHw2r77nT+KPCXEt3LHhrRPtcnPLkIlKPob3VxdHTJEQjRU2TRZloSB1XAEfl
	VBF1FMsZQexqS/lHrRVnf60lCkk4QsVajIIwurOXTSfe0U4CVGUno4UfeET0nhv8BEB9x2cJGYy
	1KcjusqApw3m/wnB/hzEZmZZd5SMNFgqW1jn9azwy30pX9fWs2fYO4FATTykZrSYSK5CRgldzQy
	inUnK13WjUUuiZeS+JQjNwtFeLyf79PPBQ7xJ/fuSM/yV9jTGadlJDe/bmZrdyoAiu6vhDrh+w4
	xTrfd1KyTqs4QZb8pDvnsKR1M1hKuaJBv1Ks1P5L5uoJJoAEx0qPVhGhPJCUQyBAle7YyoawuDe
	cOsKnOjgwlfM1vVcDdqKO6aR4b3flpMxuETUvzfVusuYnVaQPYGk1yRoT1K89HCKxeXdtk+sMDb
	mBH90u6h8uId/Empu/z5/CY7LEwPc8C7E=
X-Received: by 2002:a05:600c:8217:b0:490:ba0a:1178 with SMTP id 5b1f17b1804b1-493c2b977cdmr118647345e9.28.1783076365308;
        Fri, 03 Jul 2026 03:59:25 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:25 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/23] dt-bindings: pinctrl: renesas: Document RZ/G3L SoC
Date: Fri,  3 Jul 2026 11:58:53 +0100
Message-ID: <20260703105923.251255-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23421

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 43d2cd6f61ffc04be19f4c7542554e4d28786a17 ]

Add documentation for the pin controller found on the Renesas RZ/G3L
(R9A08G046) SoC. The RZ/G3L PFC is similar to the RZ/G3S SoC but has
more pins.

Also add header file similar to RZ/G3E and RZ/V2H as it has alpha
numeric ports.

Document renesas,clonech property for controlling clone channel
control register located on SYSC IP block on RZ/G3L SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430093422.74812-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        | 22 +++++++----
 .../pinctrl/renesas,r9a08g046-pinctrl.h       | 38 +++++++++++++++++++
 2 files changed, 52 insertions(+), 8 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a08g046-pinctrl.h

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index b6d39aea86dc..ecb11071ccce 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -26,6 +26,7 @@ properties:
               - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2} and RZ/Five
               - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
               - renesas,r9a08g045-pinctrl # RZ/G3S
+              - renesas,r9a08g046-pinctrl # RZ/G3L
               - renesas,r9a09g047-pinctrl # RZ/G3E
               - renesas,r9a09g056-pinctrl # RZ/V2N
               - renesas,r9a09g057-pinctrl # RZ/V2H(P)
@@ -88,6 +89,16 @@ properties:
           - const: main
           - const: error
 
+  renesas,clonech:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to system controller
+          - description: offset of clone channel control register
+    description:
+      Phandle and offset to the system controller containing the clone channel
+      control values.
+
 additionalProperties:
   anyOf:
     - type: object
@@ -154,15 +165,10 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a09g057-pinctrl
+            const: renesas,r9a08g046-pinctrl
     then:
-      properties:
-        resets:
-          maxItems: 2
-    else:
-      properties:
-        resets:
-          minItems: 3
+      required:
+        - renesas,clonech
 
   - if:
       properties:
diff --git a/include/dt-bindings/pinctrl/renesas,r9a08g046-pinctrl.h b/include/dt-bindings/pinctrl/renesas,r9a08g046-pinctrl.h
new file mode 100644
index 000000000000..5ec5bfc27c7d
--- /dev/null
+++ b/include/dt-bindings/pinctrl/renesas,r9a08g046-pinctrl.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for Renesas RZ/G3L family pinctrl bindings.
+ *
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ *
+ */
+
+#ifndef __DT_BINDINGS_PINCTRL_RENESAS_R9A08G046_PINCTRL_H__
+#define __DT_BINDINGS_PINCTRL_RENESAS_R9A08G046_PINCTRL_H__
+
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+/* RZG3L_Px = Offset address of PFC_P_mn  - 0x22 */
+#define RZG3L_P2	2
+#define RZG3L_P3	3
+#define RZG3L_P5	5
+#define RZG3L_P6	6
+#define RZG3L_P7	7
+#define RZG3L_P8	8
+#define RZG3L_PA	10
+#define RZG3L_PB	11
+#define RZG3L_PC	12
+#define RZG3L_PD	13
+#define RZG3L_PE	14
+#define RZG3L_PF	15
+#define RZG3L_PG	16
+#define RZG3L_PH	17
+#define RZG3L_PJ	19
+#define RZG3L_PK	20
+#define RZG3L_PL	21
+#define RZG3L_PM	22
+#define RZG3L_PS	28
+
+#define RZG3L_PORT_PINMUX(b, p, f)	RZG2L_PORT_PINMUX(RZG3L_P##b, p, f)
+#define RZG3L_GPIO(port, pin)		RZG2L_GPIO(RZG3L_P##port, pin)
+
+#endif /* __DT_BINDINGS_PINCTRL_RENESAS_R9A08G046_PINCTRL_H__ */
-- 
2.43.0


