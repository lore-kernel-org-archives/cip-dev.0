Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1C8C83030
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:06:56 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.9])
 by mx.groups.io with SMTP id smtpd.web11.8460.1751620011469671476
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=oGHBlNcW;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.9, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylKlk4tN6RI43ODwtkAnuKviclL6aYuEFvGAT6BqWpGn3RnruMlvX1N29oVgbYizq7STzhE+Uj9t9nIYQh3uOWhH7P3/Noee/xdxxwtjcts11QgPDRmk6uzYbiBsAvY3Eu//90GiXPRWCvpa150fafkka4ixqGYPDcIWfs1eiGoDgOVy4nw9CYiY/pJImDApoiSKGhx8oV2ToREnHMaJxwcPPxLegKyEwrJ5GTr1lB1GnyHaZ92M7fnNbvO9y0zC/8VEQ7TScr6q8MPLtvVqr9fy/KAhWSye77nXeGqjaTSEU33O/b81wGAmAdFbD7BNVV5eC+ubFuIYc7t9YIGZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hqab0s6rN/eCVZ5aSsBBq0QzIpOc6rN5S6j4ggqnDgQ=;
 b=ShLIESr2MvWbX+bm+t3Kc5yFXdcp8QtNFYLCMCytxjl5kswGtjJ0fnnzWBHkuOzviZD4++oVnViTm2nxYrFcnhbfuQsk3c63EksBwjdgqxfI+hvUZFl4H4fELXfsBypbXm5vmXvBsvc0xDjkrC5VXGvf0MtPHK8AyVCTrXYTGI2xAAwWzaAwe6I/X12S9qzqyATJe//CgKL00F5DNJgjK5hKdsGNyI6gjbUkTX2yyFjW0eXmjGPsNiFBLDNzSEEna9O/HCoJbJxaJub7LmF+Yr+LZfUisRPkZpQwGAab6VUyWHn5dB5j4amA9brsYjhY8uYnO/67NABvNZSI1Eh0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hqab0s6rN/eCVZ5aSsBBq0QzIpOc6rN5S6j4ggqnDgQ=;
 b=oGHBlNcWT05aCWFkTrnaY+80Zz06qP07fsQjxrWf+dYHu5nocFmaWBSZyVC+gZmbh0F64dD7JO1+YPjVri4R8DSchSNfNnLPYXC30hYcaMaoJvwfg1WtrpAWEzyqfhPYhmqqWZ9pb0d2vDzKdnM7X83x9bZoYfaW1Wo9jeteGto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:49 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:49 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 11/14] irqchip/renesas-rzv2h: Update macros ICU_TSSR_TSSEL_{MASK,PREP}
