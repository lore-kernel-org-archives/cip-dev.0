Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB02C83030
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:16 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.40])
 by mx.groups.io with SMTP id smtpd.web10.8424.1751620089291489074
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=eoG5bgO1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/FSIDWrTPF8X4Yyrkcc4L35bhYi+nepgO0w9upho8S5N/oBbR0PJL+OuBHDYgUoFL9IUeerZiaM5SlvTaaKmGB00v1LI45lbBd/mBdq+g9x1EH/x5WOApBi4upHxERnIHlOqBPa9+tMJ31h8Mf2vj+Cqt95n/gRF/i4XNgRba+HYaU94oFltUdAHTEH5fqIaySeV3ibgeHGnjWfm/akRzzQ5a9Z45wXwAY0dnIabOJKmCJS2tQXmcUae2iDjhrw3ypACXK5s8DwZHDFfhdkOZg1GN3H4/pER8SwnXsQ2DJPWCm59pNt+8iRM3LaQW8KpfW0qK2IsHNEQloNloADIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVjsab1uUHmKuxuEYNyZe0reip/47c/q9OBsynouuEY=;
 b=RxuIPTNbq3Az1sRDT19Yie5kWwJNkA8X+e0c6hXt0tTK/0os9l8sOOTlKDir0hUDNDrDdOOz4FWVj80W17kQr6Fl7+j6RlVzhcczZ/mEb828yOOya+U3ODs6Denmxkef7NZI9Cwk/Rzo7y0/FKcNcgD4uY5zmTInixi47SmrYY8YLFDMRjI+pQmgi5uzYhwl2bOaMvjClywe+xOKs8K7SYY7QrkfJRYk7MLhMoe3odGfAKXY4ClOW3jBzDjXvf+8KOK9n9lxuk0+yk8JmQbEgTQa7f4zR/9wKhAlWQBhSpdTp+zl1O9mfK6JJ0iFDzRdaSuYHH6tzAjEbw7K6XRP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVjsab1uUHmKuxuEYNyZe0reip/47c/q9OBsynouuEY=;
 b=eoG5bgO1iyAwR9hJuXrXY3fI7LruHuZ6yw9qcXwGe2jO3u2EeaXGEdjx9tNKO1gMJvmDvCzgYGgixPAr2YDxdNQLAafc7cBtj0LDq0THq2Zr51UWU8fqh+AK1oWQS5GFdCqf48WmveAv89NBpVCglsmk9KuWfIZfuXSOUbmDYlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:08:07 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:08:07 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 07/18] irqchip/renesas-rzv2h: Drop irqchip from struct rzv2h_icu_priv
