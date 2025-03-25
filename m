Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF34AC3600D
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:56:52 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.34])
 by mx.groups.io with SMTP id smtpd.web11.67706.1742914600947369189
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:56:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=cnOvaVf5;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdoPHEEXMgOVa/4QkCAdLBBnXHrBi2Z52DTtpiyJTtglLNmiJpUamtoanr7BJJtJJHmLxdLE8iNiDRrkWsYzzHSMeQEBpYkMc1kWZ5IGBkOxg5XywlXcn8Zpivufzx4C6BLIkcIxaRfjlj+/RMbogdRQcLcpNw3y8x9kyJpGsHMTLSPskpsp43TYDcpDuXjBOnAoWCHDj88k9o6er2qLFDkmQA1Oj3eY7og1gZqIfE0G80/qfGBx2v5BEghe08DYuqHUgpjT3GBoJCStOe2DCnOjmC92OAB1RyrW9dfUkWeWT4b7bisGxFeUcYM1Q2ZN/x/mIvlnFUc5XKcKN3a/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnOTmmVkYWynYo7CM1lx/CzTrYS0dJo8F1P93ugJbnM=;
 b=lDKf/twoTpuMkZMokbnnhkhJ30n1Pl376xAWBWPCjc9UPJA26EVIafQEvihQWD6Wr7TNQDhVabPFNHYY9yjNiXzW7jE3dJp8CuseMq0nenEFWrR+lU8Yy4CNPeDOUCMCLsjKK2oQIlY81fkstJN8W6sW1X8invzpn8+WB6rjixEOI0Qlc5Z23DLTLkDCfD7TXcrQUAwIJU2l97S+1XSwnUCTujNa/Ly1FPO+mP9Eg5L7shLv3nGn0FPqGzVrPeGitSVcnqLyecLvdYM9Caj1RmnrpRe9UlctQZVrKnlBnZ4EhTlOmd4+9kBYdnRwhTzGNYT780/rWW1qBmWUI8oDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnOTmmVkYWynYo7CM1lx/CzTrYS0dJo8F1P93ugJbnM=;
 b=cnOvaVf5w6WkdNR1y7Psl/KEytm6SFhOCYyZjEgE3Ewn7iey7r9iKCfQ29A9r3uscHrQuZd9t8rDUQMcR9hsVoXOzNijfYQ6C2AelPKm0+qSVkwHgmAeaAd029rWA/gZgadqzCTP2hD7XcbyByPtu5/ntNiIpUIVBnDogzNNenI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:56:41 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:56:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 03/16] dt-bindings: clock: renesas: Document RZ/G3E SoC CPG
