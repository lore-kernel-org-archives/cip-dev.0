Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D9FC83F0B
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:06:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.34])
 by mx.groups.io with SMTP id smtpd.web11.8445.1751619980896622719
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=bs94D7ua;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uykvpJCKlEfN5puDixYyL7bfewV/lYYJtpZ7eqsSFxZLV1gUv43+gh48DBWO3PxV8z1j0IIuiK73aYBvNVig2R/GX+MxRlnmOBdld34iuQ9W4Dim8ovugIQnodT3qtmsYvUWE5M9m1jf+YQE0qxy1vW9OOqBgiIqVMghnjCDDq7bXk9eqJkkyNTEcw7ir9evqMzywwZJUTUn6oRgNAM3PPQUBPL926j+MXE5czoLUJUZzMINA9A3cfWQpgNrJUTfBw6Kd8tTzz1qn8U2Knw6CpFuAJaDd9pYubWmLB0h9XJXGW4YWYGSq2Nn1xQVrJtcS91JAwGn3rkhMtdHcJtMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg2dv24mNzSYR99Hsz3qbfF1A/jRfSIbhaQ3mb+aHGE=;
 b=eNxHV6V3gTu5f/JoYJREDBqISysYJrT9Q+vayUnLvpJuWhsCYp/0kI9iwHY9h0CraOObyP51QgsTGCu1IW1kUX1i5+iHd4SAqwTQ/hl8JZwc+2WPBFu3L6sogJ6wFQnf3B8iOH03TtgipM4FaV8g3adQbcE46DgpNtFRXSQoxd9DaiPNCFyo7SzPUSbFfk3KNDndwBIpJGy6Wn4JahsB4l9qV1tYpPN16Yd0twCV9EWbkRRTEFtqUAG3UNbgECGU+Ld3bnHceJm/iApyNOwYvAR+cs2UJaranMW19KVLm+oyb85p8Puo+z6z4dXzkc7BXfJ1ijOrCcjvSthT5TjTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg2dv24mNzSYR99Hsz3qbfF1A/jRfSIbhaQ3mb+aHGE=;
 b=bs94D7uaodT2NYOyASY88GHI5MaW585QORRfnefLQe9H3VndKXOV7EQE8WeAedDNWa1prsfnhMZhuUyzC38wQcHNLTBvmNa6Bw6He97z6ihtJHrRMufnPiekn+GoMyLlYGtM0kKckiyv+P7fXWVnP7Oge/B1l3lBIL9H61Ls5KQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:19 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:19 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 01/14] dt-bindings: interrupt-controller: Add Renesas RZ/V2H(P) Interrupt Controller
