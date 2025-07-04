Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8FDC83030
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:07:06 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.48])
 by mx.groups.io with SMTP id smtpd.web10.8399.1751620017180686788
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=CHOScRA8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.48, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKQ34UPDWbYfX9J9CmPTbiBUdycZVpvXlVT2K93txinAUtucmTaGD/cujcaPpq8fsVrCeQjHA1BinsJJ5HN22Aj/ns8XYQKE+8WBVOwomOdgS7CT9x43rDF9x+YI6WgOrx0BCOPb7kO8/UFAZpo7S6bwstOANdizXiwZI06dAT4pHhBzhGbZG2033M92n54Igxj5cXOSOV24SRR9iP7/lMO4sbwNwf/FNJA3HbgZ5AMxdWIvCdBL6Pc/ju/EJdSzm1VLvDxlBYIfn6lVX5pMqzvNy7GNx9D/lY7xztL02FM5iAZ4gXfsY84gF7FII9/2g/xfO/6FS/LXcd+9o8yZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnK2W3QnfJDHYyLhw2tLjiOnxXReAfWzgbcnD+aISW4=;
 b=eSmo5ifsOs+su1xW/qtcyA0DX31tRwtyFoMuYEfKsWjaWSZ99I1nnqQUEFj4hn3qMHRIMaemwpDq/WYaOHjn+dkhtlhHyl5jj8vFHTrrrwnKsWrE1jx56lVYkTwebOt/YvuvQwKwbYsnaAaGoREZjzcINRGrvR6/Vmh0AR1C3h6ZMowLNYrLpDo3u+QAiDO2LoiVii7G3FNB51t+C5n2Pxo2RLf7GvqCtJEejJJCeLOeuXqlILzi4okCY3Js0Wvk7rlL6fmCcQX/XmoATKgVFre/zRHZ8PqkURxorpOjjOwnE50/wWXwqw7PGbQ5JJT5pOkEUr9lEaM8s6SqsyvAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnK2W3QnfJDHYyLhw2tLjiOnxXReAfWzgbcnD+aISW4=;
 b=CHOScRA8Rya5BSK9hiOK+xIFnFwkCs/YtHzSdGjHXLKaxou4KytMBtufZE+DgaNMfK5AWgCf4//kAs/en6tZ9D8xtc02+gV2G/j1n0e8d3XSvExsl/GkQinWlXZKnxMVhtq/GCK0+HxXGl1uKXjT72lc4xjUbNarnO7IFLJqJ7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:55 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 13/14] irqchip/renesas-rzv2h: Prevent TINT spurious interrupt
