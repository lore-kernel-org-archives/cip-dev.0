Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42378C433F5
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 00:46:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.34337.1639529178402854368
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Dec 2021 16:46:21 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,206,1635174000";
   d="scan'208";a="103507871"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 15 Dec 2021 09:46:21 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 28B4041657F9;
	Wed, 15 Dec 2021 09:46:19 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 4/7] dt-bindings: power: renesas,rzg2l-sysc: Add DT
 binding documentation for SYSC controller
Date: Wed, 15 Dec 2021 00:46:09 +0000
Message-Id: <20211215004612.13289-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Dec 2021 00:46:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7104

commit 972f67be8929ac095df6a8bbce738b4f39e984cb upstream.

Add DT binding documentation for SYSC controller found on
RZ/G2{L,LC,UL} SoC's.

SYSC block contains the LSI_DEVID register which is used to retrieve
SoC product information.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20210609163717.3083-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/power/renesas,rzg2l-sysc.yaml    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml

diff --git a/Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml
new file mode 100644
index 000000000000..84ddc772b003
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/renesas,rzg2l-sysc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Renesas RZ/G2L System Controller (SYSC)
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+description:
+  The RZ/G2L System Controller (SYSC) performs system control of the LSI and
+  supports following functions,
+  - External terminal state capture function
+  - 34-bit address space access function
+  - Low power consumption control
+  - WDT stop control
+
+properties:
+  compatible:
+    enum:
+      - renesas,r9a07g044-sysc # RZ/G2{L,LC}
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: CA55/CM33 Sleep/Software Standby Mode request interrupt
+      - description: CA55 Software Standby Mode release request interrupt
+      - description: CM33 Software Standby Mode release request interrupt
+      - description: CA55 ACE Asynchronous Bridge Master/Slave interface deny request interrupt
+
+  interrupt-names:
+    items:
+      - const: lpm_int
+      - const: ca55stbydone_int
+      - const: cm33stbyr_int
+      - const: ca55_deny
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sysc: system-controller@11020000 {
+            compatible = "renesas,r9a07g044-sysc";
+            reg = <0x11020000 0x10000>;
+            interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "lpm_int", "ca55stbydone_int", "cm33stbyr_int",
+                              "ca55_deny";
+    };
-- 
2.17.1


