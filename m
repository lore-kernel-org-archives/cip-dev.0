Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AC9C3600D
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:57:12 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.71])
 by mx.groups.io with SMTP id smtpd.web11.67730.1742914627157789679
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:57:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lgI2CJnK;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1W4rlGPDJfHpvhoS2NCHkC1erf+wiHp+8VqQje3Spck1Hk3oqB8O7xx31HNTWlV971yR5LY1UMTrWaUa/fPtSmD0joR8ypLU0ks1qz767WSkfUqECMqjwYYZqEXpB7BtV+UijJPDcJAJF1La2boAlVedVB4EtV/c0Rl25vhogzw1/hMCmupwfYXtJOmgiwmAzrOHLQDNKQXVd5Y40JZnA5XSm1nrZ9Z88qZ25VxWD23H3K9gnAwb4bnzA2ZFirj1Ac9hocy0aGPBUkM4NKg7QVT1esFqeAgFugj7dJIM4IFdGamK1dqZiErgHPDszEyA56e4AmvEiVtMI0GKFgXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vx2Vlf2lJGJRfQJKLAlqDv00QXzpN8a6zKMTdkxnwfw=;
 b=oxrgXDobB7Dkx3ViZpvVOtqaLOLP7DUWmWsidHZ5siTyjxWWXN5BEk0cS4uVZObbgnvyyNZvyrqR7wu8CUgOMXp5g93EwaD+THWNvyPyT0VfzZ++ak4O7d7EtZ4wty2RACXlo40eZRMD9K8sJmZVjwxloGh8alFGQua/fpn2GQeTwl9tjwjECIfWs/skBdzCocTqdnsddOxZE5D9Wq+J1+HxJtguXji3gB5iiIwpGsmNyt3uClVNLOKJaKgNR5Y9FQWcA3tCfbmx01SyD8yyL3+cjqDB+lYyZhLeIFKdpxictf38v//vIRzX8vmpknU41oFiXMmHomxayZCWyx4d6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vx2Vlf2lJGJRfQJKLAlqDv00QXzpN8a6zKMTdkxnwfw=;
 b=lgI2CJnKngG1DW9Mig/6wDO9zGfF0Ykys/pMl5RY1HiG7r4Cq0JwHAehDet0N6qazIJHALZ3UoGNXOV0pj4l9wr9YFJ6b8IKjJRsSPvtTRyz7CcOBgJZCbTmtHzS/kX5z+bm9eV3818fLqrZYp3RSQTgjoJWYkPvLygz7jPEpRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:57:05 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:57:05 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 11/16] arm64: dts: renesas: Add initial DTSI for RZ/G3E SoC