Date: Fri,  4 Jul 2025 11:05:43 +0200
Message-ID: <20250704090556.669652-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYYPR01MB13039:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2fc2b5-990d-4fc1-7fed-08ddbada0a23
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?30Oabd7tFCpuQ3zrtUFd7rKiyDxZGLgXXdfVMQlidEWQQjvDs61A2F3zerjB?=
 =?us-ascii?Q?3hZy/4mvev+G1/9mk6suV3/MEYm19pMjf8xseAJDH7ay7NX3IjFHRfZ0NjtS?=
 =?us-ascii?Q?8iefHjyQO5XzM5bDVcvMJxKV8+vmjWSB4yQEVFtJvJs/x7/twgzRp7itopmZ?=
 =?us-ascii?Q?o/odVI0w/38lSil+R+CQZuJjaBOZoRutcAz/hYlynFVtwwyJ85I4CBEkakR3?=
 =?us-ascii?Q?lmpGdigUpE7bhGfC4oJOOIrIut26CIN5mBUs+iLP6W0+tq6apFS2TsPqrXna?=
 =?us-ascii?Q?AOMG/a6MA/elVBONSoGVzzMRin+62U0LI5C7hYULMNd5aHS7Jny4JLHUm6XS?=
 =?us-ascii?Q?c4H3KnfL8AZ95EQ3djfMPa5MmEk171hMbu/q1Jed12qjC14kxYbEwThdGtgf?=
 =?us-ascii?Q?a0MKSbqZXxYExx9JnbTjJb5hgzdr9AOrofYeLu9cct8ntOEBEleqY7BJLK3X?=
 =?us-ascii?Q?RMEKuZMbqOV7tdn2i469CoWPqsTconAz6TxuSU50LzzS0ue+gw4t+5Nr1F6p?=
 =?us-ascii?Q?+6IccGRL9F6mp3TruF8kk9LrzSymySgUkHjfpT7AtoWYy580WkZKErgz7bN4?=
 =?us-ascii?Q?hpag4yyqFrhFHI7lJPOFX8jhKRsR57rMQYtyfHzT7FYEvnrl6XIMsRyerXf0?=
 =?us-ascii?Q?7FGqm4OYw0t5dAXcvM+FJbMuENhS71pEiifs2MefBGlqPj5tMNQyA+NG4PuS?=
 =?us-ascii?Q?W+0nKqNUEHatUsqDvXxJtBjxiPbydNcXHnFaaYSsNdwu4sIx81yYQU1iKS36?=
 =?us-ascii?Q?doIafwY1rrLpKLFTHiZOIlKeTK9GnYB81x8wRdrBkeeYDdq03tkhQFHRtgYY?=
 =?us-ascii?Q?69bkdttHxLxoUTmiFVcerllLKQ7NzOb9czD8vE3XTAHZjZ/HN5AsgU5rDP3q?=
 =?us-ascii?Q?ZRDTpvY76qMU+8Bo2qWTJcHrYeqVqnbfiOpD/hz4eXQh5Tgwh9/Wh0uI5ZyH?=
 =?us-ascii?Q?Y9NXFiAHgletTitT42sqDrahj9iNnacD1GBWwCkTXq/2AceS0bPC5COCH8AC?=
 =?us-ascii?Q?QCgU9HMvxZuCr2ppPYNiGIEQz7yTNERHGcv4+Y88p9fBlRepRoraic/wKM9/?=
 =?us-ascii?Q?ih9WngWmFJiV4xIxDeW5+Q/P461XL8KIOlWWj8rK07V6z5LpDC/QsEAOHdJh?=
 =?us-ascii?Q?7Nxa5hsEvoEe3ny9t62r1WmA0DOd7h2nJChiEr8Wj/2Nop5BVPagqO0F4RBz?=
 =?us-ascii?Q?8xVQLk8e4fGzu8rU3VVkrVAhBzIAKATSv2WaEUOCM1ovKgbIC9C2Wo+mSMig?=
 =?us-ascii?Q?Xf4QQvlIysoNwunW4vmKZApKNOakuyAJnhGFf7vgQGbfOB4g+SY3/BF6DscA?=
 =?us-ascii?Q?KflegKf5cIGv2NuG8o1kFj8zsuFTWb9SK2/PMw0DcWub2hcrYDVxRGjHRdYA?=
 =?us-ascii?Q?7jlbep+Vmzu2ZQvEC16YWSv3RaJAgdVHjFQJT3fT3knUJBcHwyfZq3KyzL60?=
 =?us-ascii?Q?JxQxfUHuTPY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E+iqG56tY5oGFT4KKMS5v8meCBZ1hisFyNW++OvfgeQS8+I0tAtlwTS0EF7v?=
 =?us-ascii?Q?mKcOMH4MhDLApk/OhOHv9G3DpAQaNa8Xr9g9KU9Kz5YQFtLetB1tgKD45H1k?=
 =?us-ascii?Q?2VaFJJDyJbRQAxSozgEuwIpWoxYWlvizlhxXJ+osMI/yyUL4hMr+rHSVOHHW?=
 =?us-ascii?Q?d1tht50wxCw6Jkg1BMzmOHVnE7+7ssPSrp9p+xgYyxKYYyZE+doOsJvicNs6?=
 =?us-ascii?Q?AtAtkwCDQEUGZhvL3OiTtKr4LUK//tTty07z/kTgMkOeg+ecfdBAcPxgBJye?=
 =?us-ascii?Q?R4+KdLUlMFdgGxUm3x0aABilPZxMZvBHRcv+aLpn9zryv+Yxdeu2UFdM7f9A?=
 =?us-ascii?Q?P3gd99jpb1t+KLVvSdzFq1YnX05bR6R26NJxg9p2xS7UGbUCkiKK1ijPBC3T?=
 =?us-ascii?Q?hpwwytwbR1P3yDaeNft8mVMysg3iabdAFoJwM84zjQgQnxAxGuksC99Ca/C9?=
 =?us-ascii?Q?HBiYCs71X2Iby46TMN3HlAXvsXN4yaH0y4udbXcvpn0M2TtneL4QtOMxQvNb?=
 =?us-ascii?Q?LUZ9vnc7m7RSTGXRJ5po6RZGCBHrlAJ1xjxM9zutKflbYUNk5htLvTfYi5zE?=
 =?us-ascii?Q?fT15+U1gmkY6ov7MQ5HNykrJB6YsKU3ZS8K/MbfbeJoPEbx8nfpwqC5PL6zT?=
 =?us-ascii?Q?KSf7E3moZ5j/lwzc+CJpgXvPKbRjZRpkucbHwbD0/vFPwpfDs+MEn3ALwuaR?=
 =?us-ascii?Q?vTWPfYgmUxHZjuKYTBZ7i9IszBa1ipq6yBxxz0/LEKX1n9IfrIp4K2NS0M3z?=
 =?us-ascii?Q?7+HVZ4G5FblPNnVPQVPl8OXup51wzrdQyDepV7L/KW0x/s3Zk1oKThlG/srv?=
 =?us-ascii?Q?rvR20TWO565Rdrsy/NC+3QieSPBrxmTq+YK465MD8AXwqBbejIUMAuUGceQQ?=
 =?us-ascii?Q?bjZkrtJi56zjR5WZOkRGdONlWKyp9UbD8HebOSgC1t0WZTauOiuhatojMpaF?=
 =?us-ascii?Q?nc6D0gV+ecL7jyxThBKkcl/hZv9jixrl6vmcJG63fd+eCbRWUgqvKKPYJPaH?=
 =?us-ascii?Q?h2Bm46ZssnOijEbQNYohEWw38Loisbvg1LYkIlVTjG1p2yOLrQn5/hiou9E+?=
 =?us-ascii?Q?ctHwmoS1kPrWUfrmLrzhhrRI/1Sro3myXwR6NqskwzbtiqQkkkX57CYzIVkb?=
 =?us-ascii?Q?/KC7FKeuG8dFbx8TbxKqqKtzYJbzQL7fCC8NcJcHCRiYnKTTJbKIc2N/UW6t?=
 =?us-ascii?Q?DYslD8mtVpUYQ5u6DSRxR+YObkuvomfvi5hIS5FErhrnZk+tGHvAYK/OoOPz?=
 =?us-ascii?Q?uakh8RUUklq5jTPOVKyf420zLQf6McsUyMA35S/QGO7FbgT48HXO+/B8fOeY?=
 =?us-ascii?Q?sz7Iv6+xElYr+cqkZPuFbY8lnyLsPrL0iCVDEyAn4EYcCcnfruQgWfK2XMFj?=
 =?us-ascii?Q?/ZwsiQLMbS+3JVm/Pw+N8tV/j7RuRvaM5KFJHlX5AteCv9iYZVz+wZddjsOR?=
 =?us-ascii?Q?JomjR89DL8bjuBCHt0zganQp6D8LKDBp1Ox4UNeWPKZCzAJwrHWT9xqT7/qs?=
 =?us-ascii?Q?5h/38gggq4BOeOX8+zKs2YGlsTPjXoZTgIIynGl7v4kTYyOfL43q0hi2hOKG?=
 =?us-ascii?Q?Av+Bn6Wl5VDotgIQgWP9wX0xCLNCnr1D9pbRKliwhTA6KhjLq1XjULBEz5MC?=
 =?us-ascii?Q?34FuQrHkBlgn11mveO99WIY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2fc2b5-990d-4fc1-7fed-08ddbada0a23
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:19.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrUiX1h+M2tFDUxDEbREtjAhSkPmuqqeM/vWjqV8aogOaqwM+ziE9XlRr/I0BuqvjxY4gYXS/jN6Wc9AT9e6wE0RRo53GhVFqnT1ZppCXpGt8w6b8Rc2uYsy2AkXDkln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:06:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19330

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


