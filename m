Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC81CCF6AB4
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:30 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3043.1767864682139649004
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=QMoMdTAd;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.39, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNBLhwiwIr1b1KrESBVFrptfHv+Yf2OLQBZ/rqJ95yRhldREyR8vDAxe+9gPq+RK0s6VbwQ1AwjVu1VdOJcHQYtCtZ1VDoo8rtbUmTAi8emT/1uh82w8xGEVaLYMh/wMA0rx7O1g2MMIMxNVrrf+tzyXMRzHaAuavlR4QBcSuWr4qLBVEIWypYiLu6NifoOfiGPUbjse2FZeZTsIyr4VZIyjERhWFlOlrEFa2B/+zlYDTK+Lx/UVlf7qumbk2vuww4Xs6edy9udGFje5wIal+rEAUBTUDewntQtJz5amtM0Y22ofUOVt3Z30ADTXQqPoxQT2f8kAxDxG8crRnj8HKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6YWmqi08Pw31c3d9zkJz4g5JK1dU/2UrZ9Ukz2GNbg=;
 b=DMc9mAiDJ9eyAQcwfs+wVa9TWdYvKsp5Vfk10HLGvsf/VWTmnbpB+/2rEzlNktKzorPyhrcRBNBRg76jHrKL82OzViHv9Te97AhWSdkto2JZSZ+AuLRXyJk0AO0Ps0C7Eo1upZ9ISbW6wpK4y/ynRekkhkQMzqKsqLe0jMiu3K/Ftv6wzXWHm4S+5dcGQDJfCAHCMbpjo+fMnMrstWn7NrY45XPwE1Xidq+sMKQyrwXGxI1stCLxijqDUpko18s8VnAsB1m96LpWWGVA0JnlCAsn9KryXEP5hSOf9Dv6JLaOBse1qkYt5q49Y+PBfF1nRS+LP13PCDWxBh3535vWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6YWmqi08Pw31c3d9zkJz4g5JK1dU/2UrZ9Ukz2GNbg=;
 b=QMoMdTAdPcwM51hb6uCHs3e+pqDAViI+XpmD9hp5MZrXnZLrxKzgSNfgQ4EX2HyCO2Vg5ueRx8dfrExZwlNkB1TiJldV7TUxsLvZao81rjrxV/9Nrvh5zOa8zWe6ZHFRgE+4b1s71mTcEGStiYw4W6U5RT7htD1aOCZpmM4jsV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:31:19 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:19 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 12/19] clk: renesas: r9a09g047: Add I3C0 clocks and resets
