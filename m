Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FEFC3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:11 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.67])
 by mx.groups.io with SMTP id smtpd.web10.49057.1743417967441982242
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=g96876DZ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.67, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGIZVf7QrrtfHU+ulWNYOaLCJixGk+LFQQSjRyZrqlOH0yiNNqfp7vqK8c6toOWl1lZK8r7kKcHt2Sn7a6j8KJWzcr3dme0VgUsfouAZKGPbSHvmjbQrCC5spY3NI02+vyL4o2pnMHIEn/6jzUHT9FFbj5DGlMYfFrlZ2FjZyD1wuxp8EAxhOOfd/1um/ZGeWwqYhF//s7TgmRE1SsE0+cF8HPHsS2IVuj1LogkXgNLFzRyc2fzp+6oLzQovEflgZW+Y6+29FcNLNUPu37A8Q/DsSCbIFWuzgOLf3waCaDmPc7RpT6qhKRjan+GL+oT3NDhDTjjufPuFXuHD8vt2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVKcE8jCehCsEg9QOiPHSCmCMHomGoNUpRGbtJf8BPc=;
 b=UpdSlg+LGrwmOykL9K4AYQuOIKV4MAEB1LSOd1HQK13yt6Zjbq7RuCmdr2m+kGBvTN6yn5OpmOPkA+rG7A2ApAs4bJTdgcH1WN5S2XxgcFayL+LUPy6Wz4VYshP8g4Exow3iUdvxAfxr2DgpAPa/a5/k6Ozuq4/7sDuOY/3/MHUs/V/YXIGWyWbZyphciK6hxv6xqzBSlVnzhPSB+hXvSuPhSDHSwyqKVng2sHbiJwKUTrHk7p7eAZ5ik7OCRJ/vK/rShxhLSAytB7+wcIJpBVaGfxnkX9DW35kHKudoPknjAtayf6AMelUX9fCuR98oRkJR9mbYOu6OUHA61CcfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVKcE8jCehCsEg9QOiPHSCmCMHomGoNUpRGbtJf8BPc=;
 b=g96876DZz1Prwb1LyCiNoRQaxq0pShsgX68KJWAL4L/D+2ajxbGIx0t/ETpFXROlGEhq8HCxO0d+/SV0vo6VgtWnCSQGfGygWaMzBcp75eIJDJ85XzWnUB1ix+LN7Uou5JAG128TwEMlUG6EUYIgptaUHgjgbuOUboJ+LZ4sjO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:46:05 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:04 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 11/43] pinctrl: renesas: rzg2l: Add function pointer for PFC register locking