Date: Fri,  4 Jul 2025 11:07:13 +0200
Message-ID: <20250704090724.669848-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB14451:EE_
X-MS-Office365-Filtering-Correlation-Id: f34ed686-5727-468f-68a9-08ddbada4a41
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?r/ZuzhAYc/HmvNwhvYNfT5bxUA9qucjTh29DuazrLRlKHudIiffMAEiAEy69?=
 =?us-ascii?Q?flYDDa4EDMf2JfG3MvsP0Q0+sHU4xBmUhabwHgx8XUgSSYU9ydcz+RMHq8+7?=
 =?us-ascii?Q?XhEmnvyFs2psCsdqaPaePHJsetHBr0zJ8h387pWLoTJ9wxfPboPEcWD0DANz?=
 =?us-ascii?Q?blM7SnYaTIEdCOYTdlyS4b0fqFKItik6GduuTkzKNcAloH0pDLXufDP45/+U?=
 =?us-ascii?Q?5QIcWCDBTx8TqUbmi95BmJMRxGpZWYrpjhPp2n++FKymTxYt3vtOb4XRUpLd?=
 =?us-ascii?Q?E2GjPKci18AMpehrd9sJ+ji3lGK2yiLzr+zq3KT28lsP/OzFVCPiZWuY1L0L?=
 =?us-ascii?Q?sxgikiEmNE602TUFXZAn2BNyPWCS0XguVgdQG3pEHt58AN1PaITxZbTaakgF?=
 =?us-ascii?Q?ZQpbwYTwovmoTCX9Bad3SxuLEi0WKCvqSg/ODpNl5ceATMu0l83i0Y9VLPEH?=
 =?us-ascii?Q?ypvVGSnF0cmpYzDrqYRrMz9+iZxyaRbJ05KddlNzDPepY3vHJewDSo79tkiP?=
 =?us-ascii?Q?B04PP14lZBP5ns2ljPGWw1ySbt5xYzMOqKlpdlwAQRfFcxaPUSncYjWzxEyu?=
 =?us-ascii?Q?App7ySssoLwhXuRHAIzxRzZM2lXe8mvVofbwxrMyWmSn5JcMGeAj9d1oj3If?=
 =?us-ascii?Q?xBRKHafYO6r4BggXUyXrFdn1T/w0rBiIrPyRb1s0Z9QO7C6zu9cWecxHxeU6?=
 =?us-ascii?Q?/CC9AYa7NPYsh2HApFp3lHItMe1vnr/xYu40XXB9FfnOl/nbkc/I8QsoVoyi?=
 =?us-ascii?Q?W1s7wg00KueXeBMIYNM5Qtc8XFheMfqTyKf+iEYEBkC49fSOv5a9yUzLF9dT?=
 =?us-ascii?Q?kszs5+Q+gogQjMubpil4/Wv2JthKBBgkl0qkhynBpL2V7jaaYanfCe9iFd1J?=
 =?us-ascii?Q?Ey0bdoLSswOwscOza+dY2D1g8BZV77NlktmZH/LTcxqofIJyBKpLHvbQ8QAX?=
 =?us-ascii?Q?EX+BIg4VQKQmB+dQkqNENG0z4FNkb3dO2l75SRl4+h2EVHXEUXzNzT2A/h4H?=
 =?us-ascii?Q?eSTXOvjj29DhHKpYjcOMxVkkvNdzof+BjOVHhrO2L/kZGSENHhqpAo1tlSaM?=
 =?us-ascii?Q?frZaaT0hDDjnCtz5s7BomFwFUAY9PxjoDsr/hG5YeUAGcT9XN3D6TXNjQlEe?=
 =?us-ascii?Q?0mo3GR59yosV/bF1DCyUiTeR0yWnGXOKS8Fx5Xok2eTgeYAafn94lSchNGkm?=
 =?us-ascii?Q?Y5MCsO70SLPy3Uh+NFfBQxSnOajt4DQJKHIK+01j0hCm/LiTEU05WG6gjEp+?=
 =?us-ascii?Q?uXCNFF1hTWonKP5C6EvSdmsaoX586AZhf7AYmcJGnQp8vKXNRYcHgQRI2yTb?=
 =?us-ascii?Q?F8T40H6Z9FukJG/0DwMT3t/GEa2yquHGJPwdrdBC/fvJna0cG+QSRsSR6KMn?=
 =?us-ascii?Q?zzSQjXcIGJGh0HRf3lBuqJDeOp0yiqCZ8jDYT8BCaxQs13xglB3T97boyGiq?=
 =?us-ascii?Q?UQWKR7syrWUy+Lbw4qUvA3p34E7yfYIDSUGknGNS9g1EIvApUvDM4oijMktK?=
 =?us-ascii?Q?Y2lxTcecQijMZ70=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dRXvM5YesmxmB8xKDxySBhcMz7L56Hr1zZPJLJCX0+M5PuSAl4YSu3K1gRKF?=
 =?us-ascii?Q?9jhuDJkAOT4P63po+/GFwrPrgNssIqOrFq1IgvPQTD5yIJPGxKn+wyzBCini?=
 =?us-ascii?Q?NpBI3amuLq/4R/ZS+7H4Lll25zDkuosS5MkYkAVbW2ZWr/qxGNvxuMuH9bYO?=
 =?us-ascii?Q?twDljjiCF7jWkCeu8DPSuC/3Baaxl42e8h9EWdlbIJqkPBfcoWjoiXAlQMX8?=
 =?us-ascii?Q?Yhdz3zoFEA1CMDbl8nV0otwyYfrXbZUcAuy0JZfBBKp1G/n/B8ZuMLwzd7gG?=
 =?us-ascii?Q?4t3Z0tFtlkUOyy5u79VUzYAP8W+jpvpkuVOBhTkNiZGvCCe38+Hsy9sISXf4?=
 =?us-ascii?Q?iAYfVYECXBPpW01fxhyXPwIZkg7j8gpxzOl0+xCkXLgcRZ0WA6uaDNwpWSch?=
 =?us-ascii?Q?gULm47cpkuLk26Age1JlFilMz4XYam1doZLBxxz49dIhLm5geexbOdotlRxH?=
 =?us-ascii?Q?8xJojiDEVLIGklzl40UitC3swueimknYNBY2iEiHZrjTbGKTsfSNpBm/djlI?=
 =?us-ascii?Q?HtiQ6gkWHKg4gUBdoY647QujcRYkt1ORkv/wsw7kqfW2A8NTD2npvPBdiEAZ?=
 =?us-ascii?Q?X3qX2vDJvZgvzcf8Uvrr2d75/dgoE6XsY5ao7ai5cEXIpjHM3jcQadNHkQw6?=
 =?us-ascii?Q?6LUZbFgc1Ql6exPhR9OfmKgzO5zXDDcE4RVDir84iLQvDuo2dY+qTKiuzDB8?=
 =?us-ascii?Q?oDmAKngsim6yOYRg11C2ZAo0lFqCZwksxZTMKKewlUq2NyRzl9L4JJHYh4tv?=
 =?us-ascii?Q?MqUDhAMK/Rta3gXv1eHWltSF+OGIzHnwusoI+PojC8ned2wjDzyRTd1sGL2y?=
 =?us-ascii?Q?DjKIkMi8i6CYUWN4EUGOddF7yPyOpzsxGvm5b8S1BM/crTrP187+Ho9Wv8ko?=
 =?us-ascii?Q?y3rkCVBRWRxYWpcvs5B3HHc77eKhyD/6ptp94HHD/K3mS4m42/oRKNImR+ny?=
 =?us-ascii?Q?knoYDqZHNj3rxiqiNmDoJ5UKRbz0/xKnssSTztAVYZ4ipsdGjEFI7dAx7z2q?=
 =?us-ascii?Q?1i9hxxNMTHGMHPzSBejTX76IKqfVTr37TlVTGOQhQiD2h2HavznSfOXlp4BG?=
 =?us-ascii?Q?Z6AFtCsN5wxqVjSFue1Qz0rCj3AC7iPoedAP6lmcTyOY3qeDqmFiWIGrgUpT?=
 =?us-ascii?Q?NN749agJSunklqNUtZ7ook0Jc59BFswQE4a3jRzn8LEtvEw2mztBX+278zaL?=
 =?us-ascii?Q?/RiNYXXM/AutzqDW72FmI2KSVlS3TZ6zFFgnoTtKUHD1/zK3LY8MeJLqrXoG?=
 =?us-ascii?Q?dtPZnGQebXFMoN6vGDRjZDR8tWd3uQparJ905a9uZyYjJ4Hjjp9uu70NytHI?=
 =?us-ascii?Q?Jrs4/NAXPiqhujVNXxQ4eRrVricSc99agUJgcANHGQ6p7sKsgb47VXsJ/7eP?=
 =?us-ascii?Q?HS30Ditu07KQKKpJJVpka0B95CwotGzuy8RDxzx77fwQkcWcOZhiTwZcI/k+?=
 =?us-ascii?Q?/0NuxI/+JN/r0MjTbUKmo+/aLOuTDpQWbEBgR9HNljihDgVhEo3Mgu1e9srU?=
 =?us-ascii?Q?H5g52PDy8TrcbwJlPKvMw6TkQPLhk8VONrdvmtj/RmZ2pQIwlR7cNCzzIkTJ?=
 =?us-ascii?Q?oo7G/IRLmiPhaP3/xXqFJf4eeiFpKEzGL9wHHHJw69zrQhKgdVvXhqdKgGEU?=
 =?us-ascii?Q?90ZCiSzpOWksWCpS2w1QGVE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34ed686-5727-468f-68a9-08ddbada4a41
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:08:07.0912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRhsz/0pjrhR0ke3Z9GVWeCrCYtYJ5m7Y1q7k8vfTjq5n++ofCvojKP/vzuYmiI0JFxf46WP2mVUE+lZZ/LVYJKhZlQIpy7RykxQsFOAm0nQ5OULq8eiaV5AfQlISr4F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19351

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


