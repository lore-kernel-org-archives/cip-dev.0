Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953FEC3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:51 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.20])
 by mx.groups.io with SMTP id smtpd.web10.49075.1743418004815614726
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=aYlBNBa+;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.20, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L63B3mnBvxF2yM+zTxvHUrTVBlQ8858xk2xixiMKFhXPEIg7w/J3HrkmIx8VGXL2i9zaXh56IW1wMDOm4vQmyluSIi1Dh3vQrhbDcTG8za0ltOfF9bbSUUb89Ou2YhKJLrMRcJupQPoJTw6SivnfpG7Po1ULz678q+z6M5q+eZNvDZylIrW966uq/huOIKJ0VyGHFme1iruovyaD3hwvj62/cXXfbKvt+VKcOf11xEQmthNe+qHBq3+WhOqZ95DDdaITES023QNR1vHMLe7RCVijbzcQ7rXUYPwFzB0j4MzTSFw8BvDT/B77MUvRl7j9X2WpfkrrdBiB4Xwe3ow6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGN8zPMoyfj2E92phbzrJQzjZcjhjsczVuG3uYR7fDk=;
 b=iUj6uBxNKlhnM51X8C5sVHZDev+S2l1Fqig6vBKFn5GFVhNwe4FoK5Tz4l1Ah07jZsmUxIIgB7KUptvI6oosl3+n6peIQHA1iqX97zL9rlwoGPUGNtGHGzDJuPgt/zOCzTF+zBvGYnD6NtyOmLWX+w16dD3uhhiLXASWABarT+mMq79MBNuX1vGy8BggOEcukhjiaVlib0OWRTUi0qol1SeQAUJqqxwAOPEO9I8udZRCqr8hKQclI1phLZEkORd4+FGqTiCv/3au5sO4s9I00FdJkeO3N58nD46+yeF1IFd7K+uEbC7hYyfQri9tLQmOnlUInvoQI5BCRr9HNk9Ieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGN8zPMoyfj2E92phbzrJQzjZcjhjsczVuG3uYR7fDk=;
 b=aYlBNBa+UNWevsNRo1kyK1v5eGgpq3xNFcPZQafWGhPx/ePOBMV1qrwVJEnVQZ7Nb57muaU50uHH+iPtY+wFtnji1aPb2hUAWi34+rqSH35Ox7ETqQcNnuNHkJYKrWtl9jp6dYeZ094yK9iVAi4Hi/bXZbdrDLkOvkDMhgU1ezo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:46:43 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:43 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 24/43] pinctrl: renesas: rzg2l: Clarify OEN read/write support
