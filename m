Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E9DC83030
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:46 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.69])
 by mx.groups.io with SMTP id smtpd.web10.8440.1751620120789321241
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Iuzrlew1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.69, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7M3wDaErkE1OOPi+ftXHbX+6WqgZkzuXkGNcagSPfkIzICMwDk/VJLCQiIPbxcgXVy/x8wKPtkCBVALRVKr3Vakc8Cs350stobet/w8vDbWJI/07LsnVC/JShT/oj8OsllAL8CeHclRVM75WQ8lMx55KJymcq5FCjScmO/k8A5YMKxCU8/YEGPrh6oKAgGbBxRuP7QKajLlo7c4RaAvr+AfapJm4/6tPvY/qG/GYSXsWYhaI4CyFvBYogMFw+Rb3pj2DHRjJVY46SMCX7KFpXWRDTYAX58AsO9eydjtGKB8y2CFuC3VSI8Ry49LhwcyVViOtYmMRZl+DEExyphxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGaHYElyH0OBRwMe9nPNULLmshX/Z3psI4qhs8x4gao=;
 b=RSh5o1LdJt5Y47iNYdLtJ+nG9iPtP5hNFJFlTuojbXHk1bAD6TEuXqpWuYagZSyoUPjbund6IXoIflq4Q/GxI6eZY47c5ua9UEtTGU9UQjZzio3PmXoosikEf585ENE7f6wRO5t2TdS1P//r1xwxgXoTqCnBQ1arBJpmLtP+E7aK+pA3RiKOizieiplSyD7VLuBC8B0EUOGLTRbxZnlneYm//nQWLaxq175JprRc8P9l6TyXsBtxaVjRA8B1Lf8geg6sa1key3B+ApmxmyFI8dq1qgi/deuGKW03zHj+LBLYLF5TxS1Yhn2z8ovrP9gKB1KWOTyFi6Uu5KPTbUHAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGaHYElyH0OBRwMe9nPNULLmshX/Z3psI4qhs8x4gao=;
 b=Iuzrlew1D2S0kgpWL1xQ4Vyny5TsLH7LJhZHyAKjVXNgJ3A6eCwFiTPUedTSnpG1o6Ld/wyE7V9zK+VkPeFHxNZ6zaI55QvFkzqBudwRU63TetJDWQ7db172S+yGC40plTXjDpRVx9Zwy328UVlLCtNwAQ4w/7Im0BTNbtsMMrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB8801.jpnprd01.prod.outlook.com (2603:1096:400:18a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:08:36 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:08:36 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 17/18] irqchip/renesas-rzv2h: Prevent TINT spurious interrupt
