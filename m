Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24968C35FF2
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.21])
 by mx.groups.io with SMTP id smtpd.web11.34795.1741778668450271599
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TAOuxFbN;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.21, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLwCjzTiODcktPF7wAT2kdnvDEpyZV54kM04wGJVZT+s+lHjsNY1bYUcX24gZPfOPnwdBzHLFPPDk3AdOYc10IdbWjj3mWUnUoibga8P6C6u7M1hPJSekzg4/osHVFf1GF56szmN6Y1TtG0Iv7lA+JDl7QBbDmAIbWBe1rgZzmUIQ1uRQA/NEjTVNYAtedl3N9Fx+khKL+jJGMYDqGgH+wCSh1Q1QBfJkew9u/EZYzK6k1JwDyABJNDDMRKPHUo2iEp7ubF9kAEAZqJbo3Lbekp+NQK1BmIlgXkqNYnTdIFR35NgGMAtreb03pYqFZxV/PEUBvlRtOlbHlaGmdbkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1WzZyE45N4Cao6T8SOpSfXv4EQpwEgQ7EBC0dcwXr8=;
 b=u4Rx2BnKNJHy9vzo8YO+9o4d0xG7vNVJcPBfog06mMTisfLlZVYKAz6gWDUP9vN36fY8to0o4IYLhfPz+CmZXt/0OgX0OLxW8lzefKnJ3R66LoIcwofF5bh6R7HkrqILkUIMKeIxcGCde2VHUA8repppor0R+woHrNzwIvzRfIaRXW4cLEBtpQ83BoUtyaX8KOCq42t2nbIsOCk0EltPe8a1nK2AscS7uoVySwD6F7Shn434bKdfGJ511+wjE9b4tAso1KLx85NYikXtYHcenrTbBgG9I7PqZkcjUE7uUV/6rlyye8D2I51S/YFaF4Sw0VUYjwsfwZOkMzHz6u4XRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1WzZyE45N4Cao6T8SOpSfXv4EQpwEgQ7EBC0dcwXr8=;
 b=TAOuxFbNYlMWy/hgZZozXSNSo23Sc1TIifqUXcHEU+mlxtu7VnAerqctyTtQKER8927i71nMR93p1CZi5AudPzgm7PWZvGqiVVSxTsAVV3a98p+LOUWcbatVyLUnBEhJMU6K5fDE1t2fla6eUNBgufs5TCtQJgvp+j6QM3+Innc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:26 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:26 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 17/85] arm64: dts: renesas: Add initial DTSI for RZ/G3E SoC
