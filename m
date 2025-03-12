Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415C8C35FF5
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.54])
 by mx.groups.io with SMTP id smtpd.web11.34790.1741778660322402219
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FQqUVLuZ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.54, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSEwrBecsiEbTHzCbClLsg4YY/BQh1Ayf/e2Yv8BNIu/BnXN8bqOFUv6aaGP5YwDXpeuaBRvGBGbOaXku/gP9/rPRL5vN2mKExuSDPbOPRDaaQtRJ8QSBnTd6kR3ecL1eBqyFGCuVpeZTHfdq02DxN3YGrjOgKfv//Zs3w8HxDKJVuvsKMQmPZGdfAY5hcncjShb9zjNxpjmc4WabW9CTB/djpEkwp6Yqjvvzte3atODOe9lmOlUsdub6dLLF9cw1O73nV2Awf8o3a+yU/UpIDPgoBexSpzrjxco2NbcKqGXs6zB0j0cYATqaejPY92QkaBy39mLmzEup7vg5w3mMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk3EfJavzXWjQd1i75nv3sNmwuSbQR8VcdbUnRpg1+Q=;
 b=SkTbXPXf2uDJhgYr9ZjI0D3L6FezV0xCTKSRaY4HVp9kKn7ZllBlp0WFAU8H613o0DafUDEG1QcHwIWCrcNd5R0sk6qH/K7c2OIKpzEVS5zX+sM8yoVRvyLTOHShQpjkyBM2VJ3hNGg6HjveittEMTitRHJzlKsNVknKPs5nIMjLG2Y7lLH9uObfFYyszOgUXCzifulut6GL9X2DBqadfwi9xuhQ+ipjQeLGLtaMK5XfgVYD3emBhDcbCjW5yR3scWd0EO5YtV16c1HLfUkuNYvYVgoIJv37zI/fYZq4gNE3/glyLtwnY0GQRAL/HpZTQsdQioiXPV0+6+3h9rQHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk3EfJavzXWjQd1i75nv3sNmwuSbQR8VcdbUnRpg1+Q=;
 b=FQqUVLuZPM0cCzG9t0E+P8lKXMzNFnNKG2hHZrET2eYK8kKrucKweo8W+MJjB8886IUuqgU7fbBFRmcZKqULCylOSDuriF9Qf/swdFkTuLo33i+Gts5Uh3t5Bc2IJmQLABc78783VtpSduacJIeHIfMco4M8UMJ8Ayq9Wzqc9UQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:18 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:18 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 14/85] clk: renesas: rzv2h: Add support for RZ/G3E SoC
