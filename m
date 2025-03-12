Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F69C28B30
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:45 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.44])
 by mx.groups.io with SMTP id smtpd.web11.34780.1741778632423080165
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:23:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=WFZMNhzm;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.44, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0M344Cxx52tFVmIsKkGoXlUAO3plsEzX//c4wny4HNtA7YOpDbqHSE4zJZLFSFia+jNLEVabfwZY5XVGXle/VdhFEL0fd4J8l9wHe5aROKD3ptRqhduMVO7uxCdkdrfcaWAA5r/Mjmnua8lAfpWk/LM3dtBbCl0fo4XlSJXeRGgI1m2mmUqhS2N2QhrnxKXa4D+3pt7tGVbZaU9l2VqMOvFR/hUlOgekQGGNq5eBgVZs5w/YkjyUzpovWRhjmOr5oN0rtqwm28EqIAWLszkdtcvzoox4B63YQIUpz47m75PjQNqtQMIGmjjJPSjJ+1aIqNM+10lt3zossQekAnUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/XkJlXOowH2H7xYgLyV8r8Clm2u9PQ9Zct5X0b8HwM=;
 b=a6XSoyS81tqipMycH+PR/uvXGNHReV+gPQV/zRY6nGEy9+u6/C/7bPeptM90Brg5jTwxmXXCMjbtEFyd6knfCIWu43bkxZ5r2j2KSLe4dvC6Qv7BM2NlMgWKdEgiAur71NJJunXZqwrYQJeU1HsEYgHWVTtMAYfzjtejTWIvsvFvDKtOLkcYucfEjJr8CAuhPBcdmdx4p6LRtUZNrYTSlKb9+2kiuhnWPTRkATekrh93o2uKFyiRHYz/P2EV1QmG1cVdgzkXYtWwDpxs8EvcgJfldxCksX6VaAtd4/MOWyA60xs5z91UikJyUg/4iE0FibyWR2p/7YpbmxLXQYJymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/XkJlXOowH2H7xYgLyV8r8Clm2u9PQ9Zct5X0b8HwM=;
 b=WFZMNhzmHrqHolkThSn7liLW/QMAZJuATqTmjea0ZOA1PFytQA70IFM8nWQ+18LI7okFVpaX9KWn0eFteIlHQ31rcTZH/1jtPWhku2GGnwQC2u2ghsWju4lkXg3cYBamSbCPboDE/DqOzBtK781RknHPJHUJOmN9yhmCpIl3XGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY3PR01MB10581.jpnprd01.prod.outlook.com (2603:1096:400:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:23:49 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:23:49 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 04/85] dt-bindings: clock: renesas: Document RZ/G3E SoC CPG