Date: Mon, 31 Mar 2025 12:44:55 +0200
Message-ID: <20250331104514.79090-25-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: b508f711-c0cf-4744-5a9b-08dd70415348
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1G3tRA91h/7D+QFhUyLRGXIDxvqeyR5TORoQPN9XxUfUCeeBbN/Q9CaG/y5J?=
 =?us-ascii?Q?0ka1B0zv3bfh3qoxtaAu5lfUus1mwmApdHbgHLYg4dEusWN80K2hMYRkskke?=
 =?us-ascii?Q?6ndfBNsIvNfgISPCiVkED+szvXtQ4mwpDC0o+zJBJSXvQPA03zpd5q522duW?=
 =?us-ascii?Q?qtf9nK4Bdozxvrc1ETDi/tw8Jr6hqSf9jdRhQDsCIkr0AVhaj7pPyN++SnvU?=
 =?us-ascii?Q?8GN4FY2UgGN7CnRRzSuFLqCIMk/ML29GtQO6vRiOjSTpxiKVvS4GRo3XkNNW?=
 =?us-ascii?Q?PA6fewbPnFsZ4OpcxfnH6xxxJmOFpVaXGqAaCQSolRa62/Y49MokBMbGY6ZF?=
 =?us-ascii?Q?VbPuOuXfBgH/LlJOlzlG5x72KllsgusqLyNQy608KF+FF4XHwkpj5D8YoaFb?=
 =?us-ascii?Q?O3dUYpVdKJgjDHHE7GxPc0UJtMEka/8JAuBgDFfRqmqobDbphavMmgs32qYG?=
 =?us-ascii?Q?ztObGJJ/Lp+gLxwQ7MEIJ47KYGZUl1HoPML7B1rSmWJSNQz1HVhrllPZ133z?=
 =?us-ascii?Q?2juQDfkzGxOOT+zQX7KMJKoI1dhfRWiQS3HGNwqD41Gx2lRn/rVP0GjxPRgA?=
 =?us-ascii?Q?6cL+61KMKc8KakDPm86XDBnH4k04mcdGIKaI27bXHNv5HM9nRrl2lRvjJJXV?=
 =?us-ascii?Q?ZXS+hpefGq0FWlr04P2sSRfVIdLFwZfaZHbmdIMrUrGsswz6hoOs0XkNJKNw?=
 =?us-ascii?Q?dgI6DZQdHKlAwk5EPLAv4myc0jQ2yXROoVrnFZCbUOfEzDsP/tDaKvaHkz7Q?=
 =?us-ascii?Q?AYdudjMzg3XfIgYLJwxKor0Nx3A5a7PIlF1j7a0YzYAn67sumwXoUcYO0dws?=
 =?us-ascii?Q?OLKg/JXM+xuP6xwhSPpSDC2tNBbeus6FmUtQjfnZidFSiHPeJR3JsqMYQykD?=
 =?us-ascii?Q?ISD6GZM8uNJIfylPricT0RUrMD21Mnq9w+6hAD8XVqaHv8fuW8v0CBLVySiE?=
 =?us-ascii?Q?+jXCTHvYaiF15hbB6x2qrF/L+SRZP3YUmHeNKUqVooGjWWpI2EEulKCypEUT?=
 =?us-ascii?Q?TJBY1OgxBYVz/Iu/Of+8TtHX/ulLuw/WespR185UCgQy7r0eO7YHYCp2qYi8?=
 =?us-ascii?Q?WANgLSvH5Iv37S7rcDmLP5t41QqxvffBT30rtiwlYtMMCl/kgWi8Cnf6yykH?=
 =?us-ascii?Q?zDLpcemR7N/GNIhdw1QhKT56c6kkT2VLPIRtuz5bSc0bePTtXnsX8D+nxV7W?=
 =?us-ascii?Q?peBjz1yri2CZdqqPqHfKSxvToijxOGmpDnbv5xI918gsJk9PsCExE4pvWugE?=
 =?us-ascii?Q?fEHkZQjks/gDsBwpWFbw3bwe551k36Ad0+/NWE26sZkecZc9qgDJwFplxGT1?=
 =?us-ascii?Q?ZN2xNQ0qX2cK9ZnGR3BcjFrJpIc4vyBIm5IMrHBsNXjtHoz+vBXijfXnzx+V?=
 =?us-ascii?Q?aduOhalOVALgM0mIz3y6DsKIY64/uD1Fcdhs9lOq2v0NIDH39pqWOf8sdhru?=
 =?us-ascii?Q?q16D2iE8mzHjOKRNd5FZh4TP6ADxAPao?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JnDx2gcRe1EvDVGnL/KFgznUiwbIlZpZzvEcATmbsVeXp+3GWlrjPiMW59eI?=
 =?us-ascii?Q?tXJUhtaH9Kb5lGzbFY6dzZ7pkGn6m9RWoqQ6DRrUrTbNFnAP2mvFALnzjRfT?=
 =?us-ascii?Q?8fjX5JIk73bdU9DlyVwbBSZpp1FI6ujd0VdzPcYJprexh7S3G6J3+ucr0qdA?=
 =?us-ascii?Q?EUM8WzesOZtI20gHHUO3QzZoAyVeshKZLDGUIJW+vAfn+4DPvfpDZ+gsDWmK?=
 =?us-ascii?Q?Okv432sdaZAvD/cK6oQM9mfcnadv9FmmPqbu5ZTDYHMH0cM4tCaSGUCCn0rR?=
 =?us-ascii?Q?5QN2HnEpAg9eVy58+p/1JHpUcwfd6/ACQJNVBj79DsfN6PiMaE+tauESbVxo?=
 =?us-ascii?Q?2/SVCgI4lM47um6pxHb4wUYCd0FoY1FWjcou3O++NKashHL2mRAT46WarMxF?=
 =?us-ascii?Q?GCVT9NqoA6pmQFiX4zL7oyQOYVRQ4ZQT8Q84d9FgxNdDYFuIyvzRDlcSYuZQ?=
 =?us-ascii?Q?0uiE0whCs6+OCehIijThKHN3kf/3Y7LPSWMzX7VxGlUI2rwYMsVoBWR5VJd5?=
 =?us-ascii?Q?WQWNWOmqHmPFf59J7ruTveQ/+SnmU2oylBHBwsSsZZKm/QrxKF3n+ydPyr0k?=
 =?us-ascii?Q?sf3NwHuanpOY3iewXq3FnkYk0Sfo3cO52TleeNek6S/Q2MoOwJkjCBs1ooBI?=
 =?us-ascii?Q?qtyrYPYMIJxamQef5nhi3MUf/YtSOcT53vWYcAGtpi6Atj1ZwyKpqSrDK4V2?=
 =?us-ascii?Q?iZstiByqm+3kKlLVmI6rU0RAGtfFi6qh5sW//dVRoDhUZAuK0xa14tkm11ed?=
 =?us-ascii?Q?OMhFj0NBI49eRCOqQcjtNEcgN/lNGL6kP3dJLAAGNkSCL6y9bZ4VLmUnoa6J?=
 =?us-ascii?Q?LScLexCUn4XrGfiGsSSA0E6sbtIHwLrgU9dwPde6S/UmlKYPI0/9SMKboxin?=
 =?us-ascii?Q?kQoGBlv+uZAZMrBVQlJQas55FQGFQxBxBxK+UgU3z6DZT24z6xJP3Oew4ogZ?=
 =?us-ascii?Q?l2wH+9fVtxywWd+lEQTBAqfHqMeePQUVemu6WhaOC8fcLJxTdtzD8+0xfU7U?=
 =?us-ascii?Q?KMQdP0kqejKr5GvS4oi+GX8tIwYRcamSsmlTbAVNbKpFhp9sz08OUzXXJqxD?=
 =?us-ascii?Q?G0bSwpWoiNY3174l/yErCSDh6hO0oXdrQRnjAClgMfg9pyaw5lST3GzUb/Du?=
 =?us-ascii?Q?ha0sDZN4H4pfLxYWrLz4unCoEaHRzqEpURH8M+SH96Z9R6sGuzp1fqBfdgag?=
 =?us-ascii?Q?XDXxCONBNIthBA5oWTr1msk/TmQu1RuoiiL9cY6RapClm572bj6ZdnCdIGbX?=
 =?us-ascii?Q?/8ZDYFuwPW4jrYB0g8Bj0C2osN3ITrYP5pXdOMEQTn6F9m6dgtKP1vibNflg?=
 =?us-ascii?Q?7OjBTi0N0meGXwOxn+eFQu0M2Ss0Bou32+xPpUjmQepVU97qGrnMh6sBGNi7?=
 =?us-ascii?Q?RPO6evheS2v+ns9l68DWryQdDqYZPUgoh8Yiko3z6wW5Q9sIlXbwAZ4Zg286?=
 =?us-ascii?Q?PTtLbpHquQhLHsB83lL9Hmn0KqZXT/lreSWKGAyI3/4Y3hR78nLXz2UhLAyR?=
 =?us-ascii?Q?PgK/MthFyPR61keMhNaViYxQwklTI//ClSlWQtLybXRM70j1ygfkt/XYAOZl?=
 =?us-ascii?Q?Q+8dmoydYzA+TbHP7uR3gYh8gr3gNAtsN+G8Ni87cPTlBtn3p2Ckgoz/u4KR?=
 =?us-ascii?Q?eXtA53D+NB7v+FSJir82OJ0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b508f711-c0cf-4744-5a9b-08dd70415348
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:43.0048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiCqpLAuogVV634YICL1XS3MGfyqDF+/8VMeX/A/Ch+PxYxyJuU0d1yxcNLTWvf1a/f8SjH5yNwr884KPky0fvtGqBPllr+Ne3A9ttJASI+OIXLB7UB8wGmTTLIh5Ilb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18412