Date: Thu,  8 Jan 2026 10:30:16 +0100
Message-ID: <20260108093023.489513-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB12872:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9ef604-9f5b-45c8-99c6-08de4e98addd
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?84m0lXXhfWjdTp41luYkDbt+8Rg4msQxqLobtp/xvgpm3PLtVUNdb1rbpOjr?=
 =?us-ascii?Q?SpFD54CV9LRaxtcEfhXOST5daRTO/dwTYsksQNjQsTxCyd8S2T7Wav3wTY7x?=
 =?us-ascii?Q?uh2g/NR/Pz5Wnf93Lao3JO3AJj7FUka/wcBaWGbmW08bhC1egxInshdOKT4c?=
 =?us-ascii?Q?4pBSZuOK8LHv1rckxAhtUknL+fkFMeBz9a93nE1R2BKcHZkUjfc3GgxZZfGU?=
 =?us-ascii?Q?p8k3snQop4w06Pg6hi4aGZOmDlXfKXizwo83WK9I5AUz6T+Sy1KubolbVla0?=
 =?us-ascii?Q?ntD7AYHUE+bmSHm0b9fMJlqicb8aYoweo/StJAEk1UfhmedSjmT0DRfN9p/n?=
 =?us-ascii?Q?YKgm9zOI8tmbBFArhOsdzsyAhAZKo3lUOSJKsoPjzsdVnt8OP7OQK7sICSn0?=
 =?us-ascii?Q?LDIEWC2ygCXIdD6uIaMuoZW2wFG8mg3hSmoGnJi3nShEnN/vpj8I4Joj78PQ?=
 =?us-ascii?Q?J87X7IbGihAbnfNdGp3+BRDpVXScqDgn7pTb0IIweis39QcXNWCUbxEngwf4?=
 =?us-ascii?Q?trQ1ARj6PwmhDeaJ+pvBWl8Ghd+LB36p/PmbLCrOp1rC04HJHpNILq2TZYxM?=
 =?us-ascii?Q?MiVweJjdgcTpVPDOqeig69sYK6frUoQz8S+FWRubbVQL7gUR8PFPcy+Bvfjp?=
 =?us-ascii?Q?UdoXVo+bCEmbjIMWXq/TEzsfwkb6rvM5iuEPBz3nQU22bhZ7DWUnlnXAyF7W?=
 =?us-ascii?Q?MZnDhMQ3oQxbCrjNRLgE1V4MFajHeF6i/C/k+SxnZHyMXOV/PD2XkJzdRb2Z?=
 =?us-ascii?Q?xA5rQZzlZ1plgGUq1kRr57SO1LzurUrcrD4hFoPAYB/ZGkPlVVE6E8WzGIhR?=
 =?us-ascii?Q?13BOB1XgpSqRXvCOcR51dN4ro7BcbqJbzr/o6JZYW2hYAF8N4BisX9OGri6V?=
 =?us-ascii?Q?jIPNgwBu9EGba5mccU2UcI93b+lC2WGV8OeFYh6x0PJHGQwpGJzNj1/cI8UO?=
 =?us-ascii?Q?YILN01yhYg7yDikE4PDVKytLku6RvbKTj6H/y2Wr+4v4QHRGC0FaEl0slNzz?=
 =?us-ascii?Q?1/CN1E8P0pmSybdG4w5R7mgTuDrCRkvSRv8qqOO9RkeUJ3xhLa/fNT4V47Ac?=
 =?us-ascii?Q?vaNBJ5bsghgBgZkQcfyahZ6FJ519cr1elCeyPekRjvZNsOZA8DlmAZozYH2e?=
 =?us-ascii?Q?C6DTBv/v6PgHlwjnlUB4kH2ivv8QftDTa1scTMciQV5PcDn7tSbp+JdLzTI7?=
 =?us-ascii?Q?NTfkzELnesLFCqHG9i+3sjhQq0I65xSbBF2N20srcyoD4S53lBjr4fnLWvQ6?=
 =?us-ascii?Q?/kM7JN9BbbNkMaYB3lgsFh5ffBaTInx0K+sgeZYIwMTqhLsmA/kvw+dh+Y8f?=
 =?us-ascii?Q?cBM6cQm5Mr5E0grQofAQiSq/XnDc/hLybimRXDPkc0bsN2Cn+3+aTlYQceZb?=
 =?us-ascii?Q?YTSMn/mcyvDx+h42VkrptXe2IoOEqjCAr80V5VYLjVZLnOFYE30RBcrUgrfM?=
 =?us-ascii?Q?ZvzQdZKyl6G10fxoJqT4hobvws/yiqodrBBGZE1rJ1MQowq3r7j1fg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jqJYt8OjHzjUHpzxFhTaclSP+qd6uL+kPqaEnYyHmCMos2mUot2sQuIuTHQ5?=
 =?us-ascii?Q?u2i7RHmF2QE+AyuFyCN/aPuD/4EXupLE5PYCOqlMC4ZPEdHptafWkXWtpPiV?=
 =?us-ascii?Q?pwWvPuGtHO5EzmvEuwqZADbT4Sr03YxSQqdMx7nVd86SFHyl29Xb+wnq0005?=
 =?us-ascii?Q?FfjD7VdyaaZBFxZWRYW4qbR5gEz5IkR/N96iwDJ0/hUtCXn009R7+WYOXCCp?=
 =?us-ascii?Q?O9PgPKjTsQ6G1BjjovHfvnv0J1cJODa8JoDDa9IB+lbvhP6mTWmzq3zFS9Ps?=
 =?us-ascii?Q?iaVnstKh8Wsy2yphcAvO4M6BC9XY7kfPPIxY8+RJW8LtISMkxxyzftDSnYQt?=
 =?us-ascii?Q?BMVXTTUfLRUTfcUcHh/9q4jKGHD/XfIN9YBJd4b1MnNXkKCBmoaoc0YrwEKl?=
 =?us-ascii?Q?fg5S+bnUGU3CK6yYaLcN9GW5Had0gnHNecXtOIXTL3khKnrKcCZxNAIUh39S?=
 =?us-ascii?Q?YOhjwMAVjbkfqthoQxx+KNvSOHE1y74FpjRGuq9P8m58owjg0CI/n1vY0nad?=
 =?us-ascii?Q?NmCEXi3occMm3V63yfzFnMmckMqc5GkCgjLOxJh0W97S16SQ5bukYlrE9JVJ?=
 =?us-ascii?Q?gthHlN+hwqrt7yf/ekuVgzCu2kOx5Yyxskg+x/Qx7sejfbcIomEL8fKTWQS+?=
 =?us-ascii?Q?ZRAuLQ2kkVbHgn1BkBxCx1/A0BEzi/6rNFCbLaDkFbfxU3TfM8qJfX5A/q2X?=
 =?us-ascii?Q?Xh5WHEgy8u+54CwFJ4cXAU8pcTPxvjEp71dHpDovhmGdAsMgFtwn0QPAtkcX?=
 =?us-ascii?Q?XArkf/E11EPsi8N2d0gyGdQoErYIGT1oSHsJhpPGeM1NWYOaoO2wOIei/DNS?=
 =?us-ascii?Q?EPZ/s3e/GyhaMf1l5oZSgf2UeyQgC6Iziq71Nq55u54gm+rDAcde/iEf+paO?=
 =?us-ascii?Q?JP8EyHWFTnR+Zc25YmTx2LA4/E2CATU71sGGUL6Ypy/XAJ+3hdrpNWq0ic2D?=
 =?us-ascii?Q?v35sYNnSC/JFHytsUcfvpK4/NLJnr8X73D7TbqTP7XYDECR6pD/DbV4Tj5Tf?=
 =?us-ascii?Q?Mh23fzUH3jlvLX6JBmLO6uJM7mkVpJ7V13wXkK+NcCSZXJmK0nnlph5oSv/T?=
 =?us-ascii?Q?aMxvYMtpnjH7FruFEZ+9D4EaV/FHrDD5ZDRAXmqKrKBDsQ5uSoyVVzZvqKgE?=
 =?us-ascii?Q?07K5L/OLrcynyzayFZ2gcu2fjOUjck4PO/+YGZV91HdC791QtlWI4YksI9JU?=
 =?us-ascii?Q?/aFMLl5swZF28NXBa0aRJ+KHqSMlkLhADskKXRlhO4K0fkQz7y1z0CJXyDN4?=
 =?us-ascii?Q?mPv3NKWWauK06FsN1KrRdiv+Spu3NU0ruySO/6Ubgj3b8LzOFnlPvCTouU0r?=
 =?us-ascii?Q?8+9haVAIivJNaPWPJp30B0VpkR+0Jdw7UEkT4RKkglM5W9DSgjTVlVzlKzJ8?=
 =?us-ascii?Q?1C30xXszW5//xWJLlAkytJtiR/c0E8lo9ljZpUEy4AgeyRkNIchSyQcuNwwH?=
 =?us-ascii?Q?NGHQraxlmPY37gz6rLIDenxFqnRvx6js194MPzuNFjK0zsP/yJieGMGvmyCS?=
 =?us-ascii?Q?Z7IS8kcjMiUapllTgXPYkNoVnbl5NYlxsNbm97FnLggyIR2KG5LVaJMEel/+?=
 =?us-ascii?Q?Axya4Q7mO3wYu0qPxdhizPHLPCc26R5SlnIzrZ6JCn9KI1HNw89OCUBxdJDE?=
 =?us-ascii?Q?O0awIISJg7YDn9o2kF1hpmj2Ym+xPnumbBFwtWO30zeWmW6VNRBBE05O22F0?=
 =?us-ascii?Q?Dt4pfhEXDk1LAvCvkDfdkaH5KTdl9MtwPOKwr6YYjdC8yfSadVjHf3SXlXLm?=
 =?us-ascii?Q?+2I0UE1Ls/+4P+NpmeeIqR4CRpR9luh7EC56dFCu5Zt8rTuG7NWp?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9ef604-9f5b-45c8-99c6-08de4e98addd
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:19.5086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKXslBhA1IQzRXo2BTGLIqdXPuQYxrvQE0X3v5oWI/z3o5keVCX9z6xlL/qRc8MI8tsu2wBJtxN6ePxSPLOQ7vF7SoWpkn4DOR5Gv0xy5OzB0aXSxIOAb7fH8AZ4wQ9Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21471