Date: Wed, 12 Mar 2025 12:21:51 +0100
Message-ID: <20250312112302.1605750-15-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b519ef6-f936-4329-1030-08dd61586d8a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2+x00LPUsDAtX67y/MvrLKtSDdrbXbCHGLn4GWgSQD4XtGvX2wHzbfAoRyS6?=
 =?us-ascii?Q?T+S73fWDaAVTom5f1PCh+IAIyrWhHN5Gzhert9GOjZARUS9Rf0Mxbrr8Vqhs?=
 =?us-ascii?Q?awWnud8rXTLTYUxKK8bMA7zC48bQQ0lwHlJerAzkQlztosvsP6c609YERxlz?=
 =?us-ascii?Q?7QDaa2vabE5iZ/1P+AO8rjvt+qtvEhUILfPchtLaZMqnnUNP46bKiEyRxIC7?=
 =?us-ascii?Q?j7PSBcMNjCE070zpcDuC5ztHr9dfrkxSXVtNEvABXhMOuloJJqSZMPyMm0SD?=
 =?us-ascii?Q?eEOJ1gKprYRpVcmCtmd/T2s8RsqhzyDIXgzloc6Vi+6XL4737FLpmDjSJf4R?=
 =?us-ascii?Q?ls+57JKH2LmWP4NGiHORqSvMMt3vP49D36hQrWDSiLNfHhOjPvMGzljinzWC?=
 =?us-ascii?Q?YfSzK1MfMIH2argXl90MOycioTkzcGmuVepWK/8yG1ehBzMXPGTS+Zy9O4xb?=
 =?us-ascii?Q?YPrwWsTGDGHp65Gz3NnUFbhDaVJvf8JY9ZQ7nb3FhR52iGxHfSaglGsGv+47?=
 =?us-ascii?Q?gIN4dmzG2dQFDy295QqKm3Z4ETxlur6q7syaW7MvoDbUlTA2VXkWbJ8D7/gu?=
 =?us-ascii?Q?+mEdB22Qc7q6yi+HLd+On09r10DKnaXHgr9VSELNsJeg+sFSwtYAErQITn1j?=
 =?us-ascii?Q?vXMjM/6qUsG+gZwGS6hm+nMAKGpMjbMs7eBolSbR+OZbTIM0bmPcu2wHph4g?=
 =?us-ascii?Q?DMma4pTPbGzHFpzgn+MapSVAaXJD55C8+MN9ygplW2rvDdHP5ct4EV2u+uqr?=
 =?us-ascii?Q?RJc/li9PpQO7JtVjY48Og7Uzp2KVavVSzRcKubELsmrPAV58oISrzZCPZk4n?=
 =?us-ascii?Q?qWPlkdB4gGLiFAdu80/DacfvcjP6HDWh8VzCAV72kQ9GJQQ44vLU22wCNj1K?=
 =?us-ascii?Q?9Y4qW7jjEsBMVCe1MQn8OfKUYMOmBBYRdbdRaGS8/zadGE/D741d5puKP5SC?=
 =?us-ascii?Q?YQgkCbHKCdJr5pPdNgPWBh7/wk1qK10EDQ1OXBSacLpUYrmzTrkLDKtmjKar?=
 =?us-ascii?Q?VzT/GI4qYtqi30l0ubeEjiHdnS8vg/MGawhzxADPWbH9oudNqJwBTqaSCMug?=
 =?us-ascii?Q?lWlINCVMTD9mHsPvtCwGFuTExoZB0xnx5eTzAWAcUyXelQa9ujKsZh85r01M?=
 =?us-ascii?Q?3GvmBfLoBu5GlyjzMiK0zzpYiIQ6HSXyn9oG1RC9IQCl8G7cX2tilPO7cYHP?=
 =?us-ascii?Q?RT4CF66UIKhjtCos5hfd+cH+13av4NnXwC5EQZKLppXp2THgI+/zffnrnmXB?=
 =?us-ascii?Q?68j2YI7SfFjAmugYTJO6PskKAZ8GhCMtXr/ZAkJXsygCb90Ic1IXfNUf7VHe?=
 =?us-ascii?Q?Um9ISgjHcb5zIukzoedGn0Yd8mYLLA+Pm+D8+UlxwnR0xnfbg0jX0dU486A7?=
 =?us-ascii?Q?btugEeTVRdP5mcNJ091jFmJzZuiQnETXkrI1YC7580G9Z2pDs5GzHksXsx8B?=
 =?us-ascii?Q?JoBNc3Y6DXqYlsrrFlPxy0/RUm3HWYA6?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?U4PFg710p/9GlF/fTEnxRLhrAaOSBBUPfAI91nWpEEi9/DFf+jIsA7fRr5l1?=
 =?us-ascii?Q?ZxPYKDoaN7FF9jkz7b+PSFlDEYV4AVEPe4hbuYV0zMeI0tqdl6NLzvyooCqL?=
 =?us-ascii?Q?pCi/6sT0PLmxx/4DzBmWC5OMghWLBLKR91iDiJ4c6S+OcWYrv6+HM3cnZC/1?=
 =?us-ascii?Q?90zSn5Uh5om4bJIhI4Y3HtE1BndhL/gc91k0xE8d4kFiYMOQK6++SJnrhetP?=
 =?us-ascii?Q?ajYRnzWIsyPuwSq7kkU6a8aLtqHOt/IfTgy0QPXgHF/coDvYtJZvq3nIBOt2?=
 =?us-ascii?Q?bsVMduTAK6K6p2vrKHKaBxg9XxQQZpB2+VkamYp0pf22s7Ibl0STgLJs5VAk?=
 =?us-ascii?Q?j7MKFZfOi0602bT87i5KLFEtKkSd7cYPxTg4K7pj+p9+tZyDdm2vGUgwK1du?=
 =?us-ascii?Q?WWZYNZRNliV5JkMCwenJaYb8oL3PhWfQU1ntfIg9kxghOOvyhS9Ut+Y21SPc?=
 =?us-ascii?Q?ceEqrFJ47j5jeTJ75jhejZSmcWLl/cMhy6+v1UdfB3BwS2rFuVk0nQbSADa3?=
 =?us-ascii?Q?HOBOIXK88qqblZdUWes+JM447OiYbKiSMsnbcfHTLQIQcMYFmOPsclDWdVRp?=
 =?us-ascii?Q?X4FMfxRVQeCKAp/0ErS7tdd3IM4E2sT1Y6/B3vx4q6VmvAvQFbPruIVBtzz3?=
 =?us-ascii?Q?GUhuSFk0mS3BSnFiU5R+y7Ah9h6+wbSFLoeq6gGs9vT5PEjbzQ1yX1L1KMWJ?=
 =?us-ascii?Q?+F21iKjYW/yy+KKnCll5IqXbl7kpQeWPWmaQFbHDN8q0YoCJRYAalxZC2hyc?=
 =?us-ascii?Q?VFp1Yt/TFhr41baqpfav6O7ioxTmvr+ZLjJCEXNETbeF9LpAVRwsb0w8SJjr?=
 =?us-ascii?Q?ZqXXTslbhu/+Jk1hrAS52cL4kSvOrAaiot7PGkfB5obssIGMwGEPsBTspXFK?=
 =?us-ascii?Q?gi9SWTpuaqassdlhdB/o6uHp0dxr+P6bfxWGXtXhCwEaAIQ+EwEHIaAV0PD7?=
 =?us-ascii?Q?9PXL4FhsC5BdKh01kYaCmDBH3e3KAIKMtPd40wBgZtxHXfBI7qBdgwzL2fN2?=
 =?us-ascii?Q?eNtVEkoYzLF0MUwlutpZmVCSztZOa+oSU1JQJ/dNeWOyXvbwMkNKdvGmK0sK?=
 =?us-ascii?Q?9WRRFcxq++SOSASID+4Qb88jyYT2T6WnEaFpfXYwN+UJdM0MloElZXA52Lsu?=
 =?us-ascii?Q?kHsnMNRGQmeUtv7IjgYnsbOoXtmTEBet3WTHuFesBdD6FV1Nlk7dNcUFK2tk?=
 =?us-ascii?Q?694lEMZuozXjAYjhWcG6fPOmRkT6iOMRdojj0i+oSqJZ+sRZxwm8f/nCDbKm?=
 =?us-ascii?Q?dTyRblAwKMACw573puUFEwYh9MweCZu3Lm2B/eaB1DBQgaQ25x5EnJoAstkd?=
 =?us-ascii?Q?ajdDUhMgonjgmBiKL0s57K+qggp6Xeh5LD59qmQsKG7xz++optuenxsiNRSs?=
 =?us-ascii?Q?PRzn2xPgUGYMkGcnves3Vkvp4kZdlu97NPhoovxAopCZ/qUmCOeEn3tW4/sW?=
 =?us-ascii?Q?kYeMx3cMtjxIdM0eKQDFfxjIIZI5W+9uMEMNu9w5g4yUxbnJHCU1eLCsxOBv?=
 =?us-ascii?Q?wj5fCgh9wDAtq2KKZUlhqwjqdumNh5svnmm3kLfSwQIBskC53XhvLTHQNAlv?=
 =?us-ascii?Q?NV5ivqFh9TZBcrnxws5KkjKQYMa08f5PEBVPo0A1/zaMEBqyDFltRlvta459?=
 =?us-ascii?Q?sf+kKIqCrs/b1cxnTDdF+Pc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b519ef6-f936-4329-1030-08dd61586d8a
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:18.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48b4m9NmB/ONomACa7Z0dL9f0/6WCD2T8oOqUqsJrtCw5QEGwtatx12O3Dp7/GiE7L7feMDlYLXejb0qR/ThZJhGniT6y4K7hvVGt9O8ET5YQtOROsAe2BPEPWmc5Vhb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18106

