Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8602EC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:11 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.1])
 by mx.groups.io with SMTP id smtpd.web10.49058.1743417969387923887
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=GRViNM7F;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.1, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9EU938L0XUktBqZrscwb69jOSYQ6/ZbgIgqalkut7mxspSbjnGUAc0mcizIrXaUR+6rX0qer+ylaKdelbkf7adeHC0fHcgOlp1xap0+1opaTzsZv6mi1QT/e+gVY5xBQEUfre0ljoBdLOjQSsTX2rO5xexvXpT4cEK3V8n8UqU7JDMapwXtUztqqRBKbRIm0IST0JAux6F1YAnImGleN0FoHoXefLI0j+DvU2I8HnldT9iccEOXznnGgvBhd9KANtxngRsCfkI8uEKEJaX+4xcN8ZaUjNOGknswe/ZeXiGcK+5bRgMNdkyofZ/5uLWmu0+QhE5K+me/UpYNYItOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPaF7hB23IDH30LFcinx65+jeKcw2oonUY0C2E+XrnM=;
 b=mAHhD7QaQHPuttMR3iGDNNDl5qwxm6rmHncMaijy9iWnVZs9fnRJ26s5YK3LtYrYIEdH1ZHEJ2NpEqR5OkapLs+xwrhQuucQTyEIm+zq5lx+t2s9pnAJ6c3b6yFHxEpoM/rhE4WfWqFoMZkMdEGoANLYN3dRLgxXptwuzahaW2DaBpStOTLNnKg6IDUjx89shtl+gXacIpfRH/7WJY9CXzszzgo44sKeLRuFFjrzLuAkU313rVfo0zr89TCk5DA00nlbu+lrqUXdH5RJICcH/eaO9tMqa/anxCDCYV2sRjwLI9o+phsAQWcS1fKzmEL4vU8FqkdA96+NYR0VyTVxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPaF7hB23IDH30LFcinx65+jeKcw2oonUY0C2E+XrnM=;
 b=GRViNM7FbmurZu2IIa9ZmWw2nOh6Wp+ZFCGL3y8ORBze38sFISUPfDYrCfZA5ot6cbPcttuKQeFhVxRK6mHJ9OgIbKmgw1NIOjgw0Xp0JDB4gH85Eivmf5WJjuH7x1WhYiAxsM3MxitY15yjzYc7pGPAY/HUZVvWo2TSPdn0Y0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:46:07 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:07 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 12/43] pinctrl: renesas: rzg2l: Add function pointer for PMC register write