Date: Wed, 12 Mar 2025 12:21:54 +0100
Message-ID: <20250312112302.1605750-18-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: b968a6d6-3d49-4f00-bea1-08dd6158726f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Zj0Sxk+hs1FzHZjdAL8/lXwf7E8uE0iX6i9s2u5q+Me6fQ1D/EGpX49jfseC?=
 =?us-ascii?Q?OSCh3QvMdNKFVylE7Ye7FqyGoW+h6+KxK3mDzuP+Zk7s6V/xeJ2lxL/BQwvK?=
 =?us-ascii?Q?KDVwsTC4qakSgwqB5iTTHJWGf2srYNvdAZoqTWTmcwqDO0l1ZH5tSuz03jWv?=
 =?us-ascii?Q?M/Pu5HPq2Mu1E/Q+MsQJ7USfdFZCLa9itsUeZNRR6u4fqghAnhMBHBYzc+uR?=
 =?us-ascii?Q?E6IX+3J3DcJI9p0icGU8d6n03ZMuhehXQTgtLhiTzYXLEy2r9X0Wao6fTMqr?=
 =?us-ascii?Q?uyszNgyfQ2A4wMlvBlDuo5AS9Hf8F3WarO8bkO5+dYWJos/SjWhZ9TrgKr37?=
 =?us-ascii?Q?PVrY8D/C5bMeDTAYsNUdQ5gM4QMrAaJLeQvDE4kSx4WGWq7RivY5FD1rkyve?=
 =?us-ascii?Q?po71GwwqhmVlb+lhGFW2FLNG3jXBhZVKUyTXgD5H/LEvyVrVJE8cQwuXevfK?=
 =?us-ascii?Q?mDfFTQ+beST+K+8PZwoHxSecNsa8e0T7yKmjSzpVHsGH4jRLB8ZW4VWi66AK?=
 =?us-ascii?Q?DF4Xyymh3EhyCVp4hD8Dws7E758lWvXEXToZL+/DyU/LJlndmqoO1MiQdnaC?=
 =?us-ascii?Q?VB6adVWGapihbZxdgZvVyPW0lgWGBBRepfA1D6GB2QFXRIBguQeqx5HxKjev?=
 =?us-ascii?Q?v+8/1rxvpW+DFycExSyO/KaCz/5pUSXBHwl4sXk3oRtaH+ARvj4pIGy7UGBV?=
 =?us-ascii?Q?TOE53pZyUshgNmJGNoQbjuJBqeG5fFzim2n+qO6Uj2GBDR377c4QEjOruDu2?=
 =?us-ascii?Q?JBEmQUw/mY3b+fiv7ILL4wYPPzyBB9geJiAZOgiFL4uB4y6y1pvT+UVfOLpu?=
 =?us-ascii?Q?Lll45s5Db48FeOFGFkpveKv4Cbn9EArKhB3dg7B6vLJLsB6wvEbYN57yhCvi?=
 =?us-ascii?Q?0ZpSxHq26lfgbP0Q1wtviINoYnxDvobWz/Vi8zWliCRTmaEFL7PaeHBP2dfZ?=
 =?us-ascii?Q?TMjqOESiUmswbPvTygqFRP5BztUR7fuNQVKOf7FwIoy0IU6oJG4uxVcK+ddB?=
 =?us-ascii?Q?a7d2r7vTYLWcLQlRUS3ARq41uQ1o3fuEgT0mLXjnSI9lIVEEkJqIzkiNcWbe?=
 =?us-ascii?Q?IhrkjOENqzwGIjTr1KzPxVRLf+CaDNIKLy5eyhkfuXYXtn9FeEB41i0et17F?=
 =?us-ascii?Q?CiK2Lo2JjkKMOv3oGARCuKVThYKcbbv+BaQ14mK0/If/hvlYgrCbTUil3Lpm?=
 =?us-ascii?Q?06npLt1JKTgB990/WUxkLQs/t90gZ8FEBMMWC2JO1wZgl0C5H7oyLjBJhTDx?=
 =?us-ascii?Q?MubhBIbEkNFVkVsfLYOASGncDUopE3bCcUuhQEDH2ZEBdecb+xrJa+1hEa1A?=
 =?us-ascii?Q?uTI0i0IUaEojvf1PjPDLFef2FH7YQ7ub5hAmgJIn9zIv31x6YDZLIYomzr1U?=
 =?us-ascii?Q?G07etwIIfKHE18CpKxk/JsE1n1IcYDCjElCNUryLzRkF4iHkJojc6+EgL3z8?=
 =?us-ascii?Q?pHrUmC9E3YluCwzJRYnPXTWLCgbq4yAF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MfwAm/M8EkaaRKk+8XNdgt/AGQXTw2IU7tLjzQvCwdrZ9PR35vu5fTlnRpYg?=
 =?us-ascii?Q?PMbEbg0D65Lh0mE6UAIr79MrAqWmSP/rv/VpE5lWQN6KpRDR31cgCeDiPYw0?=
 =?us-ascii?Q?wBKzy0eO8OdRF8x+oRWOpkcBDNSmvgD+oQd+d5g43EMhqy/3SdOzxSQ0iAUe?=
 =?us-ascii?Q?l8jZ5+g8+py+7b8iBCwlbWBuNxWB6rWcdBkPa9b26BNqEqJtyHDG0nTVw+ce?=
 =?us-ascii?Q?JOKGte2wjUNyyJAfInWDxGJO8ZU0ogzvr5ATtjRTQx54dPKGnFFRUFZMhNVG?=
 =?us-ascii?Q?OzFXcWd1ydoukwFLx/ahdpKlzLjcEDWgGe2bG09StQLbKHHl6qhHR/vtFueu?=
 =?us-ascii?Q?mbnqNR6EQ67vJ4TIyk6rCPJk7Y1KnJqC/VwHXB5eQkp7WUr0Lim0QLd+eDKE?=
 =?us-ascii?Q?jrmRtjWfG7/uBIQR+ri/gebW5SjgDXXtSgzsYpcRAE6OUV4qcNZ3YC+d1+Qb?=
 =?us-ascii?Q?fznJ3ndBMrX4Ul8Or9hbVVhcwPHsCReLhvNIBLudNkKMzpHtkbw1tl8c6nRY?=
 =?us-ascii?Q?fK3PnmTVgbwnsyHw89QZk9CFrkty9hpZioTUK63f61/mtnFzc2zs/1trOkHA?=
 =?us-ascii?Q?xZ9KQMi0JmxIcv4tAZvyhXazCo6LYBQbFK24o4cMYlNb8tjDUHsm+QxDE+6W?=
 =?us-ascii?Q?ZoTZh7fw7QrY5UoFlWeJjsttNvcyh7Uev0jp4ZuZVsf84aBrYVH5mtuOaHaC?=
 =?us-ascii?Q?9t4N6ooVkAwaOsNoJ1NCY70utI9mBDVOSU5Dj4xbRPAYkgHoG6Didh0pJ9jy?=
 =?us-ascii?Q?WBjmPivub1aOFkjEaHS0yjSfuIdYwrE4Auxzx8yZcgQL0fME5gVQ2ZNRzXhh?=
 =?us-ascii?Q?5QdGdIT6gEXn4Sfp6+MnLMA7OuG5rGXeGrhOQFDBqTBRdrL78KKGef+98mku?=
 =?us-ascii?Q?QmKvO6s7jP6xPyQZ17sXri+kMJmvCQpzlU+xeOUL/ybUmB5v5b/Styogl/M3?=
 =?us-ascii?Q?Yp3LG1lfkJA/R347xYp1XoOYWlPrEchA3wg38s2L/8NaDmO0CFL8x4EhjSbY?=
 =?us-ascii?Q?O8xUJvEAO5hY42zlg2V30i0wZHqehfH3jAZCJhu8IivC957EkREfv9sT6H/s?=
 =?us-ascii?Q?ZzRYCSetQAa0NJYm/DxyjBaQp9IPsUyixaMchzEyHTUvSn6k1Dipa4Ft3VyL?=
 =?us-ascii?Q?WFyCX50WsSmh3ewwUyv1CRVQT0DI4IEMt8ooSjVT0cLf/3ln4buZI0LkORVA?=
 =?us-ascii?Q?PzhxEOjVqvqdT/RSsPyeOwYMfNL/77t+2x/zu4g7PkU9wJ10gkjUaL8+gsxd?=
 =?us-ascii?Q?R5CH+d2ksUJt4soTRlbVis8T/t7aE7XRTDdFi4y4yIXsniD3r2PAWIP15Zeq?=
 =?us-ascii?Q?Xei/fdQUEtzckjPOF5cwhL5Yiu9rKOAp9goPMRXX4hnl3nOTRtued2Bhy1rb?=
 =?us-ascii?Q?+31QGcdpy2GJWwgXYcPyq71TAZkW6er9MBFR9wH5F7HXvrprt4gW9X5omGe0?=
 =?us-ascii?Q?FA6KDknK0dGVfbkrUcNWNueaxo82tIpqTQwq7ovevjL6Onep5xwCELzmHFDe?=
 =?us-ascii?Q?loxClIug7PzADFcmAkkMphqXxT1bgLEY4bnuaqohkMCEyD0AXE6j50HU7ygz?=
 =?us-ascii?Q?qJZVIg2HF2drvg78HP8R6c++1nrczKn/6PNMzsjk31/BslsDsedWMcRrjPFh?=
 =?us-ascii?Q?ln8dKLkEAsQTXiH0MiJcqbE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b968a6d6-3d49-4f00-bea1-08dd6158726f
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:26.5035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u32BsPtXVlZyrWDkIJWJJgZXV4pugYq6lNe9f639YD4hXnI+dIN2uQowfFp/F0LO1dGz90wsLcrRrMdBjg8xDo7cPg5rsubINJFqQsE673GmndEIcOPTXU5JCNIvJFyw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18109

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 9977754eeebed749a071492d98e46700307c0bd1 upstream.

