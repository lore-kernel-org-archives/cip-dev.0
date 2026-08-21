Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5EBC5DF94
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:12 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7165.1787318226380996841
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=JNhZuIE2;
 spf=pass (domain: renesas.com, ip: 52.101.228.24, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8bKVORPNx20DZijyAB9upOz702yc9DPSJQDczWjdGs0Zi4+WDSrsyJYyeJGpB+5CQADOYtpMcbhN+A5QYw0YXtRNBiIN5wAL3BF2Qfxr91JKWTOmPe88WSGQeJA4V2yFGo7Kybxrx3ZIqH2AOOFl4ocBGnlSCAplEL+PKthTlPxRIhMavdM06D9KTmI5qDfoQ1EAlquYvU99mOKupqV3tgQa4A9nVhSRz9/z7xdFuTNj5qy5R6AXmMRZBerNagPwmZuepvqSMHuWXyGzetDW0bgpqgcJlGa4xOqeHulljSgp0hHlNY7//oa/SwA1cGGi5JjFVyGYzu0weqVnCRA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+Z2wE5kINIGgTx54yHHi5TYzLKgHUfQu+KQWRXPcI4=;
 b=BbnrSTXYCjSMZdN0zsHCBq1PPg2YN36KgQWUSC7JOkD9uVeRmcPY5LoAjDOkEJf7WaALv0Yq6S8pn5jCJpe8nxPERzExZWEjWMz45+ypcxuCwG81wf3a6LJq3RIdN0jKIyNyvZ2UxDPXZ2y+ZIvB+qgieJv8kMcucsGpIKIBMGUYJfdlSmw94jTKGzp7QV22u+ZYj5CuW96CZdk03mRNjTC8BdZwjZ5uKkPdN+80kHkyCcP1sVEVsiIJMKA5Mu4Ee+ij/HwZkLNHN6j0dRhmeuh11TNb4l7lwOSmxXUQz5sVv9nYBLoqeOom8ct9dCfzTJ72nXKDTJrG9xon2Cz8zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+Z2wE5kINIGgTx54yHHi5TYzLKgHUfQu+KQWRXPcI4=;
 b=JNhZuIE261VHVahWyrFpL6lYDUGxUkR3wRi6B+vg9tmfD4GoKBQKBV774n6GUqH3t30VCrb28CB8iinTG2wfstQLg064UlZ9f5Ac6YmwFQP/qZL+QvNffNDkQD3nN6q8kJY3RSIqL0ozW3tiAK7dC3SJfXRofMu6QwUvtTq3VgM=
Received: from TY4PR01CA0023.jpnprd01.prod.outlook.com (2603:1096:405:2bf::16)
 by TYXPR01MB15181.jpnprd01.prod.outlook.com (2603:1096:405:277::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 13:16:58 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2bf:cafe::78) by TY4PR01CA0023.outlook.office365.com
 (2603:1096:405:2bf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 13:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:16:57 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 462F5300037C;
	Fri, 21 Aug 2026 22:16:56 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 06/18] dt-bindings: interrupt-controller: Document RZ/{T2H,N2H} ICU
Date: Fri, 21 Aug 2026 16:15:42 +0300
Message-ID: <20260821131554.638741-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|TYXPR01MB15181:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b4bad760-59bc-450f-5295-08deff867a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|3023799007|11063799006|56012099006|6133799003|10067099003|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ITdXlk1ARUD6dmfUFO9mxYKbPWDKdFD7Xsrk0ddvR3Jn1tYd7JL+BqvyyrIFH8F++LzGy9nv7oJK7g1wOGtDRKe+RVk60GgPKP/hoir5LSECUVzgETADFX+CN9cEKQo8PFXewPj2y7qaA469V3sKce0UK4mALS1CJPxcD4ReSWyrBtELxPzTfwt+0QbF9BY5hJhDasEc4TEu/kcPobRhAb+5SB/ImMvbTkAUOF9xQkenISCnmo8ofVTZ3PrVOKdpJVA2cTQbPv2W9W/vxgZ+EliNcfeswKN8i6FqWysFKoadE1z5XL+xJoINmA/Psb83gWChPYUZ1UB0CzW0MOLnX9Zp1QsruEvMy3mCyrPDJ2A0JxBuSwnubSCk9HAkIYv8BgCYHU4PimsWrshOXWASFYm3RkNcEsaomAAplO4QRBjwipWBefGD54odA9aOA3EUtWfRH6M/hCP4E3wAUznYs8n0byjTmnnO+9WZA+W/4y9IJ3KvVj2zBPHTXnz+8KwwiBHyTgHoVY2a6s7NvKT7495WgYhS5ZBHfdX8evt/brppLxbQsKzHbpJtGvoolPx37a/UW96X29l04JyfdRgI9czlNRlHO7xzodcvmIkeaLk9B42kpwunyJKGuHFIBEB5zp8Kq+tHQiGSMdCm9LLIyA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(3023799007)(11063799006)(56012099006)(6133799003)(10067099003)(13003099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	WfDCnqODv3DE4nUfdfVWdmx0R0u1AQvtExEI0wmXos2W1yYDrtUN/HWkOluyMzpXlOsONb5tXT2UXKPbfb3RdLmnltTc5kYtsQvsJ3aePbRPy2QK2Rf25rvdDJcCyCBoaAIQtHabnGeNXbvOf03E0TyM+o60Kb9jmwWlK6nxCfF3iMLtuTB+MeDEEoG1xXYEdhkQmSvE/N+nDojHJr70scMudkbi50lwiZTIgy5o65spG85aGajuD05Uv5QaUY5n7rpY9lAoEsxc4XFEP1IyWUxq0hqvTl/QAOeXYdMI9iu789TOsc0cJxGprGOq9xlUDQAGAwdOzNChgb0RPT7hNIEsto1hRteWrdMXh6XNAIntl3vMvt+Hsohif9M6SXLfSg8BSvRoe9LCsyz1FN+RZjU4c05DxL7QIN6OhKz6WEPsNxFcdcRwtOB94TfnZxuT
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:16:57.5462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bad760-59bc-450f-5295-08deff867a50
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB15181
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23965

commit a6568d82091d279c8fbcdb1d30b46c23756b9145 upstream.

The Renesas RZ/T2H (R9A09G077) and Renesas RZ/N2H (R9A09G087) SoCs have an
Interrupt Controller (ICU) block that routes external interrupts to the
GIC's SPIs, with the ability of level-translation, and can also produce
software interrupts and aggregate error interrupts.

It has 16 software triggered interrupts (INTCPUn), 16 external pin
interrupts (IRQn), a System error interrupt (SEI), two Cortex-A55 error
interrupts (CA55_ERRn), two Cortex-R52 error interrupts for each of the two
cores (CR52x_ERRn), two Peripheral error interrupts (PERI_ERRn), two DSMIF
error interrupts (DSMIF_ERRn), and two ENCIF error interrupts (ENCIF_ERRn).

The IRQn and SEI interrupts are exposed externally, while the others are
software triggered.

INTCPU0 to INTCPU13, IRQ 0 to IRQ13 are non-safety interrupts, while
INTCPU14, INTCPU15, IRQ14, IRQ15 and SEI are safety interrupts, and are
exposed via a separate register space.

Document them, and use RZ/T2H as a fallback for RZ/N2H as the ICU is
entirely compatible.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20251201112933.488801-2-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../renesas,r9a09g077-icu.yaml                | 236 ++++++++++++++++++
 1 file changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
renesas,r9a09g077-icu.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas=
,r9a09g077-icu.yaml b/Documentation/devicetree/bindings/interrupt-controlle=
r/renesas,r9a09g077-icu.yaml
new file mode 100644
index 000000000000..78c01d14e765
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,r9a09g=
077-icu.yaml
@@ -0,0 +1,236 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/renesas,r9a09g077-=
icu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/{T2H,N2H} Interrupt Controller
+
+maintainers:
+  - Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+description:
+  The Interrupt Controller (ICU) handles software-triggered interrupts
+  (INTCPU), external interrupts (IRQ and SEI), error interrupts and DMAC
+  requests.
+
+properties:
+  compatible:
+    oneOf:
+      - const: renesas,r9a09g077-icu # RZ/T2H
+
+      - items:
+          - enum:
+              - renesas,r9a09g087-icu # RZ/N2H
+          - const: renesas,r9a09g077-icu
+
+  reg:
+    items:
+      - description: Non-safety registers (INTCPU0-13, IRQ0-13)
+      - description: Safety registers (INTCPU14-15, IRQ14-15, SEI)
+
+  '#interrupt-cells':
+    description: The first cell is the SPI number of the interrupt, as per=
 user
+      manual. The second cell is used to specify the flag.
+    const: 2
+
+  '#address-cells':
+    const: 0
+
+  interrupt-controller: true
+
+  interrupts:
+    items:
+      - description: Software interrupt 0
+      - description: Software interrupt 1
+      - description: Software interrupt 2
+      - description: Software interrupt 3
+      - description: Software interrupt 4
+      - description: Software interrupt 5
+      - description: Software interrupt 6
+      - description: Software interrupt 7
+      - description: Software interrupt 8
+      - description: Software interrupt 9
+      - description: Software interrupt 10
+      - description: Software interrupt 11
+      - description: Software interrupt 12
+      - description: Software interrupt 13
+      - description: Software interrupt 14
+      - description: Software interrupt 15
+      - description: External pin interrupt 0
+      - description: External pin interrupt 1
+      - description: External pin interrupt 2
+      - description: External pin interrupt 3
+      - description: External pin interrupt 4
+      - description: External pin interrupt 5
+      - description: External pin interrupt 6
+      - description: External pin interrupt 7
+      - description: External pin interrupt 8
+      - description: External pin interrupt 9
+      - description: External pin interrupt 10
+      - description: External pin interrupt 11
+      - description: External pin interrupt 12
+      - description: External pin interrupt 13
+      - description: External pin interrupt 14
+      - description: External pin interrupt 15
+      - description: System error interrupt
+      - description: Cortex-A55 error event 0
+      - description: Cortex-A55 error event 1
+      - description: Cortex-R52 CPU 0 error event 0
+      - description: Cortex-R52 CPU 0 error event 1
+      - description: Cortex-R52 CPU 1 error event 0
+      - description: Cortex-R52 CPU 1 error event 1
+      - description: Peripherals error event 0
+      - description: Peripherals error event 1
+      - description: DSMIF error event 0
+      - description: DSMIF error event 1
+      - description: ENCIF error event 0
+      - description: ENCIF error event 1
+
+  interrupt-names:
+    items:
+      - const: intcpu0
+      - const: intcpu1
+      - const: intcpu2
+      - const: intcpu3
+      - const: intcpu4
+      - const: intcpu5
+      - const: intcpu6
+      - const: intcpu7
+      - const: intcpu8
+      - const: intcpu9
+      - const: intcpu10
+      - const: intcpu11
+      - const: intcpu12
+      - const: intcpu13
+      - const: intcpu14
+      - const: intcpu15
+      - const: irq0
+      - const: irq1
+      - const: irq2
+      - const: irq3
+      - const: irq4
+      - const: irq5
+      - const: irq6
+      - const: irq7
+      - const: irq8
+      - const: irq9
+      - const: irq10
+      - const: irq11
+      - const: irq12
+      - const: irq13
+      - const: irq14
+      - const: irq15
+      - const: sei
+      - const: ca55-err0
+      - const: ca55-err1
+      - const: cr520-err0
+      - const: cr520-err1
+      - const: cr521-err0
+      - const: cr521-err1
+      - const: peri-err0
+      - const: peri-err1
+      - const: dsmif-err0
+      - const: dsmif-err1
+      - const: encif-err0
+      - const: encif-err1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#interrupt-cells'
+  - '#address-cells'
+  - interrupt-controller
+  - interrupts
+  - interrupt-names
+  - clocks
+  - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h>
+
+    icu: interrupt-controller@802a0000 {
+      compatible =3D "renesas,r9a09g077-icu";
+      reg =3D <0x802a0000 0x10000>,
+            <0x812a0000 0x50>;
+      #interrupt-cells =3D <2>;
+      #address-cells =3D <0>;
+      interrupt-controller;
+      interrupts =3D <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 7 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 9 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 10 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 11 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 14 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 15 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 16 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 17 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 18 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 20 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 24 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 28 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 29 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 31 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 406 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 407 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 408 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 409 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 410 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 411 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 412 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 413 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 415 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 416 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 417 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 418 IRQ_TYPE_EDGE_RISING>;
+      interrupt-names =3D "intcpu0", "intcpu1", "intcpu2",
+                        "intcpu3", "intcpu4", "intcpu5",
+                        "intcpu6", "intcpu7", "intcpu8",
+                        "intcpu9", "intcpu10", "intcpu11",
+                        "intcpu12", "intcpu13", "intcpu14",
+                        "intcpu15",
+                        "irq0", "irq1", "irq2", "irq3",
+                        "irq4", "irq5", "irq6", "irq7",
+                        "irq8", "irq9", "irq10", "irq11",
+                        "irq12", "irq13", "irq14", "irq15",
+                        "sei",
+                        "ca55-err0", "ca55-err1",
+                        "cr520-err0", "cr520-err1",
+                        "cr521-err0", "cr521-err1",
+                        "peri-err0", "peri-err1",
+                        "dsmif-err0", "dsmif-err1",
+                        "encif-err0", "encif-err1";
+      clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKM>;
+      power-domains =3D <&cpg>;
+    };
--=20
2.55.0