Date: Mon, 31 Mar 2025 12:44:43 +0200
Message-ID: <20250331104514.79090-13-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8223ea-be22-47b3-23a6-08dd70413df5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Gn+Ioh2Ea43uc3FmMQXNdFZhZnDehVWtj32A0MX+IBtzzpk3taGVxomIpKwE?=
 =?us-ascii?Q?tC0A8d1+b4wV/k1QC8hZefCEDp82DHRkwvL6KjBDbtIEk+PbZuFKep56Pbty?=
 =?us-ascii?Q?qDb46is88fdX/qiRP68Uj2IbemJlC4Y8nxum/FrkP9U3pgKSQe35wNiuZ3Ew?=
 =?us-ascii?Q?ptroALqsrPwDNCUzHYlucvft3tCnW2H0BvtdtBvJHAyGPiUgJRPGcali3tzB?=
 =?us-ascii?Q?jN+3dRzQIA7dkK+DaMPHoAqdYRuTxPOyWtlPwW88kowNyRvoC/9r3w+O4yKC?=
 =?us-ascii?Q?sqkYAGOLrIyuCb15YP8mGk09hlYLYxBxqq/68Q6sA7qTRvfL9KkRW0IAQvmw?=
 =?us-ascii?Q?9d5HdyqkY7yppCMt6niTvS4csOye/xccXktoVIvw618n50aKGjsYfbfKo+Bv?=
 =?us-ascii?Q?kZzRJBPTi4OKdZ/LEiwCq8RLXzKCfeiUqcuzpxftLJO06oxOSXM0kEYOmgWu?=
 =?us-ascii?Q?URNq/5z1kOzM7JFQrfysZTubLdLb7JnXpMwZPn+4a7EC40SveL1IBQiMHepj?=
 =?us-ascii?Q?fuebkxg7+qAdzaNoG5/HEjefVHQSrTMoPEmgCYB70gQ+qpqXKvH+qJO++VIT?=
 =?us-ascii?Q?9So4oZOXUReJZb1y65pAuYSPjXKd8WLMUJoFMEjHp+GlaEr4aK9EXEbNDeaM?=
 =?us-ascii?Q?al6aHPDAFKjcKZLiaux0MzhZ3QsBxbdnUxezoi0TfyupIKZLBrMk2led6Nkr?=
 =?us-ascii?Q?osOodmw8cc1IqlvPXYfu/XqsTRtjRZCNxT5KmT4gkzOkHhQtbkMqkfA/7bBX?=
 =?us-ascii?Q?oG6YIo28tMP8qw1Xo7ONljyExG+JtZzlYqQYmk0QHA6IhoprOl7SuEOn/ifd?=
 =?us-ascii?Q?/Zn837wm5ovxKSUuZ4u3n6JLXMtQhC9D2urXFJ5FlQGqAV0mFC+Sz4Ox2oyT?=
 =?us-ascii?Q?wX67UV2bYiMIqSJslE89rGPihiDYImu0Sjz1ZvAFhzflX1Wk2PW96kPQu3EA?=
 =?us-ascii?Q?6BEm71ld0gekLMZtlpAkBqm0qETDyMhCPmdY9B6JjmpNdi6jl3aY0oq2r0Tu?=
 =?us-ascii?Q?CSazX6w8f4bIKgDjhQqKl99+6F+AZcJinEzpPmvCD+11a2vCxaiE2hfkdfvQ?=
 =?us-ascii?Q?/T7xqQmTwoPWJNIk5C9JCcL5HWXXgYku8xelqF0L2Q9mIQ9Zvrsx7nrOgX72?=
 =?us-ascii?Q?0EruFyruHFGgw6t7IVOEsy+GQDP9wB3NTFvTlFdWB6UGGkDhPFoEjutTIKoo?=
 =?us-ascii?Q?aTNPiZeCGLuA3i2rjDZRd31vMEB5L/04OI/x/pUB82owvg5h0g00uQq0cinu?=
 =?us-ascii?Q?kq+5gzakx81SxwNKxyarUfkHG3UXbS/sF0SzujyzpQ5G5q9q7tRJZqyeiaVW?=
 =?us-ascii?Q?mzU871ZlCr9mlMWQnKSgHLxUxtmiWiEawtDu/68Fr39cOM0EitJ1jk97ljeR?=
 =?us-ascii?Q?Q8GHD6k0zT0DATK1kBYWD18TCy+AJ6AO8O3/4zJlxR1TJ9X3epc4gAPEd8wa?=
 =?us-ascii?Q?KnrlmecBsjVoqWQOeGMpKDfHrge+gvpE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1+bL5dngYDBuMSAAsUiXyb/ocXP2wMuebtlvGBqnSZdCT57ZTPg+LPM37Mwy?=
 =?us-ascii?Q?RARDh8Aw0ghViuMuYkgwpO/A4//iuid3Yeg3QYwO1dBmlLY+Kc0OrwO850bM?=
 =?us-ascii?Q?3cyt8txVqr2NBp7wq48mRyBKzyQUxfhYAB9oZWcVwxP1gwjDOoJO7diw1jFl?=
 =?us-ascii?Q?vRO7SZpgL8h+eddHKWUauEjkOakxhcFmAlc3qDHIX8Pj6h/3zjRCG2qOYTuK?=
 =?us-ascii?Q?WhKS0UVPpx52+vJixGJwF8Jpg3FawfLg7vbY3WHYY+k49sOlclqoXJMIljY6?=
 =?us-ascii?Q?tKUzh6Y60G/ub3Ga7tbmVKEzW/amxTFhJ4ecMbxRIzDdac+PV7DYKq+gQQ8t?=
 =?us-ascii?Q?cRDdSPOPQTmjxgZUA5xEpy2qtMFmJnvq/svYkThyYr7/w0B1tXt90yZFwbrg?=
 =?us-ascii?Q?FLGe5ZFAgtAhtADqs6646fXClYOb7J/rqun8875sb/p0V+Q9vkBB2xOZcH72?=
 =?us-ascii?Q?P3pYw76kzJ9NCWQDGORzriacpH2h5xPGyH9sG+30HhZTI9HlOBqdg/jHanfc?=
 =?us-ascii?Q?1cKToYd59KTj5fNnC9DMF6XC9CWlnMI6WmVKKktTh0WTs+BOmJ38Ov1pyLBP?=
 =?us-ascii?Q?XU/I8mqbMBg80VeWUE/x+bOCX9KPtofuzadJbWinaeiConC7OQVW7cM/CbPj?=
 =?us-ascii?Q?gMWjdmS+jOn2MzR7u3dMB49+lYPZgU7sWfGkmV/gcX2jVeHQvxrrX+KinuiS?=
 =?us-ascii?Q?Fv72QYX/ZDXMXtW1af7uNSGFTLJyAdypn5BaeAcXLoAC62wS8I4S8cr/COTX?=
 =?us-ascii?Q?iiovuuxXWodq7mZkIN4RE1HRoVxyiX+JUOqU94ZsCGyKeFN2jvnIyB+ZhBfK?=
 =?us-ascii?Q?VAg0IouggmMWtjsj+PPiGXlEyMO7LsGHVA0gsu9AiRAR8vZAhDtEh2kSdsVD?=
 =?us-ascii?Q?Ck7E32FBrKx6J3wSsxyPsIy2OYNsUFEPLYz0xykHadcMKxWcK/ydMn+Tfww2?=
 =?us-ascii?Q?ElEiRzvXN/5Uvoux9nAnnSk03evzRxCbuDRl5EBTxOr7bePkrHOY+jq/Kveh?=
 =?us-ascii?Q?N6IfSvKUuuMBWQo6CrEOPLZp1PbreJVp/YWz8URizuBlnV2PUABlflv99y4B?=
 =?us-ascii?Q?3P84+s1di5BbnaX6wW857XqJWjVneseUnur1xd7jffJoDrGfRHvAH2vfvGc4?=
 =?us-ascii?Q?OYGQa7M2e7JY4fL4lC/vhiLLQMJJ5tuTMzxwuk+sQB47J9O9KUbLpziQLWn8?=
 =?us-ascii?Q?/eNl++ajOnCffmSwXOVMpW/oxi5YlhcLJvZ+9l4UjL5qvnRZX5UXuaR5iXWS?=
 =?us-ascii?Q?5uoz/eZECujlit80M1vvm2s4HFdLX1FqKehIDd23Twq3lcmPXusiaVr7nLI7?=
 =?us-ascii?Q?rz3JKxC5BoPRnyZtr00tbJHcCHTzXuokB/49kMBvzuyvMKDzNl5vdePMAx7U?=
 =?us-ascii?Q?YtVkjqSGRK3N0JstVyTrUifEWTmdttt0YOz1UzLbLyxwyOn5Xrh5GskHUVma?=
 =?us-ascii?Q?PnsP+wd1LlbsdWBzDRQaKd+MjxpULXa3yoyRKKyHqdnVq22bUXJ3ZkHXKcTd?=
 =?us-ascii?Q?RbVCvW5vqI1kQw4/szrByJors9zpTQq/DXy/vKVRqVyiPUQ60J/7I/iXjT0E?=
 =?us-ascii?Q?WCRcNO85mLybeAgCm6f7qcv1+/YJbn9Cw1/DJ104KgLgTjq757npmfCILFfm?=
 =?us-ascii?Q?fT1IPJU2KcnUa22r3g8bpmA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8223ea-be22-47b3-23a6-08dd70413df5
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:07.4412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6HqEIbnrza8/bflmHEMzY8kLL5JN+qMpPdSpLpvD0y1fHFchyBbDNtmFbVKvpj0rvjvukiqHSdInTP7OV9zQK8OY2tomeQUTRXItDVUMe5PNsFflP1FyEORr+Gt/F9t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18400

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ede014cd1ea6422d7436bd0a1771fe0d7b0fe12a upstream.

