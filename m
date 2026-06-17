Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382D2CD98F0
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:35:36 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10818.1781685335021261913
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:35:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=eaKoTnmY;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNrBaqw3QV2uzV3ivOwYOFfooxNbEtdWplyZEX33EKHOX50i3oq+pMHGWlNXiuAit4yxNq7Un5cpGm4pLzijkgWq6nhG9FVfI0FYRrncQ8nxVYsmIgbSRMf8qD9yDiUbHlk/QaWYlQvSgO1pYrGLllenxdKnt622OOV2Vh7x/x615StTN68wQ9wwNjbcQDw+OMtadSTkbj7MiOah369F3dWZpp1WSoi4NcE+RpmPhmlytcN0tBAR6sJj6kMXic2bk2NUsGMZHoEUlLt+JAAb0ZyskP3eGh/lQIoLW8QWlB+Xts+NKIt2Adz/u9qw2pLDdsVDnPAawTUJ2IjgrXTp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry+LSIac4XMqWsV3cXSQxUfdAt2TsC2Z8/t3QOAE5as=;
 b=RuBQzJrzYLTqxXaul3RYmO75D31WrfZcxBMFEEKJxIkXjbLNKQoB6LFUKEUrxT/CRzuk6HhGKV5iR+4RoZNk5JLPVdw8ZyAU6POmhFEX4YB8s5/XTqQOwOyF+9PpqRay2yoRAq9TpkI6S9F8ieInjmoD//iSW5K87OndT3USsz5Nu8Ir7LFfPVaEM9vuZ57JNplE3jpgSMjgBNJf+Dvg3hB5aQEx3SIzjTtD+bacAxdUyKySAdni7oFrXwXobgtI/drM3kU2YRuhMEZyt/ppEzxR/wolZfj2MbVFv48piZS5Jbl0eIOBd9QIjz75eDTFsQdeQI7CFcZ6gT8Kng8sbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry+LSIac4XMqWsV3cXSQxUfdAt2TsC2Z8/t3QOAE5as=;
 b=eaKoTnmY/XEpq0GskJwGSRc8KzA9zvqX5K8bR9Dr8q8FDdL/ha9cTsAkAub+AOA/6Bamrrmn3pkG/YHjgmCJflSKtGB5vAhC96c4fAjyZkCkrDszl/JWBob38b+zj9gDlGGAJkgozJ6wWXMEyKrU8NUTaIUbbZzkxjEsKYBGMgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB13245.jpnprd01.prod.outlook.com (2603:1096:405:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:35:32 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:35:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 03/24] clk: renesas: r9a09g047: Add entries for the RSPIs
