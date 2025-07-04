Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAFDC83F05
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:06:46 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.10])
 by mx.groups.io with SMTP id smtpd.web10.8396.1751620004511631375
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=RzyDjqJs;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnCth2jczeJ81DuYM5m0l6q2/InvgBh7spTj12fZHVrzx7YchBTQt+JQmbrkDab1f/tsYsWs2Moddxaac+ELPrL31j6bFErzUGS0bonDlXz+BYqid3Nm6TtPdEIVLLXpcy/sMGK9fHWZjZ/LGVMAfnT8VL6VyksguVhZ/e3Kfctj82JlyCi/ZB8qAfBJUmWXnx5KFjueVGC+WiI6ltKmm5AoGxDDWWYN0WDhE66QYVyclFCaancyyk5E4sXC0iDj8RaCNDLx+qkfS6TfGKKbW0ntyDJy6HtAXnAIwPw/Z28oR5lh4LDDdKpDtzkcF382Mn1v2KTZtgTGRVwFZWnj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX1iesMKWD+X7rln58xPxnRfOkgkeZ5NbvwCNw0Wr8A=;
 b=CwEky996495s2EBnsojgo5JLankB6acmtJXOBemBzdK9KzCTNj8WXzZq+Q9TaJd2ZcsrcFT46cr7tC31vIZm7cugJE99y6Q+3bxansNcTo6nRG6QRmw0cdnnY0kPPeYaVm9ECeSir4zkw1oOEQoVcXueqOWb7J8C5pQ8fruMylRcswr16fcb3PXanRu/8YwNGKZ6E2bAzM5027ypJJmE9iEbhLdiIbvsYWytGoym84rUJO1hS3oGZgXexlPi9sC9vqKsS2koOmT9ay4DEuvZBDPU2YTSi+hZj+fm8U41IHS0LXSvLGNCeql//qQqOuMnCCuy29OnoToTbwStMTn5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX1iesMKWD+X7rln58xPxnRfOkgkeZ5NbvwCNw0Wr8A=;
 b=RzyDjqJswLyYFUfg/Vnd86MCJSPbadHz0GwV1VQERFBaGEGRCRkFvrMhMEV240Una9Es25lN83TXlvtz74WQuDBdm/WDsJbfZSmluOGhM5dJfXozWyoacbEO0UqQSWANCg2D1Vw7iUjI5uGP/ugqIpXtX8068UI0/qiU28jbisU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:43 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:43 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 09/14] irqchip/renesas-rzv2h: Add field_width to struct rzv2h_hw_info
