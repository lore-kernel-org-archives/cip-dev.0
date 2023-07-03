Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589AFC30658
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 17:02:23 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.38621.1688403736218088483
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 10:02:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,178,1684767600"; 
   d="scan'208";a="166629896"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Jul 2023 02:02:15 +0900
Received: from dev.ree.adwin.renesas.com (unknown [10.226.38.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1E391400F2BB;
	Tue,  4 Jul 2023 02:02:13 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 5.10.y-cip 1/4] dt-bindings: soc: renesas: Add RZ/V2M PWC
Date: Mon,  3 Jul 2023 18:02:08 +0100
Message-Id: <20230703170211.15484-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703170211.15484-1-fabrizio.castro.jz@renesas.com>
References: <20230703170211.15484-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 17:02:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12186

Commit 6e1456f9251966d8fbfde2ae4750ba540b588533 upstream.

The Renesas RZ/V2M External Power Sequence Controller (PWC) IP
is capable of:
* external power supply on/off sequence generation
* on/off signal generation for the LPDDR4 core power supply (LPVDD)
* key input signals processing
* general-purpose output pins

Add the corresponding dt-bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230106125816.10600-2-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 .../soc/renesas/renesas,rzv2m-pwc.yaml        | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,rzv2m-pwc.yaml

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzv2m-pwc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzv2m-pwc.yaml
new file mode 100644
index 000000000000..12df33f58484
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzv2m-pwc.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/renesas/renesas,rzv2m-pwc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2M External Power Sequence Controller (PWC)
+
+description: |+
+  The PWC IP found in the RZ/V2M family of chips comes with the below
+  capabilities
+    - external power supply on/off sequence generation
+    - on/off signal generation for the LPDDR4 core power supply (LPVDD)
+    - key input signals processing
+    - general-purpose output pins
+
+maintainers:
+  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a09g011-pwc # RZ/V2M
+          - renesas,r9a09g055-pwc # RZ/V2MA
+      - const: renesas,rzv2m-pwc
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  renesas,rzv2m-pwc-power:
+    description: The PWC is used to control the system power supplies.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    pwc: pwc@a3700000 {
+      compatible = "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc";
+      reg = <0xa3700000 0x800>;
+      gpio-controller;
+      #gpio-cells = <2>;
+      renesas,rzv2m-pwc-power;
+    };
-- 
2.25.1


