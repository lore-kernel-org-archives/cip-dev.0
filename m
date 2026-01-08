Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D707CF6A8F
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:00 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2985.1767864532451868369
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:28:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=SwhyqL81;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOIw5IeeJMChgBStFGGhger0R5HRDLU1Ydaov8+8smwRuq7MpttQq6DiT291fc+5Xx5I1TbB08ak2TuShxfHEh04Oz11UhRKlLbdonQF26d8NGObT3ICTY/9rtSePo9HMeWkYPlBEpqWS5IOqdiIndUXuGGeMzUzIuImag2aSmKf2cVGGee6f3V3hB1zzJ5LhyXf4ft7TzrOSKojOwtNc0iuwcRHqs5WXJEqXP8r0+IZWK6ezv6V3gaCBj8Ihu1M01zSJkuk30rD96lVtrklVbyuJrApkmKV22Q65R9LT44ZF6yR5jYzncXodb9OXV17X+rb78L1O+4xJWPGijP3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXvSTA4JnfYm+lAmjBjJ7EPvwCYk39ZhR2wXtCO+kPc=;
 b=EbiFWKii38vX8eYk63kWAg3FtQ/HYnWEnZHzI15mVevWefTKKWPTU0dmkmD+nnY1re2J3pUbQficOH3xGyrGZyrbk41SkwNt2K1kZYXgNG0syDH55bafISKTyTPFfaiGYGwnGRRRSZzB5XcNwCiQe+APeFySeR/zE3ShyuFEUCbgbW3GslY/RJ/qwj9pw4SYyBCKFz/TISJmisSGHILP2fK5jd4ftR3+Q8me8YAjlrudu/uDR0mM+6NWiUTq6v9vBcgfxEInRcLT8Oojs0IgA4nyoLg7g5FhEYqR37kjh1d4JHY4H+vdiffRjHhIAvr5AgrUblS6fiHV14Bfat5h2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXvSTA4JnfYm+lAmjBjJ7EPvwCYk39ZhR2wXtCO+kPc=;
 b=SwhyqL81Bl1gv6/HrO6cj8sJujSAnbGQNFRjElwjmTWZjPuV0DX/cjMybiOAC/NVA0Qa1oL8vsozECkoRNPfuj7BigX4g1ao5c72WJwejVYAOr6rluSwKlpjMHymC5mb95t3bwganThqqXa7qVzhJa2eofKJ+cP1dg8QvS2/pC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:28:51 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:28:51 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 02/22] dt-bindings: i3c: Add Renesas I3C controller
