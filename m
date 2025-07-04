Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CDDC83F0B
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.58])
 by mx.groups.io with SMTP id smtpd.web11.8491.1751620100905763729
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ghIYD/9f;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.58, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3/B4haE6ml3B5Icsw4jD2XQ8Xae+M/dIqUdDxLbFnpt/gafTjPSwkie4J6cE+VIe2pXQYaKUA5ELKrgaMuWPjryTgk3Vop/5nibEkytJ1Gad6Uk1zZPzIFi0p9GOG/YeMQ377gPf8SGTVNYkMCAsmJFBf9SUPE1m1QY9yqtW/6kbHuulYXlvnEcX0InwYBUtFaZw5H6hhK5GH1ZcXk/mZNKNW8INeqhDS146pfLrue1dq+bmqQW48Iin6P0tBTBB7uMKVyuIBHYtwR7zIkrYdbBQNh/vKuwxLTdVHbr6IuKK/5KZQdDY5h1oAJ/fGT6p77HcCh+LC8X0zoIXytcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySg8ek+MiZwXBuZxxV09ciPp2CERawOj+q25yLmQNFA=;
 b=hNzZULcPciEYDfPVjb9cvqfvuqcvPyx0VO2R7D/pBoe/TOCID/lO+5crInkf1op2+soyyKub+VID6c2jAQMi7197vHUOR2uwW9XnOEu1hYF9O1/5Q1PO/8ymsUb1T/P0W/hWVd5n+GW7pvpUXhmICURdcLLvZkfQQpyeiqbU6kfi1E9l4j08UdF+5XtfK7jDx4JoqYWhOk+OPyUPPMieyfURp+RygulkjlBZDWh4oll0JK/ZdyUQzs7PBrHc6FNndY4bRbad4Drsos4jhgJO+lBpSeKAriktJjOZsiJjEpFyKp7jDrZxuC5KlHMQmsfcehxZw+ep+B88h5WWm9VqyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySg8ek+MiZwXBuZxxV09ciPp2CERawOj+q25yLmQNFA=;
 b=ghIYD/9fLrAGaDgSEKskOhWN/K+v6Xse537w3X92plMTCQYrA7uPO6+o4LBFqi4kTFNuD3Z6dPiZlFAYeY6s/e2YiYOis+AFRQ+4v8iPv/X9xXBu1hll/BFbY1dcjFjz38CnK4FWqmUiN+GRJII5yZjSyujaHNldKDZdeHFnlkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:08:18 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:08:18 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 11/18] irqchip/renesas-rzv2h: Add struct rzv2h_hw_info with t_offs variable