Date: Mon, 31 Mar 2025 12:44:42 +0200
Message-ID: <20250331104514.79090-12-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d0b727d-b2c6-4667-e689-08dd70413c26
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?S11Ut8BGzZ75MczzG4+waeESfmXgOZF7l7miFgn7TFQeFxGSl6Rp4vZc8uLU?=
 =?us-ascii?Q?UYhL+XHt5MC0DRoz080qbmXbz8P5GmrKeTo3ySYxQ6eqtEbMOWbngGwC0ErK?=
 =?us-ascii?Q?kX/XjLowNfGX5PKL4D3lea2w4arB87XP/cwbA+KC3b0G5pJI9MUEekPqeAfv?=
 =?us-ascii?Q?od1yLjzH+ZpfZN6UXPVpctCCB29RBm8rnO1N6l5QbGmo1cGrbPSoQBY3pEVY?=
 =?us-ascii?Q?8bGuZqbZOoYtYyrEyoWbv8XkMkRcPQXnod2GEH4Eas2wfwi05dq7DDPIi0Q0?=
 =?us-ascii?Q?emSlPEMiQ29VA9MyXd/fGgK1GV87eBYfY1bDdqiYRNPvK9HGwirtETkdqzZz?=
 =?us-ascii?Q?tsXmWGWC4Yu429qo7lb2mAt+kg/Is8mCVEOyfcs+GoX+unYK39V0B9pZEfjP?=
 =?us-ascii?Q?uPoGwmS/n9xgyJXP2JYCd0V0abSzmww5fgZZCg0+T9BdgRwH5V9lYIHqqRTX?=
 =?us-ascii?Q?aepoNB7uSaSKKj7Rwx+7ZSHKO+8wWyCvvbinXDVBJqmt4OOHAw2hS7Ya8+6c?=
 =?us-ascii?Q?u/Ih0oyqQsDO5cjGvQU5vt4tyxri5Y1bIeyW+Vvs5zSKHls35MNN1ob19S5N?=
 =?us-ascii?Q?gfzRgQ0t9c18S3b3RwcVdIfb/h2JmmHpYaKL9t74LgkfAnWHDMOXt7pBDb9T?=
 =?us-ascii?Q?oe4PYu7XTeZzOCrpfywTgvU4pafA3Fdi24M+S0RyHov5HKfL1akyf7PEXeHw?=
 =?us-ascii?Q?qc2c3XPOlqiia2W4YbL4rHRAbm5CUJ0kWNgamp9h7QyXYSOR0fg3jYEo2Xic?=
 =?us-ascii?Q?qJRQDYnLoM3Ez/B0Av8wKcyyItv7TpwjyqBBQJ2d/1QGujGPzupcRLAkyw+6?=
 =?us-ascii?Q?TsgPl9HDvBY0WMDP5V44MOR5dii4SYsOPrVYdLUXitWD28Cq2BnqF41V+Dlj?=
 =?us-ascii?Q?V5Qg5LHloU39r0RBzCOXN5OPY4oSWm3nkhxOwisEV8BqiIHv3KnvHwGCD4r9?=
 =?us-ascii?Q?YHgIj/tpcQUoHdub9I+kxOrmrl0/ol9zK0VABRAKWKDYQ+Owm7PermEgvWfH?=
 =?us-ascii?Q?o12BCAD9g54tpRhJoNC5VY1Tr02AtsLvCcD2InPEdsBXTloOoX5LEUkKnkWf?=
 =?us-ascii?Q?tyKXZqY+zqdXb7SpaibjLvprlDCtPB55ojStqr0pS0Ps+3F2JxXkYutBdkXd?=
 =?us-ascii?Q?MkQdB5NnuJ+wdjnFd9hJxjrhRpgo+5in33486hpbvo/l90vDU63MiZJq6xic?=
 =?us-ascii?Q?EF8LUVvtRJ3gsTPde3EnSEDBihzeFiGkMqO9Zntamb21tj+/68AHXvTgllD0?=
 =?us-ascii?Q?AZrbg1gAz9HvaKkLg9FBsyfzTOTyngJvaZoMRJSVVMCuBjXlKhtZ5FIZDMtC?=
 =?us-ascii?Q?U6ybrBltSn6oA8cCDjOWhqpQ0hh4Cpg2CJFieOmwWFhqukVztXkybOpuxbXT?=
 =?us-ascii?Q?4NFmv+SjTa3pH+kAmd1+jKPIkeLilDT5as4HNfY2EHNbcJYtiT7ww+1BZlQB?=
 =?us-ascii?Q?NZQDBVvuWLVftn1Xl9lBUdKMY7gRNv0J?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CBe1lnQqPbzbDqhZhlHVSUuqvdkdrZTv6ATDrL7FLddJZBVQNU3KgZnIqLdF?=
 =?us-ascii?Q?Fb1/fO1Vo+oaOCjhISG1QcouaB9I8lfDWP+a2jTdIwcVs9gTMCqC9OP/rwMt?=
 =?us-ascii?Q?XU8pWK+G2mCTt8O694Z39AzJ+tYORYLxnXg1iml+mgUWeSNkQL3DAyQGWSWT?=
 =?us-ascii?Q?rq+RKvNsRt9Lslxqo2SD2gcO9u09M8LT4lkak+ASpoPs/oLZleX9DNMXCdJZ?=
 =?us-ascii?Q?9J8juulY0od3hxM7S0S9mvC2TwFmrKaHxAs8BqaCayGKFKGp02wWItMGH0iZ?=
 =?us-ascii?Q?hEW4wtrj6QnetECctLyK5eCUF1oR9aX1VIYmaVJMsHHDhTTIcIx0L+a+HJm/?=
 =?us-ascii?Q?ckTRuqwg2K+zjzKyvM3Bfay4wxjY782PTC8g3g03KDU3WrwZOjHfzPfdlVU4?=
 =?us-ascii?Q?Ut/B+QbfdJOUIUcfWfHTVwZjN9IkUH+UsRwiizuXPIcfIzu23ZvU6YavgOUy?=
 =?us-ascii?Q?Vw97sttSyOt6uooJP/VhTcbS7XBoTZPHSJdhhLGV6U981rvuFoQPOHxgLcsB?=
 =?us-ascii?Q?pwRPQpiPh4ycNYj3Z2o7oKl2MF2K9nx754+mN0aBJDOvtiWwrNrsDI+mMdWa?=
 =?us-ascii?Q?wFrotZr+WGtTkuKQmUuoNuQdhd2Ej3Xd/mVrBDmC1Fw253gSh38A126rCiBG?=
 =?us-ascii?Q?1sMwkxV/Jx94SjIt1l0OuRTt85XqYZu76Up21sY55Ij6gtNHXb/sLs1eB5BU?=
 =?us-ascii?Q?3xb8LXNJOOHmVQjIljzn2XSkq+eRZHKDSqtnAf2XlD7Uf3LSzd0PaUiewd0j?=
 =?us-ascii?Q?4n60xz076xQUiLQ1s065v+GpTPdjsomoPwPHocoWWdTnCcOMuG6zFRvrhz2Q?=
 =?us-ascii?Q?qex95hj7d16XUj41iAjZ1JB1PI6GYncdYuuy9kqJm/pGQEl9dkuF9nWiI392?=
 =?us-ascii?Q?hXs81Di9PPL4AX0d9gwtWALMiCPTgtvv+6RLhhhbAoefHvn5JL7Goll+lb7g?=
 =?us-ascii?Q?rc325lr+6a/o2NkkmIrl6AYdkNhO26gUMxWsZyieL/aBF7pmFMzjecYMdwYE?=
 =?us-ascii?Q?gwfDAfPTMqcPQe8MoT04x8KovuzM4OuSy10ZafgmKJoVadxWDkNoDGkD/Ill?=
 =?us-ascii?Q?BTdUE439dDUcOWOO8eEkuJJWJpHLxSihgpIqPvx8WGggGELN5wDL3mFOTKjE?=
 =?us-ascii?Q?G0xIJaPDjiDFJ/9IXDeQV6zwcDGNdl2+THg7TeERUhp1p7Cs4DGL35qshExi?=
 =?us-ascii?Q?lNHThJh4mBNSnyUOhns7584XIYy/vb/Sg07etrwS8vVQsNnFKkRLJhMpmJoi?=
 =?us-ascii?Q?ySoLHjQHL7igX/fWHAih4vPWR1eNMASiuhqgoJ51a4M95vM1LlFfJP1BHZ2G?=
 =?us-ascii?Q?IfacTODiCd5ufOgERkp1ePlUYQS39jwnDRtpEx27ovnFhLMW+ENQt7lPjz2p?=
 =?us-ascii?Q?ik+ORgPKGUQ8ruIyEM+WOxQd/Fk2wD9fMva/mKdpPvQaUuH1gC0ovCh94Igd?=
 =?us-ascii?Q?faGA7qpEwsoMh3MPTE0TYbCwflYjWgMbMnlzIoijfSLd6bVrjW9oqE+rRizk?=
 =?us-ascii?Q?CicrZVGAM0WySI+0GXxhGoaxAiGUXQELNelT6y2dfRi3wF4G5g2WZkir6y5X?=
 =?us-ascii?Q?CWrnWk6sWoi0ziCet5X/I5RdD252iskzsZ1yQfDJAPgOTX7YYxnejeVLXCre?=
 =?us-ascii?Q?cJyFhpwcvyspSidGu9e3TS4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0b727d-b2c6-4667-e689-08dd70413c26
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:04.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZ3NQHIWQov3LEFAyENM5p0frQqMhvvpNQTNH6xKvNlVV+9kAuD04ECjdPL3NVt5xSOab7gks8e7bfChiNX62ZDoWcSV3vuXaneJo72r09ZAjgvCgLuq4zwVMDgVhWm4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18399

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 14c32dc1f63d0de865e67c04c919ae036de20f87 upstream.

