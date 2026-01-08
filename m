Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B1CF6AA3
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:10 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3031.1767864653256614730
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:30:53 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=j59m39/D;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.42, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnu2icxDGUtmX3DXH0tNR6VsZkEVWnuJBgcxgt+viCyaTr7eOiJuenoYaFeP3idJkhSl8AC/brulPX5UpndJamomxMuSybKrF+NkTtPOUfbjis8HYoAHvMelbhl9SYjDzjtHbQjLKAedxM1kA6AUBdYfLIg/SSEgvgBoflWezYi6a7vvGNFk7KHdFMTpRxJMbNBQIhbtp0nmvWIgXSuhNlHennrPToV2Qu+S7WrrZDgEaKmLvVCwD8i6aZHXpEkUjfaKqjfFiPPtMrvpVfuleeKaozUR/6GA6pYxIygwHEn0ubrKjsl14U5jtyUcQiDA2Hiqv0IG9X5zYh97AXy1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXvSTA4JnfYm+lAmjBjJ7EPvwCYk39ZhR2wXtCO+kPc=;
 b=LkvgdLRM4YQBDw2hqNONY+XsYH/izb8Hs9MGh63NP8O1s0K3o1QuMv+i8QbnwbnhyOBhygB9CojWypAbVcQP5LWbwtG+TFDExFNuqHixb+pG/eAZZ0n5iWi+Zr7nOL2nrtVvEQwrdkfb5JjDPejGpqXMVNigjQ7W/ISGQlBsFzIFn6fZpGFTEQg9ZnNvapwfEvMN/pmWjLEy4RguCi2VawCqdYvOMG13ac96wtJlQvdbpui+kMhe2q1lfR+WXhF3czB9r9u5Mjf3M6YI/qxMBGZ1fiBM2eNhrwX92OTDAGkwmnu39IzyVvuuHhQxOvDO09LsdBlcBxDnBng86leYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXvSTA4JnfYm+lAmjBjJ7EPvwCYk39ZhR2wXtCO+kPc=;
 b=j59m39/DTLoNoRAPBeRApUlfOPSMiZv/KSMtt+xt4c1StPZ4kDNFPQ3y/WHc0/DgdbEQV1KLN59gZzf0theAXfgjvKifdi3Lu2xM0uEh4p0QVfbE+yX4oIMso8mihTFt5SfpbRn0KnT+ZNkQxwEzVpxZ14k8CemokfzZpULvmjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14326.jpnprd01.prod.outlook.com (2603:1096:405:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Thu, 8 Jan
 2026 09:30:50 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:30:50 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 02/19] dt-bindings: i3c: Add Renesas I3C controller
