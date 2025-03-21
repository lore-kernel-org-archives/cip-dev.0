Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58E4C35FFF
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:39 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.42])
 by mx.groups.io with SMTP id smtpd.web11.18715.1742554895230483034
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pyHYOkYx;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.42, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpvKFrHhODPhVd92JDL5xiArIHGiVxzN+aPBhtNG5jrjzvz41OUUPOdTTbQihiIHYuIK7i9Zw9k4DBAOgQNs4kLZTh9ZjXZnQxUlsnzdOXAwtd03HS4kJttXydgzsxq8syC9HlSlKKveGkLDpvxicINF09FJQ7vtesRDROgftSrIk8krnol2TF6O4wSfT70oO33VA+X0YdowuCFaTmZeMp2YwOW8bAZEEP9LqQr75DRkjGrnVKhOJ0YY0VhaAm+QppoQJV40efm/2QeR/aOlmMVY5d1c5fG3Y0fC4ePKdd0l+Ktpsr7A35+ER7sqE27SWUB8fghEwMdjhIFyCmsi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=140DAkzacGZNwLmBASchubsmPQ3k6Swv6UNCk5+h8tg=;
 b=fmLqi4sMF6npcAhlXAQJmK+IHDy2zDqN5QqO6MDh1646KNFW/lH66gb0hFTiyXvZKqELWzkNJOq6RyZORVbMiEeCWqoEAYYQbEnv+g86XzeXljXDZeTgcnD59maZXnaKe5nbPjCxyyiPZxLEOcgnV0Q7MSrqEfTjw3HDNYvEtE/syIBvzN3Vuergk9RFSe3FTzIPO8zdE6kzJ9RLNApB0mjIKOJaMXlbRyc1SbSdWlYxOibyaEbHb6bDR07XjnZVSiAQbzAHy2JpKmkMJULSTL46Cd4MzlRaCgnAFSqpxysp/ipBecbND2W2T7/o1N2fGi5iJvZ9JnXKsI28iFmPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=140DAkzacGZNwLmBASchubsmPQ3k6Swv6UNCk5+h8tg=;
 b=pyHYOkYx4DYpH1oqmAw6OQn2QDHSMRk5HvqpVVFuJ+W92s+N9oOBWSJcL98uKXPSvnllsoDi/Pk08XJZKJV2VT8a96fI3z5vUaaQy7cbS+JEL5xNFC3xVQdOOfZH2ohMvBsx0eEjCYmfjh+whuaWKROcER0uk97D+jEyAoeL5nY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB8652.jpnprd01.prod.outlook.com (2603:1096:604:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:33 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:33 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 18/21] arm64: dts: renesas: Add initial support for RZ/G3E SMARC SoM