Add the initial DTSI for the RZ/G3E SoC.
The files in this commit have the following meaning:
  - r9a09g047.dtsi:    RZ/G3E family SoC common parts
  - r9a09g047e57.dtsi: RZ/G3E R0A09G047E{4,5}{7,8} SoC specific parts
  - r9a09g047e37.dtsi: RZ/G3E R0A09G047E{2,3}{7,8} SoC specific parts

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-10-biju.das.jz@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 144 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g047e37.dtsi |  18 +++
 arch/arm64/boot/dts/renesas/r9a09g047e57.dtsi |  13 ++
 3 files changed, 175 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047e37.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047e57.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
new file mode 100644
index 000000000000..4176b9aa6892
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3E SoC
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible =3D "renesas,r9a09g047";
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+
+	audio_extal_clk: audio-clk {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		/* This value must be overridden by the board */
+		clock-frequency =3D <0>;
+	};
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		cpu0: cpu@0 {
+			compatible =3D "arm,cortex-a55";
+			reg =3D <0>;
+			device_type =3D "cpu";
+			next-level-cache =3D <&L3_CA55>;
+			enable-method =3D "psci";
+		};
+
+		cpu1: cpu@100 {
+			compatible =3D "arm,cortex-a55";
+			reg =3D <0x100>;
+			device_type =3D "cpu";
+			next-level-cache =3D <&L3_CA55>;
+			enable-method =3D "psci";
+		};
+
+		cpu2: cpu@200 {
+			compatible =3D "arm,cortex-a55";
+			reg =3D <0x200>;
+			device_type =3D "cpu";
+			next-level-cache =3D <&L3_CA55>;
+			enable-method =3D "psci";
+		};
+
+		cpu3: cpu@300 {
+			compatible =3D "arm,cortex-a55";
+			reg =3D <0x300>;
+			device_type =3D "cpu";
+			next-level-cache =3D <&L3_CA55>;
+			enable-method =3D "psci";
+		};
+
+		L3_CA55: cache-controller-0 {
+			compatible =3D "cache";
+			cache-unified;
+			cache-size =3D <0x100000>;
+			cache-level =3D <3>;
+		};
+	};
+
+	psci {
+		compatible =3D "arm,psci-1.0", "arm,psci-0.2";
+		method =3D "smc";
+	};
+
+	qextal_clk: qextal-clk {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		/* This value must be overridden by the board */
+		clock-frequency =3D <0>;
+	};
+
+	rtxin_clk: rtxin-clk {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		/* This value must be overridden by the board */
+		clock-frequency =3D <0>;
+	};
+
+	soc: soc {
+		compatible =3D "simple-bus";
+		interrupt-parent =3D <&gic>;
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges;
+
+		cpg: clock-controller@10420000 {
+			compatible =3D "renesas,r9a09g047-cpg";
+			reg =3D <0 0x10420000 0 0x10000>;
+			clocks =3D <&audio_extal_clk>, <&rtxin_clk>, <&qextal_clk>;
+			clock-names =3D "audio_extal", "rtxin", "qextal";
+			#clock-cells =3D <2>;
+			#reset-cells =3D <1>;
+			#power-domain-cells =3D <0>;
+		};
+
+		scif0: serial@11c01400 {
+			compatible =3D "renesas,scif-r9a09g047", "renesas,scif-r9a09g057";
+			reg =3D <0 0x11c01400 0 0x400>;
+			interrupts =3D <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 536 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 537 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "eri", "rxi", "txi", "bri", "dri",
+					  "tei", "tei-dri", "rxi-edge", "txi-edge";
+			clocks =3D <&cpg CPG_MOD 0x8f>;
+			clock-names =3D "fck";
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0x95>;
+			status =3D "disabled";
+		};
+
+		gic: interrupt-controller@14900000 {
+			compatible =3D "arm,gic-v3";
+			reg =3D <0x0 0x14900000 0 0x20000>,
+			      <0x0 0x14940000 0 0x80000>;
+			#interrupt-cells =3D <3>;
+			#address-cells =3D <0>;
+			interrupt-controller;
+			interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts-extended =3D <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names =3D "sec-phys", "phys", "virt", "hyp-phys", "hyp-virt";
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e37.dtsi b/arch/arm64/boo=
t/dts/renesas/r9a09g047e37.dtsi
new file mode 100644
index 000000000000..e50d9159e832
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e37.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3E R9A09G047E37 SoC specific parts
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r9a09g047.dtsi"
+
+/ {
+	compatible =3D "renesas,r9a09g047e37", "renesas,r9a09g047";
+
+	cpus {
+		/delete-node/ cpu@200;
+		/delete-node/ cpu@300;
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57.dtsi b/arch/arm64/boo=
t/dts/renesas/r9a09g047e57.dtsi
new file mode 100644
index 000000000000..98a5faebd47a
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3E R9A09G047E57 SoC specific parts
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r9a09g047.dtsi"
+
+/ {
+	compatible =3D "renesas,r9a09g047e57", "renesas,r9a09g047";
+};
--=20
2.43.0