Introduces pmc_writeb() function pointer, in the struct
rzg2l_pinctrl_data to facilitate writing to the PMC register.  On the
RZ/V2H(P) SoC, unlocking the PWPR.REGWE_A bit before writing to PMC
registers is required, whereas this is not the case for the existing
RZ/G2L family.  This addition enables the reuse of existing code for
RZ/V2H(P).  Additionally, populate this function pointer with
appropriate data for existing SoCs.

Note that this functionality is only handled in rzg2l_gpio_request(), as
PMC unlock/lock during PFC setup will be taken care of in the
pwpr_pfc_lock_unlock() function pointer.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-9-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 95b51f31c387d..947fcd39b1683 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -253,6 +253,7 @@ struct rzg2l_pinctrl_data {
 	const u64 *variable_pin_cfg;
 	unsigned int n_variable_pin_cfg;
 	void (*pwpr_pfc_lock_unlock)(struct rzg2l_pinctrl *pctrl, bool lock);
+	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, u16 offset);
 };
=20
 /**
@@ -382,6 +383,11 @@ static const u64 r9a07g043f_variable_pin_cfg[] =3D {
 };
 #endif
=20
+static void rzg2l_pmc_writeb(struct rzg2l_pinctrl *pctrl, u8 val, u16 offs=
et)
+{
+	writeb(val, pctrl->base + offset);
+}
+
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -1329,7 +1335,7 @@ static int rzg2l_gpio_request(struct gpio_chip *chip,=
 unsigned int offset)
 	/* Select GPIO mode in PMC Register */
 	reg8 =3D readb(pctrl->base + PMC(off));
 	reg8 &=3D ~BIT(bit);