commit c939b63f44e50c3d2bd3790cddf07c3ef805ca5f upstream.

Add I3C0 clock and reset support to the Renesas RZ/G3E R9A09G047 CPG
driver.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250611093934.4208-3-wsa+renesas@sang-engine=
ering.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 281d19782409..26e2be7667eb 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -198,6 +198,12 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(5, BIT(13))),
 	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
 						BUS_MSTOP(3, BIT(14))),
+	DEF_MOD("i3c_0_pclkrw",			CLK_PLLCLN_DIV16, 9, 0, 4, 16,
+						BUS_MSTOP(10, BIT(15))),
+	DEF_MOD("i3c_0_pclk",			CLK_PLLCLN_DIV16, 9, 1, 4, 17,
+						BUS_MSTOP(10, BIT(15))),
+	DEF_MOD("i3c_0_tclk",			CLK_PLLCLN_DIV8, 9, 2, 4, 18,
+						BUS_MSTOP(10, BIT(15))),
 	DEF_MOD("riic_8_ckm",			CLK_PLLCM33_DIV16, 9, 3, 4, 19,
 						BUS_MSTOP(3, BIT(13))),
 	DEF_MOD("riic_0_ckm",			CLK_PLLCLN_DIV16, 9, 4, 4, 20,
@@ -301,6 +307,8 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
 	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
 	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
+	DEF_RST(9, 6, 4, 7),		/* I3C_0_PRESETN */
+	DEF_RST(9, 7, 4, 8),		/* I3C_0_TRESETN */
 	DEF_RST(9, 8, 4, 9),		/* RIIC_0_MRST */
 	DEF_RST(9, 9, 4, 10),		/* RIIC_1_MRST */
 	DEF_RST(9, 10, 4, 11),		/* RIIC_2_MRST */
--=20
2.43.0


