Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED57C36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:40:31 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.50])
 by mx.groups.io with SMTP id smtpd.web10.6121.1743752421978716939
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:40:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=L4Ftma51;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNhYvv6DKBQWIf44IydcT9njTd/7vi27HlfK+RgWa4zPljtPQaGVrxNSltCh0u3TvJGh3O3qnvFKTDcH443kQ/QHW7ryRXGu8RLIWDN7+XW4GD1/uBYw/XTHNVff2AkL+EiKhWytwSSf+rGERsIjgzxewYAj8V+92+UxM7SVT9tJO3z9LOpRJaBA+2qUbWazBn+ZT+Ug9pwSOXBz2iCywDLx7HdXTxKMn7gz/1N0XVGnq9F0zlNG0NKiCX0gw9Y26dt9VZloYTIvSnzemCaSDdSjjl8zAkGyoPjeuV+AObfwErkeGjghSObdzJR/H0Bdn/EvIaX8gJwtuSRD1gvmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTMKq5KHdTnXp8k8ahGo410NIFwTlUEzNKSJaCAshBc=;
 b=OyPW1RehsakMJsAupyrKb6Pktcect52H87EKk9oNe30WiwH5xIUznKxeDIarfznwC4h40QYquSjKKtoXYYnGW0WyJvO5vzDG7LAO30M5R8Gp8iME8uraPhfUiW7M9uuSTw1nJNBdGVERPrXKJEnPFWqfXorOHCsyyT8ot/mEufBJu63/6xb9cnWUP8PzrveSB+BZosZ1Sdk7NnYRkvMw7HLGrsqwmWX3bPNCHN0D8qDAhK57ykMKkdqMee6SNfDb6xm/cAKLsRKwFe75/1jgRQqwvgtszLgdw1wKikDM7Jss6tDjbQUp0Rot7f7eM/MG3t5T70jYwiBi5Se/O8Hq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTMKq5KHdTnXp8k8ahGo410NIFwTlUEzNKSJaCAshBc=;
 b=L4Ftma51e9AAxd9NneDTxUq5KTx53EV0Uvz5h3xr8ml03NtVBrs/FcKS4ZN1Wuw5oaqri5odf2COq2zTYMiJdPOjT7WyeGPermd/Agr/V1WSqRyAlT03DJcPRHJ2kI9RcIeCI1vLuOScv7tApz4zCcGD5lTHFV7pPyYxvnM2/EY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB11793.jpnprd01.prod.outlook.com (2603:1096:604:236::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Fri, 4 Apr
 2025 07:40:15 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:40:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 1/3] clk: renesas: r9a09g047: Add I2C clocks/resets