On the RZ/G2L SoC, the PFCWE bit controls writing to PFC registers.
However, on the RZ/V2H(P) SoC, the PFCWE (REGWE_A on RZ/V2H) bit controls
writing to both PFC and PMC registers.  Additionally, BIT(7) B0WI is
undocumented for the PWPR register on RZ/V2H(P) SoC.  To accommodate these
differences across SoC variants, introduce the pwpr_pfc_lock_unlock()
function pointer.

Note, in rzg2l_pinctrl_set_pfc_mode() the pwpr_pfc_lock_unlock(.., false)
is now called before PMC read/write and pwpr_pfc_lock_unlock(.., true) is
now called after PMC read/write this is to keep changes minimal for
RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-8-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 44 +++++++++++++++----------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index b6b53757d803b..95b51f31c387d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -240,6 +240,8 @@ struct rzg2l_dedicated_configs {
 	u64 config;
 };
=20
+struct rzg2l_pinctrl;
+
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u64 *port_pin_configs;
@@ -250,6 +252,7 @@ struct rzg2l_pinctrl_data {
 	const struct rzg2l_hwcfg *hwcfg;
 	const u64 *variable_pin_cfg;
 	unsigned int n_variable_pin_cfg;
+	void (*pwpr_pfc_lock_unlock)(struct rzg2l_pinctrl *pctrl, bool lock);
 };
