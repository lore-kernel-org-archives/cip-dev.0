Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB39C83F05
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:16 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.14])
 by mx.groups.io with SMTP id smtpd.web11.8487.1751620087225474501
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=qAmjpu3N;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.14, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KduHumuHrabD9+GgZD+VJ/v8xohe6F+vcZcOxljksMAqFu1FeEbK7UJLf4PIZFeJEJrL2CurWify20nqWu934RYE/n/mj/83+BwDLbxTSsn0OukxGbzHtzq7rPDN3TBMWXso9b41BxEmAUVEYWLHGvZy8nXrC1/wtvdw0gQY1RZcKec7MTHrsnxNNkqZrGYhVY1PUjV6g2crHZF7+YSSCvLBKP155Lcr5Rlb+RCa0N/YV3Eu3EBO1XOX6fZL+7gBOU36vCeV7eC46ZMDjCEW8vxjgmhMpCmYlfriCByhe2byg4TZ/ZrEZMPVjREoz6GnVgdstXrndfjepVjoy1ggqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ0i2HtAXx1rPWNOmg3VMNstRus8nomAYrWSQR7ySTE=;
 b=OMZeC/jtKDBf/NGw21ne+PnlI5fQ4rL5FhrSNjkqH6tHgiSa9opHO0qTIzC+NAd8h7XQBUrMmMiJOPYg3hcl8e6JZu1BAQbCCifntCQKfj5QZz5nvF4Qam6lxp0XzWm+9bGbnJYb05lpAy7tRXznaIpt5+m0UvgKCGGripif94qIioNoPkos573gJNVgybTyRguE/Hlm+nzYc4Fam3JHEPkl7QvUovTQZD3SHK9Gqk9daQnK4afhBrXVExKvDlskVmVRIIoL1KmzHqinFV4Ur2SO3Sf/0qIR3R8ddEIYp98negiYP3fzRFzw/MMQuPI7ijVG1X4GM5u+DsZ5Hunxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ0i2HtAXx1rPWNOmg3VMNstRus8nomAYrWSQR7ySTE=;
 b=qAmjpu3NXilmO9wuhH1A6l+vnSBAJRN7WLo3ZZ3pFedqbjvP7vuKePWZZG/4dPr5TcKo16jvFf0Ly6Ah+NXLgxIP6kxo4jtxfbV46EuGDEmFJF18y5VpCPkV4tQsMK4ptvUFNFRectPW2er2k598AMHnwiCH7UTJ5IE6UnQLgHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:08:04 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:08:04 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 06/18] irqchip/renesas-rzv2h: Fix wrong variable usage in rzv2h_tint_set_type()
