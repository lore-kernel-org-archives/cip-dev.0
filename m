Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506F2C83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:06:36 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.25])
 by mx.groups.io with SMTP id smtpd.web10.8389.1751619994651492563
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FrCazLLp;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFLnp6HBWc9j+lFouQmMh7dPhGJUI+c9hdHcUhhKoEf51+USR7pAHHoD8NY+I0k5t/d4Ss/hONMEgMS6TUSTseGtG1oGgAyg9DSQhadJvQOPM9zpcfKFYQdd6dnh5ede+hlvIyjvvkDoLF+rQSDwKPZsUhU6XUgWAmPGBArIH5JQKfnMYISOf9cA8phr2hMca6J06fy7ufHEQa/XF0zQVR2b1IG1YeZDSSqcrqm/wlnZ0iPCgpe3d16PXP3NsWQx1D7al6WfrK7pEDd4QOoI/jnxelOWFujTxnIlcHRXEJQe1RML1nLQ84vQihzvQIwnOWTnGqpT6YnOr3eIFIbznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVjsab1uUHmKuxuEYNyZe0reip/47c/q9OBsynouuEY=;
 b=aJNLnViKcEfsrF2IBpsQH9j8EVF1nBh+oDLHf0IivIcFJPRsR5wyGwT1OgL3Q3jCK1Vd/CeKpkO3gBZ0/PXup4eOf/21zQmRso2cj+/sme8TKD9ec5rZVwZkVqQ1kqttg4TBIYmkVsjKE23kr71JULtm2sRC33tKVytfixkL4GKc1knb25BYvwAk88Klsr1/r6UtRiwp0ZELaDD+JfkwOtXfxM62rjmfBw1k9dl/Is5fy05B1Ft2NdBs+PucRiKQRIZN3Bc/tsZflllBGjmMo/6yHjfC2X5grXHSazDGWgdAGIiJyLKXxxIqvSYUlo+En8ttNTmP7oWTsZGTSKcXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVjsab1uUHmKuxuEYNyZe0reip/47c/q9OBsynouuEY=;
 b=FrCazLLpMaPbGaVo9btwBQ4GuIqd7uCyGDMmOdpjBicrSY1WYosjo/urfDKHRHix6+FR1zzJ/Xufj30ew5nQfsefxq8z8D9x4pLXl5MtcEsOpibLF/ZRxuORKKrOrphs2H9uphsMnd1/IHBEPrRHSKLoq/fT+/IHUbnupx7AL6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:31 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 05/14] irqchip/renesas-rzv2h: Drop irqchip from struct rzv2h_icu_priv