=20
 /**
@@ -382,7 +385,6 @@ static const u64 r9a07g043f_variable_pin_cfg[] =3D {
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
-	const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg->regs;
 	unsigned long flags;
 	u32 reg;
=20
@@ -393,27 +395,23 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_p=
inctrl *pctrl,
 	reg &=3D ~(PM_MASK << (pin * 2));
 	writew(reg, pctrl->base + PM(off));
=20
+	pctrl->data->pwpr_pfc_lock_unlock(pctrl, false);
+
 	/* Temporarily switch to GPIO mode with PMC register */
 	reg =3D readb(pctrl->base + PMC(off));
 	writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
=20
-	/* Set the PWPR register to allow PFC register to write */
-	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
-	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=3D0, PFCWE=3D1 */
-
 	/* Select Pin function mode with PFC register */
 	reg =3D readl(pctrl->base + PFC(off));
 	reg &=3D ~(PFC_MASK << (pin * 4));
 	writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
=20
-	/* Set the PWPR register to be write-protected */
-	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
-	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=3D1, PFCWE=3D0 */
-
 	/* Switch to Peripheral pin function with PMC register */
 	reg =3D readb(pctrl->base + PMC(off));
 	writeb(reg | BIT(pin), pctrl->base + PMC(off));
=20
+	pctrl->data->pwpr_pfc_lock_unlock(pctrl, true);
+
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 };
=20
@@ -2439,12 +2437,8 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(st=
ruct rzg2l_pinctrl *pctrl, b
 static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_pinctrl *pctrl)
 {
 	u32 nports =3D pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
-	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
-	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
=20
-	/* Set the PWPR register to allow PFC register to write. */
-	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
-	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=3D0, PFCWE=3D1 */
+	pctrl->data->pwpr_pfc_lock_unlock(pctrl, false);
=20
 	/* Restore port registers. */
 	for (u32 port =3D 0; port < nports; port++) {
@@ -2487,9 +2481,7 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_=
pinctrl *pctrl)
 		}
 	}
=20
-	/* Set the PWPR register to be write-protected. */
-	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
-	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=3D1, PFCWE=3D0 */
+	pctrl->data->pwpr_pfc_lock_unlock(pctrl, true);
 }
=20
 static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
@@ -2551,6 +2543,21 @@ static int rzg2l_pinctrl_resume_noirq(struct device =
*dev)
 	return 0;
 }
=20
+static void rzg2l_pwpr_pfc_lock_unlock(struct rzg2l_pinctrl *pctrl, bool l=
ock)
+{
+	const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg->regs;
+
+	if (lock) {
+		/* Set the PWPR register to be write-protected */
+		writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
+		writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=3D1, PFCWE=3D0 */
+	} else {
+		/* Set the PWPR register to allow PFC register to write */
+		writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
+		writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=3D0, PFCWE=3D1 */
+	}
+}
+
 static const struct rzg2l_hwcfg rzg2l_hwcfg =3D {
 	.regs =3D {
 		.pwpr =3D 0x3014,
@@ -2608,6 +2615,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data =3D {
 	.variable_pin_cfg =3D r9a07g043f_variable_pin_cfg,
 	.n_variable_pin_cfg =3D ARRAY_SIZE(r9a07g043f_variable_pin_cfg),
 #endif
+	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 };
=20
 static struct rzg2l_pinctrl_data r9a07g044_data =3D {
@@ -2619,6 +2627,7 @@ static struct rzg2l_pinctrl_data r9a07g044_data =3D {
 	.n_dedicated_pins =3D ARRAY_SIZE(rzg2l_dedicated_pins.common) +
 		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
 	.hwcfg =3D &rzg2l_hwcfg,
+	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 };
=20
 static struct rzg2l_pinctrl_data r9a08g045_data =3D {
@@ -2629,6 +2638,7 @@ static struct rzg2l_pinctrl_data r9a08g045_data =3D {
 	.n_port_pins =3D ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT=
,
 	.n_dedicated_pins =3D ARRAY_SIZE(rzg3s_dedicated_pins),
 	.hwcfg =3D &rzg3s_hwcfg,
+	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 };
=20
 static const struct of_device_id rzg2l_pinctrl_of_table[] =3D {
--=20
2.43.0