Date: Wed, 17 Jun 2026 10:34:41 +0200
Message-ID: <20260617083502.1074160-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYYPR01MB13245:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cb7018-d96e-49df-5419-08decc4b64e3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	t1Z4mVs/zA9q0Y1SG28ITPB151VReocd5oZh3k0q/OCW+dta6blX7r6eJ+nQnp4SEfVCJ3Bx/jHQoSDC3uwfkDmv4TmWfBCG4fDgn2IyHMpEhLB/Z8EdRwk0cyReKWcjitlG6XrAeE6tlBiT8T60NLVRIIX4toeJlay6G+bj2AjG322+GyElgl6b6W1hAb836in9zKKE95jb9ZDGW1ZnehxZmDBQt0SITWs5JPiwWzdkjl5lQNdhKquQF72RCgYrEORL2SSMagduTTm8HfNH22ZoyKD2b7bFcbOwIB/FpfcV97mmXgEagr0ccnq2XYz/RXY6s7Ft9kmAF55HcxgvFGELC4sqmtDPSMb18zZ/NK0NYvR8Bp4Xl7NI1/63Ju2ogPZQMSdOa8yJNuhwcO83O6v4eTkuO6Av0Pmz98b4/RZ/3H6legACHgqasfWsIC5oaOLt4ROlMVHOnL0Rtj6l7aSPcyJI6ltiBrJtXtus1ltFNRG6S27iAhazfOe7JUwh34C3tXyIZ7ctP1pIFuFmdVgB90DIU740jV7X5vBMiZRVL38HeTP3xKXTZwUeX0aHDyEI9tx5EJY/RIvlnInu4VHZ32Ao0dzcENTUd7kyQtiKlpG0X6VgRd0gnlY2q4aA+nTtrkK3+jP/GjFN1RkHtx9T9xverKFeZLNadjK+W5JyfTvugnR09U+LtwWwZqvJLevrgA4KMrkmr+ti/2WZkw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?s1qTo1Af4AFV/1o8nMRRF3uvJKGoYYaPRanuSrQPi/jCFnQzFhr2KFU1pgs/?=
 =?us-ascii?Q?sIo0DI2HQLYBRcdif58ylMjCTKqpY1VX45XjtCvWM/3QrPznr9oZiF+hL6DI?=
 =?us-ascii?Q?Ji374WJFiBkVLKTcAzKJDzAgZm+aDAmxWi2TAlGXlZGgJKEqOhml1q4dj8Ls?=
 =?us-ascii?Q?nL7aUNqwE3T+AjiWcak/AukafgfJcZH0A9T6igkyNTCAPmlB1y5gv2ba9bNu?=
 =?us-ascii?Q?won1bEQt4fgWHA2sbJKJ4LArSNWZu2HVllcSFHDLSwTYumMJ6PNGBox1nVGk?=
 =?us-ascii?Q?UhtJFg3R2g5lQOIWReNT3WkGRUMOmC2T5PLZvdf3m3Whs0mPXFP82EfnuA7L?=
 =?us-ascii?Q?dB8e1qxCcAHJxhxZdbG5jl+6uCYyhAn3Hhucwxk/FyrM/mlvpVRUtnc4uNO+?=
 =?us-ascii?Q?KQV/boSglAdZkk8lMtffzg3PahLlVBszL4SdEXxj44d2CcQjHywsiS34DH7q?=
 =?us-ascii?Q?akxAxI7up7eOc6L8zGdk+i9c6/kJmg+ADh0wA0WSG1K6wI/z8lkUwM/PXYF+?=
 =?us-ascii?Q?8xso3B1ama1kRExnP3vWENtWntNWAFbDXubt88Mzc8leY15/ZmEjimZpr9+H?=
 =?us-ascii?Q?7XXqZnAGcitknEMVPDloplCP71VyTlViRDmSlGkvykuJP1RQ6thfUJfWpyYJ?=
 =?us-ascii?Q?e8Ksuez+AbQF7z+Bg7SE77YBVLvZAHFIMsX/owY6B7m/v1Q0MDgnpDhOuQMz?=
 =?us-ascii?Q?KJOMF4z8WfmORvO54NDxqNrEbejeda51K0taAyPhcRxWuP0ObWd9hX2cCjNX?=
 =?us-ascii?Q?wbrO4Ft3YKfdKADQPv/gsTDulUI21fpl8VgIKpXyMLSeU+1MSZp6pFndrYDR?=
 =?us-ascii?Q?qfXKM+omxNXD6aj6dHJV5f1EuaxI255fgoqxoXfoMOFRx/JSeEiqnLpKWtQb?=
 =?us-ascii?Q?ELcxDzaEl62MIoDnkDQx6owaINMMLQYpJpJV8E2ZoBm7lZ3adubdxDsRsSHE?=
 =?us-ascii?Q?dn9LZzhxI8CsjGx79vr+8S7friO81xOManl8OK513xME8ux9ykoSrawW/CZO?=
 =?us-ascii?Q?snXTl/1f1YCMnNLngKx6qsXTY3p0BFumVNnIEK8DvwMUhQ3pxWLKmpxUX73d?=
 =?us-ascii?Q?A5IVvqu7QBKh+xGlKHxk25pEvSG+P/tEQQ5LIuhRbZLWAXGJMsk5Ax3YBKAJ?=
 =?us-ascii?Q?R8+oj8VXuyIrjsyzd5y+h+TE4r+YL2ZTjlZxtQXHDV2BYbCRlba45CZyTPu2?=
 =?us-ascii?Q?hg2PytLNDQ1gLO+oFlMl9JG6QDoWUqk5V4yRY0gyvGM4hsgEuSRmoS/8ioGa?=
 =?us-ascii?Q?oa+VhS77faLG1Ebi4Y6qSp9CUu0LZQzXDKogEN99gtvUbdDWH0700fGgWwA5?=
 =?us-ascii?Q?Fq4r8Hp4J2LGkf8s5iJzvSGuC/Uu6aW2n48qSTA2RQiZjJzEOoLnltzMDrHu?=
 =?us-ascii?Q?LoBlEEB+sTRNLEcQD2DSwXBrLkWFHf5R0jINgtCdbhrAsLqYu5c7Gxq2Q2qH?=
 =?us-ascii?Q?JycL63K2/QqvgIe5+QCK3ZRawkNVw3KwqwDnkYRlmS/7yDjUSwpC105AhgYI?=
 =?us-ascii?Q?OTuyK3gsA89h/5kfejE1AK3rovYLUIrA9oU10XUt2o6hgcgeiBVFLOmdhXyl?=
 =?us-ascii?Q?WgoGKHyJd8JRJBUaDvJ1JCP55gSIg8RmTkAudfj22qlPWr/dH04SYP+5LgcI?=
 =?us-ascii?Q?6IGGyV7ubtCt6LTHhiyy6tUtzs/EYPmcTDJI8Zzjmhurw1jsahn3XqIj2fvW?=
 =?us-ascii?Q?yIdceFhi4koHMlrPltAkeFIV+fX7Y/2tKIibWU5fmEVmIzAbjYT2ecovod+V?=
 =?us-ascii?Q?WooD2lk1GvxcyLJaXUv/ald8D5TIXhXo3SVZPVHXD6YIbQEyzaky?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cb7018-d96e-49df-5419-08decc4b64e3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:35:32.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUjV2pMCODf4rpdjPkfVtMiIFL0i2lLeFBgm3JjYb1KCpetHeuacOCqBe0tgA6VPjSb3mRmR34FX72JBM+xBGb8YG5oEEovqLbMTEoD5rM2HBSmarOa2JkEdeR8Lcaqg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:35:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23195