Date: Fri,  4 Jul 2025 11:05:47 +0200
Message-ID: <20250704090556.669652-6-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: b720bdac-7c2a-4e6b-0243-08ddbada112c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Rc2OJ2bxoKS5+X+eHAYfPBJbbMB2QYbR6eBsi7kePFSLv0hzL58NP92RqWL9?=
 =?us-ascii?Q?iG7HbBj4p4vzK9iSb33DXYgCHh+4mP8zMfZCK56pT1bfH04hSt0ps1pIdciz?=
 =?us-ascii?Q?iom3udozrC5yIbPcycBsgLKyohPfl/MiedV9L6Upr2Rc+qjSHtpV8NNSaz5d?=
 =?us-ascii?Q?TMbbVUj1fhFiAnVUH8nsgcjYN0Mcun6FV+KHHjYS7jCpY4OCn+PInzkMhBDf?=
 =?us-ascii?Q?IVtuN093tiLO/L0Hz2oUEXhhayEvTMPJb29ZrTQsq5+l1wfm5qOgfJ+/hBTB?=
 =?us-ascii?Q?M3IXRLdDYeZ0ylMN1Ii4bSKI5Qe/sBILfGvJrSdCQK2qlARKxpdUy94PP3AM?=
 =?us-ascii?Q?yH6rUPamNJ6FOG+IkayUxyZOLzSKgg8PkS8jxztrQ/G9H5kZmB3BvawcUL3F?=
 =?us-ascii?Q?Kn94MOSI4t1YDKmBdYJfEBZug2xV8mlPptch9yNSxKIO/GzVEilcstW4zmi9?=
 =?us-ascii?Q?/t/aSG6dLi1Fk6TQcOWbWIXx+Jc5nuqP9G38R0KBInnlyIl53DrB+yJ2dHht?=
 =?us-ascii?Q?RbfUfMPOjeWlHIR6glzktLRE+HyNCT0c2HlOe1WT/4SHQkJyO1OtGEj0kn9U?=
 =?us-ascii?Q?oylxxupK0Qppq07dxMLjGBbTIP0USwH+jD0Hlb/JWcL7RH+VIe99qmbBsqFS?=
 =?us-ascii?Q?llOPNd8z1QwAdkfbKdFgRN91tdiEjYPWCcp5SgKlEojuNlqsDbu55irQIv8M?=
 =?us-ascii?Q?4LDD3ZRLXCVHzeWnAlwtUELDzDkp/LarHb6Et/ZxTCn6gg8TKVOW3PVjADqV?=
 =?us-ascii?Q?cGBECG1wxrNNOq7O9McdDxamPNXkOXmNHr9arObuFzZ5sUhSZQFhPUDXCkbE?=
 =?us-ascii?Q?e4gnsMIJZ8tKFt7h3v9B3NVW1vk07R6F/tQ+jkV3x7s0iVVHyanvck14mVyk?=
 =?us-ascii?Q?MCoKjDH+kuPmiUnEwNOa9ul1AFixARcGHGbUNvRHAv+RVHfmQXhO1VuBj9G1?=
 =?us-ascii?Q?2reu1Z05BRY/jHYfg3evlrQgFB3xlV2yhpPgRvb6L9ClxEcYheFuIaAX85kr?=
 =?us-ascii?Q?2XNVg+wagGZr2X4jwil2WILq77ekVEoAvCaiEE+vTHSTpK0Xqvjm2yAbEfaZ?=
 =?us-ascii?Q?Pb4RAG+Y5uJdtKqLJy5SWsrB9RYzwW9M5lms0cUS3gJ19mHPlOqdvfKd/zX7?=
 =?us-ascii?Q?cCHaxyQV1IUFC8J5xAUzb3TYJnfh/PGmKIwO/aTIbox+9h32/W7+eoCoVC4J?=
 =?us-ascii?Q?JYi5wcLR/quMo0f5l2yc6Q/Ui/mAoAuijp5ZZjwyiZ5JfZKyF2YqKTDLwSnH?=
 =?us-ascii?Q?x8CFNdMSo5BGfTU04OJSuEa0BaOD2bAAxBwoVmB6eiJPAUey90jXSEYA8Fvv?=
 =?us-ascii?Q?PrsRlLc77d5Y8VJe25L9khzxPtXPBYqs9U2iUEbiat1hcDE4AfVPWilIWfrl?=
 =?us-ascii?Q?UpYoE4OSRoCH2/HWuo1u3tqnNdFZXOd2pH1Hw0+VpJRXiAmhDF1LILii01Kf?=
 =?us-ascii?Q?YF7rJcsPwFpENNpTx3a7NqziB5xRGlH4cmeHOnCxsjFVFNrf0MCxPbhti8gN?=
 =?us-ascii?Q?X27ddjuViapPjIA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jzw+ByzbbGdK8FDRMSL7/FD1d2rQ6byv1KnledDLF6rDkC2Oq4e3/qCrWVTg?=
 =?us-ascii?Q?ko8qgF59W9SaSAih/D+N5e714HrExYTv1NJJkb6smmTXBjpg8lytun4cT3V8?=
 =?us-ascii?Q?OTvEHt8dRVw6RqU3GA7f41BwEmATRuuLqeBHSVuiBfTszczmMP01NCsNK/EF?=
 =?us-ascii?Q?4g1XVpbuToGItM+N3Ubq9/NHyDv8eb8ZAEIDDn1BUUElmpyWXZiJLeKMVdZj?=
 =?us-ascii?Q?OmWvmJwXJTN486XneWyuUjxBvJNOlbW0KGVwetI5lZ3yPdeCLC2AGwDy4JLf?=
 =?us-ascii?Q?EC13L+f/Zxvz69v5LWJMUvoFsH0P+h+kpI2CEuGehqBgbG3jLAY55hY9KD7T?=
 =?us-ascii?Q?PUtCky5D0M/xQFFbs2xnojCY/RhA9wUf5XYVxkc951lxBXBLe9uFNZa/iXR+?=
 =?us-ascii?Q?aDFcrmFGKszwLd+kvhWFCrW48QaE1xLhKSzzXEqg46m1IQu5VilJgn1dnG4b?=
 =?us-ascii?Q?llcn+zz06osQ8jdn7LoWMYr8huGk+jUPJXWwnELXsnTB/JFTX3TsfdMATdPA?=
 =?us-ascii?Q?N2I7GHyMVzfA+moWxOaKkTHfD5DgPClbfWmVPH5gvRSZZ83jn0fQq//+WEZL?=
 =?us-ascii?Q?qeg66BALfkD2F4ABnkbdoXogVZSII7Vu3HierNMLc/CKIX93wyXFomkifMs3?=
 =?us-ascii?Q?r6WoNEcSvG8UqU57RXPHhdyP/ElwxPmy3fYimaCCDdum0+lxBZJ+AG3WS6FI?=
 =?us-ascii?Q?YZ9GmWU5T7AatAW8fkT5duOzZu/qtGY4ah/N8jsiZmricXBu0MNG5KhpE5ZH?=
 =?us-ascii?Q?juQMN9308Bv8XxLjc4HI8acv2eL+QU08J7bE/ORxXN7xhE52e/MdlWjHE0e/?=
 =?us-ascii?Q?+pFDrJpfy/GdmwYd55owZTsNckVAcsyTMnHPCGmjj9A84/lYB+ogPDvruadE?=
 =?us-ascii?Q?HzoMNbQrhwjzP3DC5dOsaHfv8roPVhdlBctv9bu1bU6JJ+dGq6i0XLVkH4Jb?=
 =?us-ascii?Q?fhqhoaej4FfzDyjck1DWv0+9zQ1TM7IzyxgiCN6n62od7HLdSXCBAaAH8EO8?=
 =?us-ascii?Q?hpNBf3mihL/7CjEdDQ6DL72IPdWW41L2qUuytDY7szGhBio8Cy3eDAuZfYR6?=
 =?us-ascii?Q?8r96Q6Lc783PuCZZe9rqEOweobHRWsM35ElrnrUFxxpViOVUCvjP0DzFq/7V?=
 =?us-ascii?Q?apsclCx2ZWaWvyjuXodH/PZxN7+8GSBqUb1jUl7tiJQHkZyooIGYo17P/2kT?=
 =?us-ascii?Q?t0yn2MqCTcaeizsOXGlZizJGT2FGwJjPaTQgR02UpMI+gDdjAxxFE3jFSWbU?=
 =?us-ascii?Q?+OPme3JxpJtWkf7JIvAYh2Cnfi1quAgnEXP3EG0gbgPtJxcHIXR+hge/Mv36?=
 =?us-ascii?Q?HprdueZtw5xN17lVJD/bG8N+l06MLcv03bkgjWmcQXGs53RTRA9haJYQu2J/?=
 =?us-ascii?Q?F+mRsNeteZ10oVUQspVtlS8Vd6aEHXUGixT0PYes2Z/iwIqUocFU1Q9cRKUd?=
 =?us-ascii?Q?Nt2w/WcUAqbcXKQQWC5nX2026IQDxzjF3uvnDqx96sKAyxlUFTohvo62cCi0?=
 =?us-ascii?Q?+/4ssFBXEhqWi9Me/ADo+bHchixjFaxzuFjTmP4SDBMzMgWm3qYC2SqkXCVP?=
 =?us-ascii?Q?gqoN8d/enLVky9iR9F6h0CxJ5qoH3HNz3DiyOTyo2JYnMqnBJZiKBUfWoqRm?=
 =?us-ascii?Q?rayD12/qJUs/Q3gJUSxZzbg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b720bdac-7c2a-4e6b-0243-08ddbada112c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:31.3544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TNQKaSimTSJOo7CodYaPN7PkaHdMjZH+DbYY92hXchsu5nmYnTC5IF/pZy0aVMDhlj991Pd4PjmWPZHlTXJp9p4Idfoo1XnMjGemetiB5SyyJDxrKtW9j2Vo1wOglyi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:06:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19334

