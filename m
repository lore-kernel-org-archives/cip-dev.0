Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87269C36010
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:31 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.4])
 by mx.groups.io with SMTP id smtpd.web11.48843.1743418041468676049
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XVCEuAGZ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.4, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ao2d4MH36f77kHBit86laLcIMHdyyChT5vBVcTntbs8qNi2WA3rZRBVS2ipBgWXnwnrXPXVWazvUpuHXNaKsAoJ5xx7lOSlanOe5LYy3rwUgzlqkpj2euuosYGy1sIHJw8meOQMgAe+qfk06VSXOTL7jNgWhoinzITcidDZardxrJY+ZuNsQHjE5f/9vXH9lhDqJ5MFpjXOQVyaenuzs9xrE4L+33h4SqeWxeCC/ZwTqh9flxMHNqqI7VKlYj+y4/hzpGzN6JZJN0b15K+qcn28GZz2HHRyiV4f59PVvE4A2yYQKWLKFcsDHuUtNGMTxfo4OtWrWamd1N6JkV7Rvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/M5PUlzWT1upO5IfsQb3X9qTEXNnUFNLDqsBZjrecI=;
 b=pbdeXI/jy90MK9RyaORyxSJ1DPoQzKrZwajOZ0EpbJ6QizNa3nIqSJK09QXydQVa0+bE3RtqTmWlIrGvqUlC80/rZw2iPTTmRLMTdTfNDNY3W8qJMj+IwjwokO9vQ7jMYO9LJPyNrvYSiv/Dp6gaLo3LC1niqa/ThbfyjB0YpSqFWMAPJyLy4tZvfQtVJdy/7ISm7OgYuL486TKPA/uYe797zOxQjw/RK8YXsnpn00heKdDGdizQB22gSCMWny41FGONBZQJP1pXTk7CI+QZD2x5DAbqQgXPhwAtSqYWHz9jT0WqJZmXIie5JGValtlvliVv811YuEH+VojZQ6L8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/M5PUlzWT1upO5IfsQb3X9qTEXNnUFNLDqsBZjrecI=;
 b=XVCEuAGZdpuKNlE57zv9YHbr3XSSm9JLmZyihU5fV7y9icTjk/IUl/ykMVcDo2QWV2iL1xs4tEVmN95tDdLsxQ+BWl6s6NKK30+qZQwRhjCmG6Vfw2FWMnM714LLe55i6JGELJ7RV/ToUiffOkvwqFviLb3NLWbq2dVIQBAKkEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:47:19 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:19 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 36/43] pinctrl: renesas: rzg2l: Add support for enabling/disabling open-drain outputs
