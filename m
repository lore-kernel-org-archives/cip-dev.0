Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6C7D15D9B
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 15:38:17 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18205.1764776281542836390
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Dec 2025 07:38:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 3oaK2CgOQcqETvZ7c19vPw==
X-CSE-MsgGUID: Lz7wcvnvQEu3twbRewgX6Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Dec 2025 00:38:13 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 99778401008C;
	Thu,  4 Dec 2025 00:38:12 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 08/12] dt-bindings: clock: renesas: Document RZ/V2N SoC CPG
Date: Wed,  3 Dec 2025 15:37:53 +0000
Message-ID: <20251203153757.32977-9-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
References: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 15:38:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20821

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c04269c02273b24398590398c0b73605c72f17ac upstream.

Document the device tree bindings for the Renesas RZ/V2N (R9A09G056)
SoC Clock Pulse Generator (CPG).

Update `renesas,rzv2h-cpg.yaml` to include the compatible string for
RZ/V2N SoC and adjust the title and description accordingly.

Additionally, introduce `renesas,r9a09g056-cpg.h` to define core clock
constants for the RZ/V2N SoC. Note the existing RZ/V2H(P) family-specific
clock driver will be reused for this SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250407191628.323613-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../bindings/clock/renesas,rzv2h-cpg.yaml     |  5 ++--
 .../dt-bindings/clock/renesas,r9a09g056-cpg.h | 24 +++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g056-cpg.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
index c3fe76abd549..f261445bf341 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
@@ -4,13 +4,13 @@
 $id: http://devicetree.org/schemas/clock/renesas,rzv2h-cpg.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas RZ/{G3E,V2H(P)} Clock Pulse Generator (CPG)
+title: Renesas RZ/{G3E,V2H(P),V2N} Clock Pulse Generator (CPG)
 
 maintainers:
   - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
 
 description:
-  On Renesas RZ/{G3E,V2H(P)} SoCs, the CPG (Clock Pulse Generator) handles
+  On Renesas RZ/{G3E,V2H(P),V2N} SoCs, the CPG (Clock Pulse Generator) handles
   generation and control of clock signals for the IP modules, generation and
   control of resets, and control over booting, low power consumption and power
   supply domains.
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - renesas,r9a09g047-cpg # RZ/G3E
+      - renesas,r9a09g056-cpg # RZ/V2N
       - renesas,r9a09g057-cpg # RZ/V2H
 
   reg:
diff --git a/include/dt-bindings/clock/renesas,r9a09g056-cpg.h b/include/dt-bindings/clock/renesas,r9a09g056-cpg.h
new file mode 100644
index 000000000000..f4905b27f8d9
--- /dev/null
+++ b/include/dt-bindings/clock/renesas,r9a09g056-cpg.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_RENESAS_R9A09G056_CPG_H__
+#define __DT_BINDINGS_CLOCK_RENESAS_R9A09G056_CPG_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* Core Clock list */
+#define R9A09G056_SYS_0_PCLK			0
+#define R9A09G056_CA55_0_CORE_CLK0		1
+#define R9A09G056_CA55_0_CORE_CLK1		2
+#define R9A09G056_CA55_0_CORE_CLK2		3
+#define R9A09G056_CA55_0_CORE_CLK3		4
+#define R9A09G056_CA55_0_PERIPHCLK		5
+#define R9A09G056_CM33_CLK0			6
+#define R9A09G056_CST_0_SWCLKTCK		7
+#define R9A09G056_IOTOP_0_SHCLK			8
+#define R9A09G056_USB2_0_CLK_CORE0		9
+#define R9A09G056_GBETH_0_CLK_PTP_REF_I		10
+#define R9A09G056_GBETH_1_CLK_PTP_REF_I		11
+
+#endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G056_CPG_H__ */
-- 
2.51.0