Date: Fri,  4 Apr 2025 09:39:52 +0200
Message-ID: <20250404073954.173387-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404073954.173387-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250404073954.173387-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB11793:EE_
X-MS-Office365-Filtering-Correlation-Id: 9918ab20-321b-4dab-81f5-08dd734bf0de
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2rTB9IMXep+sv/s1lr5qJbBqEd/ERC7HtnxkT9KIi+5V+I/dEq046Au4dpEu?=
 =?us-ascii?Q?KNx9v4Spf7Ci03rLUVAUCIsfe8PRe+ytE+bVb4WeZb+mvH8bHGKR29mWi7Od?=
 =?us-ascii?Q?c998lTzJ8/QYeKh5vtSC9cZroRtUIf29yC1JGD0FLTr60rIcd/O9gH/pmhsd?=
 =?us-ascii?Q?V3cAhQ1rKOt6j+Ah04moynGh6Lm7FKGyBZ0cZmSe4Psr370OsdttdRLIPkQf?=
 =?us-ascii?Q?8uY+77UOCuwoxr4hCk4Sa63RCAG65DhiEq5kcb+8Av6r9qfdalBMSMmEF/OP?=
 =?us-ascii?Q?W0aOg1UggoJMPizs+q5xGezP4/B2sti0rqx8e1sfjlolkwXNl6T26H2AUYnh?=
 =?us-ascii?Q?eP1+zaBn7YDXqo4qEWiFLpUoxlPSPgifCdD681e4vhbiWPCdNn636aVNEF3j?=
 =?us-ascii?Q?Sf4X3ssRObYJjQP0LgBV3yBDkZhaqzyGGszu+CrA+se1X24EQw3Un3xsyce2?=
 =?us-ascii?Q?50Ia9j1oDOdSfs9HiHnMNT5+MBBSi+Y7qEX1xhoMiG8Afz2he5EcHQnUz/gN?=
 =?us-ascii?Q?yyDEQDZisqyBIqPHHsQkpHukcdBvjrKVxM/NMoz5tVDjlbwxv/ZqFvTtxjnQ?=
 =?us-ascii?Q?Vdct0RFTrKem8mwLg/VvdUOdfEB/YhBFQw0kKWP1spcOm7xi+VXc26PhSCoA?=
 =?us-ascii?Q?JB5AL6EiHhYGGjz+Sq0lNkbsWbaH1L2jR8yoe+mhbmDUjnedBeXyflUZb3Ry?=
 =?us-ascii?Q?/hi71nO5K2CUjrJ+KJi2F1ZfhG9StL17llITEo6CxitOq0VAV3IIMjX+j4OT?=
 =?us-ascii?Q?gI71PVGwTtRF/gp5a0xAywyw0IbBU/6uEIq4uavQyB6ttKV/FBAbnRGP+Jwh?=
 =?us-ascii?Q?/guEB++ogHFq5B39XbWrkn5x58IAbWpvMXuTchHr4RdHIRAAx2Y1Mo35cdRA?=
 =?us-ascii?Q?/xFZhSSincn4yK19Q62TAf4PmeooaO24++qQxJ7uw+yki1z3D8/RKznAUzRd?=
 =?us-ascii?Q?RXRUGWDSV3IHT4eCPU0W5U/+NrrHjmiN3TKvtLcxMzZ67VMjEJSti+upr1ho?=
 =?us-ascii?Q?Gmv7BN4rI+1LA5cVnINNWvAiwQzG9HytTUMbbxrLIGlpCoeblyIY+GPQwlGm?=
 =?us-ascii?Q?BE+hXB0w4HGRqHWWN6R/wNBTrwoC+kmsx4AJTQ7P2S+LVSvtwxSsZ0UiFNYz?=
 =?us-ascii?Q?t1nKbIJSs62QQWaxn1QJ95d+1VMGIQlxl0wQ0ypLnSDOKBfgYvLDbB+AGUZm?=
 =?us-ascii?Q?dS3DX5YujF/XZDTyhYKKjPcfGV+OYyho/t7PzB3OJNkE34luIZT1ngoSFCVs?=
 =?us-ascii?Q?abue/G2H6f0qmZOkMUZiZy3RhDgz1e4rdTSOqasf6SkZjUMBVc7JL5aoQxRD?=
 =?us-ascii?Q?ForXqiAUhAM0HetrLurLH7XiIYto2hOsFTdCnDCLkLs2Wu+j5iv/AxTeWti4?=
 =?us-ascii?Q?EpefoarrmDEoSQmNr8vUa+ExBv3pxuZAokSz823FQiLqKXm6T7E87uLNptGh?=
 =?us-ascii?Q?z42neI1/rgf88ITU6IoX+6aAqxz5ZRTQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?l/ydgeHojeBNVZOsq8saPoLlrZAm/q4DAOmFrYY3wvsI0ITT3nSxLM2vzfMM?=
 =?us-ascii?Q?Hs61BAASYFQqlbGbj9422yOKQthMKSG4FHKmUB+AUThhiQYZvqkK6ncE10UJ?=
 =?us-ascii?Q?HdObpUVZ9Sn+QlV6p8Zi+VVKQo/oXikuEloCq5SDRbAs37WXWoLfP9FXLOkC?=
 =?us-ascii?Q?JgcfyVW/EhT3aXvqx0GknlpSZycaD+XPJnAz/X7ar1KEpyRtEG/1xwNpezX9?=
 =?us-ascii?Q?33JN/gFIFf/c7xTpLHsz1ePVUKfsyrkoDkbb8IpxClOOYiaF0pCktHGAHQwn?=
 =?us-ascii?Q?jDQgn79y1+ZHUVwUchcnfb8vURXLo4a/VtjEJAzsiNsagQI13a72qJQ+0Cem?=
 =?us-ascii?Q?TjXSjbS6agMgkMKaPCJOTcmeCJJjJGIXj3ZHFSb9VSj6w13iYWafWLOonOC2?=
 =?us-ascii?Q?Kvyq7Rthf67APRYtPbGfKGpEV9DL7+r9Gux1DdbyrZFe8Xhm4Cgd5rgrMT+w?=
 =?us-ascii?Q?vv/075BfWCS8y1wpe9Z8I/we507MXlsSqPWyf1gzlUSEp36DhJnURrRZOJXA?=
 =?us-ascii?Q?PAciQsXdVsaIEJJ6e4z+IGns4X3wOfGu6aeeiai/9uthqCZZGQpn3E5gsXuv?=
 =?us-ascii?Q?ZaEz6mvJFJ5fXYYKrYRix67SMDX2NUKy/9Jb7zHqUP7te+Bxz/oIZokHTx65?=
 =?us-ascii?Q?VeAMFjYwD3JGr+Eu7AXk0GmNpbx+6ve6mlbfYfrZaTIHa3jRuXldbeviKUGb?=
 =?us-ascii?Q?GEzCnfJBmroQe4ELOErBSeOIVmbbwJ5q3oE7JQnciVo2+7X4Yi5XadcU92W2?=
 =?us-ascii?Q?6TJgtIA1WdHMYx7E4zbl5+ep7QuOVedkvbJAcOnvNbNJN1hOg/gztiQ0XPDZ?=
 =?us-ascii?Q?lE2pIVmCv2cM0rU1phDZLxrfN0x72VVAb66qTugd5SgTodTGvRZy5IfKs5LK?=
 =?us-ascii?Q?e8LLepxGFKmQtYElgT31szRY+cgWbqk9JlDpPBcibbY+s+CdgDe00I14VJJl?=
 =?us-ascii?Q?esUipLkp8AsFukCPvNqAQC8GtHCqLQOQS475tija0M+4mkqdYYWrfEhdo2/t?=
 =?us-ascii?Q?ED4ndy9FXsHy5Q6GRA2rcauc+I2j4sYMuk3qM0/M/1x3Ri/UCvN3t3OS7YRi?=
 =?us-ascii?Q?ek6QraMiW15lfoP+VeWAob92E96J8ifzAr4ZmCp9IiybxYZY1UWtd7gfRx+/?=
 =?us-ascii?Q?Hl0knA82pVRDzXVJ+ChrlY0dHmJGadbR0Vu/q7iql72YDsBuroYV4nd8YvEg?=
 =?us-ascii?Q?aDsg4m/1tB32suH3/0jPqmWtT9o74Vzk18PQbRnwcxP5sBaZha6tCFwx3P27?=
 =?us-ascii?Q?xeC6EMmJPBjdy6t4QUyGCeVZ4wkY8FZ+e04kIa0WMj+14kJPBKmcyM2GRrpX?=
 =?us-ascii?Q?CoiNUzbdlDZP0gfF09Hs8ChA/Fwduztk5jiml7QIntGocczOpclJC5csktN4?=
 =?us-ascii?Q?D6ud4owHWnezaDKEdx8t0G/Vq1ngeIZR8qQlcf27RQNDiDykBf/Seed5+xSe?=
 =?us-ascii?Q?gvinqtwGfLihYsDC7QeDn59vf/DdOuaCrs+u0XQ6XxG3WW7wa9DzA7OF3/Wq?=
 =?us-ascii?Q?RX8/D0flA1T1X00Y6IWJxYDeWAG15Upvmbikjh32FzrRyt8QYrwUpRYB9wX5?=
 =?us-ascii?Q?fJFx0Q+Lb91/y91kaEA6eBEmVnl34cSFj/pG+6IStH11hdnopcdQEl/sBTas?=
 =?us-ascii?Q?GxlPmxtNx2vYh+ncEUtBDhY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9918ab20-321b-4dab-81f5-08dd734bf0de
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:40:15.8587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrPl4fU4aD6zUgT/ehM0YFuQ7kkTSy7VYRvWihUrbMrjA22zuThArdNrAU/oWJ4Wd50lNlRvyNf6KWuRVKE5p2C3AO5qvnC/DE0SrT0nwKxP2UQt1ZQsBo48TL9A+zho
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11793
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:40:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18475

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 29ebc6197403c643f389b59ba334e5bb53457103 upstream.