Date: Tue, 25 Mar 2025 15:55:57 +0100
Message-ID: <20250325145611.3595454-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13248:EE_
X-MS-Office365-Filtering-Correlation-Id: 1295264c-27df-4372-133b-08dd6bad40a2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?M3gPUsWl++Up4qWxFJ3bwYvysKP9rsx2wYkLmtIoPedAN4nz5pWJv2zjWOBU?=
 =?us-ascii?Q?87tGEkUXX25rxSx0cpeEQ6/mbq7jeDsBGb2ZHB22zRZGA0Htx/DefVoC+Txy?=
 =?us-ascii?Q?o5GoV9+QZZvPp2I2kp6WT0/xiBjxyMmTagSDxwNsMJNIC5v4o8GZTVrluepa?=
 =?us-ascii?Q?eUmFHJ2WzVnJaPRlnssnruBgGj/yNkg4qRl33w50FJNpyt/Y0SSlgVqRLnBv?=
 =?us-ascii?Q?VLrLws4/cvRSeVS4AuV9N55iHOqqYZCZ5XN9Sjl8UtelWEy7yo7cwuRz6Ts7?=
 =?us-ascii?Q?23+N9OjQdN8/gTQJowC2qs9Dxzvi8750HeItBBBFCkqwz3wgJi/lmDYCT+fs?=
 =?us-ascii?Q?1rVp6PWL9kRyhApyj3IShgYsWyR2FCHJ2Y3FCT9fvoDchKuSFbHM/mtWoyrN?=
 =?us-ascii?Q?spMzohcMAIvlmSjpKme7ufSaRwV7IK0OQJTsO81Oqoq6ukM3m5uWR7aUzb82?=
 =?us-ascii?Q?vX1p1KwKgK77JV82ERbScfaAWdXqITYbrnUebeeFEgOkGDQnK4HtbfDlB4UO?=
 =?us-ascii?Q?bEIuKvteL1Uxvu5SZ4HTPhLt9f+NfIVqOpd3MCwcj6iai9d4vHlgro7wvl+C?=
 =?us-ascii?Q?ydllS2tu7F9K+9gyfE8q4rv5VrHDsdGekYjF3Qu4xakm+O5dIkGaiTMlGvel?=
 =?us-ascii?Q?K2Fzm/aDAo2QaZh41zIbGlOaZqwMt/nmaBEX4v/t7DYY9AkyT6zlXn80DGyd?=
 =?us-ascii?Q?WRC09JCN8zeFwEdyW8rU+HvROzZO9RFRs030ZaNaUP3e4HZhe40NV0aasnwn?=
 =?us-ascii?Q?yNsdnQepox09YTf6cBhjdRaXsu7B9HKxaFGtndlT/unlQZDjoH0DXDjRtaMx?=
 =?us-ascii?Q?TWcS7j9dSVBjmCcufQIqTKLD3jVSfWsDCA1CAUwY1NtxDgt8RfZMy2EaGU7i?=
 =?us-ascii?Q?zXGSduCpmXFr3+lbUHR9hoKL53KJauJzTi5wEUe8d4X6gDLW9dBLt5Of6uWU?=
 =?us-ascii?Q?KarPIt6fCVChGg+o9aGOh1FsQqkhjDGSOXAQfdaguUJjYpjxqp2VLSLJp2i8?=
 =?us-ascii?Q?Lvtc6ll/41r8VTTT/lJ9cFy302IEVv40LziMfcEUIaMoxiQrBFcTtEzEG6Gb?=
 =?us-ascii?Q?WDqFik45JZO92gAENDyl7m5nl4RVCGUm+0FrOk+velRYX8tMZz54tFOtqRnF?=
 =?us-ascii?Q?MsO4RuKN68SommBUQzYeiDhH4t9j8UulguG03z6Yalhr/847kSvNJymBTZq9?=
 =?us-ascii?Q?e5qNKg6eb/zL8jpknWDSLNq0l961fxwkvyjJYG2BRDxwRE+CiEx9/JrAU5PF?=
 =?us-ascii?Q?FpZdFyTWEWGy+1Y9X/nLMjNBFMuZRt2LuC8go5DY2WiA1nJyd2VQ/wdw+ZFt?=
 =?us-ascii?Q?StUdCbHXhAMBKHte8oZJ7K2dK4wCax5xY/eNkonyZrmnFmS3FVhOBLJgtAcn?=
 =?us-ascii?Q?3BFSaEdf70Jxk9rWnEs+C2fl0b/tZY1mDEL8ibuFPEhu8hcMhQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5ByuzRozd44jbaFvVYlaemPpkoXr2JbJEWBu/bq/DNfLqgARjHCb1XFw+lo4?=
 =?us-ascii?Q?8DArMQX9BOt7zJ37+xO9lI7RH7gfDFTxn9ZFun3iFf73QT1fzHCnzH8QsgoV?=
 =?us-ascii?Q?dFnkKHNFjpvIoBDIt216BQXduDMFW14BbsJpQ1g1+gEMSazZnMxfjXZW/50u?=
 =?us-ascii?Q?hqTl5OoCjtEVDkPxbGpxdJ6fcRELru43ceRMu8grt3wtpfoPsrg5WEn0UFw3?=
 =?us-ascii?Q?itjpKCdhOshgcoI+nlZVslhPYC0ahs1DbnomKglBdNhCA/9fjRdF4GET1HaP?=
 =?us-ascii?Q?ddEKOt2K7SZobjPu6t2vhseak9nJXynIb58fhQ++l+Q+c1VWQp2IaGypHLZS?=
 =?us-ascii?Q?PCiamziXrBzCFKuvoCOL6U4cnX5mFl5xmKRF7567naX5oyPk4pF9QZCFzRhs?=
 =?us-ascii?Q?YBOwTUvJcpw4kzctvBnhwJb3XVECdhtUkui1TJcbz9Tkq1ih5yOFUuS+Hzxt?=
 =?us-ascii?Q?PfX6MB1FqJv2pgceXCTPGtlQILfc/aKVovkmUgpDcivww4Uy6cuJrAiMnhPE?=
 =?us-ascii?Q?OIzS+otVFSsK4zrk0mwtKjkySqrtKdUCTtO+w9lSGNV8YCKOZS3yhaefjh5D?=
 =?us-ascii?Q?Krxls7rNpohFlruvt4Gwtd6ZdV7HQxGOi7msMmprVWFWFgxthY4mpxUEv63O?=
 =?us-ascii?Q?sqg4S31YICr7PY+wkGDuoOXa7cRQnYXHXZN1npMqQiqXh+hBDrNU5j4zn2+I?=
 =?us-ascii?Q?ySKAgkfdEYn60NEHncErQHklyA19BAQHAQoNJDSdk8FY7HfrZjfcg7jypfK6?=
 =?us-ascii?Q?HtcBLikfnNAMMJp2hmE34J1TNCP37rIwqmItmYbHZoiQuG7aGrbCv6DMooll?=
 =?us-ascii?Q?R35yrYgzDb3gjlHF7pB28il8oR/H8fYN2bcxeuPmJv7yS/3MEr9unoB7jasX?=
 =?us-ascii?Q?2QLZMkDJZA56uq3ELW2XL9we379eDOICNQuoY1IaqxOniDyI0+3qGf915cXq?=
 =?us-ascii?Q?bfOtV8/cwLWxZ2UgVQltqQ8nU/6J6zO8H6aWss+rxyqL87R0dVtvFAHiyxTy?=
 =?us-ascii?Q?Hnd7dURsiQCmIlD9rktwRXjKZjhNTq/EgTmAwI9aEqsOCXPjLjJztFSdJJi8?=
 =?us-ascii?Q?YVwyR/KTdhC/cpQzLkBpAzjuc5Wuo7x80mHDKGd8bTKZ9v4Ew68Daj7S8jHM?=
 =?us-ascii?Q?tdjup8ouq6RvTkGK+RHH/HPmz7rpH27RaA6aem1I+QjbeepRL/L8VkQkq0Us?=
 =?us-ascii?Q?7HyyDhZVfZrpMCwuXmUVSxSD3urwDGtfiDGliBr4mOcfP5KuzhR9Z5V4GprW?=
 =?us-ascii?Q?Ti17K6qQgzWDCM6LaG0DwJVuPw5BpoUZybB5kMEklEQWxT3GPRu2693YRKEM?=
 =?us-ascii?Q?R1TCP7xsjfx/2A0TCSPzQoyeBPILKTpHLZVtREVdati7v+dsOQ2PYGR5YYdT?=
 =?us-ascii?Q?Ycm9ThRuakrcXpalxwWd1XFzS4o7J9ZYWVsNrvQpMaB0vQ0c1ZncNPyGYoOZ?=
 =?us-ascii?Q?MPJMtxyVS4wohjjJsJVTO1iiq2Ms7gtBTJUlf0MCedF61Bym9gFyzrAU72w3?=
 =?us-ascii?Q?fyzsngrmtF7IBcj6BiyXt+OFcFycZVl8zDrh1qZzQHBLaEc2ejt/vLnJhtMR?=
 =?us-ascii?Q?opUrBw4R1LjiHFWFs+U4AVc2m/PlPFsQ8QjeKW5zhIK0JEUwmUuP3giVK5A7?=
 =?us-ascii?Q?KlqBABT1i88VXsz1GhvywWk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1295264c-27df-4372-133b-08dd6bad40a2
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:56:41.7669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /L1cG2Zv7MAzPd0hAJWGUJY+EYOWnGdGgXECyt9m6UIXBbrVdAGZC0Pl0O30zuzFSTIJaqiM3WTh4YmEmEcDJrG1TagAA3/yFksrvP88g9HqzWAIdmf7llphGxy/hwZQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:56:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18353

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
index 926c503bed1f4..c3fe76abd549d 100644
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
index 0000000000000..1d031bf6bf030
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


