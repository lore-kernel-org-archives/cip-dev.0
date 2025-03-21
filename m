Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4235C36002
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:00:59 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.48])
 by mx.groups.io with SMTP id smtpd.web10.18677.1742554856700641334
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:00:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=WzTM8SO8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.48, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpqcHZmpoiEqsdXJ2JKOYlrl3tSyh4rGNfRhoK2iLKRWMRF+GGxAIe6kJhsV+/w2hJ9XYYfyDkmwuAzewTiLK4rvzRAVHYvqT/wJDdiOmnaWLBzkZtoWRnHjK+XNGPEj6mF05U33V2Ou5jaiaPG6QZHYKIDQLQudN4gglrkC+gOqLV1bC7Nseim1inY0RKnNgHO6WXW50VZJYJlrXVcR3FcO2FBPYmLFWxkUgBidVH2mrxTijzF66ZQVE1uKbiWO7lggYPUEg8SUfn2m11bAZVBqsIuk26CE4ukPsEfpkfSD80aJyqWMMn4JFQaLkNj+bx0mXrZdM5JekUUxDctJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ql8wih0FV764kWevvBgX/gfG6CSTRQ/MtuGetV7xRo=;
 b=wbfHHFQ4G413tqytG2S3K0XGz6QbdgwOLK3LIwFRMkm/37khz49ZJodICdWwBNnf52qmXYDve6Z3ck0f570AIhxyV+p/o0RpTGaYi0XV5B3iZf34TSj27E3bWlXrDFH2fSCZbk9EikVSPRcIg59MethFbQIQbqWLHde02ZvSNShqOy5byNYjlI6ly2rDWKItXWxMP34Spn+/9FA/IlW+afJZvYLGRX7wc9hRI2H39a+OCtURVM68cJQOntPWtPlaAk2QvhkiIqhehaql0Wi5mqbWZvUFcA4Qf+xWSAb2Ok6+Kx4fowt1Zfv2bWUuioCIeHx0qL6tvc7XP8jkdAd3dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ql8wih0FV764kWevvBgX/gfG6CSTRQ/MtuGetV7xRo=;
 b=WzTM8SO8La1YlPv+aKeGbDTR+qQ27LociTs3ZW/T58hOMtrGH2g+rc1R/OPGTGgAWfy0Zx85e9khrvfr3NMkSLlpYGAUEgALNcD2IHHzVeUtUV1hvhs4704VNYQzltdvK9lQUqqMUHU5DjVH2Y51+ky+dxdErWBIAz6DGGdLpi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB12437.jpnprd01.prod.outlook.com (2603:1096:604:2e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 11:00:53 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:00:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 04/21] dt-bindings: clock: renesas: Document RZ/G3E SoC CPG