Date: Fri,  4 Jul 2025 11:05:53 +0200
Message-ID: <20250704090556.669652-12-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYYPR01MB13039:EE_
X-MS-Office365-Filtering-Correlation-Id: fa193d05-fb7a-4c6a-76a7-08ddbada1bf7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?F5UNGwg5ZVI7KJkNtJnn6T8ZuPCc8YNPzLm0GPo/15FY7TdxNeoc29ywQ/oq?=
 =?us-ascii?Q?//ocG/gRvlKdgaXCOHdgf5SzC5vUsDQF/2AMp9dnuWAF8Q6HyktIwbmue19K?=
 =?us-ascii?Q?G3vtvsIVuRFA7jMgGnJQejKLQiTl/79bXqMX7pY8HoJ8WTtCY6UJdeFaXhul?=
 =?us-ascii?Q?LmpRO1RaiO6dFkprBWRlhg//EFYSBcW3AqCHK4p+TNQAcIezCP3qnBlmVfTU?=
 =?us-ascii?Q?Mf3XR6soEnV+ifRN1GK4ou8VsFMvzgpH5O6rcgK1UdNsM6m+85PG1RqtI2pe?=
 =?us-ascii?Q?1x/fKfuHWM8Nb2/FMifjby9hD7oWBWDHSfD7T+p+DeC3fuHx77KRMXULGIZr?=
 =?us-ascii?Q?cqKD7WbHMoBNGy2Cckw92CcMFi4GLlC3Hqexa9U5U9ewXXgRWoXo4/KNnMT0?=
 =?us-ascii?Q?etiSGFMGAOMVPFNDkls77EeHhFLPcmpq6BCAU7W1rRF9QoX0InRTA2r1gGD0?=
 =?us-ascii?Q?lh1j86D9efjgJitiJs/NYLQOPi/Kf4uRYIwuwjTfiG412xW4VmpuLgNzVTvu?=
 =?us-ascii?Q?305FT696kGF4ebAMXu/E0t+FCuctWsN0N4uYEcbhTUgi6zFqEO2K1x7EUHg4?=
 =?us-ascii?Q?dTTelkaRxZ2ITfY77ezX0R9MdwMcDkW6TdRkjW6bsCw5nSJtei3eV629gnme?=
 =?us-ascii?Q?lVq2dhdb9CiMx3N509sP3HwCz9XdgN+OL+Ub2Fab5p522TxCIbGUOIxKC8ld?=
 =?us-ascii?Q?4ruvL65EdeIjN1nQ9TdYgRQvjvlxcvH+94Bny9dzCD6KHXCLackdMfkOC/3p?=
 =?us-ascii?Q?fy/iEB161+K0zfascuuzQCeULLQ/mDs8b44PeKr14plWmk+5J5b961tGCvOw?=
 =?us-ascii?Q?45o2sMAG81iUDCflD5JMD+svkKGYtx0bi8riFkWlOgz9FJpX5i4w8tao+GtM?=
 =?us-ascii?Q?5UbHHgf7/t8gsCJK6xUuqGiFDbAVgo371rcFfLu4ohS4oZ+SL9OY/p/6Tge7?=
 =?us-ascii?Q?s5wcDD9fQa+rV/vYAl/94Mj7CsnJ46HsElwKAuZP5AKoS+IfdPkM1bCLzePO?=
 =?us-ascii?Q?nLY/yZwQVaA/yrKwPlr0IklR5LIUitTjbtooVfBsltmELjZbNTZ25FGz0yQf?=
 =?us-ascii?Q?d6+GBXxsZ0hI7uoiwauqAd/HpAMcVv5MOOhxFzM9Infczx3P3VcOEaNw2o7/?=
 =?us-ascii?Q?DA8/hedv9IpST9HrYX/xci+VBngSc9RftPxas7HSYjGC0xXtxAE24DBhW0FJ?=
 =?us-ascii?Q?2D9Ql/CmUlSBKPGzGS6y+bw+Z9hobxkmvrWGD1UAxVpqcr99Z+A0G7muI+S3?=
 =?us-ascii?Q?lTybMyWHib55Q2n0T5ywdgXg4LinaluTLlVV3Qf8GzdqvsliaH7uLKC2pepJ?=
 =?us-ascii?Q?8GOrLEawKSAVgAEU0Vop7mqFWNIPxa1RJtkmeE9k8i5WSFTHx9tgV3IuTCNW?=
 =?us-ascii?Q?W66aSZmvcDoDB27punbl0TmZh/ekaZ1RzT+I+/I9Y8hrL9zLB+1wTwN/eZKv?=
 =?us-ascii?Q?6UpTCBYnbJSk4Pj0c54/Vt0RLuTiiMkE1W3bB30pVMelVpqtmItawxPtGMJe?=
 =?us-ascii?Q?qqlpJ5wG/LemZ+c=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fiMskamYOH3L8RhyORV5UQm5p1jsoNF+V5OKZ5E76gFYBmU1H7EgbeN4d+/2?=
 =?us-ascii?Q?ybjNaSk5tPd0a6gmhNoW50hhQz5oxl50N7ynZlCH6aTS9usj4+UsvkGwt3No?=
 =?us-ascii?Q?qfwNg8iIu3STj0KLiXF9IU01lGikJMq+OT3hbeRv/tQ4g05MO2lmr/AEVKjs?=
 =?us-ascii?Q?gnZXywTiwNkfdXaVBPn/AhGOOJI1jGk9FBmklAJ3uFKC2u7AvMr/yMWx4F97?=
 =?us-ascii?Q?RQenIJDekoUaqPF4V70/5YzgILvqENXR7BANhQIw0yR3BqxEh6h6fdbb3VWe?=
 =?us-ascii?Q?xEoJ5V/bAkFIX3qMAa24OBsjgraraA0KsQwbAdmN4AvlljAcqar7ERFD+uRR?=
 =?us-ascii?Q?kigde1O5UdNXrld6pzTpBYXaSmdlRmbtFpgfeP6CjK2t5LsUyjPVImLEzSmz?=
 =?us-ascii?Q?A6UDgFsdEAgEs/Ykeb8/Ni5QQOIUbbMRUMAnrohYbIQ8dtJsVRurTLUctti/?=
 =?us-ascii?Q?FnqiQzkPI8tu9QJTMVtAKMLtX1KsN6JsdoSQ7dMemSxV7Iy3QgI69RyFxwT6?=
 =?us-ascii?Q?tqI0xWvJEUCjinmzRsWkt3Uzh59EPNSL5JK8f3sTiv1amoHLHhgNZpDQpnC8?=
 =?us-ascii?Q?2Y+dcj8Crq5ayHgAZXOugzJksTHaQZU7hpnFdPoaRGSmGUnWXJzZuYBbFFEe?=
 =?us-ascii?Q?cXA+VEzRDQIbvvKtAVWpSZxwDeO2boa54R1PkjQ4gSsS4Ppl9bSYiJ/tdh2x?=
 =?us-ascii?Q?NRNyy8dduUiTjhoNfWq//z7COFql3PlPMj4uhrC61PIDLP3e5vQeMYluYWXT?=
 =?us-ascii?Q?gUvlj8HcbcwWmRPb6UG7phK+q2BwNCl5RC49fN8yl8DrLkem1IsaYsRiLmOs?=
 =?us-ascii?Q?kcAHypIWfo0NLQLAOvYzI2u67OR5Xa3nugovncCFd84veDNoYKUaFKU/QNpL?=
 =?us-ascii?Q?YWRrkASGTmoxkN7G4KZZbG/o7AdU8Gh98oRyac7nJndfwG4TTW450Ap+2j4Q?=
 =?us-ascii?Q?nJHHtvcY/pvOdXUcJbdpwSyZcmRnvsdWp0Td9Z6fCTG23kl101bWacMhsfg+?=
 =?us-ascii?Q?oAvxEmiplAiZd9KHYyQLU1I+xCUvTwFyZA9awWbKUHfa22Jp3O9yM8Gpo1B8?=
 =?us-ascii?Q?0qmLgQrqeGFnSdicABhlBYFZmq+RT/nLV21nP3icr9SodKE9wYopX3PaW66Z?=
 =?us-ascii?Q?m1zRFyuZ2uhliVEQ65tAaSMG49evKTpGRZ0kV84XFCPbyvfzx8PIea6rucbQ?=
 =?us-ascii?Q?MISV4GhFMpUA1oT8N2gCacF6vUcAiWbZNnoB3aH6tpLG3B4gvwUO1WQjovYS?=
 =?us-ascii?Q?JV30Lv44UODCugra5dIF2yfkD9ATXpEcTp+lJX/DRl2sypaPhaXDQA1UYLZR?=
 =?us-ascii?Q?YZYLEjw0QQW79xBvmE62veNHLFnLm4Ubvt+xAgZC/HI9bhN1NWqndh47Qpu/?=
 =?us-ascii?Q?t3VtMXSaQkgwOX1PGcFsmuvsbCmd7Y2eSpPwi1p/XNLxJSrBa8h5Kl88sWB2?=
 =?us-ascii?Q?uWgxDmCx6Hcwl05cAI0bbjNtR+sn7p+fazyFRo9g43odXuIDuIAft+O+qM5N?=
 =?us-ascii?Q?TZ4UKvfbV2zAI6uUmJzeuFKhopbKUZhDozSUW3YAazjYzTU6Y0/Zh8m5JWPY?=
 =?us-ascii?Q?aBbjFuqHIRbfGRqhRv9Tke3R5zqBn3b/l7UsAOxJVf+bYKKrZTZKiWuIsim9?=
 =?us-ascii?Q?l/oZQe8TJGufMoux+PDiGaU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa193d05-fb7a-4c6a-76a7-08ddbada1bf7
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:49.4273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Soe5DwwN4nnGhHivFhQmJdWbK6J7Gw+iME9kzOaLEenR9zdJXjCvStVjqIL9So1CtDBfkSjlYjCrO3pgjWnSfX89cwlBgu/W7iqMmOWZUwTzDryv16To4qBpl8DWBG58
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:06:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19340