From: Paul Barker <paul.barker.ct@bp.renesas.com>

commit 07dd08c39eb4b645a0e2f2440a54326b49944705 upstream.

We currently support OEN read/write for the RZ/G3S SoC but not the
RZ/G2L SoC family (consisting of RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/V2L &
RZ/Five). The appropriate functions are renamed to clarify this and to
match the callback names.

We should also only set the oen_read and oen_write function pointers for
the devices which support these operations. This requires us to check
that these function pointers are valid before calling them.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240625200316.4282-2-paul.barker.ct@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 28 ++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 7d76e0962e5c7..5159dff565b74 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -999,7 +999,7 @@ static bool rzg2l_ds_is_supported(struct rzg2l_pinctrl =
*pctrl, u32 caps,
 	return false;
 }
=20
-static bool rzg2l_oen_is_supported(u32 caps, u8 pin, u8 max_pin)
+static bool rzg3s_oen_is_supported(u32 caps, u8 pin, u8 max_pin)
 {
 	if (!(caps & PIN_CFG_OEN))
 		return false;
@@ -1010,7 +1010,7 @@ static bool rzg2l_oen_is_supported(u32 caps, u8 pin, =
u8 max_pin)
 	return true;
 }
=20
-static u8 rzg2l_pin_to_oen_bit(u32 offset, u8 pin, u8 max_port)
+static u8 rzg3s_pin_to_oen_bit(u32 offset, u8 pin, u8 max_port)
 {
 	if (pin)
 		pin *=3D 2;
@@ -1021,31 +1021,31 @@ static u8 rzg2l_pin_to_oen_bit(u32 offset, u8 pin, =
u8 max_port)
 	return pin;
 }