Date: Fri,  4 Jul 2025 11:07:17 +0200
Message-ID: <20250704090724.669848-12-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8a5ce35-5bdd-48f1-9fee-08ddbada512c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?utDtf+F19CGVjNDxJ3i0tY0x9XYc/rD3EUpI6ptUn2VnZW9R8luxcx/Amzuf?=
 =?us-ascii?Q?Uxhpw7Xhb9LLEvDf/R1IqvHvJWv76HC9KbMIh8oDKHcA9PREzKEXPPhnauQ+?=
 =?us-ascii?Q?tf2aQwJIcHw+LV0QGUsush1ougfTYsd4x4zwD8+DpOw84187EoDtkSE0DMcB?=
 =?us-ascii?Q?78gSAo+xOgMNGdaCtFJqT7dQqxvI0S52I+VhKfRxYhr/1+fVUUBPhivgbNx7?=
 =?us-ascii?Q?TQWxUZ1RxgOZrrJTvibxCmjdnz2Qg3ikVBCMwu/SAZVLLp5nriIK/p42muLM?=
 =?us-ascii?Q?XvGFWI7clZmXgM31ktU+QUiapmShF49/kZM/oJQvrQYCc6MWY8AejKhHzIPs?=
 =?us-ascii?Q?w3gGsQ2vLiaP5U15YxnHOz0fx330SrcOtk6f/SN+BJtYm8pfWJSlvipIJ+2C?=
 =?us-ascii?Q?l1QWA8gGiFJm9nh2+0r7YQvKgbuAk+OjUTxKe3ZHzSYvNEWJzEHkDWftrAkv?=
 =?us-ascii?Q?1IomCOHdKnzhNKgFyBPirRrM0kmgj5K2vdZODcgjvd91NWDdAXXfE7I0GTjw?=
 =?us-ascii?Q?6VgN7s9Bf7wMhHxoOB2Lly7fYkUtdx94WHnzRPjUHTNmHVQfSrljPjOwOM0/?=
 =?us-ascii?Q?4ryPi0ZzaQijiPFZrhTpl41z5SEjkqyTlXwBEH1pXLGMrE6e4kQlPkE4I7p1?=
 =?us-ascii?Q?NbxjyiBYOsy9kWTpBstD27uV8GDAyZ0v9XJVuFK5jJl8iPILsL/uq3Q8eyBE?=
 =?us-ascii?Q?v28wXrS9q9M7LCteb0mlSW61hX9iD4MUer0g5lptdVU+WlUakLjhv0PJzMT6?=
 =?us-ascii?Q?j7e+ThnhoCZdi7QJxiGqEW5LMhf1V3DdLDLWTkWBFXodp7c0Lj9YIu4n8gy8?=
 =?us-ascii?Q?j+93t3mMyZEVwCFGNJc4PoGd/YHxPRDS10T2o0nngjOsgkzUcCsZzDoYJrsm?=
 =?us-ascii?Q?adlsw+ow21DMLFtd/lhPl1UG+5/ZZpi8EUnUfvY40tCYVEWFs62dpLJ82dIU?=
 =?us-ascii?Q?ePTLXNyuWOT9Xu9lyuGLDd43jR8P/OsOTQRzUVH5TVc4wNI/AawASkl/e9u2?=
 =?us-ascii?Q?4be65LAPK0dBTlHxPJbCTuhWgUhObctRWs/VGxz25jv96kbnyYRK8+PGXT0m?=
 =?us-ascii?Q?7fVKooS6ccEXlTOlSxkZjSO79TzxdC6FBA6DHNU5Yok2c2DquqUcqnQRNzkU?=
 =?us-ascii?Q?UrSbrWQfVFsk4PAPEpim/qNIJJlzr356jMLCOPmxSNsQnPS2RQJWuo/2qmdJ?=
 =?us-ascii?Q?/Fpx3tu+EKbFE4oBs9gY0U0oHpI5TMFyBvP7ORNJhdN45pqoHw72TFdUVlHd?=
 =?us-ascii?Q?iVmKjR/EGUOKAIlpmoEvVCUluJfaR/gAiqHljXTptTJNZURbFIHb6a+t65Gk?=
 =?us-ascii?Q?iwpohJIOmuNuY4I1ddYYBXtV6Yd/yBTbH2sV8qYH/AeBoXNzMSw6GEMM+0CY?=
 =?us-ascii?Q?4tqaAS3J16tGAGDi797qx1aHzJA6Yj+Qj3zOpOkg9jKTSLKPRjES07lomqyu?=
 =?us-ascii?Q?kLiF5AUbJ/3UfJlwsy5fXNWmqr/XKbgD7+VSRbgXH2R8DK/opaBM/4xXlNsh?=
 =?us-ascii?Q?xkPyH/kHcmdCqkk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZINcfCDAJP68wzuLQljIB4pFULgc/WNropZmgbZen1oXXjFHg3ZkSBQ8OhD4?=
 =?us-ascii?Q?GXdWNacwICKUsdod7SIWDtYEu2s2+M6tN637G64f7AT39Jw3af4GoS9Jca4v?=
 =?us-ascii?Q?7gLkIar7qFYYq8QgLT+t9y/q4gX2ShkTshLWNUnbn/Xc/XNJgIoxMXlVI9/L?=
 =?us-ascii?Q?h9aUet9x6Zck/QX7xVVJntXLpHTsHBrHsNuwSlW3QEIDPYc9ZG9kyV+cBRqj?=
 =?us-ascii?Q?j3Je2z+xtRmLLKUtXyJKEda7OrK5k9hj5utO8LnRmP2jbQQqCJXTADJ0jMvR?=
 =?us-ascii?Q?0VHAxEbGXeyqJKjSSG8rKuAN84xi2ZNhPayvPMWbcfZ0FJzGW+qaJpTG1UkR?=
 =?us-ascii?Q?VvYkmEXHk0EHYHfEjPI/AaC4DhL7d72dIN2zjYXINvjjH8H3yeFPRua5PqOo?=
 =?us-ascii?Q?NtBz4NzXPUpCOSyjO1zT2Wuyw4ghdx0aDm/TpZIlksbf+8uFBmGpWl/jzC6h?=
 =?us-ascii?Q?faEBbl6e6JVGjOXfEduSD28InwN4jdbi0v0LVa6c8K+4k40+0KqFoR9uczd2?=
 =?us-ascii?Q?hK2/jldfFURHPpUjdNqetJvVN1w2+mm6YDmbGPRqIMMjSjhWGRckYj7MTukV?=
 =?us-ascii?Q?CzGV8bnBXRMlU9T+V5SLjiCwdL2S+E0QAm/5Gxq0IntwY7cNeJR2irinMuKv?=
 =?us-ascii?Q?7X6U1jmyXEAF4t2eiTYfJASwTaO7/mR+YSVv1M1x00VAjnyj0QzftulpPIuV?=
 =?us-ascii?Q?c9HZhN1N9MKi8N9hA0bNKPiuih5aGDrjGDlbeOefTlQxe5irMREDPs5xqo0t?=
 =?us-ascii?Q?x6/idWqikkHEJyNfxkRcpcla4+sbsQgKWb4zmRsJz3AV3kCZ0zNycRTXRNVh?=
 =?us-ascii?Q?pB3B3k9vsmUxEyh6bPpT01ljNqk4iy+vItnlOWceJ4Yli0ZElto7Nyf4iN6L?=
 =?us-ascii?Q?AMmtduUZ8PEbZqNkZcBf5rsHqtlgcGp0Rj5fkiGzVJ5gTKf+94nTVrcBkAp2?=
 =?us-ascii?Q?wLIqsJJvRbOGQ8ygnQbTDNNs6Z43zLquHbIErjOqCC8QX2KCzE+U3C1DNkr7?=
 =?us-ascii?Q?vlqweUT2OgPe+nhOP/vZbMw4uZzzsj0H/h3aDqZuoT7veYwbXw3scAFZu5Rs?=
 =?us-ascii?Q?V1KIZkez6w17+/F23bNPdYRbYH/pMwHmk8IEa0tozbujHGKdCE+Ng/IUP6+J?=
 =?us-ascii?Q?ml2vJivjmer7IU+39vGs6qYmCo93x8yfEjZdxp7TC+KrHTADFL7MtLJVeDCp?=
 =?us-ascii?Q?lthP5NtK5Qp13c6ThdjW+FHISBA7HaszJZbr8PaiCXh/9imDXJ3Du1zOcYTs?=
 =?us-ascii?Q?uDLCNvzgLZ0Q0yLrp+slrl53e5MVb01EFR2VQunzq7UZnT+0FPHnJGOukEMX?=
 =?us-ascii?Q?cmT7Hg2MePglcXIVyWvgX9EA9J660Sln2itRypsGJeoi67QAh/VdzxpaqbMM?=
 =?us-ascii?Q?xuDpMt/jjXmsC0EmyP0MfgjX98i4LXfsVsOezmzFGotAi5JQ48kE8dua2RXl?=
 =?us-ascii?Q?dud+SzF83Lf0Whij/KkdWDmnSimDd1jtQ3i+rdrNCF3Wgrb+8hmhsNdujizh?=
 =?us-ascii?Q?gvmVO9DMbyanY1fV4kSqfvxEV7U+Bzp6ImjEmwareZPDF+dDT40ZAUc5kkFN?=
 =?us-ascii?Q?Diz8jrZ8zC+mX0VLWdYmFVt5IzCHqpQushbqQrCu5KG3UnXOazNqcwBaHmAK?=
 =?us-ascii?Q?GvsqgB2iM/UnwQkibHC8Hx4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a5ce35-5bdd-48f1-9fee-08ddbada512c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:08:18.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tglNLAxKTn8d15uRV6253c91WYiGyXthr/8ZKhiNIo+AvCgTByagq70OzKYK8j3uXVOB9wKAEx9rzrU77JqMoCcLOj63asVUnaY/k0LmvncwgSQ634hpRGvqJBgKQ5LV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19355

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 0a9d6ef64e5e917f93db98935cd09bac38507ebf upstream.