From: Biju Das <biju.das.jz@bp.renesas.com>

commit bb6a9aaf670735d6583c76073ec41190f5404dc5 upstream.

The clock structure for RZ/G3E is almost identical to RZ/V2H SoC with
more IP blocks compared to RZ/V2H. For eg: VSPI, LVDS, DPI and LCDC1
are present only on the RZ/G3E SoC.

Add minimal clock and reset entries required to boot the Renesas RZ/G3E
SMARC EVK and binds it with the RZ/V2H CPG core driver.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/20241213123550.289193-3-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/Kconfig         |   7 +-
 drivers/clk/renesas/Makefile        |   1 +
 drivers/clk/renesas/r9a09g047-cpg.c | 102 ++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.c     |   6 ++
 drivers/clk/renesas/rzv2h-cpg.h     |   1 +
 5 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/renesas/r9a09g047-cpg.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 688c088a68d9..e1950ef22baa 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -39,6 +39,7 @@ config CLK_RENESAS
 	select CLK_R9A07G054 if ARCH_R9A07G054
 	select CLK_R9A08G045 if ARCH_R9A08G045
 	select CLK_R9A09G011 if ARCH_R9A09G011
+	select CLK_R9A09G047 if ARCH_R9A09G047
 	select CLK_R9A09G057 if ARCH_R9A09G057
 	select CLK_SH73A0 if ARCH_SH73A0