Date: Fri,  4 Jul 2025 11:05:51 +0200
Message-ID: <20250704090556.669652-10-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 205f9ae9-e45c-48a7-8ade-08ddbada1886
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2dJjFz1N3EAT77CUbcBIdMFOIVEHj7d2NMlLi8pffvW2SDhmadBvT+d+Rwn9?=
 =?us-ascii?Q?G922FcCnrWviJf/dUK1sYe+XDVE0Umb+9oXGJSjHLO9l0BvS47goEuC7pl8A?=
 =?us-ascii?Q?qUL5VRiss5Uw53jbcyTgoa714KXTsGYwX5yTssZ3wXjgeLtZdBGP264sMrws?=
 =?us-ascii?Q?+L8+y2PVDpF2teuJYnmcMlR+3iIeg0Bl4xcJnCTpfdbrkgk4+zgYQ4w1fyTO?=
 =?us-ascii?Q?CKgmwd8bXLBnaDbUyVxIunDDNdketoxoDBpfSvt+cGSaER1qKKF/zNhVAEBc?=
 =?us-ascii?Q?2C6uIfesQpyo1/u1ega8T4ZKDw1bokAb4tLHAZIOjoCQepREVqDCyGEIbCCe?=
 =?us-ascii?Q?gT5m5P131vxRuZ1vTOKZwNeWalN11gHnHDjSXHeHjZ7i9wYNlXmNzvSSi53C?=
 =?us-ascii?Q?jYB3lqQATqHskGzbdZ0vNOkkbBYNmnynxJeFVD9n2aWCCk8t2jg4cycWaVLC?=
 =?us-ascii?Q?kpr984GAWpY3OYYnb4MoMwetrsFpUX67QzZKJi6GvrF3uSY+UBCZzHfMVJPZ?=
 =?us-ascii?Q?DMnew20hq7a1P5VSi5wA86Q9dbpv239s+Jd5TfAEq3A5aN70LztNMsaId6Tl?=
 =?us-ascii?Q?zXx4aI7uPwqexAcYBJYMnasFmptfO+ha94vwy0hi6RVqeIOmFkMXdAx1Jt1e?=
 =?us-ascii?Q?/rtkaEvEMk1z0FTFTPXhtRq81isCjTlrTcZ5V4WAvKFOpFpuE9Nz2JSW1bCu?=
 =?us-ascii?Q?Od8s/KbNAMyB0UpU18vmpnmAAEgh/7gootDd7pRXXx9veW8wUiYJ7jkoclm3?=
 =?us-ascii?Q?mGNQpbiVwg2IxjPqWIf9Nc+4vf9xZ3qcd3z35l9rvPch/AKLcJ5nmx8bGnZP?=
 =?us-ascii?Q?c9cOVWYw2Tu87f91Y6cjqLGfjdI5OKC+3W35IixUNhI1KBNQj1poFDaBFrHu?=
 =?us-ascii?Q?I7yHsTdZIuaCZYVLgrHp47y09dW7qrczSHUW96BdSHKaPW8YubSDhg9r1aO7?=
 =?us-ascii?Q?klukQrEhPrJrfVSNXZTixggRf339Hr8ZuE5k+tImOO1cF/Xwf8sZkgFHvTJI?=
 =?us-ascii?Q?2o7689y50TZvUaEr9yuhv6E4UPY4o+gpKjKXixHruuzYw+FDZkrw20zkAxSB?=
 =?us-ascii?Q?O/lm9sN6hI954klLoq1v1x3RXvu75ClV9ldSTRwzfWNfuLnrKIgPDa25koxN?=
 =?us-ascii?Q?Q6YbttYAjAdRD60727UCF6XVAIVImuLJ/rKb8aAe5/dQFtOfNVyrXL4M5isj?=
 =?us-ascii?Q?viaA6nISojshMeXdRKB1rJMcBVBULhPUee7chbwHpU8NKF9sp9BtbsXsKDIo?=
 =?us-ascii?Q?m5p5ZgE/6DGSZSYv1MJYKfLwentfqulv55hS8p9Edt3ZhFuvjzw1jO9FnVtH?=
 =?us-ascii?Q?NwJwuHTwug3HtPIDi3kkd3fhS4U+xd46iJ1ktEWehk0NVe1litDHm24AV2hY?=
 =?us-ascii?Q?64d5zIi4EXjZV/8fWLkvp5tcZZozP0MuNkUKf2B5hU1vHKnxCXRgbK2GLXlD?=
 =?us-ascii?Q?SyNZoXq3NuCu2KVXq0HLPol0bZVmB5JsecHrZa+UgkIKEm3kw419dmLqXfkS?=
 =?us-ascii?Q?hKxTrJSb0TDu5KE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?c0dH68OzZwRJF6OTOCt42DsVHH0UlauNMC14ry/PV7olPN5+CSZh9avg296B?=
 =?us-ascii?Q?H1rA27RVN8IOGzEordTiGR4H8lNpBeIA6QSILxW/g1XjL1LvQjjmLW9EauJL?=
 =?us-ascii?Q?LqzGLkx2DxazQ6/Hdgevesry/mCNWjEClgYdzfdHi5L3BMi4pO1fiJDko64b?=
 =?us-ascii?Q?nD97hFNn+3TdPDKElh4VEZQZ1DnK1ItlWZja+kSY+N+jF/Qq6pKMSq1rs8Xp?=
 =?us-ascii?Q?GGpk+h6n6uweaprFB+EsVcwgNSu6F3C+X/mdz1O2u3pmeLO7x4VjRTVOLX3k?=
 =?us-ascii?Q?33epn/66pd+aqYnT/eA08/zZSnfF5ZZgK9thzGddvxXu7FX0rJ0DB4z8kwvl?=
 =?us-ascii?Q?kHxGa4962p8VmzDGPckETjzkCtc9DISvKY7lkcEl8fNIW2XGnwtNBXZYTr+A?=
 =?us-ascii?Q?lFMfTazjfNOPVHC3aPmS1yA2mLckySD+QO9/uGk0V+7T8ZmHqWDxOhyGDVMl?=
 =?us-ascii?Q?xyvhkY41MyOfmtOeKZ+Pc3vjyDSG5GBcReQTXMru9reROrJbyJyT3tykRYxL?=
 =?us-ascii?Q?LP1ilnlBYtleIfqr6sefDnw8VPKfBYw1tNcAuwzAhrjV+5T2wLmiE5xuhNSc?=
 =?us-ascii?Q?6DxsNjFTfRKtjeNvhO3m7RLvTMLgjZsvXlFfeiLYTPK/21w4h8vFEa4cyZF9?=
 =?us-ascii?Q?3I1IlCvFSyJr4Vpeo8N7p5TV7x9AGIORry82rSRauxSblv1WNs8sAr/e3Y10?=
 =?us-ascii?Q?tcD2lUnwctJjKnMcETFSOUI916ABsbzz7QWj1XgIMuGlh7VvaURFboQAK6TH?=
 =?us-ascii?Q?qeSKhqPR5IR+JBBmmsEsLRh6vBeqFTq9ETJSRWe/sxCI+6K22GBVW15W795f?=
 =?us-ascii?Q?gcn7sOeGdgQi3QWP7kZhM3k43xDLqP/BnBrL2syfpOLpu4Xv3jrku4ldXOHj?=
 =?us-ascii?Q?IdS2bvdS97V0wHKOyb/yboae53aHFajF2hzWLK8t/Ya4yGkbW0AHbhbb5jIo?=
 =?us-ascii?Q?P3KCjdlKbGwYS8ZG/26hvKr0pX4qJORiZmZl5TZnJhYGx3xIvDljYl0ShoAm?=
 =?us-ascii?Q?Q45f7GIytF4dFyZRO0RpQv32KBzZy8b91ko2GbgJOeJdXJ5GMhWf9Zk5e7Kg?=
 =?us-ascii?Q?aH68THP4lZr3elTZ0zcJigBvQV58u0MLOB3eHJ19AU7zgVIRjVxof5Bqm3kR?=
 =?us-ascii?Q?RGqyuO5SMoMEsleO46+iLHmIeX0NkmKDF32/1dNC2d51CSD5eEBN+DF5emEq?=
 =?us-ascii?Q?jtEKg9ZqfDr6VeBAutrYXSZH43vuJ7NrYPiyEyXrYp1ES7O0ccMn/cAGQ/VV?=
 =?us-ascii?Q?LD4snHL0O7Tmcl4NznXCi0LnP/fiN3nnU6/VUQXeWiY9+95sWQTRWcd4bZ7Z?=
 =?us-ascii?Q?2n1JXRJeqCpSyZ5qpekN8L/k+A2sGAsukELKcXLTQ4ASxO4Jh/U1Qm3A6pRQ?=
 =?us-ascii?Q?q6lD+qOiYdA41uzwTcn23qbstP6raclq0jVtFHYlK+BGEc+nH1pGyCuh15wQ?=
 =?us-ascii?Q?qY14imP183dEz+n0oDDIGgfdc2QjbIqBXMda5xlA6xDThHdQk49QpQUu906e?=
 =?us-ascii?Q?QV/7FdRKAQCLQpgan8gePhCirf+Z8tPOp2I4dtKlrGpRekJMfiRKU4mLW5Iy?=
 =?us-ascii?Q?VvpSDcMDfOrTgnFTquoRo5P8/F9N4PVzxNtasjpsMgAJS+xvYkoOZNeKpuE/?=
 =?us-ascii?Q?iMHGFPCmCa2ZuH9DDyhTh0A=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205f9ae9-e45c-48a7-8ade-08ddbada1886
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:43.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avlvmdZJVTjPym9Qfo34VdigEWn50OX2s0QPX8sY1ukD4kzR3MA6eeymw5DgnXv/DXHVp3D0ukQ92fNVz2x84t9tup8Zv2Z9gNw/GASVisf981N8D8pDUQQMNOFlyqOS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:06:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19338

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 1a6ebcc10b138a6c55f8df2cf6cc630ddabe3cab upstream.

