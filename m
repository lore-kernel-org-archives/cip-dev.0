Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C625FC35FF5
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:15 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.65])
 by mx.groups.io with SMTP id smtpd.web11.34831.1741778748388261134
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lh2mmhGb;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.65, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzGDUqUPRbQaJ/mAR/MEzP/gRjvLpAWB2hmitnq//kt9l1M3ZQQHNbdYBzfhSSBFHyM11bjVJc2OaZ0rreZl3VN3gv0rTBqShcIQVpgBiH8e3oNVJ0rwLFghmed9bB8oZiuGdkxmaVTTa8xzSeHAUXX86s9H/Ymi2rKrnxQZUgZtFwFOtVaTI+NDmZ0Slmt9hgyLD93WfUxbY+e4R4Cl151IPJ7BBwgviR7fbJ8G5Nq9z/bNb8vwRTCntxtaGBMkGgcrXKrMyne7BqWPuhsQqSnVX275XB02Jjw0exBAjanO2bHjg6UK14uujn7ZbjTQTGQljIfoHNmACYuwky7TcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gT+Qi69yh5hInJ3Dj9dJIy/nM9L4ipGR9bcR5XeSyk=;
 b=mWvu8Cyq6g1wWTn/Go0ipajoAy6VctUqaOJoSBdVdeeLJ8QmyB7wV3qccoi7bFtT9mvmynuuD44bUyHyZ1elfvn1FzgkfBop3750MSRK3vKz7HMRdeLddxGiMoDc9XE7oc9JnFwcNygDG+4xzFlqYlNfkUj9G3vdZG1h58cfaD2zc7GM5Km8jsOcJYwJ6pZ/tK0+E2sIK50BJfXzIEotK9K+Ad/mmkEbfO94oR7yjf17jynzai7vr9iPxsvqKb4T9zvXAnq8Br98BOXw9FAPk7mpILEScPQmZQB5fCtWq8TuX4xw882+tF9TDlyttNDWQpUuHo7CYQPV8gM2KTHSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gT+Qi69yh5hInJ3Dj9dJIy/nM9L4ipGR9bcR5XeSyk=;
 b=lh2mmhGbgiZ5Vj4rnZvpbbp8WxqJmyO8lHnT8OlycLfXbVSr0a0VV19MnLCOGvn2Ofk/Q1jyrD3EqBk3qf6ju6qlLuJ5EuDsgVz9l51TrrvkkCornB8CKVJQ/L5GKR4CV/K3oMbqmL1d0tBTb6JckOem2RaDsDV0gevIkH5IGAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:25:46 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:45 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 44/85] pinctrl: renesas: rzg2l: Move RZG2L_SINGLE_PIN definition to top of the file