Date: Tue, 25 Mar 2025 15:56:05 +0100
Message-ID: <20250325145611.3595454-12-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 16b70231-df8f-4d58-6a12-08dd6bad4ea7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?r6GtXgVakgxc0S2i42/nQaBG5EcTeqBKQjhfUOEMk2Oq8RAB/t5N7eAcxUkm?=
 =?us-ascii?Q?lOSgpTF/kOzBN/OIfRYRFBcprv8i8Z2x4A+06HiNdyOb1Br/vTNm3EEUnr5P?=
 =?us-ascii?Q?Mktgbsm8qgrXtKWBn4m8kRqbtDu/1UXHrZMzGWzJ/ON0DFAwyJtRY5aZN+iV?=
 =?us-ascii?Q?FPoFNgF+wjbvYsqYMXzi2aW8cXH31IAZP9ReRtQNkC+L+39B/3W5OTxlaf05?=
 =?us-ascii?Q?J9un4cozk7LIXPQ6fr4sDfOTCmTuvNAgGhr3+h48ZJsFg6FbxKlJQtzuJ8TB?=
 =?us-ascii?Q?e7glFurRGJzqePv14++SRGsCSfS5ZIDk+38zlpzTfrZBIUbDZ8DYYRNazMll?=
 =?us-ascii?Q?S20MDhf/7om1PnDusYwbumlQQmnmzyucKftWtyiYODbsRpWJWxw/bxcL75nj?=
 =?us-ascii?Q?30Dv73465dlF8W+fwe/jphReSTtV08oeJC/fDRIVlSXB/XAgrneVM5TPu8pc?=
 =?us-ascii?Q?XqtrEyK6enpwxuGOtQJMOC4+G/YjUlLFkYeAX40R2u6b24Ntve1UOF894CH3?=
 =?us-ascii?Q?WTPP5cN77xELf1WsTk2QIrjTb1TUsz/7V2FL2cA3826k2SwFfUKBsDwUoMPN?=
 =?us-ascii?Q?QQcI8Bsk8Y6RPJymGzqzykPUZVIcKqQL+UqCAjkyCwEpvwA7CU+yLvE9/jne?=
 =?us-ascii?Q?lgPsQqVZrXabpyZF8Kr50kUFlnVoTnfonWhv7myKTDHOV6TnZMpmAxlaVlDb?=
 =?us-ascii?Q?GLLqzxeQaSC57pHrj7dSIJstN9sm2zn0CmFvNFTu0M1qZVSkXLLCuaDo8hCN?=
 =?us-ascii?Q?IUIx/nXN0VXfIHCZR+dv7KZSwZ5SpOEXzo93y+6UAfLvh3rG2zZnW8WjtiHN?=
 =?us-ascii?Q?0Y1jHjEju3VLUvYrAkik+oqUcB6Z9vKKTyV3ce7JXLLcjoVg/gFuiRTtqd0D?=
 =?us-ascii?Q?ngMpLATjUNyUHLjX/yeQ0JtEOBqIegodqxh8N7vvbB5c7A6feXeF63vcbYCb?=
 =?us-ascii?Q?wXmzoiOxhzGhDpGVYuY+8sbWJ4vScsBS2tyJ+U6h/Oxi3Vh6bK9IrlbSi1ME?=
 =?us-ascii?Q?MIPHSn8ujPqUIpWFXDox1j9jWNuY4hFah0jyLMS7FRv2QZAsasCcLFD13Tb0?=
 =?us-ascii?Q?u/KMA2/RDgv2hjGwsoPA5ImWfRw+wxxiCjRtBXSyoYwo+TuEjWJTkr8dQp9p?=
 =?us-ascii?Q?mnbWlq0yFkY41Lfxfie+npY0rRyLHjTbsr5WruXM1AMtYFEG69IqD78Xtdln?=
 =?us-ascii?Q?0eitSXcDPBSY4YOlIIsy0D1eGScM8vC1+YBCUW8NZSuR1QJZ7SCXss54xYvk?=
 =?us-ascii?Q?0cf7B+qtbGkyLkEUz24Qzi+r2zdDzc0GkLNsrEcwxBHA3CFdBLmneo2nfMyH?=
 =?us-ascii?Q?/+Z7xyMhhMPtL7oeS1McJbRA6vPnJPSgVhBHnsNBs/YCcJNAsHPq2qgNlGRu?=
 =?us-ascii?Q?95PPYbBR3CtJ5wA5bWIIXrqkLlRTKIyJwGcyNduhCBmCprnZc3zPLKsH5LKm?=
 =?us-ascii?Q?ylJhxNi3+/nN1LBUxE3CyZyKNLSabJEt?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?siYXvs9ZBkk/4oDtGEVDrUk1WRw7Kd9KhLo3UxizzKTN+eR9V/Gvg1UXYANg?=
 =?us-ascii?Q?galqPVRGrF98z9J0KNX6U1yLSd1UwY047UvIf6F6CwN6Dh60708QTrN+429Y?=
 =?us-ascii?Q?RQuAxqlG1I6zkvkFA4FmCCtymqkq7hanVfBTyXWVmDxH9gbHldCqo+pFIhaj?=
 =?us-ascii?Q?pulv1iYr+omT0VibLP5rLcCdePkclFvGzcmp/9g3a9y+4pFPtTLqqnpkT65f?=
 =?us-ascii?Q?j8S/ghxvKJdqDu83QKD7tQZVZ16n3Q/X4k4/Ik1aRb0y20vIQ8aTBt6JEvyL?=
 =?us-ascii?Q?RfUhYdthY5qIY7W62cWbCrU9m/dDJe6UFI6lJVjMqzVj6fZOH0+ZeDBQlydu?=
 =?us-ascii?Q?Jwvbq8LYRwCpXVfozmk6WjdRP9cF/qLgbgqHGy2lwIe9yAfTC32fUw0onpdD?=
 =?us-ascii?Q?nzciDOmge10pZHXr4ZX/pC22BW2jYVEg43uYaKxjiFdwPQO0IR/dXTA2YBFs?=
 =?us-ascii?Q?oW5ndRem2IeBgMjOQ0gNRNyRulKLqfVYzJWa/qzQuaHJO3IUXXlOeny3MQjg?=
 =?us-ascii?Q?9u65C4UGHYSnF/MBufLoCqp6mCF+1UhKgSDZfWgINxG4NzTP7Z6xXOEspbuY?=
 =?us-ascii?Q?BOUv55fnVmS9uiGCchTxViIfBpJIwogid8J8lYZwfdcGkQZyc8Sj5eJZ0tAG?=
 =?us-ascii?Q?ZVP0DMQoeI3gBgaPGVpcwKZX4JuGNuYNGrYBtB3jVFMkI28gz9Xb6W1S7CoA?=
 =?us-ascii?Q?sjGn8ZKwefxSyk5AkQBFJv0RNCLmZvt5yzu19qgkPYcK3C5Scv+OZ0wU+3qS?=
 =?us-ascii?Q?D9lZEj0yV1iJpIyhZ6tstXqBvS6pB356WE2vbFat/eLFU7q/lxNDO8WbkC30?=
 =?us-ascii?Q?D4pmIo8Wffnt9h0si5ixCq1QtwOi12c3OsRDbGS/fInzfCodpRq4ILNdNh3J?=
 =?us-ascii?Q?eXnjz/80qW4HsyagsCHUVMmjB8E2KSm2cYk7FiN79LRAbfvcpgx9fo7L9f+R?=
 =?us-ascii?Q?14EWhQ3UB5lZRBSx3eDprRZsYZNY5pbgEn4be3Nid351hiSb7VjcMUBoNXCr?=
 =?us-ascii?Q?4/qvti9nWAh6LedCGNunSh+EMGAIF78ylUbRS9SRe5F6Rirj+R0FeKmG5FI7?=
 =?us-ascii?Q?VMw1HpL4eFOKOjVEH7OJmu3SO4OVFP7ZFSQrUEtaWgLI/rjz5OINDZv4tk7e?=
 =?us-ascii?Q?U9IGT99Vfhz32vSo99tJqPSJe/aBsB7gmgwHJxMjDaeTz2rH0PwpLZGr/osb?=
 =?us-ascii?Q?zwm/wIu8bLFf+n2ze0lzaW0+efvK7XqR4pVwd2y6amOFZHAiH4OKmlXFJboi?=
 =?us-ascii?Q?1dLr8J/1fcDi3iyX8Xbluk+P9rZgnOsaowBUfnnKXaoeydPHtvP6FMArZ6FN?=
 =?us-ascii?Q?smJe561RcSQye4DCKsrY4Mo5Wb8Ca3LcLkUOhVDW2/DiZBBcJli2fNQzaRp+?=
 =?us-ascii?Q?nmPTxqU/6jnEfbJfcAUwaEyVKliaJgqsm4XexY8aGYPR1RtJf6tsXLB8lwNA?=
 =?us-ascii?Q?idfdNi7/ssqajBdkiyEbJIKagXnlF8E5xjcJaLW8Er/YBCx3ZW+GZjVVW72s?=
 =?us-ascii?Q?pCMATN+i4y5z+hhtXDK316r0IXyqJHTdVQEaEfMKR3wqXV5Oy/JPxr3ChAlL?=
 =?us-ascii?Q?KwTN5jb5yFSe9kgpYgNcMeHotA0SdtzoQvXdYxg0V0a9rxhkbM4+zdmezxv0?=
 =?us-ascii?Q?vQFEpHaf0y+I2WIiPU7MxZg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b70231-df8f-4d58-6a12-08dd6bad4ea7
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:57:05.2772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwzLRE0epBLlQeNaFUNaF8LoBFlIp2hqSuk3nOhZ72LbPrpGvj6B5neKspOKxLkzwqXwPHv06B5SD8sXkE1GdMesq0rCk2nsYDLM4bH1bN3pEW0jJKtW6yMD7BB79cQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:57:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18361

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
index 0000000000000..4176b9aa6892b
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
index 0000000000000..e50d9159e8324
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
index 0000000000000..98a5faebd47a6
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