commit 24a51f8bf869053de4927e0798d17dbcda9ea3cf upstream.

Add clock and reset entries for the Renesas RZ/G3E RSPI IPs.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/ca59fdcc6c32b8f6659aa9218f1a42d2bcd258c3.177=
1344527.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 728a72093d87..bca513f48133 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -218,6 +218,24 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(5, BIT(13))),
 	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18,
 						BUS_MSTOP(5, BIT(13))),
+	DEF_MOD("rspi_0_pclk",			CLK_PLLCLN_DIV8, 5, 4, 2, 20,
+						BUS_MSTOP(11, BIT(0))),
+	DEF_MOD("rspi_0_pclk_sfr",		CLK_PLLCLN_DIV8, 5, 5, 2, 21,
+						BUS_MSTOP(11, BIT(0))),
+	DEF_MOD("rspi_0_tclk",			CLK_PLLCLN_DIV8, 5, 6, 2, 22,
+						BUS_MSTOP(11, BIT(0))),
+	DEF_MOD("rspi_1_pclk",			CLK_PLLCLN_DIV8, 5, 7, 2, 23,
+						BUS_MSTOP(11, BIT(1))),
+	DEF_MOD("rspi_1_pclk_sfr",		CLK_PLLCLN_DIV8, 5, 8, 2, 24,
+						BUS_MSTOP(11, BIT(1))),
+	DEF_MOD("rspi_1_tclk",			CLK_PLLCLN_DIV8, 5, 9, 2, 25,
+						BUS_MSTOP(11, BIT(1))),
+	DEF_MOD("rspi_2_pclk",			CLK_PLLCLN_DIV8, 5, 10, 2, 26,
+						BUS_MSTOP(11, BIT(2))),
+	DEF_MOD("rspi_2_pclk_sfr",		CLK_PLLCLN_DIV8, 5, 11, 2, 27,
+						BUS_MSTOP(11, BIT(2))),
+	DEF_MOD("rspi_2_tclk",			CLK_PLLCLN_DIV8, 5, 12, 2, 28,
+						BUS_MSTOP(11, BIT(2))),
 	DEF_MOD("rsci0_pclk",			CLK_PLLCLN_DIV16, 5, 13, 2, 29,
 						BUS_MSTOP(11, BIT(3))),
 	DEF_MOD("rsci0_tclk",			CLK_PLLCLN_DIV16, 5, 14, 2, 30,
@@ -441,6 +459,12 @@ static const struct rzv2h_reset r9a09g047_resets[] __i=
nitconst =3D {
 	DEF_RST(7, 6, 3, 7),		/* WDT_1_RESET */
 	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
 	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
+	DEF_RST(7, 11, 3, 12),		/* RSPI_0_PRESETN */
+	DEF_RST(7, 12, 3, 13),		/* RSPI_0_TRESETN */
+	DEF_RST(7, 13, 3, 14),		/* RSPI_1_PRESETN */
+	DEF_RST(7, 14, 3, 15),		/* RSPI_1_TRESETN */
+	DEF_RST(7, 15, 3, 16),		/* RSPI_2_PRESETN */
+	DEF_RST(8, 0, 3, 17),		/* RSPI_2_TRESETN */
 	DEF_RST(8, 1, 3, 18),		/* RSCI0_PRESETN */
 	DEF_RST(8, 2, 3, 19),		/* RSCI0_TRESETN */
 	DEF_RST(8, 3, 3, 20),		/* RSCI1_PRESETN */
--=20
2.54.0