On RZ/G3E the field width for TSSR register for a TINT is 16 compared to 8
on the RZ/V2H.

Add field_width to struct rzv2h_hw_info and replace the macros ICU_TSSR_K
and ICU_TSSR_TSSEL_N by a runtime evaluation:

    (32 / field_width) provides the number of tints in the TSSR register.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-10-biju.das.jz@bp.r=
enesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 0df8c3145ae4..df26026f33d6 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -64,8 +64,6 @@
 #define ICU_TINT_LEVEL_HIGH			2
 #define ICU_TINT_LEVEL_LOW			3
=20
-#define ICU_TSSR_K(tint_nr)			((tint_nr) / 4)
-#define ICU_TSSR_TSSEL_N(tint_nr)		((tint_nr) % 4)
 #define ICU_TSSR_TSSEL_PREP(tssel, n)		((tssel) << ((n) * 8))
 #define ICU_TSSR_TSSEL_MASK(n)			ICU_TSSR_TSSEL_PREP(0x7F, n)
 #define ICU_TSSR_TIEN(n)			(BIT(7) << ((n) * 8))
@@ -84,10 +82,12 @@
  * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info =
structure.
  * @t_offs:		TINT offset
  * @max_tssel:		TSSEL max value
+ * @field_width:	TSSR field width
  */
 struct rzv2h_hw_info {
 	u16		t_offs;
 	u8		max_tssel;
+	u8		field_width;
 };