The ICU block on the RZ/G3E SoC is almost identical to the one found on
the RZ/V2H SoC, with the following differences:

 - The TINT register base offset is 0x800 instead of zero.
 - The number of GPIO interrupts for TINT selection is 141 instead of 86.
 - The pin index and TINT selection index are not in the 1:1 map
 - The number of TSSR registers is 16 instead of 8
 - Each TSSR register can program 2 TINTs instead of 4 TINTs

Introduce struct rzv2h_hw_info to describe the SoC properties and refactor
the code by moving rzv2h_icu_init() into rzv2h_icu_init_common() and pass
the variable containing hw difference to support both these SoCs.

As a first step add t_offs to the new struct and replace the hardcoded
constants in the code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-8-biju.das.jz@bp.re=
nesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 46 +++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 10b9b63a1f09..43b805b6df94 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -80,16 +80,26 @@
 #define ICU_TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 #define ICU_PB5_TINT				0x55
=20
+/**
+ * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info =
structure.
+ * @t_offs:		TINT offset
+ */
+struct rzv2h_hw_info {
+	u16		t_offs;
+};
+
 /**
  * struct rzv2h_icu_priv - Interrupt Control Unit controller private data =
structure.
  * @base:	Controller's base address
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
+ * @info:	Pointer to struct rzv2h_hw_info
  */
 struct rzv2h_icu_priv {
 	void __iomem			*base;
 	struct irq_fwspec		fwspec[ICU_NUM_IRQ];
 	raw_spinlock_t			lock;
+	const struct rzv2h_hw_info	*info;
 };