Date: Fri,  4 Jul 2025 11:07:12 +0200
Message-ID: <20250704090724.669848-7-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d627bd1-fec0-4bbd-2c85-08ddbada4894
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mxByOHBjkdY7NrxUcHxs/JDgVel6WBISxLeJsDF36vxTxSaMM0YHFqF7RQnW?=
 =?us-ascii?Q?FPSWW1c0Kglz033S4l2ePhbO7qsroFfPItxxDpGcUu5Rm0rK3cu42b06idIJ?=
 =?us-ascii?Q?OA3MQ6/dI5Aqu2Cz4gLsvmn3oxvrDMCEIctsxjLRCPMZYQkpv82BUD9rzrEW?=
 =?us-ascii?Q?KgbXCWH2S/pujjWE9ZgiX5dG4UhNccc5qpL2lDl84G0+SwKIPX3PeXXV29ET?=
 =?us-ascii?Q?vPAGEBVVVIpJuqLA9lkuUiP5H+mkxJKOWhvQSpkJCeoeGC2DvoJK1wep+H7J?=
 =?us-ascii?Q?4Si93VGb2fggXljm7gh2gz826AfeLfeeVpipZVtZ11qt0T4B7C+/8J4LPlry?=
 =?us-ascii?Q?6XgUZA2kN9mvy4cH92jhMCDJr3JLlWhwaoo1gHFim1Q4QAHmwsmORnwbyCCf?=
 =?us-ascii?Q?4eHLKuJPw1zI/oCQm64MqERFcWLW+vW7zcuQz8RF0jvmpdKkMuqa4/11R/l9?=
 =?us-ascii?Q?zdwj4TIUVEpjpxGkFc88E4KK6Z6qKXCC7TO7n1n3c3FSbe8BxhObGDqHIn33?=
 =?us-ascii?Q?TxDpOwL7X164ket3nebvJTkOkdxEcLz+vw5xGgdR+dWpt8Yhp/uhOQkISOK3?=
 =?us-ascii?Q?nADucObh9ctqnH5Bu6g7Dx7sFVwzeObtD1YeEaarMbgWNP/wYy6orTjECeUS?=
 =?us-ascii?Q?supTmtfrG9syht5jiG6qZbZafFsuAIt2oEjpu8LKm1IbTSlwp2ZRWBt5a0n/?=
 =?us-ascii?Q?QN4HuOosT0DnLBbya1Q5wXhMrfCVtfDw+lHN3o1w/n/V/sHMmIpYdpgu9fHJ?=
 =?us-ascii?Q?6MpHstbLch/zblR/ZaqlC9RrEgyMdWYQ17GBkCy1LI32tNkbx5gqmUMp6Ifb?=
 =?us-ascii?Q?iSSBQ8GOAykcJR4jut2Jvul/7Qv3GKX3AeMg5gHjy/w54F2FWZtqWjv+Ri0g?=
 =?us-ascii?Q?H2ndMW9VgQwelW1JVB10JHfbJCObmi03j+de/5Gn4exZS0WPMaFXAZtGGi/T?=
 =?us-ascii?Q?ZMjLAsV4S05B5s1aGgxTojLM7zfrn4FqMRuQpTllzJbC8IGZSFkXNoBQA8VA?=
 =?us-ascii?Q?sU1+s6L9v9cupTOKk2h3Qpu+LTKVMKIx/ouFfLv1NiHsam4S3CyXwO5n0P+l?=
 =?us-ascii?Q?/SZMlNFXGzoq//LdvN8BepqjnJCx8uVH/fxJkRnz/nG7HOaw1ZooA9oaP7zh?=
 =?us-ascii?Q?y6je05R7YB2IM9YEWM4NSvshPbb0L4peInC+ZmElI+Eha0kBIeA04XV/qWDc?=
 =?us-ascii?Q?eAcdLg7n1xlzG/IMM3f8DOf7okFeH14431uN2HMyo54ul11+jYdZMqD3bWDp?=
 =?us-ascii?Q?aJ2gK34WwU9dwXvNld9v6OAw5JDN7jDpFChbGfqbkFDIqWKGzSdkvOKuSN2Z?=
 =?us-ascii?Q?jGBuzuQ/WeclWmtk3PB3ZlmYbL7J21+8UAXzbXfJVeL4ATXYAVgPmN8kYdyr?=
 =?us-ascii?Q?c9qHJJtfSnQBj4kFz6Bo3GQW0bWGcf7h5/45E1T6MXrcgNW1Z9JBD4ewrjR5?=
 =?us-ascii?Q?VHyIH0qgWNuY61Hkmw3NVONrZP3J64hy?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YCixvFfMvIUvdYKkywLCDVqiJyCboN9MdwT7xZhywETgMf9lHm/bNXFm8Rp9?=
 =?us-ascii?Q?zIh6617q9M1E+a3KxkSVr0xFKYGWKtr3uHehoQprvaXAU6fQljAQoV4QbNiw?=
 =?us-ascii?Q?4cEc3SUWXeYVPswUHPQ279h0xzqcxiHAzFRZbpbHURgpfdLkjn4v/AWieXFP?=
 =?us-ascii?Q?0nrhaIABaQzqADtxkEC8n50+KSYUutablTLSLSZOrOngrWTF3uH9gjdATomD?=
 =?us-ascii?Q?rfQeE87ht388zxObCOusLiYrmqZM2m6va6C+g5jJaY6Qbw+M0j8qknpDRpK1?=
 =?us-ascii?Q?X5pVmQ2JfJEE+yebn+XjW3F9tlfj7BR4dE8QlpIn5RxcR8xPM3LZ1tX35e07?=
 =?us-ascii?Q?eXxoAIJL91TKWlHWqdZECSjAbUOAz02le5uJnuwEKT56Xf6+nBojj9BqJpFU?=
 =?us-ascii?Q?zd2nZLfD+3YzSoqGQ9owu/1cB5oYf6nMQ8iSShEc4CGdof/GgikrusKSQYJr?=
 =?us-ascii?Q?FH36uFIEU2XUhsTR3+043nZ9fVRtpe6J4JwqRwnwIxdd6fYnV2CGkVLEc6D3?=
 =?us-ascii?Q?0JU8sMtlKD0SZZj2dcFCkmQKUtHA7KfF9TItQ/g9WapEBmbhQUKQo/Su1aI/?=
 =?us-ascii?Q?3YjX+etfhzZjoftXbo/6MKBGh6GupEmtKCD+ydMB+YYJvbsgYh7cGJhbX8/e?=
 =?us-ascii?Q?b3B9yhd15icDeY0SzleoPJZp/DJGECRvESSL/HLg60yfeziG1noMv1WXhZei?=
 =?us-ascii?Q?Kozo9dcnJNdu40mx8XZvE949sDeBaPBw+fsAmRnKAMGddVfwHtQUKL+KVqpb?=
 =?us-ascii?Q?hjWQ/LcXHchWMDgyUhcW6xaoqHexrcMrV8QHqnNm84iAYsEHIN5jnhQOmc4l?=
 =?us-ascii?Q?/cYoI2j6NaT/6QUVU73si3pSbi93PRw6NWJXBCSnYo6hE7l/ELS+64qUGuaS?=
 =?us-ascii?Q?Lwh0vJZEbCQCaujuqxX1x3QtV5IFo8Vy3x9U116bVuUTc5X4o0gaKKf4tDvu?=
 =?us-ascii?Q?zJ4+0exIckHp1af6ornRFccZKLGnuqaaIhUX2v5wnzZSxNXzXpyTyquN7wss?=
 =?us-ascii?Q?lXBYZsouIWqid2VmtITNUYVXIkwEk+shBGb+muDKpdLi5IYuUXxDFsaQdDdH?=
 =?us-ascii?Q?S9p8jELBoFJKtdRg28fgFUFNdKXpgcpezs1zIAYsl849B89E+8mEtqBZqjE8?=
 =?us-ascii?Q?2cLHRaH/K75hrT5z3UiJfopuVSl290DPCgv7XOvlxftVx9ak8RAV3eexN/L1?=
 =?us-ascii?Q?D5kKBFWYZXA3EMpfXnupc7/MV5AoGA4gu1q6lYu8IAWjLWci9+w6ymxL0Qcq?=
 =?us-ascii?Q?3Cqa4f5t8g3UE+t/AME/+W9vUK2DF4fSSOr6+MIHYFhGsKkJPw1A/coR3Lxn?=
 =?us-ascii?Q?IUXLB726vlp4mrc23JbwBmioDFryxxjto21mwjtAaD8nobjUz6EwewyVDUM4?=
 =?us-ascii?Q?VfM35lT1gwJV+qn56A553d4VmMyeyk2obbzT5NJo7wtBDjpgCePta5EDuQMy?=
 =?us-ascii?Q?BMzHAX9CTWqchP4/uaYBhUSV17/kZQ7kZAeBVIkA6cJHi5XQ3mSTyayC2JCF?=
 =?us-ascii?Q?QaGRQKeFiaU7AmUJslRzGTk0ifyam5wnai3bxh6bMYFDQ5F3pCWmKZpgFDYS?=
 =?us-ascii?Q?ICVur+awO2vzZvdFPk0XLMCjHAMbLo94avrag7PkeRPH2Xxlg0SrZiGqID+a?=
 =?us-ascii?Q?O5tEg9EMSFb/J1iLF9YKo2o=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d627bd1-fec0-4bbd-2c85-08ddbada4894
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:08:04.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T80XgSDlz1kmiSHmVzax2o3iwTMGL7SwqKV/6MlMIxt4isZy3hOAynUmZf8sjs7pWJDjJRZcz+GegoTW4c/29HtNUWyqYaTptNsmOq4YWhHqql10THbuJ7hVHpNAt89V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19350

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 72310650788ad3d3afe3810735656dd291fea885 upstream.