=20
 /**
@@ -140,13 +140,15 @@ static void rzv2h_tint_irq_endisable(struct irq_data =
*d, bool enable)
 	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
 	unsigned int hw_irq =3D irqd_to_hwirq(d);
 	u32 tint_nr, tssel_n, k, tssr;
+	u8 nr_tint;
=20
 	if (hw_irq < ICU_TINT_START)
 		return;
=20
 	tint_nr =3D hw_irq - ICU_TINT_START;
-	k =3D ICU_TSSR_K(tint_nr);
-	tssel_n =3D ICU_TSSR_TSSEL_N(tint_nr);
+	nr_tint =3D 32 / priv->info->field_width;
+	k =3D tint_nr / nr_tint;
+	tssel_n =3D tint_nr % nr_tint;
=20
 	guard(raw_spinlock)(&priv->lock);
 	tssr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(k));
@@ -278,6 +280,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsi=
gned int type)
 	unsigned int hwirq;
 	u32 tint, sense;
 	int tint_nr;
+	u8 nr_tint;
=20
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_LEVEL_LOW:
@@ -308,8 +311,9 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsi=
gned int type)
 	hwirq =3D irqd_to_hwirq(d);
 	tint_nr =3D hwirq - ICU_TINT_START;
=20
-	tssr_k =3D ICU_TSSR_K(tint_nr);
-	tssel_n =3D ICU_TSSR_TSSEL_N(tint_nr);
+	nr_tint =3D 32 / priv->info->field_width;
+	tssr_k =3D tint_nr / nr_tint;
+	tssel_n =3D tint_nr % nr_tint;
 	tien =3D ICU_TSSR_TIEN(tssel_n);
=20
 	titsr_k =3D ICU_TITSR_K(tint_nr);
@@ -520,6 +524,7 @@ static int rzv2h_icu_init_common(struct device_node *no=
de, struct device_node *p
 static const struct rzv2h_hw_info rzv2h_hw_params =3D {
 	.t_offs		=3D 0,
 	.max_tssel	=3D ICU_RZV2H_TSSEL_MAX_VAL,
+	.field_width	=3D 8,
 };
=20
 static int rzv2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
--=20
2.43.0