Date: Fri, 21 Mar 2025 12:00:18 +0100
Message-ID: <20250321110021.3612805-19-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: d36c61d9-9daa-4193-feee-08dd6867bdc9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?T0tggrv6/PxuP1/NImquwTHfLlovZ1EMp0ZofnEAFIhX601bxmrZXlDyisLf?=
 =?us-ascii?Q?IDNiEWKbVqgQqJDNbKKhJAlShUnKLVoSj8K7iym6oNtW8hyteov1sowp7tzd?=
 =?us-ascii?Q?n50zaqfZikiUd4ZStxwL8PQ3oJuTPy08WmvHoODWC405+ZSku1CX94VkpCVH?=
 =?us-ascii?Q?c3Me5XfhEi0J5r4xr1Emi1SVl0znEhFaUi6Ztm4mZzJChMPvU/kCQJWGGO2N?=
 =?us-ascii?Q?/eenYn+d8V/IMNuRyD94W30sAiPI1R4reHEmSFsnsYqSFSrGEXty7ZaP9VMC?=
 =?us-ascii?Q?2gab3IZZ5C5QO3ftmaK7sY6M4lppU7lHij+P13fxQlLbBZCVlqdZIAwdl9A7?=
 =?us-ascii?Q?8onUGMzufzct+td+wytrN6xh64HaLRH/oOCQQiLGDWp21AMJlvQFRrN/Ro/5?=
 =?us-ascii?Q?obcnfPxugflzqudh1WkTRhtWzcW7+oauOjo1lnEaDK8I8hvDoFxPxcXIh1iq?=
 =?us-ascii?Q?zn4n8NXS+D1uCdknYxEn5jGXIVWPtpH1x25Dye0H34+npskkoA8rZiUcIaop?=
 =?us-ascii?Q?Xj1WALhhunb8ei3M6YhCbv68GoJArXvajTThouRs8CdOlRW9Wl0HmdizKnXL?=
 =?us-ascii?Q?Jb+6NQirzmBCFRiv/I2PFQOBjbyy46w05fygUxFviPc9WNvPDctqjxV/q+g/?=
 =?us-ascii?Q?Ih7vqaRL9eo0F8P90Pfv/4ZtbaFZfpaTOyrY5Ig0wnGypuWhcnxhx+BXynEP?=
 =?us-ascii?Q?ktMjrizwJ2rnfmvcdRSRFoMNk6Ln/SPZDfgFKGvoOS2VwA8OI/62s2tYGRZd?=
 =?us-ascii?Q?QveE2oEI0otp4QizPOM6rrsunsDBTDmsc4xpK8W2aL4Ldxr8kI7H8/bAGJy7?=
 =?us-ascii?Q?cj2D7XL+S0x+57SMar2PWEVojBP50JFOo/GecUZz9t25L1KoFxO+UUl9DxzQ?=
 =?us-ascii?Q?fq07Zd0WZJ78sHuXO4jG7/uSvVM3GMP9MIda2P0QZuCgeG+jUpy31IuJRJSU?=
 =?us-ascii?Q?uqNBsGo7fQ9snRQkDVumsmtQ3AjdkdlAQTRYym07/B7WkGPwklRx0IBb1Khd?=
 =?us-ascii?Q?Uh9AAt39lGC+4vtlqgxc16bYcvge4K5ngmycnG5DloEzEuOfUNNGnAdzPZVq?=
 =?us-ascii?Q?+45reektLqh4q723cTtWaYoT4AGf0n+XGpPAFMDYDmKsYU9tBbVQLNDGWHvf?=
 =?us-ascii?Q?681PYF+L/8Uk2IwOOePlcr+MCAIVrTK/0gbX0YnBcOOLuzgaPOQ3mA44xmJ1?=
 =?us-ascii?Q?4WJaSI5ho2sFYnXX0KL8L+NKVu6B1wHoUjPh5k77LFujSPqiSlcjsx4wzs8I?=
 =?us-ascii?Q?6E3pi4/4gE3NHHKsg43u3BT8vNSthEIuWjuzs82de6Eb0+fJZT3m2VU8gY0S?=
 =?us-ascii?Q?sDmHFZdypStwmyMs8YEx0eG7NNUcUro9RMQUoFi0wX7JpfXyaCZmG5u8Rkmq?=
 =?us-ascii?Q?s1D/4H8bnNjAG0Xgndrd+6LTETMFE61XayZQiPQzC0vUdvs/FrLpHTz9w/I9?=
 =?us-ascii?Q?R8ULOED0fiH26bOoHqxKD4OPY/ywObEW?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+FHAm88qwEens9Pb9e/7dCtX9tnhhGMUjTEMNhQGocEElrpCWKcomA4cGfKM?=
 =?us-ascii?Q?ydgrnL3IYilc3rLbfmmlmMzNRVQKmZPLL7WefH/ZUd3JsF2LqsGubnU6JW8Z?=
 =?us-ascii?Q?CvTx1DZJaQC9pFJhrY/zYE0U/99slGKAPQkwVDDHRX2LpkCIWRloE/y0YIXK?=
 =?us-ascii?Q?puaNd8qKOOucM13CRFMHWB4k2h7pMHLih1Idt8n2YuAKWOfGZ9APu6EdoPG+?=
 =?us-ascii?Q?QY7wBF0lMgmD9+lN/O6cKqhDWr6PjQzS1aFeQdJmbcxR6CNJqQimzyCiJMFh?=
 =?us-ascii?Q?fd+wIXW3wt42z6hCCsjRKJsebHFAgyz/6Ci4D3T1bTW3MDIffAeUGxEM+w3Z?=
 =?us-ascii?Q?gTNan40HFKfsEeC/6HzrwPtCfz4DjGEkvueQEMQbDc7MWv+gAUmyOmKq73JM?=
 =?us-ascii?Q?upAPl21uADwwu2QstDImDGp34vZ05xA/bKulWsSCfIpPLMCY4cC6PGbB2rUt?=
 =?us-ascii?Q?Nhqv8Ub9dUDFNZUuy7I+7xxiYh5fMiYT414/RIexnwcbEnO7jWm6+ZbVTT0w?=
 =?us-ascii?Q?eAb+Foy77Nd5+ctAEDeqAmZXnCpGpJeNyr4tI9g6eMR/jZTc90IXMd2XIgdX?=
 =?us-ascii?Q?2NJcg1jkdVFyxXH3q8ca32i44GmkS71nvbfR0geObEExiHPFYQ+J5DKJDNLo?=
 =?us-ascii?Q?Hmv72I+CCFH7ayKfGIvllzxWce6ZaKQVFOdRpB8WyaBBrZ3ZU0kdjf+QAZeS?=
 =?us-ascii?Q?sT0XziVD2GJsrpYw3E5r0aVW2xVOXa2lLwOZJXmxsFIrFk407oWq2SgkXqSZ?=
 =?us-ascii?Q?DXhEp3QkLC8+xdr2RiS6YTfpI+HwBBXJM9wD1eh2HFntv1WyewPyM2WOT19G?=
 =?us-ascii?Q?BMC62yLWi+zieidQ7SpMatpBqK7LYvxoFPdjewlCVLxq+dYH6LoHdlYPMbXV?=
 =?us-ascii?Q?FvCo0M+J1mUnCxiljPcnQYwVyjSj+H1dEY5QcDF4AA7Uc/HmxNn/ok7NT9yi?=
 =?us-ascii?Q?3hiZJC5fwleJg5xUlWHAv6++ZM7G8zGsIz8WAoOn+FJn2EZvJADFgcmznWzu?=
 =?us-ascii?Q?wAOmuCYVxCHMjjBsEwIhbnym0m/pnWT9Olss4JOKpzGA76shQgZn9Dw3R5Aj?=
 =?us-ascii?Q?HgpMi4hLs/V5LOGGcdzvFvrPuJ1nlO9jmfHOUq0kZbck+3Q7wXMAyQosMpEP?=
 =?us-ascii?Q?fpp1n7/JJTBcjxFE7OtWmhqzAecYKaxE3ctn+RBmAyetG+gvDKsKp5hiSiUv?=
 =?us-ascii?Q?6v5jVuqmMYdKeIpcWGldC6QuADgZANZtOueWjNY96Q9ZLw8Vs2bXC3DptWfr?=
 =?us-ascii?Q?HXUwRCidR41X7vjjARX85SOUARhq3eQeHogK13F2dJvqjmsQArAVgeMVM9+5?=
 =?us-ascii?Q?IQBahMdea6S/+QlFOkXX+tKFAz01jEm1zQJESjtx284rYl5sIQTnv0el8TCL?=
 =?us-ascii?Q?6ouAApNZ9wQ7GzfiVuqiB+tWI7yiAMs+paL+ig1dqFltokjGxzhIfLMBIMN5?=
 =?us-ascii?Q?zC2RHCmXJnBJ9RbC1RQIjoe8NqPuA2MNale0FgsawSyvoRBhfVouo2axXMW7?=
 =?us-ascii?Q?vDZXntWoPxFoQqCcYux7mYafVI7du9veybRqnUolJRCb/fhs/621/WC6xLbY?=
 =?us-ascii?Q?6A2TiDplTLEg1RVIxoPaMouOvN0gNSoQDva+GOkJgCjjdp6FmNqhfZchYtKE?=
 =?us-ascii?Q?56WyS14eeIiIfxU7Gcpe9XI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36c61d9-9daa-4193-feee-08dd6867bdc9
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:33.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4myUyUohZGVLB25W/FSQOJzg9qaTFVGA4qjokcLS4eDalMFJeB7B4zHFW3KfN+h3mIRvtGC0ROk/1QdVClBCcJIHPyu7n1cFkxfkh8cARN+RoglaUfqV5i93dEQxiMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18325

From: Biju Das <biju.das.jz@bp.renesas.com>

commit e0379695728b0d79c20bc1a904bb4168d4f117c0 upstream.

Add initial support for the RZ/G3E SMARC SoM with 4GB memory,
audio_extal, qextal and rtxin clks.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-12-biju.das.jz@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
new file mode 100644
index 000000000000..6b583ae2ac52
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the R9A09G047E57 SMARC SoM board.
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+/ {
+	compatible =3D "renesas,rzg3e-smarcm", "renesas,r9a09g047e57", "renesas,r=
9a09g047";
+
+	memory@48000000 {
+		device_type =3D "memory";
+		/* First 128MB is reserved for secure area. */
+		reg =3D <0x0 0x48000000 0x0 0xf8000000>;
+	};
+};
+
+&audio_extal_clk {
+	clock-frequency =3D <48000000>;
+};
+
+&qextal_clk {
+	clock-frequency =3D <24000000>;
+};
+
+&rtxin_clk {
+	clock-frequency =3D <32768>;
+};
--=20
2.43.0