Date: Thu,  8 Jan 2026 10:28:03 +0100
Message-ID: <20260108092823.489287-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB12872:EE_
X-MS-Office365-Filtering-Correlation-Id: 398b1b27-9a1e-43a2-1ae0-08de4e9855b6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?w6je4VLL3qam115kZvBUjxHhComMzrDipim9ej3S1FtS6tD1IGdfSqrIIHGZ?=
 =?us-ascii?Q?Bo+L5O+5uM6uuVJrMfjm7wRyovb2mNrr/1ot5OMHs5MZ0w9YKOowGIruDH6V?=
 =?us-ascii?Q?5ZLHmM/SZxdV/MYdvuJw6h/DRkQHVURrAm3kzgEu9/nlJ7HfjU70LBdSEm8H?=
 =?us-ascii?Q?32ZKdHg83An+wEXsrZuxrJKgJMqtq8Rl9YosU5VR7U0yKPRbnPC2ZVQ7wvw3?=
 =?us-ascii?Q?uXAyOvFTsN+26V3h8WgHNypzjXYNH/akQ5Q72I+7gaokLSkWWeAB8Y6ywBaH?=
 =?us-ascii?Q?tko/JA/gdk6S4AY0Buvh96lTUxMgB8i2jfWOaY0p8MzcJ51PueOPL3n2FV+9?=
 =?us-ascii?Q?B57C3sAeNayj2gxkjmsz6mjzMy+e66W2RQf/OcCeEApSxYTSmk2Sow0sNnVY?=
 =?us-ascii?Q?PpvKlHqYKCpFeaCbqclupQhK4w0gpY0nh3I6TI2AiR4+B6TLw4NgofJjajok?=
 =?us-ascii?Q?+BwC+4c3JgSAmJHZuw3PENuRj4j3pKu4Knvr9nXwG53BxTnNj0mMTh3Il1Va?=
 =?us-ascii?Q?4j4PCNnH/nIMltkt5mQczsCmXCq4rEG0IFdmF3ZOnaPqas3JeKX02j25KmYm?=
 =?us-ascii?Q?uCTrjb7J78fOBo9VTHph8heR8EACKGZbdpU9asMdBQIVBvgBxP4lrvmwzTqA?=
 =?us-ascii?Q?TFmZct5vUmhgshJzJYYSCHd7bCr+XrEKscj5f4nIISu2qXFcJVuFYQXFYS0o?=
 =?us-ascii?Q?9LdNXWvqt1bDBFxmlAMEuCQNzr/MNF5ZKX1pH3tZUxR2H4I8CIIT+p3l31qt?=
 =?us-ascii?Q?psY4sZcqjPvvOBBvkxn/DRX4jrHEXafIXL/Uv4+T564ghzsWsS2IJC0tK40l?=
 =?us-ascii?Q?o1aVG/UEOPj4LjxyUhw1Ps0UwpF6rRVmNn0crPJI2ltN1iqCe3q60I5V/jlM?=
 =?us-ascii?Q?/gGAzjSRabGTn90koYE19lenPXdIh6Syj5q0yfqhSBrTXVPQ4sYXoIHfzAZp?=
 =?us-ascii?Q?uw6agjb6MLPYVRVYA+UoVRBWseQlYXPd+q88cXRE9KdxcSJ4pxyRkuQm66oB?=
 =?us-ascii?Q?6ekYHhgC8DXvt3HLxVGJPs4Hu03vdACIaXTl06QXyv58g92efZsA9H5FKDxH?=
 =?us-ascii?Q?9nHcwN07gNdLcuhLKGX071FlSmnH1e8TdnWBoF6jAzq9yBSqb8OGAFxHgfj5?=
 =?us-ascii?Q?fjIKb67nV1mXyV/1n7trMghNdLsZzpXSe+D7gFsIhhqz1y4gyRXoCDWHQCEO?=
 =?us-ascii?Q?FHMX2/Ht7nwapP1d3qMKeyP/O3qpBgWaZOXih/pQV6mVih3xX6A3lUMwqMEH?=
 =?us-ascii?Q?exfA3DTa48NqBOPS+336/wAgKiQIeyPWJ8SWRJt3/UZQEdYnvBdmJyw9U9dI?=
 =?us-ascii?Q?2RKhp+BPEC+nFVIK0YgsHQnurZoRIO/Uc5HJCBPCexUIV4AZ2WMQPjCtjvTj?=
 =?us-ascii?Q?dH1943YLTQzAuhireXLbFDsbYcWobcGvg37p6rtdtbI/Tkf9GX4lSBOTNJYY?=
 =?us-ascii?Q?cFmLOjFsUXVKzsmILK2C2HRo7DWCGNIHetBUaszFNNferktwjrK4HA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XZnHnplezkke0EgbNpPCG9sxllqSaqCxdGarBF33VvsdRndZp+9pv9yqctwd?=
 =?us-ascii?Q?xZ2a8eFIBCtU5nDUSaxw8wWB0bRHiAI0gvtOo1iKUI0fqKQjEGQ/V6JX47ce?=
 =?us-ascii?Q?U97oWM3WqRR0sMng3VjVYpmeeDLTkGq0/367UX7Yxx3KeEjtTySs9qmFsVJe?=
 =?us-ascii?Q?nQiHew7RkD0jAFVx1jbsyGiWmdfLNkmezITdFselkdaQlPlRvmkk/xLd1xas?=
 =?us-ascii?Q?Nyq9u+q0zZmX5BzVxTFihuaeTl3sz8AALSx41STbD5m9ces1K36+gn+JxuQj?=
 =?us-ascii?Q?0mGLEhGq1reUTSCygop6pxSpU4TDtPdnHbmqoj6UWyaX+J/BZwVj6yb3svbz?=
 =?us-ascii?Q?w8/pf5Kf1dYMMqlDHJDFOtel16anJE/wXMYPNpWMSMKzpZQU8AhZcr0LlbZd?=
 =?us-ascii?Q?PGxhRV3IwNeltk+M+L0hEVLo/wAkIcpIRmfQjFFOaw7w1LpjVFP8qBXEyvLd?=
 =?us-ascii?Q?TPl4r22lpagAsbOSzBJ7gqdLvKIJKGuwQDDeaKQ2itmRbH2nUWQ6PKeSqi9I?=
 =?us-ascii?Q?KtjqotTkfUqwYLQkPZOGmJcXVf0cRaNHS9A37TzXS74hngUmeyKADMX6FykW?=
 =?us-ascii?Q?WfN+jYXnyIxdlbzXXNNgNTCr4UWGt+5yq3jkYokVyjPL6PiKJ6KFjrRIE/rd?=
 =?us-ascii?Q?jbvzZhyy0itALgWwK+MK5FX/YPmrcFvBdmUuSXeIzbKBBwrgVth0hIiJXR36?=
 =?us-ascii?Q?eyYmAxNkh/MqLqFU3Kz2YDt/+YLxJBMXJVwVnzH9P2VLtD2+YR9nh+MJ+8Al?=
 =?us-ascii?Q?ySXfPSYSFBZmn0zrvVadzEBjW4bg4xvKSlw2X0qood2oL+45kV67qppTRy21?=
 =?us-ascii?Q?Q81S1i+7jn97cUhazGg/lTKARHx8bZm6oRYtTWbhxDprjx9uFqSBiWfdWDnp?=
 =?us-ascii?Q?v1VMgL2naFHvyket5VZbfgmja68v8xeSj9E5DnA+ly/RqjBNwGvMP0XkI83m?=
 =?us-ascii?Q?yYSxM9AGkD3LC7XhBgAoVZC12rZNYXK7xl/dZNSu4lmdaUywMRE3yl1N6KFk?=
 =?us-ascii?Q?ysF/GIW5zQd7NJfSASCPuQCfPOkpRu/ncSxgOmwPQwrPMw6INvMyHLyALoLp?=
 =?us-ascii?Q?seE4sR9bJVSL77L03pcqY5iD9TYcPAQkLhRIJhRRUuAngcqLbAF7/S5ktiBQ?=
 =?us-ascii?Q?Qf5QRNDfGPPzONzakYPM9LM8kVAT6HRBKKwi/tvxquaPEPuA2/NHw/fwwlfd?=
 =?us-ascii?Q?xkmapUmv9CPK9YXymvu49OORjFEN3rW823qF824GotvEaTnTI4Adoi23r7Wv?=
 =?us-ascii?Q?grnWTjETTFoGlpQejhOSfcktOW/rtvj7FaURsq6r26/8aVC8QFkGiY17gnxs?=
 =?us-ascii?Q?OQYb+Al9HfuPomD6nRmBA2klBYUwzuwLq19y/dsUzjYYv3kMqlRZxh4wBmFc?=
 =?us-ascii?Q?P7xfhwaNLYmmd++aXgQWYe0UDaFizZp4Wz8c7OBwJq7uRBHWHxbxWCXyS7VA?=
 =?us-ascii?Q?l3LtTRDOaQRYVy44P+eVv3lyo7gfp7yAASlYtyuHTdE+cN0RVMdeHQgVkFkS?=
 =?us-ascii?Q?8xA3a6EXaUXGipYGBo4BeUi+1YLCfLrDv9OfDDz8naytdogCX58mKRzDV25r?=
 =?us-ascii?Q?z9QuAY0raqshMRrzDZk/tjXPkIqCS0JRN37ATFxzA/3W7jvOgo8IJeix2JGV?=
 =?us-ascii?Q?9rKMjhFH5Bv6dRp5zwoFvfbciWCFVbEKx2yr4knlUSzuHHC0an+LohY/RMao?=
 =?us-ascii?Q?HpFrIQBIMe1347tAxo+ejeAvx0/wrmCGFyu+DwmIzdtJ6pY+UHCw53ATS/DL?=
 =?us-ascii?Q?Qnod4leSWSbj+oJ5CDxKo76ANu7EcBqLj+7gWw0VfvxAEZ3xIrP8?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398b1b27-9a1e-43a2-1ae0-08de4e9855b6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:28:51.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdNre8s+TxMVDZ1hpLoK9kIJ3aCDCCoLcHLXjn4xZ+r+z44Q2Rayff1ENV17+UxSS9tOxxybMHblkiH5+aYlo9ml31/faEaGFJpYc7FZtdlaI47Zs4jV9Ei7/j0lBIWt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21438