Date: Fri,  4 Jul 2025 11:05:55 +0200
Message-ID: <20250704090556.669652-14-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: fbb03c96-d3b4-4c8a-e6a3-08ddbada1f73
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UjzwMJxuBbhz1BETqQrgcgddPzhi6jK9ubyTBGdr0ouL4IFlgpU2eFXVAGNm?=
 =?us-ascii?Q?OvZ3K341UDHVPAfbJDDlvcw64JaByFBsZeerWctjiONQum4ATXIyChe/T7o8?=
 =?us-ascii?Q?hpbSDCKpwj6qJb9OlrxxY7uzLIG1s73VfDBK1kbNmzLMaJvKYO7raQgIvHH9?=
 =?us-ascii?Q?KukvNAEDEE+g8q1tvKS4wqyJcCWaxGrD5mtAuv0ZzEAI97UJi178k3oMDglB?=
 =?us-ascii?Q?wK7ydnu3ThIJn8DsrqDXQwNvYD4bGaTC50Y5MHnRx7LEfekEr11IpfaVQcFj?=
 =?us-ascii?Q?qSSFjNgAU7aRjMkH9+71sKJIX8zJ1ZSQVsr7rHHAEf+Wo4k7VbzVFloxBI9p?=
 =?us-ascii?Q?omE9YjTwNLM6zn+9Yx7WrSI4tig2uQigAtT8GuifOeFZSWM7RSYJRj5tNTCX?=
 =?us-ascii?Q?G7YM2s2BYhG36o19wzGqmMyxEB8p+oLhuQXs4R3AIWaN4w70fJ655Ta0ds8o?=
 =?us-ascii?Q?03FZKYENvYNYOxoh9RcSLqECpyiozvOXtjyAKAyAxDUFIXM6mlkAc9LFFyBX?=
 =?us-ascii?Q?tT8VkVjpEYtouzquMgbYTJWaJuWF/lIMqJhS+XDkaNMw/V4P7M0ICnBdu5nl?=
 =?us-ascii?Q?bfp6jyz2Cr2cKfr5j/rnx937cro0B5eBYaAyz4DnKzc31ey+urgwttIS9Lfh?=
 =?us-ascii?Q?aGD1wxyv17QKkmrr3uL041s13zmEMnDRWmBxj3vDqOabOhJWCTknNBS6kak5?=
 =?us-ascii?Q?okP6Q4wAhShdavotnmAVtOyFNNfx1R99aEqe0qC7yHIvW3N0jrQ2DkiuQhf1?=
 =?us-ascii?Q?fBU4dnXLwq10Nw1DEKaR2ZEnqB+VUBoMiEtL9a0O4ZGWCcBIjiJf0oXXD3XD?=
 =?us-ascii?Q?MpihmXpvHNoiHysYSoPK93v4Tbpz762lPPwwHA0DxXcAUH2v4DZYD+z0uvCi?=
 =?us-ascii?Q?ZSvuHyZpczGBrS8V1W1LeRmjbEGWIIujXbO5k+A+0pL+PA9re/umCraVgAPG?=
 =?us-ascii?Q?5195JICyLs4+v1SK65YVcz8jit2312a7yukMGtJQqowVZL67As9n1FowlD50?=
 =?us-ascii?Q?aJBD/pxp/T8NQlH3BvtRX28VFKhxkmuQynZTf8N8H9A/ird1WyYF3gdnHUaY?=
 =?us-ascii?Q?qtM3LoPKWvFECjP+WeCCjiSz5wz2opCOi+143sz2OCzZSueAvKvmYRpjW1nn?=
 =?us-ascii?Q?nhT8TiMr7o/g5RbjanuUFrkTbx2fnXJOa2mfm09afJ10xfKnLiE/vI3zHX1a?=
 =?us-ascii?Q?a4DS5tvohgig3Y2+o7a0/rEjoMRi2juxVreZeszKWs0KvcIPXf4lIKhS6yJ4?=
 =?us-ascii?Q?b7SOX/v7SFZF7DRVmu4vKUgZgIb4/MxpD+Wyluxw3qT8JnjuJobiyQxJMR6A?=
 =?us-ascii?Q?znPsxI3AqqaeCIng/id9mxAid+QpZo6Nh3lFCXBZEhgAlmB5YLnrcCAQE8ob?=
 =?us-ascii?Q?nUghwkOlwjI6K3/juv4J84yFRHG93h3gXMATumC7s5RPdU8cL3o2iIqZLTVu?=
 =?us-ascii?Q?tyzZ8nXfduABukJjvREpXpCk3pJvYEoMKbP+0AVLwpfQLB2OQmlGGQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?U58GF0/xDua7gKUx0/qEtOnxidINbXYH0JhcHbyCQSqMTtZo7TvQo83wpQO4?=
 =?us-ascii?Q?b6O5gu0zPuLAxRIavXWhou/KqOhsIrJqb8VDpQ9BVA/I6AuMEbQEGrqHPh/F?=
 =?us-ascii?Q?1jfMtFmuLD997dLr0YTPJmBgYuTRfittHchfscmNK40dpYTRnmz7/q/5bEQK?=
 =?us-ascii?Q?HF58VU7Bwfqa+7WmlueUHvm9h4Cc18QDi0YOSLJuHtfGG5cMPgyYU/lG989S?=
 =?us-ascii?Q?3lSQWZk4BBf741g+YhgH/C543QZK4VEEp3TBPK8Pl9kTAP9G7fikwOTpfaLA?=
 =?us-ascii?Q?c+iURugQ9UE5nJYdbOklP9WUIlnNRjC5mfaLyToo60bN+1ds/5PIckm57/id?=
 =?us-ascii?Q?7IBH4GYji6+iT1ajyb0AMdIk8YkN7ozhHBk+iw3wor0WBEYkxohSQWcddNdR?=
 =?us-ascii?Q?CqL6ytLkgAl+5XEW8aff3a+Gz0a06cJ1JXQVzC53E1JzeoM++pKOVvd55xm+?=
 =?us-ascii?Q?WKM3HzInuvzzh2VNcH7YmR5Lw2fvcY98uws7H6p6KrKUr6FNusVz13DajNKV?=
 =?us-ascii?Q?jMvBI0YniMMfi2foyYYYvM4E19WzUoYaNs9z82q8x/OIW0R1w6MoIvgN16gK?=
 =?us-ascii?Q?l2Aj5houvtCTq9LaMRLVZkeFMGzn5tBNwp2kmi8w9Ch0Ssmd1gdwfV6wD3OM?=
 =?us-ascii?Q?I82IlKjv5Y0Sn19/i7IhZqC2wUNIGiYdmQId6FIrfHahRbv5qFUwsxdSGDYK?=
 =?us-ascii?Q?FkcEHFuD/BCyn5niImKqcs7A8sQ/69t2ISR9cXoCtbTmmGlhPtLs5dukidvf?=
 =?us-ascii?Q?hfGrEwPZmeFNlUCv/pfo6Ls56lV7Mqh8BpRF13WEgpu1qIcNQcECBqo4pfXy?=
 =?us-ascii?Q?Jlqgt38TO+FdJijNJW9Q/h698xShqx4yn7kR/f7WxWC6RU+DFmgQZYJE0Jde?=
 =?us-ascii?Q?S/vTu8a5EGwkOqG72ynDsO82dQ8Dw29p3IzDMGDOyHl53Q0BfanEy6kBiNu5?=
 =?us-ascii?Q?Az4JcJjEXTXOE00uJJdyuflHWPUiE+uwtaspO77VscMfoZWFUfDm+yCfTbfP?=
 =?us-ascii?Q?IvCUWf/KmKXEtmcdFeI+SDDLfDjtWEkzBtFZui1M4XH15lJ4m/D/qETpJ0V+?=
 =?us-ascii?Q?nEyMyY+iI93+w0EjfK3mnfvC7D7ryZoOiAbXNhH/O5lrrZU0G7sL7R93lFjn?=
 =?us-ascii?Q?6ho2jQOVOfBo6wpBCnrGSeg30V1CunCHSUfyIqPEsyK+zPUFiSQzoBZMGyRd?=
 =?us-ascii?Q?RicvVvZc6Q8NQNdNdOKSxXKFwuXgySThjvDv8VT4eiTIBh2LBxuerU8i4I6I?=
 =?us-ascii?Q?wGYaRur/tmC3y6wVahnAE1KZeNQqJQEmeKLcrXDuFkHmX50x+q/bPH17+TNJ?=
 =?us-ascii?Q?Ya3uCDczmgw8ZdZNjWpRIMxQ0PwwJp+MDivUH7owJbKASt8/WAbndbO/G95q?=
 =?us-ascii?Q?8Icy7Ip8b0gOU4bXhZRl1phXGo/DQ386OYDTpXftjFvcA/FbXc3YOM4flWVy?=
 =?us-ascii?Q?onrKUkmfXj2MjXrVvMQPBJlNgj4AmuwXIC+nZUK7eRbnTP1k9WpMNtfZ38BD?=
 =?us-ascii?Q?MDD0Fw/w+gRPHBx+yFDTg9WGaNkLHoIWCm/a6nLvCFM3Wi0IX+h40T3DYLLR?=
 =?us-ascii?Q?eICfQhgUdgw+XdxaEGx7iFg7Tsm8OQ22ylrhsmQIvjd/6QEsoXi1m5riK5kW?=
 =?us-ascii?Q?+VRS+uuy+xEWdXekAinClTE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb03c96-d3b4-4c8a-e6a3-08ddbada1f73
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:55.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YSE7gaDnoLpK4W3ebo0qiXp5GOXjetme7/9FoAuvr/koKjKWES8fSoArNFRIt9sm6IlGXb+rGqY3fSLz1psfFc7EmTN+W69W+ooEjifje7cXRfngtlKKhYGbzWuF/ve
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:07:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19342

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
index 374108f2fcda..8cccebaae111 100644
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