Date: Mon, 31 Mar 2025 12:45:07 +0200
Message-ID: <20250331104514.79090-37-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4a197bd7-c871-46db-0760-08dd704168ee
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bOrtHzeRMiP44m0R1otm3S3qV6mdVA83G6ReJZiP7df2xFF7oJsbB7p3L+Jh?=
 =?us-ascii?Q?G7tmxiZo08N6Skt0ZQrcu/HCvGGL4K6k4mnDID8TJAnWvv6/CreoK8wbWKSD?=
 =?us-ascii?Q?G4f+382ZgRAwT0Mf0zV3BeuYsLoex2zQyKFvqaxFbI9CMgAkx2QMZz2WEduW?=
 =?us-ascii?Q?31U76sRk/dTWf6JgSGDcNCXR+gA224gAQnr8LHAjs5eXVDtqDU/Vixqkyd2l?=
 =?us-ascii?Q?EX0z5z9AwLIdaKcTqW11p1rngti4sX0LSg47//ctiraK+js+NJZlmfrybrCQ?=
 =?us-ascii?Q?mI0MHU+txfQ6iMeyYQP612VzWzkUSta3YGYkBjqMbHJFHO9Ow2Ge39ug7gUP?=
 =?us-ascii?Q?eS3MH3yZxvQg0dEVjHrDbo55z8DAre/S6/6B6w5wm+JMgoLKlB7pk1VzdJmb?=
 =?us-ascii?Q?wny7lUd2QzN8BsGscUcBo6uSTkk1ASIgi0CTF66akC7zU0OaZX91stH2L3SL?=
 =?us-ascii?Q?EjMuGwDkrD38NLgVvoq2HPWU2NY4umRpIx+VG42JPYQq2B6FV9qaiT3YCL5Y?=
 =?us-ascii?Q?dzvdKHBEMsjXH4vR8Sr9ud/IqjgD4KSfdbz8UGMedBawVOxE+8inmkbZWJzs?=
 =?us-ascii?Q?m+Tg9aWDIlB4owbAitdD1DRg9MCMkok02N5hBQHqI9Bwo/Vzv9y2emBf0DuX?=
 =?us-ascii?Q?WlfkSTu6HL7po32c+C655fwTprsoK08wkxh63kEJHucQve2KOF6Qow0GWPRE?=
 =?us-ascii?Q?UTa1s5fjALbrnJ2ZNEn/ppvgXMVVCtiOflgbRtRodGIkfuaFzFPjTPcFINnL?=
 =?us-ascii?Q?WnDdTXFj8lH5kAgohtNL5w8Zf7AmUGoE+czjfHx10CpzEsgYnpQF4xzdUsu1?=
 =?us-ascii?Q?5zb/oSEisVq1NvLFGHlYRL2GmgnwCxjCgrtfBVPcAFFyF5fDbY0/679e7sg/?=
 =?us-ascii?Q?X+sSJx6qckWcVjhuAaH+6JAkr+WdmVpan2CU5wO5VGKWf9XKqFu2UEz+BmFp?=
 =?us-ascii?Q?Aji/C5SK9nfmuxMDQMJmjYhT9+UMoexUyAWE1NKOZ4EdndtznV0YPCLPV47o?=
 =?us-ascii?Q?v/gdBjVUluItd3X6UbScUfg79FsMkcxeq88d5yOgDayBIOntB6fJCaxiGUwu?=
 =?us-ascii?Q?LZSup6VrEg02gTRzSon/Yt9mqM9MiPlYKmkQakXFTmxqDKcBrRAxOgfehshh?=
 =?us-ascii?Q?f6+XZZVPL2pdBfyyCPU9riiWc1qOYoZ+/71R3QrWP+x9H8tS5B4nO2rw35Da?=
 =?us-ascii?Q?wO8+x6maejOsmvcAoeb8bdPwUFFWEYA1mrzU/9pJ+DGkljjsuOwjm6DRVBym?=
 =?us-ascii?Q?Y5d/tBxpibzy7A4pcOTsYj/SqAM3i12kVrYQ475Q3oV/NVkXpHioBHeuw7EY?=
 =?us-ascii?Q?Wk5cO1k9MR9yGJUG79TgLWacqYXofeK8Dlh1oOSVYPNG4YhKvNCG2BlbNEE0?=
 =?us-ascii?Q?9t8gE6lNMvBVbu8Pjm26qcsg4VSeUEdOEK/Hi6c8nLcl2ENis/aC6OUPAi7M?=
 =?us-ascii?Q?0B+/ggl1fpsK3Fu9XGYLQbGSi421F4/i?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?X//BSHHsuWquZ2DS2Qt4UVncmANJ+IQ+6FPtUaVVHE4pmrQvjWLt4dKs64HO?=
 =?us-ascii?Q?ic7yjJKnkIFOxQdZb+EWY3z16Ji/E+ddEGm8zsffUPe0bWCpdpWpcZ6ZbD2C?=
 =?us-ascii?Q?mlvasXdfLnWs61QJuGIChFXTBYmnSlEg4LjY1irudMHK9isz1QZYsj8vqJKZ?=
 =?us-ascii?Q?uAgZaCEtOJdO5Jhdb//CkUz+Z4JgceYATDXZoLRjoxJn1w/swU3Pxt0CPUbx?=
 =?us-ascii?Q?1GUQxluB8sG0G7KoVDcUm6ASkNfVoh8pAypx3f43kYSO1R5yXuavil36Zg5R?=
 =?us-ascii?Q?xaSQm7izUJ3Aku7eg9D98oxOXrKOBslqrh8CdztmSy2K/AGKV/YKLxf7ElO7?=
 =?us-ascii?Q?l1p65sLWalhvahp/CqAM4rOPxMxp3TbbbSbI5zHhpLmp4DZ9XBJRiQwsAke3?=
 =?us-ascii?Q?nq7bgz5tm1j49Dv/9RcoICBTirN/ozvHGUY3q5pHWGaO4RlBdLiEiShVi8n6?=
 =?us-ascii?Q?g/0shE6Z+YIztHkXXsuREoQkWu/0H64fLiPUXcrV8VS2qu/oR/UMWpR11lMF?=
 =?us-ascii?Q?BcKirS4l6nMfZByYTcuXhjaDTUH9XAP/w5HXzG3intOAMHOKCAC/GC23mGKT?=
 =?us-ascii?Q?aZS/do4P/AllXkN9RSGG94lio3KfOsKl+jmJ5tn3+/ZSjDvcuXvP8Y0JyCoG?=
 =?us-ascii?Q?hW6DQLUYsDsIupllKP+F2TpFt7qOITWb3ze577lIdgeevd9Q4x8Kq09lLqaN?=
 =?us-ascii?Q?IT1R5T33ttkvCWGHcuhQySjmKIK7NZ06t0fvHRk0l/2UIGqleA1rm23YPMBw?=
 =?us-ascii?Q?N5P/FhQnclO8nADpkUSnc1xQJPn5kYjsNaNXT0ypir/u5n87YhIWJDmQCzeB?=
 =?us-ascii?Q?BxsM5Qd9PFt1eRz1wv2fdLr7OfOcuE+zCHOO7qph8L2SjETCHDIWqmC3E/4R?=
 =?us-ascii?Q?qFtLczlDv+0fZCzebhDGGiNC6gh4CBQjvV7/LDKxB2LvnzHdxuQ5y9aGMMOU?=
 =?us-ascii?Q?Qy9WtxNFu2SgsmlekDv7yeWO2XbP3V4YclBmsBTsVSyrC+tITxFz/RVe8fZF?=
 =?us-ascii?Q?y9asD6acRMOak9ZY9otC105ngXKtVMdWPeDNzJmZNcHswCLLGAM5p/CKMLjd?=
 =?us-ascii?Q?sDWD3AccNGwBisKdOw2zleEZj/DIrpUzvbR2pK4q1S1is5UehgrZoAQyy2tB?=
 =?us-ascii?Q?p8A2U1Gb+U9F0pMlqXKkAgPQgS2yV87hYEc5OL5AHvxyExZ2zzQO/28XQBnx?=
 =?us-ascii?Q?NynAI7KLUFFD6j7dw5tsvG4IQqompvNiCO/81PpOfu3K0GU7YbvaWRmKU/Js?=
 =?us-ascii?Q?PBrw87A6r6HJC6cVd3xgze/S5hT03WI29U1pRlMsach30FwzSndxXrJB9QYr?=
 =?us-ascii?Q?3U2xQBoHNFZDBDq/pq/eUu1ESh8A4yqyXnEOT5sDMGM0aaz9odJ2tRyT1LTB?=
 =?us-ascii?Q?a/dUXWOsijcIm+oe7v0GFBNSQ2HdB3fKZEw3BC4pba5FYvT8LI1GIflFu0SY?=
 =?us-ascii?Q?87DsENENGbaVfJAsSRHl6iGo3f34xQ6QwFE56gQK6Tay3fmwFF3f0S3mRhau?=
 =?us-ascii?Q?9gyRZ1CP8NQTjtE338bmOWOLnlE/6DdOMLxCuBCV6dzEDHh5LKvSajvAV7Zc?=
 =?us-ascii?Q?qrGUdDRAv7aoxx/xyjl8iSgxzw47jNshJxpbmlvV43E9jbvikmC48t9BnTNB?=
 =?us-ascii?Q?mKmf67V9EKAHqwy0evEWE98=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a197bd7-c871-46db-0760-08dd704168ee
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:19.5619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCfV4q+UGze2Kvxqhp+2divrWTPUlB8xmSFqo/6FTv5Hi7Kl2tNqvB7n1O2ulb+k1zveSgO3SSGFKJ6pdSfdDkphbgmzA7Q+anY2GsRfn6G3WrF6gp7RmREWaSrqi6U2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18424

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9d75b70061917fbfe3247e2594879e5a14d3e24a upstream.