Date: Fri, 21 Mar 2025 12:00:04 +0100
Message-ID: <20250321110021.3612805-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB12437:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6c2f31-0730-4e9a-edee-08dd6867a5dc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eZ0Ecj8CViwGNAydF6nrccCqk/IImvEiG9ytcmD0DYxwOAC6xOl+aSt/kixk?=
 =?us-ascii?Q?jwzk1XStuQgoaLfNyXMUCo04Lp7Yjp0vNxntfaHY5peR2MwoTR9wJz9jL+p1?=
 =?us-ascii?Q?42hJWkhJK2azyhFZM76k4xH6hJTcyLQ+wkvqhcCPU2eYgQEaJjZvza3hift3?=
 =?us-ascii?Q?oWequL47NKtce5qstiHjyI9moCRRIVL58qYke4v9XFvZSu9b9IClvd7NjJTk?=
 =?us-ascii?Q?RVLiCRWr2CO1840nf7lBvFkac94m0m8xKejrK85xKoqHmxYVN86uPY71E37y?=
 =?us-ascii?Q?gcAU0FNh3GPzWOpCl3UjsbpdBiheDzc5HE3YN1Y+Fi0i9d5gNfR3du31a862?=
 =?us-ascii?Q?ifKxSzRjYshS50X3JH0oQ98qUopQgyPsvlYCd3GF96NFZ9IBywXqMjv0T/BT?=
 =?us-ascii?Q?ieKPPoZK6y4CeYXYRFjY4FYxdJqYt3sw9wLBDpuCs3vJ/zEDVTb8S7+ipWWy?=
 =?us-ascii?Q?l0Xc7EQOmSHopl34xVk1SFJQB44x7qpUyKxTrmphcW/c4/5behKtbopJNLrY?=
 =?us-ascii?Q?k5wfjjyQX29D7BChoFYmAqUbMizx0S9qGo8LsupkkWucob86rBg3hodgEQTo?=
 =?us-ascii?Q?epy6JyEjgxgQJ/Kty5LTKySYkWh63zh+n5/GEVDdGdtCfZN4Y0Eifp8ZZsfa?=
 =?us-ascii?Q?f1IqhTcuN7PA3rHhf17pLq20cFP3qXtF2Y7LjmtRmikTp6I+QLUuliDi6eSG?=
 =?us-ascii?Q?5yl15iEI+/Zef2Iy8aLD/rKvOiuuLW5apfUosouQ5Z0IehsReMwyNF8OioNX?=
 =?us-ascii?Q?4/9tbC+fArjpcmpzoFsL8Yg712QFQXPD+/lOIV0nBTOcaO05xjFGm8JKLlhB?=
 =?us-ascii?Q?li/7CEYU+hmqNafl/t/1MhMLQR28H+AfidP9OtINWNoxX4zI6s5g1Mylb+A1?=
 =?us-ascii?Q?ujGGoFXF55UYznJMPmq1eIopniHwPzmKAtPoLWpW+xbmsCdp6Ipdfr0zoFBE?=
 =?us-ascii?Q?69XVmjFYxerzTMjNcRaXhA88iPREAJ5nnSxHvabYhptuwqh/J5dDfFf0pgHZ?=
 =?us-ascii?Q?WTk5aCEAhzaOyAm5E+JuS+sa568LRWAGpKzFMSqnxiZ+wwK26agXj0mzVVQK?=
 =?us-ascii?Q?fHki9qAX6w3GkmTS8cGpz78WWq3NiC02mUdIvxuenJsttvAEX7uv/nYFcg7e?=
 =?us-ascii?Q?BWt1BQqToj1kIclBLMtNyK8E54n/eOYraLrB3fp53fjoRb9dB/pRX8TptMhN?=
 =?us-ascii?Q?oX++1YUH4dCL3A7Wr8f+5aflqjpxL59jUUQ/l8iR9ooSHEKJHkgr4B/1p4Cz?=
 =?us-ascii?Q?JJUqI+Uua/5/y1CYMIhgbuzPN7vPLpHAb5f/JCUbZOohw7Ao9pbAsOcPQWLZ?=
 =?us-ascii?Q?jzz+cHWiV8BMFDAnmvzzfTkfHPzvWG5dAy8XG4DaHc2U5xCKsHCME2/CyS0L?=
 =?us-ascii?Q?02kfCBIxIrAsR/OmsVuKLpHv9/yW/s32AxlBUtKXe/elIOemmg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QwK/p5SuhCbb9SNRclVldzzWdZQoHZPCsuFtvfj/8TkYFnj7cXDJOPgFV0Lg?=
 =?us-ascii?Q?VHem0SNjCb5kdYUj1nHSe7PZb6LIiDP65IS5Z6RhGL1rYdathW3fJPLHOxJL?=
 =?us-ascii?Q?SAyNkCOqT2GwRpCiUDsuCgBvHIN7QCoKBhfW7L0ZgtbKG6ieI90oVjRQVKU4?=
 =?us-ascii?Q?etPUqEamsAdrtf2nMdx3UWwirXn58EVJaRpmOG/sXMW5dbbZAP0qnypnqOkt?=
 =?us-ascii?Q?K6c7wKh3VmFpyHdRvmDv7Z6LFLKldyRuRxNLR+biyEkwahZNOLOo0fxF84+h?=
 =?us-ascii?Q?Un1wKeJKNyCiabRejP2i2EW5/A3zD/T5wdcVb75Ok78nmne2z969v+tChDmC?=
 =?us-ascii?Q?i2DCDH4kTtSU9K3CrpTD4XPhidIVz3Y178wOjutAeXw7yLLx1lxzgn221Nlo?=
 =?us-ascii?Q?ZGSL1FaZ86Bi6StuaifY9wIIP/zHsjWpGS8dOcSyHTGiHAtdnSauuprH9b3+?=
 =?us-ascii?Q?PCmjKZ3uiOPFgLjGpKIUgc85XHvEwxX5/d0TWSxc1dxJ/Sb/D5SU04lgo5wo?=
 =?us-ascii?Q?KRFRBr/eEZ6Tx+4LzB0QpZ5Vv94TsuCNhbJ1iTi0Km7LLwxQDHQfqJvs6NPo?=
 =?us-ascii?Q?W7boD9bydTd7ibxuUdnK398tcIHxpkODPQhHtGxf/+lFwSDuRztkTZI1G4Ko?=
 =?us-ascii?Q?DLYd4FGFUAi8pNXlZuem5d4De8QH1+vz4r2GBvB8vbH9jJdw8WyrxgMwBLD6?=
 =?us-ascii?Q?QL95Kzyl9VjKJDTOGADTdUIgNBx3M8bSkQHNDKRymJ8cfyP/+zG8F0ddx9Uc?=
 =?us-ascii?Q?4jUXln34CE2Zc4pj2hCCALw2qvnLZNEsbaIHy2qtCFpkqpE29GCF7V7khBp6?=
 =?us-ascii?Q?FfznYQl6oB+UADBPw+guuMRCnqmu2i6dfwA/ygssyHTYA1syf5VmYV/ki9SK?=
 =?us-ascii?Q?kslkAL933j0stE/8VYOsRzFaeTnDYqRUlQl1U6bwpvgT+2aDZ7tsmsAOVrre?=
 =?us-ascii?Q?IdhTyAHAV6cHrUQsVUaodp2EMXRUnyhUMN53CgDDU9ebsa8xTY4xlsSqO0PN?=
 =?us-ascii?Q?Un5SLHIMMJ+xa88lIoQMcR9inOEdJTWeKSdh77l2ccFTDGRrqlysZJ88146p?=
 =?us-ascii?Q?FlhEtV2KPlCKG3uL7pj6zXzqD4bnWXABbLknPnugmCMN4z6sUqKVRXneDMcr?=
 =?us-ascii?Q?vkN79+GyoeWcyMkbDuzamOWYY0zSKTfcpASwZsMSU4Y5Afwtr3d5c3GHlUt0?=
 =?us-ascii?Q?+oAR8iDr7OyuFWprkCbOa+qyb1tGVE/SCFJE/mU7TuZ5hffWlBSIj4BgVeum?=
 =?us-ascii?Q?AwHpTeLkVle/1VQgAbK74xNknsnR/wxFawyuUNx5cl7qz87YCOQcpaKt5/0U?=
 =?us-ascii?Q?hwkw3vtQ15jXDRa1uTin1IiJyuhHk9/ZjWP/BLd5ZjLSc6qHDsGGn/Wm1Puu?=
 =?us-ascii?Q?EFhj/+okWa5V9OBRkaLd+FPeL25g+yDl42Sp4Ngd4W2yV5LvLVzKvhUfPzIU?=
 =?us-ascii?Q?yvEUBuXP9rwe8a/FujvgW7J65ZHsHjGBXcd/ZEGyxSfSylTmbKj3LKF1SFP0?=
 =?us-ascii?Q?aLPsvvlAv0ERJW2MXlIQtsQZGLuUUvy6QacCw/Qvx+6hMeLfxbsXtinI3cTM?=
 =?us-ascii?Q?tRQUWR7ZNvjHTZAlFYXLG7E9r5v+jrlDI+9e5Z7etiN4WqZPk6O6o0omdHrf?=
 =?us-ascii?Q?Rs09y21/d17OunIUbEWZYUI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6c2f31-0730-4e9a-edee-08dd6867a5dc
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:00:53.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8xR12aMb68kbAVGgWGRlEPCTb5sOJ7IzyLNRDBKuQ/MJbmZb4Pf1z2LV8SqeZmuPf9X29gEW9uOqvLixCy9eMgc1+KfS1wVV0UceoaLKscCDjndYbARWxfmdELS4emF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12437
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:00:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18311

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 25458fdd39a18a5ce00c36f38992da54bb7453f3 upstream.

