Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A852EC36001
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.8])
 by mx.groups.io with SMTP id smtpd.web10.34457.1741778717954436742
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Fm1ARrq8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.8, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZyqf0rMJ2aXZB/cEVA2Zw+/hs4TYa1SmIW6z5CldAe+QklPUQiKzf9dUKwnh73+6lN7hH3pgiwdmvrin3DTMYyG9Vjygs8p4p1E5ZRv9vLPYd3FVb/4Xo4Mna+D9HdMr39o7qwqnDDumfdYPKZV3uX5VuEOCxCqgNCljOP9cl4RfQ+GIeSsosXaheEMLX39ywGC8isf3AZZr7kEwsPL60C91DaYSH8h1mH6OwBKb9KMJDlXwOGPj/prhVicncF2f7+ghcEj5JWcCcG4dvm+AfuY7HYdoNVIGcoO8EorRKT9dYVbTfhR+dOkHWuJJXhwk+QLdCvIiy7ZIMX1mWlg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpnjpr+GtSZKjzUfJYnXNgqYhMAAyr1pBWJyk4myQ08=;
 b=NxzPZhE4hsi4gG2B5V9I6qK+z/ne3HtwTXJHubna/Az+cPRogRaIyZEDXTVNMyH1pWJ9RzWp9twNMvz759abpcdHBG+qpnM87631spLQdrxbTrdxIiNdkkd0LNhYGoCC5iGvxOTPlqEqoXlPkZ6fXjPT6qCU7/W3xh4atyym55jCV/VduQn3OqL28QtBVtt+zUK69jR0ibeBTI9v6VgeVBuj9M5KigcIFpYcJRxv6hUrfeagzR/pDfdlMLK6ZQjBmo6wLp3prEqCjU9wAFzuHjFpi4fXJfQ8e3G1zFTPa/NHZT9TkD/oTZnG1ZkUmxhQWXDHu/LMjHl0p8ydWb6EVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpnjpr+GtSZKjzUfJYnXNgqYhMAAyr1pBWJyk4myQ08=;
 b=Fm1ARrq8P7TLep9ayah2AQb7IDRJF16MkNBGI886hlHkNCWOieYj/RjwpKcaNf7dncBRtH254bbhx4rWuWQ4wzhaaaQ84cKocf9McNASNMqJtBSBh60en6fNuf2goGZzHxFNAqOvbJHSYGJPE9V1lAEOwHI4xR0y7bhx2yUXbjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:25:16 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:16 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 34/85] pinctrl: renesas: rzg2l: Add function pointer for PMC register write