=20
 static inline struct rzv2h_icu_priv *irq_data_to_priv(struct irq_data *dat=
a)
@@ -109,7 +119,7 @@ static void rzv2h_icu_eoi(struct irq_data *d)
 			tintirq_nr =3D hw_irq - ICU_TINT_START;
 			bit =3D BIT(tintirq_nr);
 			if (!irqd_is_level_type(d))
-				writel_relaxed(bit, priv->base + ICU_TSCLR);
+				writel_relaxed(bit, priv->base + priv->info->t_offs + ICU_TSCLR);
 		} else if (hw_irq >=3D ICU_IRQ_START) {
 			tintirq_nr =3D hw_irq - ICU_IRQ_START;
 			bit =3D BIT(tintirq_nr);
@@ -137,12 +147,12 @@ static void rzv2h_tint_irq_endisable(struct irq_data =
*d, bool enable)
 	tssel_n =3D ICU_TSSR_TSSEL_N(tint_nr);
=20
 	guard(raw_spinlock)(&priv->lock);
-	tssr =3D readl_relaxed(priv->base + ICU_TSSR(k));
+	tssr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(k));
 	if (enable)
 		tssr |=3D ICU_TSSR_TIEN(tssel_n);
 	else
 		tssr &=3D ~ICU_TSSR_TIEN(tssel_n);