Date: Wed, 12 Mar 2025 12:22:21 +0100
Message-ID: <20250312112302.1605750-45-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 160b4f23-989d-4b59-74ca-08dd6158a175
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hKE0xmGkFMy4iDsFxVNezgvMWHNgooGdKhBv3eDrVmuMs8rFBxcI+2YIF7n7?=
 =?us-ascii?Q?oaI67gtXB++TgHI6MLuvMLfa6nriQ8DGnlN3ec5Q2k/th1tf1gIh9ayX+J/G?=
 =?us-ascii?Q?IIz0iMHoIj4M8IaUXKzI5Ue3ItHkPj+d0Mma5XKhH7g9pjJx0cYJGMf7ofzP?=
 =?us-ascii?Q?mSLsawL8C6ujZ8CiKKmXQnz889CpbBA0SbVk+HXxIHelA5LStbIFkiHemf2w?=
 =?us-ascii?Q?urA2xMD8udEehEsdsO9EF+H1N93cvwYrrt1P8awf/jgowwnEnqfJnHwOyjZP?=
 =?us-ascii?Q?AXvRnFq1M2q00mzp3kcya5nxC3J26ueyKsnvIM93Q/XVf6A6YEmhKyUAjGfn?=
 =?us-ascii?Q?TCIAnvYoL/jPM6x48iQ4RvLW4F7hpEMjJ301dYSUkEPbF1ucrG6ohYCmE456?=
 =?us-ascii?Q?aHw5vmr3meJ8l0B60S15vqnPrrhno99BtWI5c9sfVPyWFVURsBqiVfmKsb8j?=
 =?us-ascii?Q?a3euzKV6d7/UKyGffdUkI+aC4e28Lmf99aWq3a6b7RROM090iWmFkY2uDMH8?=
 =?us-ascii?Q?EYqD2RIa6jqfOTC634SfXZ4BjG7lwmacRK3FRTku9mreHA7d6h+ME3IfH+v3?=
 =?us-ascii?Q?lvJUw6Z+5ac0oswAEdzyDYZx9unJuQvcF6LokGXsaKRcKFDu5k5NAVNa+Pei?=
 =?us-ascii?Q?6xZo0smm5MMYKtM67sZz71Bbirs88BwGOjibqCxeS6AA4RUI0LnaaUyxmTtT?=
 =?us-ascii?Q?Bt5JjXsbOWt1Fxf6NkC3P/egTnB38ArR7qMEPFJmGNKJfTtitMm/2s6+VYnC?=
 =?us-ascii?Q?fsuIrniUGDlEcaud59d78mcgEI3pbVr+puXNgJ/GPc0HsGOdzEvwrlIViKyJ?=
 =?us-ascii?Q?FvKcMJ31KZlWWHnZYtgX6xpAkv95qzMZSxk+RgsyvzNtcTmRePCk3k+gsbG3?=
 =?us-ascii?Q?MpoefLn9s/6jtWKj94FmSTNEygoXpYpmI+GagYnuhFd5FagOCRCfBASgipof?=
 =?us-ascii?Q?Va3rLvY3tqhykZkPtHJWl9Gk16awj5UkRdCu7d9zOk3esGxcYcydMBZxxv2l?=
 =?us-ascii?Q?BsF7W6EwoKZuFKpGet+M+AOrAxyAOPPktxQ9HqALTIzInQWVdNzJn/rtvAR5?=
 =?us-ascii?Q?F/ntdQn6vMmaydDAT3V5GsCEoqKaFyH1gCpW0RwuLbfANNka7qntaZwvDQKn?=
 =?us-ascii?Q?6eTojgfwpG+EWSLMvnhhF8tEnUmPQqVmT31ieQlHpId613/IIQlNfqJcuxYM?=
 =?us-ascii?Q?Oq4nE/Xk2FrMQAliQkYlke29MLtECWQxO0zeaK0j9Ud4/aVuUzuV8WxnxRpB?=
 =?us-ascii?Q?cuhzYk/GpXgBDHK8oK9o+VhsJi7cxJnXcEI2FsxUDOJie0TTZBgNY76QyI8A?=
 =?us-ascii?Q?uRDVchBYEK9VXhwXsSMV5SbjeJy6N/mQYQVsMYmp7LuEq3d+JZ2kYTcPBieP?=
 =?us-ascii?Q?Ul4FJkQP4jZ8N4met+Z/cj5xqo5LHUuNzwZ/icGU/Tqaod70MuGHDV2MeerD?=
 =?us-ascii?Q?On5RcYYpLqbAD689IGQUkqyF5ImszDS9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hDBVkhzjYYXLI2rCDsjj4PP4hjVRnSaIvLGOc3mcfVRinNjcpjOg3UH3tALK?=
 =?us-ascii?Q?3xpvNLOnlgm4G8/9LsBMreJMajICG3AFeHMmznIaZ7BTAJwv3CpJuhNnayBw?=
 =?us-ascii?Q?Toxbm7AVI0xCjkVV4TaQWF50hjxLVVjkssER8Vgpqu1E5gn84U9TdhYbr/zO?=
 =?us-ascii?Q?sPwFuBESm8GDHPdl1KnnFRkgQUTA7XskeY4awyb9MDbStRyxZ2iULw1JXZuQ?=
 =?us-ascii?Q?yhZMBZ6yv/8XaFMVGKME9XF8M59ZddqtKWOhEj+vPW5lt/cNTqBKDtkYiOw4?=
 =?us-ascii?Q?02Izs0mm04Y0lfuJxfXYLm4gXoUf1mRq2PNv/RYFt3WZafJhoGGJC29bB8dZ?=
 =?us-ascii?Q?6quMl45i80X+EuRo2g3RO7j2kGRU7hyOLGNf00Xo1WijcfdtC+Cbvq4ondQ6?=
 =?us-ascii?Q?uIFERt9JV28cOtRQKUNZGccP7En9dmrzevZ1I/2AbP6+l1ow5DO8sd8g1EtJ?=
 =?us-ascii?Q?12id/V0F8JolHVfOy1PkbCLx66cgpVUH82nmHqzbybLXLHJrCpqADpzGSdwj?=
 =?us-ascii?Q?lJW8UGYIm7HQk2bwU+u6lAM7MxUg/DKhd6ad6OuGQStW9bQQLD3HDztRv6mU?=
 =?us-ascii?Q?r3/m80+IGLDKDZzLUilP3SVpszcryVTHEhkbz6SdvFRkuUiioEiPT9M3IgOf?=
 =?us-ascii?Q?kNtKq0rnOK/iY3F2lXOnxmcjHJtD6IZkaIqxLzkZFEwJ8o7A2zTSme75fiNb?=
 =?us-ascii?Q?QNchudUUjZH6HtdQUN8hCFrZd2v72fPT4p/auFGaQ7mJZRJnp3cJ8zMGCm03?=
 =?us-ascii?Q?2SFGiCj4WhsAeckvc+XQk4aMNXUTCJzqmGr8mKKcVh9yINWMse3MpFYn4Hdv?=
 =?us-ascii?Q?MbGiFVkaGfmK+o0mn6Ja2pOEhVxddA2tD0ji6MxrJeSJJlvDWuc5LxIDOqC7?=
 =?us-ascii?Q?Q7fEwdclJtaMeu/EAjFre7wvClGNn6DB4QSWQ9BiCSIx9JNK/dDJlI7pAkqX?=
 =?us-ascii?Q?SnSxe1btrnRfn52vcMlGwaQgmP5UokwOcBXvEA6Yjo1ahTmfuL/8adEOtlff?=
 =?us-ascii?Q?fwggYJtqz1zNXnjIvcwcintAY4eHZWUOm9rD3IJZrhSYfYAnciYcjGph7KCr?=
 =?us-ascii?Q?zq4pprk9SiOfXIfs7Snv/6pDU4MS6n2YsTqRLAl9mim/SjQbkEG+2R/jOtZn?=
 =?us-ascii?Q?JxCS4jIaQH7WV02vcrIktmt/2QFtEmshmfZDVcNaypaS4nqc9tNwEIgUub9N?=
 =?us-ascii?Q?D6MgVX7bfeAx1smNp5wIIuis9YwEzPJJzJwUsIQAZmRYFrZ6bNI87ED9ujb8?=
 =?us-ascii?Q?+k5M5Zv7ofIyTtZh8+ogTjxDEq1AYdT7Rw/M1Dx2NrCIiZSoNAyv6WrSOqpv?=
 =?us-ascii?Q?sHsakaK+vT9ANAlFScDa92/iFTBuUKQm1/RNw/K5exlMS4J/Pip1Cydn8SFe?=
 =?us-ascii?Q?STuzCGss/olJ8OSyiQ2zIfW7KqoE4SZnGydqO5iQWPHqJgsC1RLvP+Wq0YPe?=
 =?us-ascii?Q?Z9eC2bED81c1S4GgVQawNGF6qgCllgJJStnMvhbpjbVxmqC9jro7tLsuT/PE?=
 =?us-ascii?Q?xR2lhjzVd9IYlIP8PH3aarT4i+K8NLidTIXSsDUjdLE1tR9Kshew7WKcJQZZ?=
 =?us-ascii?Q?srd4iKj7L01lgALqodvBp87kkPexPKRyRRrYE5JzjOHTCNXRi7LRhoa/y9hv?=
 =?us-ascii?Q?Y/ESMA1qldMZVEXevT7EG3c=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160b4f23-989d-4b59-74ca-08dd6158a175
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:45.6884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuM2/gARPNpk06YQWHDZnQk3/lPHpCSrWjdOxI0InGBaukoYvfluaPQP4XbtzfdRVpTyFjspS0FA3aPSqKgnky8nJTzWRzINdLRi/dnQqgMToqyxG3JioXxjXLqRNa2+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18136

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 13dcd63dc704b33a8ad94f1d161c0f5dad243a5b upstream.

