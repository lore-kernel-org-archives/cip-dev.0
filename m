Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96224C3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:31 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.36])
 by mx.groups.io with SMTP id smtpd.web10.49095.1743418044580660981
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pp1q40ww;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.36, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP9CiFffQZMDcmOxX0A1NrlHrBmwHFUNNZfpHDW1BRDmYtdUdP2LmCnGl+KZaDbXTj5O+gd07uB3aqXHc2vreibHcRABBazflxkl++WsEP3K7tPOyW5RTDU5WeP+h+uqaSq89aU/9IRcj3BPDU+G7J9pplFbSnvJPVZDLIug/Q1L3rJzYFrB1TPU1NvspUXSJ0/C9LwbJu0xj+lOv4cy4Zh6W1LxFcFMUiEMg1bcKUlba6QEe4/xuckUDtlCq83eIBOzfH4cGf05dUVwuZp0FS1T4JTIPfW1DuAa9LbCvqCZXRJ35yH7oFlcHAwi8xxns7chjMtNV87PLjn2XWhkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0/7KLxZti6jISaSed9ORyE7R2VKvapyRDlMc3YxaoQ=;
 b=h6E24+x6qAeyCNpXIiDdPrAfa8rRlzAoRXxU8B1ZSMc18ighBe0NutI0BaXZeYr4rOq9K7daksvB4edWWcXkjGPh9V4Smy/ho1xQXe6E8rzLYwdA1nJN/blxyWlYzN1pQ+DSOWMs5PH2CHqEaqWyYm0MCdDlDe4YveGt0S2/d19AJaJrqz1TuSUaSU19rmVz9h1y32t3sDhgR1fZP1C0gFyfL37bYMmcBm4l5c/JezYOF7AeSK04bSCdSyvaW3F1pr7+PwMCuJBqsEUE8HkikmkLeJsux+IfVJMwpxmhUzsKMrmvIJEp6XpduYoiJOLsMmFCB0S7RUcHHdPWP89ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0/7KLxZti6jISaSed9ORyE7R2VKvapyRDlMc3YxaoQ=;
 b=pp1q40wwRSoWErUx26baTMj7dgjifOHNGxZvH/puOfJ5tNu3L7ZfRrs8hJwU9y5TCBNk/2/HwkqIGu1V49xbUPtbopqPMXdo4zxcZ/dREOZoYE3SJT4HJki6ss3QaheoRLbvF5empwgBhkShhmXTCD0C6h3gj6GFy+cqpxGxVUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:47:22 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:22 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 37/43] pinctrl: renesas: rzg2l: Add support for configuring schmitt-trigger