Document the device tree bindings for the Renesas RZ/G3E SoC
Clock Pulse Generator (CPG).

Also define constants for the core clocks of the RZ/G3E SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-5-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../bindings/clock/renesas,rzv2h-cpg.yaml     | 15 +++++++------
 .../dt-bindings/clock/renesas,r9a09g047-cpg.h | 21 +++++++++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g047-cpg.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml=
 b/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
index 926c503bed1f..c3fe76abd549 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
@@ -4,19 +4,22 @@
 $id: http://devicetree.org/schemas/clock/renesas,rzv2h-cpg.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Renesas RZ/V2H(P) Clock Pulse Generator (CPG)
+title: Renesas RZ/{G3E,V2H(P)} Clock Pulse Generator (CPG)
=20
 maintainers:
   - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
=20
 description:
-  On Renesas RZ/V2H(P) SoCs, the CPG (Clock Pulse Generator) handles gener=
ation
-  and control of clock signals for the IP modules, generation and control =
of resets,
-  and control over booting, low power consumption and power supply domains=
.
+  On Renesas RZ/{G3E,V2H(P)} SoCs, the CPG (Clock Pulse Generator) handles
+  generation and control of clock signals for the IP modules, generation a=
nd
+  control of resets, and control over booting, low power consumption and p=
ower
+  supply domains.
=20
 properties:
   compatible:
-    const: renesas,r9a09g057-cpg
+    enum:
+      - renesas,r9a09g047-cpg # RZ/G3E
+      - renesas,r9a09g057-cpg # RZ/V2H
=20
   reg:
     maxItems: 1
@@ -37,7 +40,7 @@ properties:
     description: |
       - For CPG core clocks, the two clock specifier cells must be "CPG_CO=
RE"
         and a core clock reference, as defined in
-        <dt-bindings/clock/renesas,r9a09g057-cpg.h>,
+        <dt-bindings/clock/renesas,r9a09g0*-cpg.h>,
       - For module clocks, the two clock specifier cells must be "CPG_MOD"=
 and
         a module number.  The module number is calculated as the CLKON reg=
ister
         offset index multiplied by 16, plus the actual bit in the register
diff --git a/include/dt-bindings/clock/renesas,r9a09g047-cpg.h b/include/dt=
-bindings/clock/renesas,r9a09g047-cpg.h
new file mode 100644
index 000000000000..1d031bf6bf03
--- /dev/null
+++ b/include/dt-bindings/clock/renesas,r9a09g047-cpg.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_RENESAS_R9A09G047_CPG_H__
+#define __DT_BINDINGS_CLOCK_RENESAS_R9A09G047_CPG_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* Core Clock list */
+#define R9A09G047_SYS_0_PCLK			0
+#define R9A09G047_CA55_0_CORECLK0		1
+#define R9A09G047_CA55_0_CORECLK1		2
+#define R9A09G047_CA55_0_CORECLK2		3
+#define R9A09G047_CA55_0_CORECLK3		4
+#define R9A09G047_CA55_0_PERIPHCLK		5
+#define R9A09G047_CM33_CLK0			6
+#define R9A09G047_CST_0_SWCLKTCK		7
+#define R9A09G047_IOTOP_0_SHCLK			8
+
+#endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G047_CPG_H__ */
--=20
2.43.0