Date: Wed, 12 Mar 2025 12:22:11 +0100
Message-ID: <20250312112302.1605750-35-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9b075f-d799-4828-8c76-08dd61589038
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zL1NXl/6pwQx3fykxu+hOXyhPZqhC4GFxNjVRtIAoF4ETIpCjOYi9QtJNf+b?=
 =?us-ascii?Q?NtTFgCBQYUX72qBJ7UTYKRuhJ0HBLNzPqu1XnLE4EXJYvDokio1IZquH/Rim?=
 =?us-ascii?Q?z9+9MNji8WzeQFU56o0HQBb+o68eIaMtfpeb8e/rhVnEOGGbcl541YCWdWN0?=
 =?us-ascii?Q?gq9/rc+ViSy1HkFzTlG8092Bzd+gzDQVInOn6+6KqqxpBr2uTMdh+5x7YYMk?=
 =?us-ascii?Q?DyGY9trJYmNTZ85qnbKbhwIXWNa4PH068unvf/bD4IwzDeGyccwiP8XcqOjc?=
 =?us-ascii?Q?4T3bbjjxBi6M7cz9RRR8Y5GNiZR5zzJxSw3Rm0LbZpGFVOwovQkTU1MKu4br?=
 =?us-ascii?Q?AQ8HPO/t07gWz2gDTrbyZSrSGOXHPk3aJb7hSbqvD5sWYuWKep+Rja5mUmLV?=
 =?us-ascii?Q?mHmHdmKmrrx0gab3/CfYA8Ym4QY/zswGueW4Ow1NQ0j2qfVzVE0RivMOdLmO?=
 =?us-ascii?Q?+kq03J7reyuAlmiPBIzfm1AY5wQbOFF7vkirhuPda7tXMvAwFAmE++kdfWjs?=
 =?us-ascii?Q?NduMeoNEVTvB49fNw9j6phYU46uECKMuwlZ3WW5DcFiTBLYP4R6lmuRTTbTC?=
 =?us-ascii?Q?o3k6kk/ibs08A/g9dQAB7uXAjkZriNbprqceD7+c2D+HxE71il583V3bqmTS?=
 =?us-ascii?Q?DfZj2GM2nwERmjh4skj/JFNu/H+SXq18HJfxBqJR5f9zs40T0bNM20eCTehG?=
 =?us-ascii?Q?aqXyRnwK/iL5isogj7gGsCSxIicjjbSDGvYUIVXOM/J4RGFyVPIJPbFiCsqC?=
 =?us-ascii?Q?hqB0aGD6hEihYTU07tX/WlUgT4MoSqCeAeAk7WWJ7BptGHJO9oxlwdWuMic/?=
 =?us-ascii?Q?uUXE8IhQYclINmyzgjAC8od1JCBlKR2W8zUVHRJ3ccnLRT2LKGWZw+Fhgg6m?=
 =?us-ascii?Q?WFyQ3I6QctVEyJ8pKhTDDjRSRwVS7dUr9jcEC+TYc+qj5sGojN3GFptp7fwW?=
 =?us-ascii?Q?9sW083pWDH6ifaV1jqU8yyXdUNj1698vpsixi+WktJLKmm2EKPhDwybyVdTM?=
 =?us-ascii?Q?VbtfK2S66UumfJuFE4TAGQpJK5PbXoo7Fn6OfcqqXNBC0jHZH02yAHvrvVig?=
 =?us-ascii?Q?CQDTdkHQtuWete/GencRB//F2C0w4roLdbDud/xBIGPcON1hHrQp+UFZ3Zli?=
 =?us-ascii?Q?cSpgS/dkdk7uvCDloBEbkbAihkddMfZI01b90v5ic49CklNoHW4to+61q4mZ?=
 =?us-ascii?Q?HDuC2u0vCGwevCZGaN2ScFCs0s6jAz5wvHvd+Mnh+Pdw3s5tiKBM748u68yJ?=
 =?us-ascii?Q?RcEr/vnY9chQz6k7yQGen6lAS/SF4m5bDbtZeKC6ut1Hb3tHdG5q1XjLnrlo?=
 =?us-ascii?Q?dPhHQYdbOX82YE+y5eEUHRhEXs5SK3ClLBVccuFU6ACnzkeRM8R7HkyKPL8Q?=
 =?us-ascii?Q?y4OzkkryRARI/nefXxOpu3gmPGJgzXEdNhmKy0XFywozOPnBimVQYPABGFf/?=
 =?us-ascii?Q?vt/vX+Cd2orvvMsXIxGokq3nBWGW5/Ml?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GP4el1gQgzNXzCz2DcnOZqz4SCVktKwRh+DGIm/oelq9NRlP4FpAzEa3u4nV?=
 =?us-ascii?Q?j0eVerr8w/uUnvPe0CQs7NJIapZNWMKiIL6Qq0Im4pmsm9ItLYSNUokcXAoS?=
 =?us-ascii?Q?mtfVDGcH9U5G3C2JilOBSl/gOM6QNCclmW71SW3xjD7U6OQe6j26eBrXl1aT?=
 =?us-ascii?Q?nlrzr241V5B28OoesCbh1Gd7Eb2dlO6w9iLCsf2gw43lkyH6fv6sg/nwLEs1?=
 =?us-ascii?Q?Q8QLr6bEPTiY3NxO3RrLo+dF5FRkPx2TE8eFC7InMePnoA+jcr7asBg+ddJV?=
 =?us-ascii?Q?Ivlcy4dbVEdFbfYyuB3tGOUA6bsp38l0249VSHCp5n7VebdGH8qZK4I5DaOz?=
 =?us-ascii?Q?URbSEnHpgGgBHvi4jLNDwA28Sywndd/HH4xDR8YJPWKFqclX2g3s7kL7421O?=
 =?us-ascii?Q?JurTKaqDDp3mASq+sqqndTq3LFHCpOPr9Mgdb5GcBG2swbUai03zuXgEqwx6?=
 =?us-ascii?Q?XSyGNXCLyzzBFYCXxl7eX+wXq+QkhUtqi7Kr6mpwlCZn4UE/Dl1qrQ5guP7A?=
 =?us-ascii?Q?5QPZAmvl9xRY6Z+4raeGM1hMMYvo+9f13FzNhVhEt26KbfY8ckWW3ezgNMrk?=
 =?us-ascii?Q?ea0qb8QcILpYxVU4FAdxexZI652AHSUxD47Z6IihSXgYojvhJ8GX9teipo4E?=
 =?us-ascii?Q?IeTNtMmbcZ8CQX4nQQrfhjN6b2iQussMbmiwjYAQBgwx2Sua/tdo/ZDSIp6R?=
 =?us-ascii?Q?zJdC8unGAZ8Y+1Bx25d80691aKUKHviDhVAVbaGS4kEH6pIexQoG+vwlYHfR?=
 =?us-ascii?Q?IBZiLYyV8sBr08kD3crx5X1MrHAUfs3GE4e0QMtliFaQKuoIFFcpECqhQR8S?=
 =?us-ascii?Q?EavYzA3NETKeWxkaSojH6ehJLGDA/vshzhxKIryqfkkropgSNzL7e+PryRmk?=
 =?us-ascii?Q?+2OpNd0adJKIdA4Y2iPjSYxwxJ+gGQgxPU+tAF6lrhKqtDt/dlwqXtU1taCr?=
 =?us-ascii?Q?wKE23Cbap8xRqXoM9WoNKsU6o+vrW1FFozd00kdNavnLUbc80pDZswipqbS/?=
 =?us-ascii?Q?BzvFXvQWvnPlARsPN1Xxi/zQJk67E0XimKwqVhsijtcBi4fhuCinUPb1nnCS?=
 =?us-ascii?Q?cFuu9USV5hMGO4JlzemcMrqZR+yRoaHZbGbK5SeL9S98CapIQRN71imvsSGO?=
 =?us-ascii?Q?isYmFkbYF/YAa+OeQzZRTcJQ/tUwo9TwUfesbVg2mq+pC8KceN3lI1yCmDaz?=
 =?us-ascii?Q?jnUj84Uj7KR2yWcAjx/nOUzC1dJmEI9iRtu+HeypVwU70j2RilE9q3WSKpmE?=
 =?us-ascii?Q?HOdgJ3O4NQtSDvjNIyRghZE0c0lSMt2HtHX6LnSbEtLWrksNo2mnABEQayvT?=
 =?us-ascii?Q?XtMOWknAjtRArN33zZ9u90oUYDjvjD3loIP6IUDNq4VVGuBFlfgOclzVM9Pa?=
 =?us-ascii?Q?1g/n6NY8j6ZriZEBqW0PkYjDud3zYcqyKZK/SlGtNvdPCaA3xm5605JhYQz5?=
 =?us-ascii?Q?siqdfwM83cLbkOMeE6wbSl7mTkI9v2eB84vG5qoQlDs3PjyKQyj9QWdLSIwt?=
 =?us-ascii?Q?dE3CwNLaNq5n/RBNdpEEgVYp8KjsxJqpxpFUn4i1/XRwbcZjyAZbxd3sTnzO?=
 =?us-ascii?Q?8eZ0bttBwzdSAQiV61COlAd8G/Kc9b8B7J1CBdGeAbinGRJxJ1LIsygUri4T?=
 =?us-ascii?Q?TLtOoslZNVsTVLH0WC9PqC4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9b075f-d799-4828-8c76-08dd61589038
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:16.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhcVGWsijY6dES3FLYIZFHX6gW6o5jiq7D9OjpV9857EfuIWs/GuTki+A1290Glv53OrGXKs/7tAt8Puh29GgMHbRX/ZZUiuhVLTynz/LDtIlUy8Vqw11zT7hEnLApVt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18126

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
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 95b51f31c387..947fcd39b168 100644
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