Date: Mon, 31 Mar 2025 12:45:08 +0200
Message-ID: <20250331104514.79090-38-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY7PR01MB13744:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1e18c9-2c02-499f-9dbb-08dd70416abf
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7L6L39U9+V3eKEhAl1f0lWrZhkmK7fivOrqJ5XLBedyJuQD5E0O0xhCDmIMi?=
 =?us-ascii?Q?89Pl2R7ZczqnA0ZRBV4niZVnXac73Mqpp/YeTU9uR5zWgY+hdwG8mrJxLgyI?=
 =?us-ascii?Q?7iSoFpVE/u3MHxWBn4EDPCXSRkPfe4oTBJyQjgCnyNZwSWLFkCInoXyPY3Ue?=
 =?us-ascii?Q?6++V251iYwW6fGv5JxsHDd7vrXEHEYxfUR+CLMK8sl69OpMLwY0PqXNDfyMv?=
 =?us-ascii?Q?xKrxcBXyjyQz1mCJkBpxdhONOrt/vIdyiU2+woODRVlBmYIdyWJkj6RcMpb2?=
 =?us-ascii?Q?F9J8LCK4BK2kd/6fyGaOqK6PoerdvwsEexQmNwVijLr0SvgC7uZ/e+aE22br?=
 =?us-ascii?Q?qS1sj3h2gzaoN5obcBT+vE8CAtarhnMZaraxIOho4Ha6CeEsu+c49Kgqu/qd?=
 =?us-ascii?Q?aFDLFaujdlPVzP5OVn2Qr/oziNiBmo4HPB7XPhWa4vp2yOTCub4FTmGqnBaY?=
 =?us-ascii?Q?ARa+uBNmB3ZKdareD02pFl2VAiZILX7AmAJvmigmmSiJODjwZ1qhSIdrXMNE?=
 =?us-ascii?Q?xziwXyTUKK3bE8WkuwcUlejPlajo1SdrVeR/XwyWiNKKNdnFRHg1QsWaUUHI?=
 =?us-ascii?Q?LnFtCm283u6Ybh56DKaPuXbky89M/B6K1Oi3/iqg7QWtKSQBvdtLZTf4jUEm?=
 =?us-ascii?Q?Wv9jHYSOYWX3mEdIg1YRqbgqhkzoM7IaeUu0BLZZqTnUh9HpkgiWiX+qhBzE?=
 =?us-ascii?Q?J8jtyzSE191zp7gw89c8RUyLDE4P2Przsi03BRzWyycQqCyMHpLAbIzfZ0PL?=
 =?us-ascii?Q?/4mDTBwwCWu80/PxL7++OJC5l4X+eLKYelvhqwtnSXA7ojoK4ASnL5MBfoQf?=
 =?us-ascii?Q?sq9i94mnVMWbz6NdPVn2rlVqN3ZPZcwZZmBXENka1ELYmPvOotNi0llglaSc?=
 =?us-ascii?Q?Y0N1hkUd3WJ7+AWZ5f5tUhiEFu5uH23bjz5G3zKB2RFvyabsItLPc0tn4rwp?=
 =?us-ascii?Q?l7cjln1O3NI+B211qXJ5T5b1A+DquL5J/w5QRQ57JvZlKKWeO3S8WcMGSw8w?=
 =?us-ascii?Q?pnsRKS4lNBEmiHfrs8CbrjcV2rJX7JyvUf7isoIGNbBxbAmqwbB0u7YcMCVQ?=
 =?us-ascii?Q?Ir5fqsPWc5Nn4cOO/rtiknIsp8H5ZBxS5hN9r76mjGBPoR1rF+Q4Y/FA4U1Z?=
 =?us-ascii?Q?qtEjTzC9SJkCr0QWgVBZnaCB5enoYHrmQuUmV74+eReL5QXqTebe6fuNzsRf?=
 =?us-ascii?Q?RR8qafhdWe/cjmujWMirpHPpUb8RrNqV6AkzB5BGGwd9xnHsKQbKF5gVJJEQ?=
 =?us-ascii?Q?wIW1j4VJGnVfipm2XOC1M/FbzEyPuUj2wxm/L5Rh0Lje6ua7Lru7/YJolNdi?=
 =?us-ascii?Q?yckUsAzsrZPBDYMSRNl3xzIcFOLRP79Zwpl0dPSXmVXsEUs50EZ/Jwujac0e?=
 =?us-ascii?Q?1KKjQj8YQJcgLOunbRjKL4Oo/GK48Vo8hFpkhRAEWsy4hapn1SHnnQXUNEok?=
 =?us-ascii?Q?hHqupZ7vcWKkdWPLGQYN99o36GWlXwWt?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I6pidjruWmG3DI2FgJQcR4gXefLXgiVzUj9k/uMcCuboShRhqwsFmo04oBm5?=
 =?us-ascii?Q?Pxi+sKW4Qpq54z+7YBvCXbgN2ZN7tnEgqZe8+Dx+JOgXKudjBnZVVY2a1yhU?=
 =?us-ascii?Q?mxAeaEQOOE2o/Z2V6eMgm7LadVMmKqIBZCzFNoOkNJNwU5e7cHpBM7xrm0jZ?=
 =?us-ascii?Q?Bx9GsdQpBljWDhWllaF8GZhO4AKQtprqbG1lzj9FaPJ1Le/EJ+a6NhIzGtYT?=
 =?us-ascii?Q?Qv96y2vA/RuJXcPuUzbln435wBdk8RJI6/PZAn0AhwhZAQQFpuCUsBfXKVja?=
 =?us-ascii?Q?vbmrVsUegJY3QZZpHN5VNEF6LolCOQk/0V/CVKUahELKTaaDzXX0aWDZHIkT?=
 =?us-ascii?Q?gTvwo7omu35oQv5bp3RwaTsEtA6W7vVdyf/cGSR8AcXHJSXLlnzk7eDZCuSu?=
 =?us-ascii?Q?LBHUg7gkiUcvN0FqFqBi/eVZc/iv6KkGkTQHCgYUv9Cr56wNFA9n2KISXVcA?=
 =?us-ascii?Q?4lU8YACkcn67XipJFyG80vJGS9TD9zqqyxNjpLFgpl76yqRf6LGt9rZO2vS0?=
 =?us-ascii?Q?rPHT258tywthd3YkJjaBuhlaBQDMYow9cCL8yFO6RbiVXQzlqbiivgi/mNmU?=
 =?us-ascii?Q?4YrnkonI36EQtC3z3co2EQmUP5X2nk5OLbBuTVvWwo+sDq1GTNvYMn+TjZ7/?=
 =?us-ascii?Q?oc+8ACQoO7GdpbWec9gChuEGbC1M717wa7DFVZjgEVTCG3MbNP0lfBA8H4y1?=
 =?us-ascii?Q?8/xp4ozu1v32SHDYhg9rAwp9lS9fXa59c/K3J071gUm0Y+Yjrh6FLCH4LfWJ?=
 =?us-ascii?Q?nUiK9djODcCMY8NCeSEln/DOIHmI1QwgWU3yzxgZwlaeD6x+pUpobdi6kqAV?=
 =?us-ascii?Q?8IVspI+cTuntDqdgNt4b2K1afP+c6kEVII9P4DxXuDslJDxuS2pRz01Oq3u2?=
 =?us-ascii?Q?crXUphSsvWw3rFu0u8FVoP83E0KPYlsvWx72tQQY0yW+WDxS/MqwbIQat2UP?=
 =?us-ascii?Q?Rl3fBGUCTInB09vK1ALrFQ6vU5RU9Q6OanYv+SrF17gobd+iEZOm6EG4Ubu3?=
 =?us-ascii?Q?IREwfUkkBxw4FhsoqJXBhe3GocQ16KHwvrv2721M7OjZCDKgLXt+EKjs+PLl?=
 =?us-ascii?Q?0gY11A8Xi7/fCmZN9wQM21dOJCSFYq+ah65ct3Y7hA8IvdWuojgx8BoEFIfg?=
 =?us-ascii?Q?3HLHAHWerydHmYdYMESGwLCJ5G9EftQ759VBFwFGitorN9ZO0UwAkvvHtxy1?=
 =?us-ascii?Q?s1deMyggR94kKbF/N7+o0q6AbAi865nncvmqpBnhL0/AF+DzDWyxgi4fVWb2?=
 =?us-ascii?Q?Yt59g+Wnfz071v7wwi2tCEs6F1ydLp6lYO87ELdGR+9tXjjc39eVINXNRTHC?=
 =?us-ascii?Q?24lSIHFN9bfenHw6WYYM9hua+05lPt8HiKH/PfnKE1hDiYyNFHhAGGDN+hGE?=
 =?us-ascii?Q?6+87qhobV/SsgBjZUfnFkacR6y6z/KeRjk6TUSUK86gcDR2/+N49wqeQe6Hf?=
 =?us-ascii?Q?l1CCk3wYrkeQLzcV9NPDZbjF/5w7wzK2O7lLpCGtwR40ttC64Q9qMbSnBWeW?=
 =?us-ascii?Q?uDEZWMnK33ARIkIIEUs6ytLhoNGn22bmgOMKZBA7O+qnXreNBvxJVOrGMzxA?=
 =?us-ascii?Q?ilt77TfnOldifTZ8AxmFjNJxA0AsUQ+r9BmwVl0b1Z4Q0+ib0yZWnHMt3jGi?=
 =?us-ascii?Q?H/GHPJMGoBSwB2FKwiqpEDA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1e18c9-2c02-499f-9dbb-08dd70416abf
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:22.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygvAKQkY+8Kqv9DDSB3qM6IO9ALlPxiTNbdZNyMXZs0fsR82pJ7IIf22RpGKLMJ/KWqnx1Z+oIcvuDcTc0CHXUfqS/I5Mn0GedMzlkyab5VMfOmXDk4QK82O6b2+8gbY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18425

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 725933a54f718af5362ec39971b2933d8bdf6994 upstream.

