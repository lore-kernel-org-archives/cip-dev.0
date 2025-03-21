Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A92C36002
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:39 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.13])
 by mx.groups.io with SMTP id smtpd.web10.18702.1742554890359190300
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=d8GZhok5;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.13, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwwZMm8+qyzaqNPZ5zmKLVFl7WQHLdERVI8dI2timfzc89cqc0sGlLfajgpbmltm9hMcBvIQQC7G5SRO5LWkgrQtraY1J0DQIPB9iCzcakD8ybys5REFqzj6Vbp/ffaliMXTJF8yzrDKRn4/GyR5TYTZIDGeyT71QorwNZB++CNujlJdHkC7ok9MCmcdwKaD8Bo/dIbsdxg2jqgI7I5yfbIrXMpgha+yl36CqQ1fANoO9HZqLMpBk7FB9VQ/V0fqppST9XevXqhZGepRLYqaHfRhznX8pW+UvdzV8KouHiQ+s/KDfaI/bdoCGxRexDx+EXn6v5MfPMr/PwrHsUcF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e81R+o79q7ezsPUN5QrK4Q1EzUVhpWh/Z/ivtfIYbr8=;
 b=Wn7S4mRLAF9iiS0bKjJjiS64MgyZtTpu8tuzHGmoce8VFFY/OPfwmlsMoPMOGYLoArbAru/kcSl8OOfSu/EqgA+ETrKZYIXSUcyKU2f4e1ZZ3sfvfeh3LEYixI7Fimaj3oNTXnmtYxDdIr4cK40ZCG4MKA5AAk2P0Qo5QfoeOU6xMEXDjNDXUKNCux9XFNiNJhHPefuvOoQSNZu5c/D+n4Gc37qukBPZCL8fbI8x+dkad99zVL4Itg1EjLYrpk0bXbfQxAVyRl1MAt7FkOqQvK5N/2k9XtrriDm20VIwNKkIDzLi6L3pDNGl5x/pP9YnlGdz23EotdtDH8QyDUJqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e81R+o79q7ezsPUN5QrK4Q1EzUVhpWh/Z/ivtfIYbr8=;
 b=d8GZhok5S7NkoXfW005Q6nftgxEafd1PPtrZabTCdB0VO2fEnSNCnAkWs0crW5mfrAQ5qk5EjU31p0YT32IjNnQokChF6PLRideIveoeI7D9YUwpq6m7GgL9A425FB2xgpindnstK7SsoinukIobIrXyaSXJ2Y/dSzmHtOjOx6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB8652.jpnprd01.prod.outlook.com (2603:1096:604:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:27 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:27 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 16/21] arm64: dts: renesas: Add initial DTSI for RZ/G3E SoC