-	writeb(reg8, pctrl->base + PMC(off));
+	pctrl->data->pmc_writeb(pctrl, reg8, PMC(off));
=20
 	spin_unlock_irqrestore(&pctrl->lock, flags);
=20
@@ -2616,6 +2622,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data =3D {
 	.n_variable_pin_cfg =3D ARRAY_SIZE(r9a07g043f_variable_pin_cfg),
 #endif
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
+	.pmc_writeb =3D &rzg2l_pmc_writeb,
 };
=20
 static struct rzg2l_pinctrl_data r9a07g044_data =3D {
@@ -2628,6 +2635,7 @@ static struct rzg2l_pinctrl_data r9a07g044_data =3D {
 		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
 	.hwcfg =3D &rzg2l_hwcfg,
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
+	.pmc_writeb =3D &rzg2l_pmc_writeb,
 };
=20
 static struct rzg2l_pinctrl_data r9a08g045_data =3D {
@@ -2639,6 +2647,7 @@ static struct rzg2l_pinctrl_data r9a08g045_data =3D {
 	.n_dedicated_pins =3D ARRAY_SIZE(rzg3s_dedicated_pins),
 	.hwcfg =3D &rzg3s_hwcfg,
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
+	.pmc_writeb =3D &rzg2l_pmc_writeb,
 };
=20
 static const struct of_device_id rzg2l_pinctrl_of_table[] =3D {
--=20
2.43.0