From: Biju Das <biju.das.jz@bp.renesas.com>

commit c56cab0c3ee063f30d1e53cca7614574e3c2cbd5 upstream.

Use rzv2h_icu_chip directly on irq_domain_set_hwirq_and_chip() and drop
the global variable irqchip from struct rzv2h_icu_priv.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-4-biju.das.jz@bp.re=
nesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index f6363246a71a..0573062c89c4 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -83,13 +83,11 @@
 /**
  * struct rzv2h_icu_priv - Interrupt Control Unit controller private data =
structure.
  * @base:	Controller's base address
- * @irqchip:	Pointer to struct irq_chip
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
  */
 struct rzv2h_icu_priv {
 	void __iomem			*base;
-	const struct irq_chip		*irqchip;
 	struct irq_fwspec		fwspec[ICU_NUM_IRQ];
 	raw_spinlock_t			lock;
 };
@@ -390,7 +388,7 @@ static int rzv2h_icu_alloc(struct irq_domain *domain, u=
nsigned int virq, unsigne
 	if (hwirq > (ICU_NUM_IRQ - 1))
 		return -EINVAL;
=20
-	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, priv->irqchip,
+	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &rzv2h_icu_chi=
p,
 					    (void *)(uintptr_t)tint);
 	if (ret)
 		return ret;
@@ -446,8 +444,6 @@ static int rzv2h_icu_init(struct device_node *node, str=
uct device_node *parent)
 		goto put_dev;
 	}
=20
-	rzv2h_icu_data->irqchip =3D &rzv2h_icu_chip;
-
 	rzv2h_icu_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, =
NULL);
 	if (IS_ERR(rzv2h_icu_data->base)) {
 		ret =3D PTR_ERR(rzv2h_icu_data->base);
--=20
2.43.0


