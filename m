Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DD1C83F05
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:06 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.13])
 by mx.groups.io with SMTP id smtpd.web10.8418.1751620077550484624
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:07:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=iUf0jevg;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.13, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDgqv4U04cfgQoJMape+Fq9DvElmC45YV3ec1/6z28aeeTvk82nBnEYjTJm0jvMBqDxt+M2bH5Kx6VQu2aMjJjQ4WtLigTLNUBYA2+qkCSlvNgMjSrPExR/VJ91daq9j9J81T9CcdA33uJ24/bTi1iR3K39J9AaIKgWFa7rDlUBAY1p4OdPkAZ2YwMdHU6yzfMqjPCKerHRSa4DLTcSReW7F8HgNbV2G0lxwbqMv3iRR5lR5yxb8yotQs7JI7UuaWhzYQ5+PhbBbLO5WwDI1Xi4uOt1aHt4X2OJ0Yx4YBfnqwHcG3ldMxnzJLC5deRIyNDY4p+no58rejBnQcyDiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg2dv24mNzSYR99Hsz3qbfF1A/jRfSIbhaQ3mb+aHGE=;
 b=eRM+D5bWRT8PwimqtHYWR2GrqO39E0I/8AN0Qlqx8h9+P9WKMZGz+s/l36OveKXwFSZCh2CwuGoPn/d4gizgEzv2sr0mq9/knJsY91gwrTpXzQICN6pgjZuVvzGPSjuAk/rcSQ1d3NMPtEp3pfRwZQXWg4vLD4br7lOqofGjnJNZYSAp/3zHjMoC+BOS539T+Nbr4Me+yStQhfZRLyYRrpuO6ajC6jt+VpftVrusad8MWh1spaQhC97BRY8MiOtAz7daPyY5ipq7wFO21zeRZZuVQ3jDdbJKccJqANgbv6uvlnYZMOrxlNXc3SoQ7Up5pBgcG2keb/5kfJ795XJ0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg2dv24mNzSYR99Hsz3qbfF1A/jRfSIbhaQ3mb+aHGE=;
 b=iUf0jevgWKipEuPeNUIsMyLGY56NbcC2zTwBDXOnThOUGoOBeTvCvWtCilCmFMsSt07OiHQgtXUld/ZuUz9VOGIBy0t8vFlRDVvPIz/7UXG6dx/8tnqs7LLB3isVi6/Q5DTpWV3Tgkdp2TxbgXaaSNswqri2tcPpQTFxP97utSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:07:55 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:07:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 03/18] dt-bindings: interrupt-controller: Add Renesas RZ/V2H(P) Interrupt Controller