The variable tssel_n is used for selecting TINT source and titsel_n for
setting the interrupt type. The variable titsel_n is wrongly used for
enabling the TINT interrupt in rzv2h_tint_set_type(). Fix this issue by
using the correct variable tssel_n.

While at it, move the tien variable assignment near to tssr.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) d=
river")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250224131253.134199-3-biju.das.jz@bp.re=
nesas.com
Closes: https://lore.kernel.org/CAMuHMdU3xJpz-jh=3Dj7t4JreBat2of2ksP_OR3+nK=
AoZBr4pSxg@mail.gmail.com
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index fe2d29e91026..f6363246a71a 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -301,10 +301,10 @@ static int rzv2h_tint_set_type(struct irq_data *d, un=
signed int type)
=20
 	tssr_k =3D ICU_TSSR_K(tint_nr);
 	tssel_n =3D ICU_TSSR_TSSEL_N(tint_nr);
+	tien =3D ICU_TSSR_TIEN(tssel_n);
=20
 	titsr_k =3D ICU_TITSR_K(tint_nr);
 	titsel_n =3D ICU_TITSR_TITSEL_N(tint_nr);
-	tien =3D ICU_TSSR_TIEN(titsel_n);
=20
 	guard(raw_spinlock)(&priv->lock);
=20
--=20
2.43.0