Add support for configuring the multiplexed pins as schmitt-trigger
inputs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241004123658.764557-4-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 834fac5db21e0..36f1a82352fbb 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -139,6 +139,7 @@
 #define PUPD(off)		(0x1C00 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
 #define NOD(off)		(0x3000 + (off) * 8)
+#define SMT(off)		(0x3400 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
@@ -161,6 +162,7 @@
 #define SR_MASK			0x01
 #define PUPD_MASK		0x03
 #define NOD_MASK		0x01
+#define SMT_MASK		0x01
=20
 #define PM_INPUT		0x1
 #define PM_OUTPUT		0x2
@@ -1352,6 +1354,15 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_=
dev *pctldev,
 			return -EINVAL;
 		break;
=20
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		if (!(cfg & PIN_CFG_SMT))
+			return -EINVAL;
+
+		arg =3D rzg2l_read_pin_config(pctrl, SMT(off), bit, SMT_MASK);
+		if (!arg)
+			return -EINVAL;
+		break;
+
 	case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
 		if (!(cfg & PIN_CFG_IOLH_RZV2H))
 			return -EINVAL;
@@ -1490,6 +1501,13 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_=
dev *pctldev,
 					     param =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAIN ? 1 : 0);
 			break;
=20
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+			if (!(cfg & PIN_CFG_SMT))
+				return -EINVAL;
+
+			rzg2l_rmw_pin_config(pctrl, SMT(off), bit, SMT_MASK, arg);
+			break;
+
 		case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
 			if (!(cfg & PIN_CFG_IOLH_RZV2H))
 				return -EINVAL;
--=20
2.43.0