Date: Fri,  4 Jul 2025 11:07:09 +0200
Message-ID: <20250704090724.669848-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB14451:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a544cf1-53a8-43c5-5e94-08ddbada432a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1+nz822yUjZTSN6ucQgQ9SPsgWXTLmjez8CuH4eCMTFDdlruA0P+CmVVpkvs?=
 =?us-ascii?Q?+5pH67xvm8endzNJFF0wqOdNCazZ1Bc74MJtuRipE8lYebE/xSBsnAf3ank/?=
 =?us-ascii?Q?l/EPSRpoRuHjkCLKbr9iR2VFGqCrYyRLL3VVn2dgS7xs12X/90ML8c6mDyBT?=
 =?us-ascii?Q?YM84o3lprzkoFcWG7sjpOSsmPaneFl0KKm8tDut/H+IWApuOvq8zFfp9Y6Z+?=
 =?us-ascii?Q?DQFTEAuwAGzmbvjur/inbpZmf7bmWFJ0+MtIYwSo4/ZenlQtrbO4XET8Md+C?=
 =?us-ascii?Q?avNcqo6jw3R3CUmaIIlxI2fMsk6gpRGCB3PcbF6fcDrNSL63q0S09piLuFsq?=
 =?us-ascii?Q?ns+T13JAk5fpww8worUA+eVyJnCaV6wx9CvVcbVZt/XLqsHrq16q9b2koWvn?=
 =?us-ascii?Q?+q0Oz3tzcMTICXmMQHs0F592lWP/o5a+j5t5+ASQcby/G5XncfEOVf+4BUV3?=
 =?us-ascii?Q?xUBIV6x0W0tZsOraS+eXY/3TOHk0js6cCdJKQEjgyM+F/ikBP7jd0XP5jW1B?=
 =?us-ascii?Q?np+Pcq+ogS8+FX0zM/zSpK3jM62MK+TSiSlYMOIwTTVB1PQ/DxvQTs4XGOa8?=
 =?us-ascii?Q?0v2ICJZKnqwpH4Wz3h37NEqW5y5NVSAQr3Ncfn91OmSoXMaD8fPpXBwrIdiE?=
 =?us-ascii?Q?YiUSFRvS4IjkBORwIAiEsmAiesYyyzpiWsIQ3jgO9Rn+TgXOwFX6B3kKQBgj?=
 =?us-ascii?Q?utWYjwPqzpIiBdE27bZfyl8UhtDUO4ABgrppaMyml1IHnOVBEmQU7jATwg+I?=
 =?us-ascii?Q?3HC/CNp+ySGs1LbZT5OxqTvcjJ6J9F7JLq6YlTvCawspM2AZNlakPWpmExBw?=
 =?us-ascii?Q?kwZBrd1c0OEBki3chDkzzHs2dJ2DSxht0NeZ1PyHSqEBFuPGMBFnMKuT4EHx?=
 =?us-ascii?Q?4wbWQ4jK8upIoTXBAZxCCqyf082RfJ4bPqF2oMexBSz1ofCguXlu4G1KP+kk?=
 =?us-ascii?Q?dahuJY0SoqFiUcXZRzwOcAiiGFqPNKMmvOSdZTeI9XF+8wNLTSHoMl4A0bPG?=
 =?us-ascii?Q?COaFpfIFj/EM2jMQBPhmaEN+0om2DJCzaSfjrb3YlgHyX/qV7/ubvdUPjoxm?=
 =?us-ascii?Q?8z+aUOh1l2el0bLmYQ+YniFVS72KIEBIk4bXtgJ/R5LRiVz34Ob4dOq0rzRP?=
 =?us-ascii?Q?rEOYpArji2/MzWdjCDJmeKHFLLHSvMIKYSux6gTK88s9qnXhHPuQCYC/jfYv?=
 =?us-ascii?Q?vQTETs6JOmHzM9HisWmXz38PFViE0DeFXrS/Q8EVXzlAkkSxi7dY51JYMczL?=
 =?us-ascii?Q?DUjaav1s39e89xLHQsD42+GTmsQiym5vu3UM9uN8xmprNKcOb1n+fqtsgl2l?=
 =?us-ascii?Q?rdwqDaFoEqnHgyUdC2Hhzf5l4rxCfv/ynSFjOXsQlsC+onoVd7tBFvTW8vyO?=
 =?us-ascii?Q?Q1BeJIJhjbooW7Z6jItNncXdlHBHXJpEs5EYp17TdUmFt2vLiQtI9H+sENTp?=
 =?us-ascii?Q?csNGcADHmmc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a6TCVJS33IPNWlZeid8zg8GgKXEIFON8vhR9lvI/4Aqubyd7coBLKdKBUAYZ?=
 =?us-ascii?Q?LsfgUxzZ7ycMj2ksLCcJMXVGMDl5zNBYDRb+4q+Rp1CT1cP8Mm8E2aIZii6P?=
 =?us-ascii?Q?hAJQccYAcCP6iQI1jYtkaU5JlZ/3giUDrbbdbqG82W09gsu4XEyGh/Pbjw7+?=
 =?us-ascii?Q?3M5GIFJZwsXF6zCH68BurNCdTTJ7Q4fM+SA6D7f0y/B9WfnUmMHJn9+bQO1s?=
 =?us-ascii?Q?oPVIjWNQbORL36TphMX3fmQTZh/Zl7nveNljMvKROj6W7kPM0vXdG+D40D5q?=
 =?us-ascii?Q?rWnyg/yEw+Wrhg/K0c0waRmA7be9bT1o5TvBEVm7PUf/PvG6ZiO2BGUmpti5?=
 =?us-ascii?Q?cJ6pVoADE//hgPc9EiRI1RMfSSNfrBA/mdCpImDHQCsOII5JKLKlk0kJJv+9?=
 =?us-ascii?Q?G/wTBixshvqJKukrnIepcfdbseWuRJNnthtE0Qwv7k9eD0hAKW3Fw5zyn8Vn?=
 =?us-ascii?Q?EeG/W/IGZCB5hLkGi8rOjCPesv4VekN402u9Da89SnAfjVR/8m55740Xq1Av?=
 =?us-ascii?Q?nr9LpLTA7BohO+GE+9HHExTDpdJBaN6uiiifaZ/6ja4Bwar/ppRbI+Q263dE?=
 =?us-ascii?Q?0fZae9Vdjl+1EfPMoszykPiG5yjQKT/WagRg3tOGT4PsCMkYMlibo4kvLhEv?=
 =?us-ascii?Q?NzQcRtoR2Cb005uP7+XC5hEKCw/PXGEPxil+8vJG7+AqZ8oHrsBV8uXh93KV?=
 =?us-ascii?Q?UVALQLoHLWOvgVeI+qYCkSqd7N9ovmfKYutSTlKa42X4CUiiIUSaSyIntRw3?=
 =?us-ascii?Q?SS+LvsMUqbwvFYaEl+dXOY98xZ2dN9BaIIpGEfiIpyNpBXB3mXxQXSR5BZht?=
 =?us-ascii?Q?KJMwcab0xcDEEZqk27dv0ThF9ECwg1wyMDyv8gCwSPD8MQT57fZVH9J+m5eB?=
 =?us-ascii?Q?5OfJSjd8p/r0DbcKrp3TQ2XSkq9CyOlIEBnB+Q/FEqrw9ccC/S8EwNBV40ai?=
 =?us-ascii?Q?kNwRpqaQ7As2CP2AemN1IvJrZbQh2xfVMjSYzXgJpDb+mqeY4LLmgV53TCXl?=
 =?us-ascii?Q?J4Zm+tumRazoi9VA5ZLDRULRpu4kZmX4071bIExdZqC39u7TsdVYykT9wZoS?=
 =?us-ascii?Q?PaaarKXIhuQsn/ny0y40RIyPN4GVPqCCYgCdNcEXaE18I4B2l9nQ58qcQPq/?=
 =?us-ascii?Q?R4tgT8Cl/Eo5NCHjkyduVrZ2cTYVacZ/sO+h+hjmYnnQI7ppbY6EVFjhsQFe?=
 =?us-ascii?Q?FZNX/8bUj7XrEOknL02SXRCRrDPo3RBlkjBnnhtkqymuK5etxD49lCWNt6Hg?=
 =?us-ascii?Q?p+TDH9jB4dLx+NthXwvqrNuwNWmac3Sesn17/bmL0Cpy/AJ6R0s8HNGn0SVq?=
 =?us-ascii?Q?ckDRvqi0FcHtVC2n14T4ucHvNLpvisT2b8zmQgOSzYUFGnLOfLEzqXnvAAkK?=
 =?us-ascii?Q?HwMv0fRBHj4xGXkYLyB4UCbtRYTfr9UJq01rFMZvMlrC4l2S0N18aypeOdF8?=
 =?us-ascii?Q?ZPB83RLnIUvtrZJlJ5yCQ7TzgnEkLW8rvESjMqEnc/TMwoG+Skzb9aSouXxq?=
 =?us-ascii?Q?xyIMiKBlheEAXFK+L5Fi2EPv7cHWW+IsF32vBHX4oVFmlnZaVf52aIRhrfhd?=
 =?us-ascii?Q?I3AQ27RzyVussbj/8PpGwmfJNgqxk3F8NeRmJf4FO25ms0hagGTQ/I/XWNzM?=
 =?us-ascii?Q?qRZlDU61KBrIp113402HgS4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a544cf1-53a8-43c5-5e94-08ddbada432a
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:07:55.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkITKFprQjJssC1Ou7vf4yCb+WQeBXjJXkgBnHN5HLtmYqfHr0vxubUv9vu33iwrdAJqKZQH/zSnEL2dSO3zg8cBR1X9FaTD8tgCRqskPvaFSOnbRrJ0bfIGNUpggB3+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19347

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 3d5fb05e829682fd7d0d08cfcf6415aa50d4cb22 upstream.