=20
@@ -189,6 +190,10 @@ config CLK_R9A09G011
 	bool "RZ/V2M clock support" if COMPILE_TEST
 	select CLK_RZG2L
=20
+config CLK_R9A09G047
+       bool "RZ/G3E clock support" if COMPILE_TEST
+       select CLK_RZV2H
+
 config CLK_R9A09G057
        bool "RZ/V2H(P) clock support" if COMPILE_TEST
        select CLK_RZV2H
@@ -234,7 +239,7 @@ config CLK_RENESAS_VBATTB
 	select RESET_CONTROLLER
=20
 config CLK_RZV2H
-	bool "RZ/V2H(P) family clock support" if COMPILE_TEST
+	bool "RZ/{G3E,V2H(P)} family clock support" if COMPILE_TEST
 	select RESET_CONTROLLER
=20
 # Generic
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index e7ff58c0a480..a1fdc48c5c7d 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_CLK_R9A07G044)		+=3D r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A07G054)		+=3D r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A08G045)		+=3D r9a08g045-cpg.o
 obj-$(CONFIG_CLK_R9A09G011)		+=3D r9a09g011-cpg.o
+obj-$(CONFIG_CLK_R9A09G047)		+=3D r9a09g047-cpg.o
 obj-$(CONFIG_CLK_R9A09G057)		+=3D r9a09g057-cpg.o
 obj-$(CONFIG_CLK_SH73A0)		+=3D clk-sh73a0.o