Add support for enabling and disabling open-drain outputs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241004123658.764557-3-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index c6ee32a7a9410..834fac5db21e0 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -138,6 +138,7 @@
 #define IEN(off)		(0x1800 + (off) * 8)
 #define PUPD(off)		(0x1C00 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
+#define NOD(off)		(0x3000 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
@@ -159,6 +160,7 @@
 #define IOLH_MASK		0x03
 #define SR_MASK			0x01
 #define PUPD_MASK		0x03
+#define NOD_MASK		0x01
=20
 #define PM_INPUT		0x1
 #define PM_OUTPUT		0x2
@@ -1338,6 +1340,18 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_=
dev *pctldev,
 		break;
 	}
=20
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (!(cfg & PIN_CFG_NOD))
+			return -EINVAL;
+
+		arg =3D rzg2l_read_pin_config(pctrl, NOD(off), bit, NOD_MASK);
+		if (!arg && param !=3D PIN_CONFIG_DRIVE_PUSH_PULL)
+			return -EINVAL;
+		if (arg && param !=3D PIN_CONFIG_DRIVE_OPEN_DRAIN)
+			return -EINVAL;
+		break;
+
 	case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
 		if (!(cfg & PIN_CFG_IOLH_RZV2H))
 			return -EINVAL;
@@ -1467,6 +1481,15 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_=
dev *pctldev,
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
=20
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		case PIN_CONFIG_DRIVE_PUSH_PULL:
+			if (!(cfg & PIN_CFG_NOD))
+				return -EINVAL;
+
+			rzg2l_rmw_pin_config(pctrl, NOD(off), bit, NOD_MASK,
+					     param =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAIN ? 1 : 0);
+			break;
+
 		case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
 			if (!(cfg & PIN_CFG_IOLH_RZV2H))
 				return -EINVAL;
--=20
2.43.0