From: Biju Das <biju.das.jz@bp.renesas.com>

commit e3a16c33db69ffd1369ebfdf93f93a93a785896a upstream.

On RZ/G3E, TSSEL register field is 8 bits wide compared to 7 on RZ/V2H.
Also bits 8..14 is reserved on RZ/G3E and any writes on these reserved
bits is ignored.

Use bitmask GENMASK(field_width - 2, 0) on both SoCs for extracting TSSEL
and then update the macros ICU_TSSR_TSSEL_PREP and ICU_TSSR_TSSEL_MASK for
supporting both SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-12-biju.das.jz@bp.r=
enesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 301d15756504..d1e2613dd7d3 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -64,8 +64,13 @@
 #define ICU_TINT_LEVEL_HIGH			2
 #define ICU_TINT_LEVEL_LOW			3
=20
-#define ICU_TSSR_TSSEL_PREP(tssel, n)		((tssel) << ((n) * 8))
-#define ICU_TSSR_TSSEL_MASK(n)			ICU_TSSR_TSSEL_PREP(0x7F, n)
+#define ICU_TSSR_TSSEL_PREP(tssel, n, field_width)	((tssel) << ((n) * (fie=
ld_width)))
+#define ICU_TSSR_TSSEL_MASK(n, field_width)	\
+({\
+		typeof(field_width) (_field_width) =3D (field_width); \
+		ICU_TSSR_TSSEL_PREP((GENMASK(((_field_width) - 2), 0)), (n), _field_widt=
h); \
+})
+
 #define ICU_TSSR_TIEN(n, field_width)	\
 ({\
 		typeof(field_width) (_field_width) =3D (field_width); \
@@ -326,8 +331,8 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsi=
gned int type)
 	guard(raw_spinlock)(&priv->lock);
=20
 	tssr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(tssr_k)=
);
-	tssr &=3D ~(ICU_TSSR_TSSEL_MASK(tssel_n) | tien);
-	tssr |=3D ICU_TSSR_TSSEL_PREP(tint, tssel_n);
+	tssr &=3D ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | tien)=
;
+	tssr |=3D ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
=20
 	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
=20
--=20
2.43.0