=20
-static u32 rzg2l_read_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offse=
t, u8 pin)
+static u32 rzg3s_oen_read(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offse=
t, u8 pin)
 {
 	u8 max_port =3D pctrl->data->hwcfg->oen_max_port;
 	u8 max_pin =3D pctrl->data->hwcfg->oen_max_pin;
 	u8 bit;
=20
-	if (!rzg2l_oen_is_supported(caps, pin, max_pin))
+	if (!rzg3s_oen_is_supported(caps, pin, max_pin))
 		return 0;
=20
-	bit =3D rzg2l_pin_to_oen_bit(offset, pin, max_port);
+	bit =3D rzg3s_pin_to_oen_bit(offset, pin, max_port);
=20
 	return !(readb(pctrl->base + ETH_MODE) & BIT(bit));
 }
=20
-static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offs=
et, u8 pin, u8 oen)
+static int rzg3s_oen_write(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offs=
et, u8 pin, u8 oen)
 {
 	u8 max_port =3D pctrl->data->hwcfg->oen_max_port;
 	u8 max_pin =3D pctrl->data->hwcfg->oen_max_pin;
 	unsigned long flags;
 	u8 val, bit;
=20
-	if (!rzg2l_oen_is_supported(caps, pin, max_pin))
+	if (!rzg3s_oen_is_supported(caps, pin, max_pin))
 		return -EINVAL;
=20
-	bit =3D rzg2l_pin_to_oen_bit(offset, pin, max_port);
+	bit =3D rzg3s_pin_to_oen_bit(offset, pin, max_port);
=20
 	spin_lock_irqsave(&pctrl->lock, flags);
 	val =3D readb(pctrl->base + ETH_MODE);
@@ -1220,6 +1220,8 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_d=
ev *pctldev,
 		break;
=20
 	case PIN_CONFIG_OUTPUT_ENABLE:
+		if (!pctrl->data->oen_read)
+			return -EOPNOTSUPP;
 		arg =3D pctrl->data->oen_read(pctrl, cfg, _pin, bit);
 		if (!arg)
 			return -EINVAL;
@@ -1359,6 +1361,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
=20
 		case PIN_CONFIG_OUTPUT_ENABLE:
 			arg =3D pinconf_to_config_argument(_configs[i]);
+			if (!pctrl->data->oen_write)
+				return -EOPNOTSUPP;
 			ret =3D pctrl->data->oen_write(pctrl, cfg, _pin, bit, !!arg);
 			if (ret)
 				return ret;
@@ -3070,8 +3074,6 @@ static struct rzg2l_pinctrl_data r9a07g043_data =3D {
 #endif
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
-	.oen_read =3D &rzg2l_read_oen,
-	.oen_write =3D &rzg2l_write_oen,
 	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
 	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
@@ -3087,8 +3089,6 @@ static struct rzg2l_pinctrl_data r9a07g044_data =3D {
 	.hwcfg =3D &rzg2l_hwcfg,
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
-	.oen_read =3D &rzg2l_read_oen,
-	.oen_write =3D &rzg2l_write_oen,
 	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
 	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
@@ -3103,8 +3103,8 @@ static struct rzg2l_pinctrl_data r9a08g045_data =3D {
 	.hwcfg =3D &rzg3s_hwcfg,
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
-	.oen_read =3D &rzg2l_read_oen,
-	.oen_write =3D &rzg2l_write_oen,
+	.oen_read =3D &rzg3s_oen_read,
+	.oen_write =3D &rzg3s_oen_write,
 	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
 	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
--=20
2.43.0


