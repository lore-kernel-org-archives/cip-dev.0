From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 14:24:09 +0000
Subject: [cip-dev] [PATCH 11/18] dt-bindings: power: Add r8a774c0 SYSC power
	domain definitions
In-Reply-To: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
References: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553178256-6293-12-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch adds power domain indices for RZ/G2E.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit cb391265bca42f17c59d90e842a6bc582e3e2211)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 include/dt-bindings/power/r8a774c0-sysc.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a774c0-sysc.h

diff --git a/include/dt-bindings/power/r8a774c0-sysc.h b/include/dt-bindings/power/r8a774c0-sysc.h
new file mode 100644
index 0000000..9922d4c
--- /dev/null
+++ b/include/dt-bindings/power/r8a774c0-sysc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A774C0_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A774C0_SYSC_H__
+
+/*
+ * These power domain indices match the numbers of the interrupt bits
+ * representing the power areas in the various Interrupt Registers
+ * (e.g. SYSCISR, Interrupt Status Register)
+ */
+
+#define R8A774C0_PD_CA53_CPU0		5
+#define R8A774C0_PD_CA53_CPU1		6
+#define R8A774C0_PD_A3VC		14
+#define R8A774C0_PD_3DG_A		17
+#define R8A774C0_PD_3DG_B		18
+#define R8A774C0_PD_CA53_SCU		21
+#define R8A774C0_PD_A2VC1		26
+
+/* Always-on power area */
+#define R8A774C0_PD_ALWAYS_ON		32
+
+#endif /* __DT_BINDINGS_POWER_R8A774C0_SYSC_H__ */
-- 
2.7.4