Add I2C{0..8} clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216120029.143944-3-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index f5966c08de417..536d922bed703 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -25,11 +25,13 @@ enum clk_ids {
=20
 	/* PLL Clocks */
 	CLK_PLLCM33,
+	CLK_PLLCLN,
 	CLK_PLLDTY,
 	CLK_PLLCA55,
=20
 	/* Internal Core Clocks */
 	CLK_PLLCM33_DIV16,
+	CLK_PLLCLN_DIV16,
 	CLK_PLLDTY_ACPU,
 	CLK_PLLDTY_ACPU_DIV4,
=20
@@ -62,12 +64,15 @@ static const struct cpg_core_clk r9a09g047_core_clks[] =
__initconst =3D {
=20
 	/* PLL Clocks */
 	DEF_FIXED(".pllcm33", CLK_PLLCM33, CLK_QEXTAL, 200, 3),
+	DEF_FIXED(".pllcln", CLK_PLLCLN, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
 	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
=20
 	/* Internal Core Clocks */
 	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
=20
+	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
+
 	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
 	DEF_FIXED(".plldty_acpu_div4", CLK_PLLDTY_ACPU_DIV4, CLK_PLLDTY_ACPU, 1, =
4),
=20
@@ -89,6 +94,24 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] _=
_initconst =3D {
 						BUS_MSTOP(3, BIT(5))),
 	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
 						BUS_MSTOP(3, BIT(14))),
+	DEF_MOD("riic_8_ckm",			CLK_PLLCM33_DIV16, 9, 3, 4, 19,
+						BUS_MSTOP(3, BIT(13))),
+	DEF_MOD("riic_0_ckm",			CLK_PLLCLN_DIV16, 9, 4, 4, 20,
+						BUS_MSTOP(1, BIT(1))),
+	DEF_MOD("riic_1_ckm",			CLK_PLLCLN_DIV16, 9, 5, 4, 21,
+						BUS_MSTOP(1, BIT(2))),
+	DEF_MOD("riic_2_ckm",			CLK_PLLCLN_DIV16, 9, 6, 4, 22,
+						BUS_MSTOP(1, BIT(3))),
+	DEF_MOD("riic_3_ckm",			CLK_PLLCLN_DIV16, 9, 7, 4, 23,
+						BUS_MSTOP(1, BIT(4))),
+	DEF_MOD("riic_4_ckm",			CLK_PLLCLN_DIV16, 9, 8, 4, 24,
+						BUS_MSTOP(1, BIT(5))),
+	DEF_MOD("riic_5_ckm",			CLK_PLLCLN_DIV16, 9, 9, 4, 25,
+						BUS_MSTOP(1, BIT(6))),
+	DEF_MOD("riic_6_ckm",			CLK_PLLCLN_DIV16, 9, 10, 4, 26,
+						BUS_MSTOP(1, BIT(7))),
+	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27,
+						BUS_MSTOP(1, BIT(8))),
 };
=20
 static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
@@ -96,6 +119,15 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
 	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
 	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
+	DEF_RST(9, 8, 4, 9),		/* RIIC_0_MRST */
+	DEF_RST(9, 9, 4, 10),		/* RIIC_1_MRST */
+	DEF_RST(9, 10, 4, 11),		/* RIIC_2_MRST */
+	DEF_RST(9, 11, 4, 12),		/* RIIC_3_MRST */
+	DEF_RST(9, 12, 4, 13),		/* RIIC_4_MRST */
+	DEF_RST(9, 13, 4, 14),		/* RIIC_5_MRST */
+	DEF_RST(9, 14, 4, 15),		/* RIIC_6_MRST */
+	DEF_RST(9, 15, 4, 16),		/* RIIC_7_MRST */
+	DEF_RST(10, 0, 4, 17),		/* RIIC_8_MRST */
 };
=20
 const struct rzv2h_cpg_info r9a09g047_cpg_info __initconst =3D {
--=20
2.43.0