Add DT bindings for the Renesas RZ/V2H(P) Interrupt Controller.

Also add macros for the NMI and IRQ0-15 interrupts which map the
SPI0-16 interrupts on the RZ/V2H(P) SoC so that they can be
used in the first cell of the interrupt specifiers.

For the second cell of the interrupt specifier, since NMI, IRQn
and TINTn support different types of interrupts between themselves,
add helper macros to make it easier for the user to work out what's
available.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/all/20241009230817.798582-2-fabrizio.castro.j=
z@renesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../renesas,rzv2h-icu.yaml                    | 278 ++++++++++++++++++
 1 file changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
renesas,rzv2h-icu.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas=
,rzv2h-icu.yaml b/Documentation/devicetree/bindings/interrupt-controller/re=
nesas,rzv2h-icu.yaml
new file mode 100644
index 000000000000..d7ef4f1323a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-=
icu.yaml
@@ -0,0 +1,278 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/renesas,rzv2h-icu.=
yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2H(P) Interrupt Control Unit
+
+maintainers:
+  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+description:
+  The Interrupt Control Unit (ICU) handles external interrupts (NMI, IRQ, =
and
+  TINT), error interrupts, DMAC requests, GPT interrupts, and internal
+  interrupts.
+
+properties:
+  compatible:
+    const: renesas,r9a09g057-icu # RZ/V2H(P)
+
+  '#interrupt-cells':
+    description: The first cell is the SPI number of the NMI or the
+      PORT_IRQ[0-15] interrupt, as per user manual. The second cell is use=
d to
+      specify the flag.
+    const: 2
+
+  '#address-cells':
+    const: 0
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 58
+    items:
+      - description: NMI interrupt
+      - description: PORT_IRQ0 interrupt
+      - description: PORT_IRQ1 interrupt
+      - description: PORT_IRQ2 interrupt
+      - description: PORT_IRQ3 interrupt
+      - description: PORT_IRQ4 interrupt
+      - description: PORT_IRQ5 interrupt
+      - description: PORT_IRQ6 interrupt
+      - description: PORT_IRQ7 interrupt
+      - description: PORT_IRQ8 interrupt
+      - description: PORT_IRQ9 interrupt
+      - description: PORT_IRQ10 interrupt
+      - description: PORT_IRQ11 interrupt
+      - description: PORT_IRQ12 interrupt
+      - description: PORT_IRQ13 interrupt
+      - description: PORT_IRQ14 interrupt
+      - description: PORT_IRQ15 interrupt
+      - description: GPIO interrupt, TINT0
+      - description: GPIO interrupt, TINT1
+      - description: GPIO interrupt, TINT2
+      - description: GPIO interrupt, TINT3
+      - description: GPIO interrupt, TINT4
+      - description: GPIO interrupt, TINT5
+      - description: GPIO interrupt, TINT6
+      - description: GPIO interrupt, TINT7
+      - description: GPIO interrupt, TINT8
+      - description: GPIO interrupt, TINT9
+      - description: GPIO interrupt, TINT10
+      - description: GPIO interrupt, TINT11
+      - description: GPIO interrupt, TINT12
+      - description: GPIO interrupt, TINT13
+      - description: GPIO interrupt, TINT14
+      - description: GPIO interrupt, TINT15
+      - description: GPIO interrupt, TINT16
+      - description: GPIO interrupt, TINT17
+      - description: GPIO interrupt, TINT18
+      - description: GPIO interrupt, TINT19
+      - description: GPIO interrupt, TINT20
+      - description: GPIO interrupt, TINT21
+      - description: GPIO interrupt, TINT22
+      - description: GPIO interrupt, TINT23
+      - description: GPIO interrupt, TINT24
+      - description: GPIO interrupt, TINT25
+      - description: GPIO interrupt, TINT26
+      - description: GPIO interrupt, TINT27
+      - description: GPIO interrupt, TINT28
+      - description: GPIO interrupt, TINT29
+      - description: GPIO interrupt, TINT30
+      - description: GPIO interrupt, TINT31
+      - description: Software interrupt, INTA55_0
+      - description: Software interrupt, INTA55_1
+      - description: Software interrupt, INTA55_2
+      - description: Software interrupt, INTA55_3
+      - description: Error interrupt to CA55
+      - description: GTCCRA compare match/input capture (U0)
+      - description: GTCCRB compare match/input capture (U0)
+      - description: GTCCRA compare match/input capture (U1)
+      - description: GTCCRB compare match/input capture (U1)
+
+  interrupt-names:
+    minItems: 58
+    items:
+      - const: nmi
+      - const: port_irq0
+      - const: port_irq1
+      - const: port_irq2
+      - const: port_irq3
+      - const: port_irq4
+      - const: port_irq5
+      - const: port_irq6
+      - const: port_irq7
+      - const: port_irq8
+      - const: port_irq9
+      - const: port_irq10
+      - const: port_irq11
+      - const: port_irq12
+      - const: port_irq13
+      - const: port_irq14
+      - const: port_irq15
+      - const: tint0
+      - const: tint1
+      - const: tint2
+      - const: tint3
+      - const: tint4
+      - const: tint5
+      - const: tint6
+      - const: tint7
+      - const: tint8
+      - const: tint9
+      - const: tint10
+      - const: tint11
+      - const: tint12
+      - const: tint13
+      - const: tint14
+      - const: tint15
+      - const: tint16
+      - const: tint17
+      - const: tint18
+      - const: tint19
+      - const: tint20
+      - const: tint21
+      - const: tint22
+      - const: tint23
+      - const: tint24
+      - const: tint25
+      - const: tint26
+      - const: tint27
+      - const: tint28
+      - const: tint29
+      - const: tint30
+      - const: tint31
+      - const: int-ca55-0
+      - const: int-ca55-1
+      - const: int-ca55-2
+      - const: int-ca55-3
+      - const: icu-error-ca55
+      - const: gpt-u0-gtciada
+      - const: gpt-u0-gtciadb
+      - const: gpt-u1-gtciada
+      - const: gpt-u1-gtciadb
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
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
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+    icu: interrupt-controller@10400000 {
+        compatible =3D "renesas,r9a09g057-icu";
+        reg =3D <0x10400000 0x10000>;
+        #interrupt-cells =3D <2>;
+        #address-cells =3D <0>;
+        interrupt-controller;
+        interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 262 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 263 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 265 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names =3D "nmi",
+                          "port_irq0", "port_irq1", "port_irq2",
+                          "port_irq3", "port_irq4", "port_irq5",
+                          "port_irq6", "port_irq7", "port_irq8",
+                          "port_irq9", "port_irq10", "port_irq11",
+                          "port_irq12", "port_irq13", "port_irq14",
+                          "port_irq15",
+                          "tint0", "tint1", "tint2", "tint3",
+                          "tint4", "tint5", "tint6", "tint7",
+                          "tint8", "tint9", "tint10", "tint11",
+                          "tint12", "tint13", "tint14", "tint15",
+                          "tint16", "tint17", "tint18", "tint19",
+                          "tint20", "tint21", "tint22", "tint23",
+                          "tint24", "tint25", "tint26", "tint27",
+                          "tint28", "tint29", "tint30", "tint31",
+                          "int-ca55-0", "int-ca55-1",
+                          "int-ca55-2", "int-ca55-3",
+                          "icu-error-ca55",
+                          "gpt-u0-gtciada", "gpt-u0-gtciadb",
+                          "gpt-u1-gtciada", "gpt-u1-gtciadb";
+        clocks =3D <&cpg CPG_MOD 0x5>;
+        power-domains =3D <&cpg>;
+        resets =3D <&cpg 0x36>;
+    };
--=20
2.43.0