Date: Fri, 21 Mar 2025 12:00:16 +0100
Message-ID: <20250321110021.3612805-17-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 700d3fc4-2c69-49cf-b486-08dd6867ba74
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xX3UaJyguFmlEh4MSDbrpWmrfM2m18GXZyBUMToOA6ckBkii3GXIC/LqsxH5?=
 =?us-ascii?Q?1HT+ZuQf7aAWwRpZtwDTZZN0EgGOd2pc22cVXyikBQ3wZti2mNlEmJeGGBUn?=
 =?us-ascii?Q?iRViRo+CF1RJYv2Kg5xy383ns0zi/gLfNhkHXc3SmSU3U6gEQCLkKtnPZ/eA?=
 =?us-ascii?Q?1MfzRxTHnzNkOPWMiTrccgoJp5JHoHJpt2R5RKtyILwtljXT3h6F2LBwUFkj?=
 =?us-ascii?Q?Q+r0IVbRnf7l1Oh3DEZDoLCI2lanKsIGLWIT9jYuIyDnBdjZVlBz3sV9UkeK?=
 =?us-ascii?Q?dLg3sCicOJ4yBABPZpGLpyui3cs3Tdt9Ft4g8agwjVbHAYVdNp3dUUuoA5na?=
 =?us-ascii?Q?nnYXzpktWy+NiZR1W21gAh8PQ43AnibyD6RwFTfO83I6y+B8huQQpGZ4hACy?=
 =?us-ascii?Q?UJ63fp5vnLf65cujaYPCSPVYJmQxHZJ3WYOAZyPjCPNh3EgkZS0GPpgVfZXw?=
 =?us-ascii?Q?rmprtEiNTqiI9J5/pfFWYdKMX6Z8Sw5UOHDxiQqO0BgpwZPhlT3w5sLCkBhn?=
 =?us-ascii?Q?TBPROyQ3BJ58AqiTbMb2liqP88Ox++JJkTQfSR0dP7EP/DZbyVPJ8R/6gtDk?=
 =?us-ascii?Q?STcGJl4GycMuFQtecuI6F1VUtxLsfqb4DEvh2IinWSvdB4hyeTmYMdSfT7e4?=
 =?us-ascii?Q?Pd3VrdIXGzhxRYo/cupXlqA4GW7m6SMJcAUE89zt87jGHlgto+lkgomH9gvc?=
 =?us-ascii?Q?Z91XIL1p3VJGjwkD0ziLT2IVyBmlx3d32WDU4S38Y+5xL5MLVarX3sqT9zgV?=
 =?us-ascii?Q?kE/os7ZZOBXN0V5B4hrQgdr1OG9Apeik8CWkrql7nHFVSOlMsC17bdO2fMl6?=
 =?us-ascii?Q?6a2kimNu7oFfTNgfXyNI0/RiKu0n1pPO9Px8O+Kc+XbF3xMJgHmn5qN1sidr?=
 =?us-ascii?Q?T72YF3TYDl7Nk8t9Jmph82sIL/EjWUwIfjYt1tzqq0L3rST9JkBCa6WMQSdU?=
 =?us-ascii?Q?MHoQLKASEnmKpECmMbaB6u/Zpv+yJWKzi8KdlqSAMxb2ttiv2iDFDepxxzTS?=
 =?us-ascii?Q?KgpbAavrpyL7H0GMM4pvjTXUZ3qI3fstaGg2qJbprEVPzXox1cONZAzA8+3i?=
 =?us-ascii?Q?T1s07j6vaMnQyb0yghMV/f0KjwJp0ngakK3e8hcWS0x2iZb856SZ3+xQWSER?=
 =?us-ascii?Q?UjA8YZe6rcRWH0JxB4xAD863E+e6enhIRLzXRwXzzhAXB3wUO+MnhGjmXzqW?=
 =?us-ascii?Q?rg7PgT8KDstO3XXTZ8jJcQ+Mzdnbe0XHBX03+vGT7+/TaP52AXcEjoZF5vcx?=
 =?us-ascii?Q?CdMpq1AJ1jEOI9g0AQn5y8DACOw8jzyUlq1u4XyRm6i56JhTCqia3SkHxhpq?=
 =?us-ascii?Q?RTUrR8F7ZWFnqOJAftJC4e+NeNi7GyMwPAuxeCPns1axHlCn87ui7mN21Adl?=
 =?us-ascii?Q?VYqtEFidkyeL/mAzD3Ph9fDBw+hxHls+LjGLJTH7onmX+A2blriJOLRezdtg?=
 =?us-ascii?Q?AAIiGC4Ak+C8y8HtXL0OKVmwzSLySZCx?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yyaTxe8NbDrhAoPSAlZF/IK5t0qUR32EfOcLzR8d3VIV/2fVrOv+tJTLCHUv?=
 =?us-ascii?Q?4Z6ESUa4psMz9tyvC9s3YqLl/5qcUeTiGQn4yCv/4iTkTOECEs3q+13Sp4G6?=
 =?us-ascii?Q?wJFgSwoZv6aWFe/nVgTqL8/T6Pw8dGTa80HnL9tTI8tcUNHkA2k+0OHU72TY?=
 =?us-ascii?Q?Eu8Ue7gdODQrtqOGzUmN33nPdGwmGH78MwnsFZd5fbCWXJ899ZgAhuw95uYC?=
 =?us-ascii?Q?yEWHif7yPNZe9z27IPvqwtarx2zszwywGVB5xAJRv7dtHzf/k/NfBwM0LXxL?=
 =?us-ascii?Q?PJ9lSPc6x6tTCTYcnBZ91/QU890I9hW4RUkBICTbFB2AsWyGglCyiD5BExMD?=
 =?us-ascii?Q?fiChiaNLcwyRobCiE4jvsgBFNCmyBOi2a1SIPWVpxRQxoBz1fPTxT/bn1qnw?=
 =?us-ascii?Q?uy9MOQ+/FuHep2bVaQHeyXsjARA8jtJu2rvC4dTaYiB2Nxa/IbDARqBQihMO?=
 =?us-ascii?Q?Oe2Mc3a9oHbxFj6Ok+2+3apLBzNvBQPHPzw6m7led4UYbJPUaByvU17bNcUq?=
 =?us-ascii?Q?NzQRACLJIFr1wW940b+iezaIPU+YtRUAIC9rVlC+MtvpNW3frKRuftmvuhTd?=
 =?us-ascii?Q?B+DFuASuYVJcQavHeeBYALWY8zd1BdUWkTNd+gNIhEQKwmXAwOmHX3hR5rGf?=
 =?us-ascii?Q?mbRm0Ewsy9QYkngYkPcwoO/azjNpWmaTrMKYMhRTudalKoXOnRSVG0/xEnYU?=
 =?us-ascii?Q?VM7VAnrltVTpmCDJL0oG4NCvpxF6ad/pFOv3kKQYECRM0fMm8I+TWb8KVgCw?=
 =?us-ascii?Q?lNZG8955EGt+IcLtRnc8EWACEYhAasKpQoB7ttQI+BOyA8INrT7vSg8dxef+?=
 =?us-ascii?Q?+RF+7BZu51zQvaBCvCZr8clcXqj97pvrcMzKxikCJCXgodXaXvw+70yUgV4y?=
 =?us-ascii?Q?esULMrP9jSvsGuR5DpHkgmVbG3q7wYWtLaSW5eI9mxG1Xfar9GuhpxCtLWzs?=
 =?us-ascii?Q?l07ZYtM8r0mmZCBpcRKRLzSlGooDp/bcQIg+uhbVOmrL3pqeqPRzXV4ncwG6?=
 =?us-ascii?Q?wxSfGTcRzgYhj1KDiehBnFjrplNlFo/xMd0ayuv/SW6MbT1zgUSSOKBG09Ge?=
 =?us-ascii?Q?h61Exi4vHWyzacP059gu5TqwlNFiEz78erqU8ut6vu8782oXU759C5+qI9AJ?=
 =?us-ascii?Q?PuCldXwOW4W78ousWW0kbZxzQQ/JnkJbbOaIB27ErL+W6R0L4vgxLCgA3rOC?=
 =?us-ascii?Q?kIhXJRc3syGbRUxlB8mZlQb3E5C9mt8TPvUIiFle6H4yX8rInYOgpGn63++F?=
 =?us-ascii?Q?sUSVuLXgI1lTJZJj1KZwADOhK3EMyL7Uz2W1pXngoOcgL6nH+AHwhax2L8fM?=
 =?us-ascii?Q?AGnzh+JBKohtbsWigCKnj+G90HKYQwwYl2BbfGLB0EXod6Cx9pFrImIsO93F?=
 =?us-ascii?Q?3cGj1afhd/TQWvUu+6XRrBcknMEmDy0bKBWxPt0BFT+13s1Q5CqqxfGxs7E9?=
 =?us-ascii?Q?6tp2T6y0Ki4ioaiJ/4fGEXsZIeWFy/CIzCgyzLfIb6sXmMT3RcTKAnX9O5Ei?=
 =?us-ascii?Q?9Js8f/Gzqw/ilgwzxACc+U8hFpQGNVtu7bNvEFThkbxj3EllHNETul/6G6mW?=
 =?us-ascii?Q?gcu4WIMazhP1bPrQC+uF7lrTYUXni1OmWdslwnX5YExX/3XjeZyunLfwXT13?=
 =?us-ascii?Q?tm13mHvSecV6DDFxB4+BY4w=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700d3fc4-2c69-49cf-b486-08dd6867ba74
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:27.6490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJd1sEEd3KoarXfcoHqy3/YkCoPqFFrDHKHUqHawiAa8o9VYf3UrsRn4fFfFWGdr+H0VUqFNApFEvOzYALTwA7kQMLLQBmix6b4LfUuRdMOuCrx+deHnAfUY6tYPguoj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18323

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
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
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