=20
diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
new file mode 100644
index 000000000000..1178335dbed3
--- /dev/null
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G3E CPG driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+
+#include "rzv2h-cpg.h"
+
+enum clk_ids {
+	/* Core Clock Outputs exported to DT */
+	LAST_DT_CORE_CLK =3D R9A09G047_IOTOP_0_SHCLK,
+
+	/* External Input Clocks */
+	CLK_AUDIO_EXTAL,
+	CLK_RTXIN,
+	CLK_QEXTAL,
+
+	/* PLL Clocks */
+	CLK_PLLCM33,
+	CLK_PLLDTY,
+	CLK_PLLCA55,
+
+	/* Internal Core Clocks */
+	CLK_PLLCM33_DIV16,
+	CLK_PLLDTY_ACPU,
+	CLK_PLLDTY_ACPU_DIV4,
+
+	/* Module Clocks */
+	MOD_CLK_BASE,
+};
+
+static const struct clk_div_table dtable_2_64[] =3D {
+	{0, 2},
+	{1, 4},
+	{2, 8},
+	{3, 16},
+	{4, 64},
+	{0, 0},
+};
+
+static const struct cpg_core_clk r9a09g047_core_clks[] __initconst =3D {
+	/* External Clock Inputs */
+	DEF_INPUT("audio_extal", CLK_AUDIO_EXTAL),
+	DEF_INPUT("rtxin", CLK_RTXIN),
+	DEF_INPUT("qextal", CLK_QEXTAL),
+
+	/* PLL Clocks */
+	DEF_FIXED(".pllcm33", CLK_PLLCM33, CLK_QEXTAL, 200, 3),
+	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
+	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
+
+	/* Internal Core Clocks */
+	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
+
+	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
+	DEF_FIXED(".plldty_acpu_div4", CLK_PLLDTY_ACPU_DIV4, CLK_PLLDTY_ACPU, 1, =
4),
+
+	/* Core Clocks */
+	DEF_FIXED("sys_0_pclk", R9A09G047_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
+	DEF_FIXED("iotop_0_shclk", R9A09G047_IOTOP_0_SHCLK, CLK_PLLCM33_DIV16, 1,=
 1),
+};
+
+static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst =3D {
+	DEF_MOD_CRITICAL("gic_0_gicclk",	CLK_PLLDTY_ACPU_DIV4, 1, 3, 0, 19,
+						BUS_MSTOP(3, BIT(5))),
+	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
+						BUS_MSTOP(3, BIT(14))),
+};
+
+static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
+	DEF_RST(3, 0, 1, 1),		/* SYS_0_PRESETN */
+	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
+	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
+	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
+};
+
+const struct rzv2h_cpg_info r9a09g047_cpg_info __initconst =3D {
+	/* Core Clocks */
+	.core_clks =3D r9a09g047_core_clks,
+	.num_core_clks =3D ARRAY_SIZE(r9a09g047_core_clks),
+	.last_dt_core_clk =3D LAST_DT_CORE_CLK,
+	.num_total_core_clks =3D MOD_CLK_BASE,
+
+	/* Module Clocks */
+	.mod_clks =3D r9a09g047_mod_clks,
+	.num_mod_clks =3D ARRAY_SIZE(r9a09g047_mod_clks),
+	.num_hw_mod_clks =3D 28 * 16,
+
+	/* Resets */
+	.resets =3D r9a09g047_resets,
+	.num_resets =3D ARRAY_SIZE(r9a09g047_resets),
+
+	.num_mstop_bits =3D 208,
+};
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index 6f096abda33c..1612864732e4 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -972,6 +972,12 @@ static const struct of_device_id rzv2h_cpg_match[] =3D=
 {
 		.compatible =3D "renesas,r9a09g057-cpg",
 		.data =3D &r9a09g057_cpg_info,
 	},
+#endif
+#ifdef CONFIG_CLK_R9A09G047
+	{
+		.compatible =3D "renesas,r9a09g047-cpg",
+		.data =3D &r9a09g047_cpg_info,
+	},
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index dcd65e9c09da..fd8eb985c75b 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -218,6 +218,7 @@ struct rzv2h_cpg_info {
 	unsigned int num_mstop_bits;
 };
=20
+extern const struct rzv2h_cpg_info r9a09g047_cpg_info;
 extern const struct rzv2h_cpg_info r9a09g057_cpg_info;
=20
 #endif	/* __RENESAS_RZV2H_CPG_H__ */
--=20
2.43.0


