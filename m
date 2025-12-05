Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B82D32D79
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:33:41 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6927.1764945202623019546
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 0GEVRi5+T+Wrsrmll8fpGQ==
X-CSE-MsgGUID: 4mIZ2kUYQJKrKwdF++nJ0A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:32 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 496344179CE0;
	Fri,  5 Dec 2025 23:33:31 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 18/38] dt-bindings: clock: renesas,cpg-mssr: Document RZ/N2H support
Date: Fri,  5 Dec 2025 14:32:38 +0000
Message-ID: <20251205143258.13748-19-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:33:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20932

commit 292bf6c5b8100ba4e16cd194bdc89785f6fb6f7a  upstream.

Document support for Module Standby and Software Reset found on the
Renesas RZ/N2H (R9A09G087) SoC.  The Module Standby and Software Reset
IP is similar to that found on the RZ/T2H SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250609203656.333138-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/clock/renesas,cpg-mssr.yaml      |  5 +++-
 .../clock/renesas,r9a09g087-cpg-mssr.h        | 28 +++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
index 708ab6bd7d448..bc2fd3761328c 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
@@ -53,6 +53,7 @@ properties:
       - renesas,r8a779g0-cpg-mssr # R-Car V4H
       - renesas,r8a779h0-cpg-mssr # R-Car V4M
       - renesas,r9a09g077-cpg-mssr # RZ/T2H
+      - renesas,r9a09g087-cpg-mssr # RZ/N2H
 
   reg:
     minItems: 1
@@ -112,7 +113,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a09g077-cpg-mssr
+            enum:
+              - renesas,r9a09g077-cpg-mssr
+              - renesas,r9a09g087-cpg-mssr
     then:
       properties:
         reg:
diff --git a/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h b/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
new file mode 100644
index 0000000000000..f28166d6015f4
--- /dev/null
+++ b/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_RENESAS_R9A09G087_CPG_H__
+#define __DT_BINDINGS_CLOCK_RENESAS_R9A09G087_CPG_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* R9A09G087 CPG Core Clocks */
+#define R9A09G087_CLK_CA55C0		0
+#define R9A09G087_CLK_CA55C1		1
+#define R9A09G087_CLK_CA55C2		2
+#define R9A09G087_CLK_CA55C3		3
+#define R9A09G087_CLK_CA55S		4
+#define R9A09G087_CLK_CR52_CPU0		5
+#define R9A09G087_CLK_CR52_CPU1		6
+#define R9A09G087_CLK_CKIO		7
+#define R9A09G087_CLK_PCLKAH		8
+#define R9A09G087_CLK_PCLKAM		9
+#define R9A09G087_CLK_PCLKAL		10
+#define R9A09G087_CLK_PCLKGPTL		11
+#define R9A09G087_CLK_PCLKH		12
+#define R9A09G087_CLK_PCLKM		13
+#define R9A09G087_CLK_PCLKL		14
+
+#endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G087_CPG_H__ */
-- 
2.43.0