Define `RZG2L_SINGLE_PIN` at the top of the file to clarify its use for
dedicated pins for improved readability.

While at it update the comment for `RZG2L_SINGLE_PIN_PACK` macro and place
it just above the macro for clarity.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20240618174831.415583-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 2a8223a9e226..d38df51c7118 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -63,6 +63,8 @@
 #define PIN_CFG_ELC			BIT(20)
 #define PIN_CFG_IOLH_RZV2H		BIT(21)
=20
+#define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
+
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
 					 PIN_CFG_PUPD | \
@@ -104,15 +106,13 @@
  */
 #define RZG2L_GPIO_PORT_PACK(n, a, f)	RZG2L_GPIO_PORT_SPARSE_PACK((1ULL <<=
 (n)) - 1, (a), (f))
=20
-/*
- * BIT(63) indicates dedicated pin, p is the register index while
- * referencing to SR/IEN/IOLH/FILxx registers, b is the register bits
- * (b * 8) and f is the pin configuration capabilities supported.
- */
-#define RZG2L_SINGLE_PIN		BIT_ULL(63)
 #define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK_ULL(62, 56)
 #define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK_ULL(55, 53)
-
+/*
+ * p is the register index while referencing to SR/IEN/IOLH/FILxx
+ * registers, b is the register bits (b * 8) and f is the pin
+ * configuration capabilities supported.
+ */
 #define RZG2L_SINGLE_PIN_PACK(p, b, f)	(RZG2L_SINGLE_PIN | \
 					 FIELD_PREP_CONST(RZG2L_SINGLE_PIN_INDEX_MASK, (p)) | \
 					 FIELD_PREP_CONST(RZG2L_SINGLE_PIN_BITS_MASK, (b)) | \
--=20
2.43.0