-	writel_relaxed(tssr, priv->base + ICU_TSSR(k));
+	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(k));
 }
=20
 static void rzv2h_icu_irq_disable(struct irq_data *d)
@@ -245,8 +255,8 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv =
*priv, unsigned int hwirq
 	u32 bit =3D BIT(tint_nr);
 	int k =3D tint_nr / 16;
=20
-	tsctr =3D readl_relaxed(priv->base + ICU_TSCTR);
-	titsr =3D readl_relaxed(priv->base + ICU_TITSR(k));
+	tsctr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSCTR);
+	titsr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(k));
 	titsel =3D ICU_TITSR_TITSEL_GET(titsr, titsel_n);
=20
 	/*
@@ -255,7 +265,7 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv =
*priv, unsigned int hwirq
 	 */
 	if ((tsctr & bit) && ((titsel =3D=3D ICU_TINT_EDGE_RISING) ||
 			      (titsel =3D=3D ICU_TINT_EDGE_FALLING)))
-		writel_relaxed(bit, priv->base + ICU_TSCLR);
+		writel_relaxed(bit, priv->base + priv->info->t_offs + ICU_TSCLR);
 }
=20
 static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
@@ -306,21 +316,21 @@ static int rzv2h_tint_set_type(struct irq_data *d, un=
signed int type)
=20
 	guard(raw_spinlock)(&priv->lock);
=20
-	tssr =3D readl_relaxed(priv->base + ICU_TSSR(tssr_k));
+	tssr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(tssr_k)=
);
 	tssr &=3D ~(ICU_TSSR_TSSEL_MASK(tssel_n) | tien);
 	tssr |=3D ICU_TSSR_TSSEL_PREP(tint, tssel_n);
=20
-	writel_relaxed(tssr, priv->base + ICU_TSSR(tssr_k));
+	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
=20
-	titsr =3D readl_relaxed(priv->base + ICU_TITSR(titsr_k));
+	titsr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr=
_k));
 	titsr &=3D ~ICU_TITSR_TITSEL_MASK(titsel_n);
 	titsr |=3D ICU_TITSR_TITSEL_PREP(sense, titsel_n);
=20
-	writel_relaxed(titsr, priv->base + ICU_TITSR(titsr_k));
+	writel_relaxed(titsr, priv->base + priv->info->t_offs + ICU_TITSR(titsr_k=
));
=20
 	rzv2h_clear_tint_int(priv, hwirq);
=20
-	writel_relaxed(tssr | tien, priv->base + ICU_TSSR(tssr_k));
+	writel_relaxed(tssr | tien, priv->base + priv->info->t_offs + ICU_TSSR(ts=
sr_k));
=20
 	return 0;
 }
@@ -424,7 +434,8 @@ static void rzv2h_icu_put_device(void *data)
 	put_device(data);
 }
=20
-static int rzv2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
+static int rzv2h_icu_init_common(struct device_node *node, struct device_n=
ode *parent,
+				 const struct rzv2h_hw_info *hw_info)
 {
 	struct irq_domain *irq_domain, *parent_domain;
 	struct rzv2h_icu_priv *rzv2h_icu_data;
@@ -490,6 +501,8 @@ static int rzv2h_icu_init(struct device_node *node, str=
uct device_node *parent)
 		goto pm_put;
 	}
=20
+	rzv2h_icu_data->info =3D hw_info;
+
 	/*
 	 * coccicheck complains about a missing put_device call before returning,=
 but it's a false
 	 * positive. We still need &pdev->dev after successfully returning from t=
his function.
@@ -502,6 +515,15 @@ static int rzv2h_icu_init(struct device_node *node, st=
ruct device_node *parent)
 	return ret;
 }
=20
+static const struct rzv2h_hw_info rzv2h_hw_params =3D {
+	.t_offs		=3D 0,
+};
+
+static int rzv2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
+{
+	return rzv2h_icu_init_common(node, parent, &rzv2h_hw_params);
+}
+
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
 IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
--=20
2.43.0