Date: Wed, 12 Mar 2025 12:21:41 +0100
Message-ID: <20250312112302.1605750-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY3PR01MB10581:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eddd7a1-1dba-4c36-9279-08dd61585c3e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7zir4iNtEMgJRVciYGJX9Ynsvw76JJ5lY+pMYJ5IsSCimz7islGgcL3BToWT?=
 =?us-ascii?Q?MgrFoB2zI9SJkA7kRVSGqdvq7or7LK4Dk+EbMkAsqnYkwa8/XLcZgMMe/99n?=
 =?us-ascii?Q?Tkyt75YfjB4rwQ/fbxrjydURZSeHJZtnBTDGyCZOyBCrJci/k1891gUIqOOL?=
 =?us-ascii?Q?nMiu6Y0GtN7mv5e43hKHGlpWq5UTaFH9IuRfztrzFX5kpXHSzpak1HBFauWq?=
 =?us-ascii?Q?ZddenzSOcFTdWcPbXMCdJFb+Nsc+Bp1YyECXjjgM3hzBy1z6z+axwIicDbel?=
 =?us-ascii?Q?GLTECnNraf5zEUJEEjWvFwVMBOMaag1KDVJ/RSLsuGucml+zAMTyY/JPjnEg?=
 =?us-ascii?Q?sy+7KBg1g4GYNoquym2vEQf/9VOzLu5/iUuYx8/2bmEl8Mzi4FkCBBm+EBIw?=
 =?us-ascii?Q?9pa008EL1cIEzsUAJyja3hUJCZm/fiq+l2Dp3enirfG7qLj/vqYkeOCoi8Xl?=
 =?us-ascii?Q?qjdEHlAyVmzA86Pfn3TJYiqH9akMvJ4v80ml7T70PHo16CWfAhQPgm5GkZPR?=
 =?us-ascii?Q?0OeTZ6A6jN/N0bXH0940l3Vc4cIvZUhWN7j3Vuev0ewwoeZlIQytBgPTFI3h?=
 =?us-ascii?Q?ZmPXrknudIxsQAqKdAQHwIfWqXzMfGPgRzqCKEWyA4LkDrA2gA8j9iO9XqgG?=
 =?us-ascii?Q?SLBvFqF2I1zG12vzlBSSdghPWRGbpNmlelWAy21pPv9OmCcpKkixiaaBQKkX?=
 =?us-ascii?Q?AHmPBfKTrnl3Eg9Zn9OqHykH+Jo6wJQ008Kp84ti5paNrWk2zR5QePfybKkI?=
 =?us-ascii?Q?nUMXV42cMmIv6xwlxtYTfZdj6pltCMAyGB6Ceh/8dhWNlIK6EFNg2xTjg3TK?=
 =?us-ascii?Q?2FT5Nh9ZjL98A2VcHcg0ooPgcGdnAvKoHLC54fANP8HMFNTs9V9Km+kjwBn+?=
 =?us-ascii?Q?PKrZEDYUbfhFO7DTeeJhzPMO+KyJxXDHFCARO7KA0phwN9ez0ZbyIdl33iMj?=
 =?us-ascii?Q?RUzWPgI1P+dMHCu28lLp+e9fRC4Ap2S6FQxvPw/430Khy3mfLss5mUnt0EeL?=
 =?us-ascii?Q?NImvOfJ6OAsQhZwK7m9fi9jzUpJN469+LkDN45gsGLNZwlBXqcVH/T7jGJCH?=
 =?us-ascii?Q?8biKAP5mRFrWBOkcBiTSY4FuOyTDAw0KfbPicSFRJVgrVJihYlsi+3aXHtzr?=
 =?us-ascii?Q?GUyMG5mZ/u0/nhHfuOz91EcoSuGCSF5AZe9zBzJtVUnJU+dNXSsqZdGRaRQz?=
 =?us-ascii?Q?1WlZGJB/vKk+DhZiC3KDH4ZoLY+3m6AcF+q1QVnIrS4MHs86zhhjSXqZdWx5?=
 =?us-ascii?Q?kdY9gIsyt5Cc/bPMssGPZgWbhsHtp+XY02c6vqpB2Kt34TGjrTOzNsEA97Pj?=
 =?us-ascii?Q?6fl39OUAvQgJcZrgB/4muKFllH+iK11CKqQ7ZaT5HkOOMl1IBEz782/2Q5ZL?=
 =?us-ascii?Q?+l670SqiGpyqDlvOy2EXCf/N5n2NTJ1QtAZ0j92rwX0CcqOOsw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?th5nM3evLWRkXC2UmnKet68VN9c2zxCZJCxhHvQAATrOSu8tDJR4tU3SY1Kw?=
 =?us-ascii?Q?2erqoziwJI1QxUIB2BH0yCHpIXk1sFur+evzD6bVMzv6xJY0yXbOVuBYTAzL?=
 =?us-ascii?Q?pxZne+dcw48+1f+xbbEl3PAJlRdD4ltIb7XW2GCWZ1ng+Q0HDKAqQi4Oe3/d?=
 =?us-ascii?Q?9Exn4QvWihkO1AHj9afLh1g+e2N9bGLmzVSohJkLUtmN44eYxvz1CKp45tki?=
 =?us-ascii?Q?WJsBNkNrQmJMd+B66oTYj+c8Hafylhh2GNzKXfZcggLJjO+JD/g7tBAXrEea?=
 =?us-ascii?Q?7w+g86dybAP148Upm3/OeBmm6hCSFUf2b3zNv1rAAe1UnZ9OXf/SRomd8HXT?=
 =?us-ascii?Q?qiI/XiDJ1CDgUn6T2AJ1ErCOK4CkfcTLOMOMnD1CRp9tCplLl1yGEGHv2LXc?=
 =?us-ascii?Q?PcBGh9Jevy1FoAzUikqcKyEyrdsTp4rNnp52shRFSCIN4cjIBQmcDbWQHFps?=
 =?us-ascii?Q?UJbtN35AGPMeBe+y0B9bzOzrMvelwVflPamYwdGe8eJ1OvugmPVjGrtBBXJx?=
 =?us-ascii?Q?f8IB1wgv85AY9f2QIFJYrWDVieY6csA9LiLWrAqGl2oA7Uq/x7nLd16qjgPg?=
 =?us-ascii?Q?QODz43BD356gl4Ohr+rx4Hn+D1pZPEgWvPiK1DkgNYsLH3zfqWiSOtkDlx2x?=
 =?us-ascii?Q?ng/i7ycw4Mp3XjcN6gUl5iFsoMoBWsm5jxdF1DfWPl3rkb5mg2O2anQ8ohKR?=
 =?us-ascii?Q?83T1fhRtK8JgW0wqdT0khh9Rl62bBIa2dobOWL4Vh7jyDDqC5b7IaBnAcsPO?=
 =?us-ascii?Q?+v5iH+wS/gXN+d93VOotCd60rUKSHbupn1daMbVEKHX9zfsxDXp7lZmZdKdv?=
 =?us-ascii?Q?HBxBgrRf8FpQBGkwRYU1fdysZzUe3O7fIVBFIr+kUl4SBeS4qr42Mfwe19qD?=
 =?us-ascii?Q?ZC4tKTLVud9ZVAciOD8yz3ZRhAfHlOcP46lOLIq3SVuicB/CqhTbLWa5ZP2e?=
 =?us-ascii?Q?bqGDhppYAczmx/JzsqHJzApgB4qK0aIq05kHCAUuUdilLAON7TrQ3GaZAhOY?=
 =?us-ascii?Q?gDnMIpAphNtsRAgouPQ2F/qJzFvM0A9E8YNo+0aaA8v7ISKcBwQ9eaYhlzF9?=
 =?us-ascii?Q?7iQo1TqEM60OMlvf0d8Bya+2r5SI7A+QxmjPFPdyja1BzSaYzJ7fT6K8FgWK?=
 =?us-ascii?Q?KhpFyzDzFeTSPiobzd+OEq2uxRTgIGfVcwelRzPtzZsCowBeHqG1NWgZBE4N?=
 =?us-ascii?Q?h9DfTyb2L9p/kSrOC3T+vW5qvUjS1Z8Uq4VOJp2+CS5uOqHKROBw0UwsUkYV?=
 =?us-ascii?Q?2NUb6Zkhp8YUjoLiEJTY+DGAojwuL2E4QCxv2TvRcofpBJagEtUiXAUqQ084?=
 =?us-ascii?Q?1R/9wSBExuQB066+fzuKLK6zU7XybRMlg+x8xWhbYKhbW8nsTOGhrcdOlYJY?=
 =?us-ascii?Q?v0Ic6ESCZpCICgvL2VzD8Mv50q5jQCHFhLfu3Hc2qX7KAGvKoMHNNocCA4vN?=
 =?us-ascii?Q?tfUrF+/HEeBvK/P2OlcVU5W41QVpzBfFZV4JhedkO4sqkvuIwK93F49YKDn6?=
 =?us-ascii?Q?XasJrP2Rv2zTB13chXyrlYhvy1H5tHZwDoCV5WxIAuals4Vh5MUcswuYtHrP?=
 =?us-ascii?Q?ZFv7dAMAKCvVBHQUIXyIjFk40KraT0FB3+ReVXfs26L76gp46fEpTlmnY2b0?=
 =?us-ascii?Q?5bJ3q9oWq1jiU6Ks/Brg6o0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eddd7a1-1dba-4c36-9279-08dd61585c3e
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:23:49.0342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JucpvRlWWz6J9zGP3sf6cuxTrBf7qsO5OBl3N6PBtzNdNMsCKCEeWQvoE3jqvHqgzG+uTl1JEmLhU28AQmEcufs3KOMeatBtSLykDGyKTDenDhn2FXClNG1EtrKNak3i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10581
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18096

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