commit 94e611b5b9ef3a1d9ba77f41343e95155a5091d2 upstream.

Add Renesas I3C controller which is available in R9A08G045 (RZ/G3S) and
R9A09G047 (RZ/G3E) SoCs.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250724094146.6443-4-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/i3c/renesas,i3c.yaml  | 179 ++++++++++++++++++
 1 file changed, 179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/renesas,i3c.yaml

diff --git a/Documentation/devicetree/bindings/i3c/renesas,i3c.yaml b/Docum=
entation/devicetree/bindings/i3c/renesas,i3c.yaml
new file mode 100644
index 000000000000..fe2e9633c46f
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/renesas,i3c.yaml
@@ -0,0 +1,179 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/renesas,i3c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3S and RZ/G3E I3C Bus Interface
+
+maintainers:
+  - Wolfram Sang <wsa+renesas@sang-engineering.com>
+  - Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a08g045-i3c # RZ/G3S
+          - renesas,r9a09g047-i3c # RZ/G3E
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Non-recoverable internal error interrupt
+      - description: Normal transfer error interrupt
+      - description: Normal transfer abort interrupt
+      - description: Normal response status buffer full interrupt
+      - description: Normal command buffer empty interrupt
+      - description: Normal IBI status buffer full interrupt
+      - description: Normal Rx data buffer full interrupt
+      - description: Normal Tx data buffer empty interrupt
+      - description: Normal receive status buffer full interrupt
+      - description: START condition detection interrupt
+      - description: STOP condition detection interrupt
+      - description: Transmit end interrupt
+      - description: NACK detection interrupt
+      - description: Arbitration lost interrupt
+      - description: Timeout detection interrupt
+      - description: Wake-up condition detection interrupt
+      - description: HDR Exit Pattern detection interrupt
+    minItems: 16
+
+  interrupt-names:
+    items:
+      - const: ierr
+      - const: terr
+      - const: abort
+      - const: resp
+      - const: cmd
+      - const: ibi
+      - const: rx
+      - const: tx
+      - const: rcv
+      - const: st
+      - const: sp
+      - const: tend
+      - const: nack
+      - const: al
+      - const: tmo
+      - const: wu
+      - const: exit
+    minItems: 16
+
+  clocks:
+    items:
+      - description: APB bus clock
+      - description: transfer clock
+      - description: SFRs clock
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: tclk
+      - const: pclkrw
+    minItems: 2
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: Reset signal
+      - description: APB interface reset signal/SCAN reset signal
+
+  reset-names:
+    items:
+      - const: presetn
+      - const: tresetn
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clock-names
+  - clocks
+  - power-domains
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: i3c.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-i3c
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+        interrupts:
+          minItems: 17
+        interrupt-names:
+          minItems: 17
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-i3c
+    then:
+      properties:
+        clocks:
+          minItems: 3
+        clock-names:
+          minItems: 3
+        interrupts:
+          maxItems: 16
+        interrupt-names:
+          maxItems: 16
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a08g045-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i3c@1005b000 {
+        compatible =3D "renesas,r9a08g045-i3c";
+        reg =3D <0x1005b000 0x1000>;
+        clocks =3D <&cpg CPG_MOD R9A08G045_I3C_PCLK>,
+                 <&cpg CPG_MOD R9A08G045_I3C_TCLK>;
+        clock-names =3D "pclk", "tclk";
+        interrupts =3D <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 294 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 295 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 296 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 297 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 298 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 299 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names =3D "ierr", "terr", "abort", "resp",
+                          "cmd", "ibi", "rx", "tx", "rcv",
+                          "st", "sp", "tend", "nack",
+                          "al", "tmo", "wu", "exit";
+        resets =3D <&cpg R9A08G045_I3C_PRESETN>,
+                 <&cpg R9A08G045_I3C_TRESETN>;
+        reset-names =3D "presetn", "tresetn";
+        power-domains =3D <&cpg>;
+        #address-cells =3D <3>;
+        #size-cells =3D <0>;
+    };
+...
--=20
2.43.0