Date: Thu,  8 Jan 2026 10:30:06 +0100
Message-ID: <20260108093023.489513-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14326:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6ef792-f454-451b-56b1-08de4e989ca2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yU6LrLfLnmFArLp98rqz2SHLiFEUbxQ2T1z1NDFrrivVGeMpcwKDeit7Ny8Q?=
 =?us-ascii?Q?P05G0SPoALnxlrgpDabW8voT2fyrZUMfPKiYHPF3KH51O57LilVk9QevxJ+Z?=
 =?us-ascii?Q?kAq46vFARXGAnvoWJeNvAtcPhaQe28N9nPkaYgVAEV4Azzl3TG2MHYOEPRDP?=
 =?us-ascii?Q?F/vE3zdWwL45JBcGRRnWe3xDebvb236fjmyqksX2CvDAWZAK9berReJ9tPTg?=
 =?us-ascii?Q?l7GLghCwd3KY3rcGVwUrtKwvKtEtaghVq0oeLS3VlvuuVwfX5kOAC0bOZ+lj?=
 =?us-ascii?Q?556ragjPlogc3VnOOJJDMulnagY0KspGIYB5UiGTkQ5jPglA3bJx3oR+eknV?=
 =?us-ascii?Q?GmEAUAWn1ZK4Mc/0RHhYgRbde5tnQyG1dHZ+VYTctPAjhX8IdlBH/2Ec5T+W?=
 =?us-ascii?Q?iZLqeMDD5shTCq9OXA4ozxTc0IGkn/hsf0IJOI7rdIlsq8XVKP3eKXx6RMAC?=
 =?us-ascii?Q?pZnCQqWajCJ3fPqzS2wKlWsodkq5kGK84+h7cWLaPRjRc16g1xfVtigDN1Bp?=
 =?us-ascii?Q?4/DLN2UeNHTdXG2m0CHed/7Mn9J99k+i3xGLDuNNZa7M83LrG0WX1qaKsjGp?=
 =?us-ascii?Q?XcNZWZ9I0jB9enp3PIg1XhRlzBxNFyAMLv7cmsUG/cTmRelOJs++S4Gau8Tb?=
 =?us-ascii?Q?bvKrn1TSAK9gh5pk5YQEgwyHR8h25KtPXHLn9JNbptCdNQ+2F45Xf/VbC9J6?=
 =?us-ascii?Q?WIE+hL5BBJK+4D1blm1t8TqnPFu12+JLRjNhBb/Zw3xwQrT9jbVeR17OpSAQ?=
 =?us-ascii?Q?NxKMavU62Tsn6XHne5eqwH8C7iBRzjqphGRJ0Np6MAp9N+IPtGV81Nrod2nh?=
 =?us-ascii?Q?GqT2pHSgLdgmRYLWIeqJbfDN70T6ngRCv7L4nC5e2Is7/m5yBv4NNrT1FsjK?=
 =?us-ascii?Q?TA9ZyWLhk7Y+IT/ktpwrzSaCoiQlWSpolO1a1+Fa8rbnHELBGOUOuBoFx06y?=
 =?us-ascii?Q?KslIJt+l465E23FmQARZ8eZt9hdrsIIhy19780iiK5FWIyoXlrqLU9plggaY?=
 =?us-ascii?Q?j0GqG4xxOfkx0J3rkvqQ5h07yYbmuVJ46yYxWKLS9BEbNF3bVp8SWY9LLnEO?=
 =?us-ascii?Q?H77Pe9GlBV+kLaq6uWealMpPHvwTS/jVsluAUh0aYr9niPz6FPhXXg9mhtxL?=
 =?us-ascii?Q?IUB1MaVZioTpjrzThDAcWi9ZhTdSncZKz+ItPXiaE30/nRKNfMz1L/Oa+Ys1?=
 =?us-ascii?Q?Vkk2MRr550PawMyfmegkvyLiM9/ryC4jmo7KX6Eq9O+ov2ui8+XpBr5nKx81?=
 =?us-ascii?Q?4IoOrNZKJd06j1jO6CmTNVKQEu/hP61u/NqXMH+Nub6PLGQIcTvKWnCPXZCY?=
 =?us-ascii?Q?8JW8G2vWsUubNWqZNTnGzcIwn6fOQseaDWDmV2ppVypHvcas8pXqIvROrX4Q?=
 =?us-ascii?Q?sppJRGVuSlB+3LjBMNNgsikCx7oo7vcbV9Rehg2D0dZexDu66Vi5nSukjVVU?=
 =?us-ascii?Q?KI8YQ6EJb0xWBYt76s6Q+IcFW3kpEQvnaeHuLaa0USnyBozgrnIS0g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UqWC3BrscHVpDd6JfGog05bW144MAedjKWD3Dtj+UJsr60s5Qw+jZFtH+m1X?=
 =?us-ascii?Q?irKwvpPbXAzcgB4tXuqP2Sv15PO5hFc8alZfTKKXF2x8yt8RIH1Ep3BIyAvA?=
 =?us-ascii?Q?Zf8asjgvgZkcp7pDYyot0k0+sT+HkHH+kaF8+8yfYJbUHhIGV1pHCEeTpxuE?=
 =?us-ascii?Q?NcEWYJ/N+1nA1H+a6lUDcNUK5NYCgFR6lewxlIJiiqSj9TXxy/zBWvG53KHc?=
 =?us-ascii?Q?9rAuTDczoY+BfcnJyA9IXx6Ndn5F4utrHfNM71DZC0lzMNJnA6w3ous022gV?=
 =?us-ascii?Q?EVJG1gqEUl9icHF8LdmesMMFOaP4Clw9n6ulJoOcZFTQoMaAyHawTSc4cqSc?=
 =?us-ascii?Q?IuyTPLXxR9SCYXgaUCmTNxDu4bVtJJP2xZ2cmvkjBnOdzTCZtpYF0s6aecEU?=
 =?us-ascii?Q?wO3am8HtRVrOcd7apBZM/H1fI1lMflohlJUeVhQt6xqL4IzjGGrm5X4cy8Wg?=
 =?us-ascii?Q?Ee4qRRld0FEhmioUZfXoz0psku4CONctldMxHejzWMP41uIl+jMiBZMLa8ih?=
 =?us-ascii?Q?1aV+eVAyVl27P4oDb3wuTgBC+5282YJJtjRoQ9mWNpFNvSEPWuDkYmX0GiFe?=
 =?us-ascii?Q?JIgvFKm8fekoPgR0dNldwwy7Be7gZL8Cl/Mjeyzc/JgwCoHSEWZ+G/+nDmee?=
 =?us-ascii?Q?YEulGOxYMVpAITVJ6vBsk8xCwyZxc3LnbwY0aej2UmLhK+yRO3VdUacJYcqL?=
 =?us-ascii?Q?KYmX9IwBRs9N7CYNSua6uKjQ18WqPtToVRHIDZQIGzd2rbddglD16ws+45kb?=
 =?us-ascii?Q?LeNsuPIKes+eRrqBdPJrNS9Av/lJqFatgq8LxTJCFNW0LDZZUDuSDqMVm/cy?=
 =?us-ascii?Q?N6R68/37DHC+yeQmqJoKW9czJ6TSKRQqqwpy7Xuap1YxYPEs/rzXzQJgsZQD?=
 =?us-ascii?Q?mPmrHshDcI4QwG7HY0Zo1mfrQQpFnsIlB/ere0J1EGgDPBhZhVHxr/O+xTlI?=
 =?us-ascii?Q?mif/lbZ0L5MTorrYiUbCmigDS+ogBNG8qqD7E+VvWDjNZ1AxR9rdZ/JCMknO?=
 =?us-ascii?Q?gXCwlpmhd0DsojNsig23PLR8i2qLpFIhlOi1tu0Hp+U6OzFQKKuY+B7yWz6k?=
 =?us-ascii?Q?uR9SP8E2HcAk6+RIuNr0nf9FB/aTfaYw0GB1afKbUy5EzDMujlclrdhKsQbm?=
 =?us-ascii?Q?M+6pWnzBCs0UsmN9jl/gjkJeVpxenRwxzhL6FDBMIEls94aWba84RvuhlfYB?=
 =?us-ascii?Q?ZeRUG8628YIHGveGcalHBnuJkgqMlo9oE46ix78OhN4LRh48VFWNI7DiSDD6?=
 =?us-ascii?Q?ez3DyXVTxDELXnVYT95+5vla8mgHXOq0YbNlPWYWC+hcBSh8KMAtqgdb3CpI?=
 =?us-ascii?Q?YWo5eQKZ7nbL/84Oi++72SjKDrSZMsQYcUVeb//xIyRuybij98W72lBpDjj/?=
 =?us-ascii?Q?2SnAGmJeO6R33IVupVEzMUe/DIsul16p/dPSd7EQ4Mi3weUFcvySe0ix9L5K?=
 =?us-ascii?Q?XH3iWiLsUOkErKXK+npSxB3Wwl80fyoL4YrbeSC64d3gNkhx9pcbW6HCYl2V?=
 =?us-ascii?Q?mtshMdekMRPUeAPtax5X59crmebhAMUznTxj78va99OOo/RyDkcLvEpQ4e0O?=
 =?us-ascii?Q?1UYIxbRch64H5lt3jKUvFkbaJSbcMQrpq+PSTEMnjnZkgDGmWyttNwQxS+hD?=
 =?us-ascii?Q?Pw80Jzz035IMBoLHr7quEEttTLwJrdaQkBw+zoo6PMHNyGRZgiA1cM8LOuyb?=
 =?us-ascii?Q?SLVGeSa830548BsvqJ+1v+hCSJCzrTxqzCoIZczs48K3YBvUdY5gOHcqjbrZ?=
 =?us-ascii?Q?i5Q57oRb3acWZyI5fiRs9B0dwrNR9VMfo6DdJHfm5FAcU0ft6pjS?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6ef792-f454-451b-56b1-08de4e989ca2
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:30:50.6083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ry0LV/cCcNjtnVzwY8QOMbIJGy5QxcebNrsMy0+Sqk4JEkg8+f/vqknU7Z5cpleBsIusGgA5JO4a+951dNeCFIbHW3OMbsjsFtXtuFY4yXyowk3X7q9ZjjiIIClJP+C+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21461

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