Date: Fri,  4 Jul 2025 11:07:23 +0200
Message-ID: <20250704090724.669848-18-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: c325d58e-a2f6-4ab7-6a85-08ddbada5bbf
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?r2aTEbvPx4sq0eZx88rZ9PUBFc41xr6hF9CDUxDxgZziJAt3YBTEXEz5Es+v?=
 =?us-ascii?Q?EQgp3bRYtkH8MRna3VUtra2u9xGezZQyK3TcEOC7/i3+WFglGvrwJ2COaKgN?=
 =?us-ascii?Q?NnAXH5sFy5ZHQR/aTPEJXilWqRHEZA48K6mdOfqgQpSxgVvRHQGMvPei83PB?=
 =?us-ascii?Q?JPEgI4r7xtOdu78tZd1VbsP+hnk0Jtb8iLEMAFLKzThIeCfA9j8xYR3VBKX4?=
 =?us-ascii?Q?f+FFoY4BmwDoOGdHrxxGQdRclY877pFLYT3S6b7Dvw6dOMWdkj4Hk2ArckHX?=
 =?us-ascii?Q?UV8NQhfnwI91o0nqAxxK1r05K0crMZoTop3bDJWPMYFJdiw1ZBjqDI84NxOX?=
 =?us-ascii?Q?KMJJ4MWTDFwIg18N0FEwzl2KcvIqhEEIA3ItEZuig4PTAejK5iac3bA0UhJK?=
 =?us-ascii?Q?vvDd8p1VxEWdMWGiCViEc1gHDk/FTmpJkVsrA8nl10AjuEioncsB2KJHLizF?=
 =?us-ascii?Q?42yRQGINtEHN4jHYCuTNT6z8ahwGFC5dtBu/u9OrMNJsyHx6d6YQSbbgsyiA?=
 =?us-ascii?Q?FhOMolOu1a9mOavW2NVulD5uGy+dOAkExJNfkPkNNH1Ki2a5ZWNLhFLk5BHS?=
 =?us-ascii?Q?MKrAvjvKYwFP0qCoU20qLcPqkxz2qr8zp4CmjdA60PXoMb19TeU16zDFwjQ9?=
 =?us-ascii?Q?PJSiOsbJyJqVcZdfLY4nFP9eNIkSRLW/YvThB+/gIvnjHX8hExunuy0Upthe?=
 =?us-ascii?Q?8tfUBW9DoB3Jntf82rhQkagjzoTUcAjrXeSGMQKluW5pAsuMzTUrfHqd+tqe?=
 =?us-ascii?Q?lkuGgU5jrNtWLgl0OjEaDyuYLhAzDuiwI/BozbxmmAfaB4gwuzj+4eiDkv14?=
 =?us-ascii?Q?tM2nD3UC397IHuVlmqkce0REsXjrJ9w7WsWnRWYwfATia5LH5Taj/T0Kxovm?=
 =?us-ascii?Q?Cyk2dVXTzGiyfjYz8HnNrW2StSsgHqISjhnNljWuS+f5ym02MYCFo49kuxKm?=
 =?us-ascii?Q?oeba9U5lKdhJ03cNLIy4M/K2xLD8a0IlKgToZCwwBoIx1Tt/80dtrOGdNQS3?=
 =?us-ascii?Q?YBNNwshmJDGcVf55ACyKUc7ZmYyTqDFWyrjt5Iio0AiI2wXYXqX3aCe/5Ryf?=
 =?us-ascii?Q?6ClCjbKrgt5fLXYaAQjkfynbeCkvXLsNTPaODhSSapH4bF0QeCIK4JOWLMkE?=
 =?us-ascii?Q?XF36IFmjoAWyTRq142NEE47imBlgOUo9Eq0/PQnKd5+8DepBRSFEXlAv1R80?=
 =?us-ascii?Q?vr3+QuNpMylxGR9bwwHq6Fc97QYk5e9LLpE8MWnjYMJLCTzBKxI8JFFq/9Us?=
 =?us-ascii?Q?Mvl6Ku2csQ2gp45b9J0laYiRSfR8LJGOMJBCxzF2aXon/sFETwQSYQtyyUwG?=
 =?us-ascii?Q?VfVOTnLhjh5fjOw3UiTrJWc5g+WGyOuoGPGbtf02kd4ewu6lu/7uCRyJLQGI?=
 =?us-ascii?Q?LzpM3v1vscC3ejjovIgHiT4GJDOdXzbkOtAUaehxihqmVtirgPVYcaLFEU0n?=
 =?us-ascii?Q?cM3eMSeBbEGf0PvlpnL9LHArf1mUFesG4VxY5PBCVe6BJxYnaP5kuQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Z/H9kM3wNAj0KotCBHiiUhkv+m8BNkoNFcohw8kWUKrc1C4eZzSwDXAexJdE?=
 =?us-ascii?Q?ZETBo9Aj4UrMmaBGVR5y9aTIIegoO0MP0NsqQJvPQuN/MeGSA9TEOinH08Sn?=
 =?us-ascii?Q?lumiadKPh4QLTCytfN9Go/yWCWg64x31vbVqZ0Wmt/4ChjT7ZhTAUo/cxsXX?=
 =?us-ascii?Q?d0eeTKTZpcDCrL/0y8cyOQS3WebWY7TJrZZINY4Qd4w0Pel+i0fc2IlEh5Vn?=
 =?us-ascii?Q?TsTge6vF5Zb4m2t4qRp7EHCDfcUvfl3I8ixTeULhS9wOHBtWdiYRUHyD7+aC?=
 =?us-ascii?Q?xJbIL9cAZfCdxeVo/xAeYYpuTRkJrcwt4/nkYHi9MuLawr1eBBn9D7V5KVyg?=
 =?us-ascii?Q?5fuL0I0CySDF8PZ5HmBqRxW5Z9DwrhEQb+h0zvo6MG5bSfFFlQwDde/IDsHL?=
 =?us-ascii?Q?4rfXibl0IoIUXvDYoY0gok3DAM4U+FXBE04oeiOnXfiTx2is2baXPRZ+EvEn?=
 =?us-ascii?Q?zbGwGkfT7oQajLEuQ21IjXUXrQCY7KNc1ktshjSOnl7gufl60ilAbccLThJf?=
 =?us-ascii?Q?A29UZF3313tlkf3rHN5DbWAN9VVbqro/ULm/apgcmWk8meRF1yGEn2E8UgE2?=
 =?us-ascii?Q?fDo25joiA24s1FtOjS68JQFIHhUwJA2QNXHy1oUgmeXoPc8G8RvgF7TQelbM?=
 =?us-ascii?Q?riWGR09UhnvD98vYn2UqwzXr+qn89zF4Gkt2c/nyZyHncBrovtA4jelCPY1F?=
 =?us-ascii?Q?iu4wlr+XF26iQsNBsCX0MtA10p3cEIsAnwq+0/JbOtSYA3QvByyTn8dVDkg7?=
 =?us-ascii?Q?Jnp/19iAG7RzUpipVdhmDdeWICVBi+Q7PFE4ltp9/TDYznEDh76bbcPn7Qh3?=
 =?us-ascii?Q?xvpyTJH2g7VjMzip+943Xcuf6GUFt5hyuf6+GzbTaRX0sb9nMDOSIhhQ4x7Y?=
 =?us-ascii?Q?2EgVtEnMNZbfEdMwJHerx7zdwvkv4npH0CRlCCqP59s0QEGlhUbRvfqFxaWJ?=
 =?us-ascii?Q?5qmzJQfOiAUmwMiM+PbG2uAJHdZFGd/POnlVO3XkSwZ71lmRd5a5rX3sGEPQ?=
 =?us-ascii?Q?rHmyos50NSiukjrRohA8vdMk19QVDG3VUf90oAH1SDEZi7N5asfF0a78cT5M?=
 =?us-ascii?Q?4v/6JcArUJbhtGPaNDyJKuSj5ZW3+HKmx7T86bc8FYfzwqZJ+OCjznK4zyvX?=
 =?us-ascii?Q?mV9UZwlNo0895tjxg2kPm/qqDutonZLnnzIR34NrccthWIRUPzcJg3KpgixE?=
 =?us-ascii?Q?VR2vdYLpWpFM6zrKN7P0azkzFvq5fF9BFYP1Sxfx2ZqeZ0RUIGVzo0YoxTi1?=
 =?us-ascii?Q?NBSBV/khjp5DeDS2bTn+vvdKUhtqTVIPcEAoQQcj9Qv30ZpCoSg2LvMB4D9s?=
 =?us-ascii?Q?ObFEzr6Qk67BSJ3nEptLBqqUEYQa9fEri7Rd1terE4bSXGliC2bdzXaDKuMD?=
 =?us-ascii?Q?DdcYmnvvHjlhwWNZbZSUaEOB39B5IWQqFZoN9PVbOE/BqdI2pSQd+7e3prNK?=
 =?us-ascii?Q?8E1wbTBJeJnzpYBbDyposAb7Ps1LOa9RgkMI4idhDjgYmoWFhCkw5GZnyiVn?=
 =?us-ascii?Q?/9izmLV19x0Mkq5oXqG2qBWp2h2vM195zPlur6x2cTwxjMvJxyydj9StVqU0?=
 =?us-ascii?Q?by0FKNec+yxCvCRbLpuwLbVrfSMchnntF8pmYGWQAMdh1JjLI3N1N23RSreC?=
 =?us-ascii?Q?sqDn7jeJBq9HJVXu7N1kRKg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c325d58e-a2f6-4ab7-6a85-08ddbada5bbf
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:08:36.2364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgQLH/aqcn2ME3/NZvcl8nubXZCCsWegsbplCRUV9Q2K5NwodcvB/Ark3uKwAIO/+5VjF2YaDyDyhkwe3DBFLDSVme/nwFwOP5Wqn3oKbROocKcqkR6krs3MxvAbywvG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8801
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19361

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 28e89cdac6482f3c980df3e2e245db7366269124 upstream.

A spurious TINT interrupt is seen during boot on RZ/G3E SMARC EVK.

A glitch in the edge detection circuit can cause a spurious interrupt.

Clear the status flag after setting the ICU_TSSRk registers, which is
recommended in the hardware manual as a countermeasure.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) d=
river")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 3d5b5fdf9bde..0f0fd7d4dfdf 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -170,6 +170,14 @@ static void rzv2h_tint_irq_endisable(struct irq_data *=
d, bool enable)
 	else
 		tssr &=3D ~ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
 	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(k));
+
+	/*
+	 * A glitch in the edge detection circuit can cause a spurious
+	 * interrupt. Clear the status flag after setting the ICU_TSSRk
+	 * registers, which is recommended by the hardware manual as a
+	 * countermeasure.
+	 */
+	writel_relaxed(BIT(tint_nr), priv->base + priv->info->t_offs + ICU_TSCLR)=
;
 }
=20
 static void rzv2h_icu_irq_disable(struct irq_data *d)
--=20
2.43.0


