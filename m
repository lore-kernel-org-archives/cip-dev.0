Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599E7C83030
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:36 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.23])
 by mx.groups.io with SMTP id smtpd.web10.8432.1751620106441966980
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=EJByHBDe;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.23, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLQfQbQZHosO0o3DguMCfikK5iLKm0iFeQD6MlYN5af3UwufMAhTjTZRiZnYu985zn4dpZoyyflccMBC/w45LEVKrOTcRNImLsu8eyRylACT1hRgh39f6eJeqRPv7Ry+i+4gfSP0fT+8bemdCzWhsRDqS3GHXm1ny5WmSKBoQPG5p7MCalZ7db3GRzwF0+J/tggKlKMZM3RzzZtq5qVMo82zgycOeJlBpuXH/0rZSlQYSglx5+SiYF/WrwZOVJEYAXBvgVBL2veOglZpfin05SEGbIy65lTKXWLdQ6dvWmjgOSdIhZPYfz/rTN0o1+9ZEayeC62cpGWOaWnYPENpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MywdxNaRUcpG/4IYyF1dD+ZNfTOvve92l8nb47ouqm8=;
 b=VN2J2ySMatZUwlc49LK3RzbRCgtD3IpvjMTw3iHUy0JGRJ6QWpk7/OP5npJFuNLurineqZNrdjulvZENZaa2L/zaLJ7C2YUO1WHETezPm+AxwJNyEUuPeE6SXlY9TUbZMdG9w3rXL4Ekyb6bp3xu/4tbSzzb+3cQvVVJAwk1byU7L6psUlOWo9R/oFv+l6Gx6RQZGKM4pSISIYiSJRUrQq5aOSF1S19I2CgkrbLtIWCQBWBYqAW5aet/+Mhy3S/viUPrxZQaNrFSc7uJkwioRkrGqBqcUIl4MCRLS/X7V7zTJbduBPrNNI9FwyXsXCfPakj2wV2KJQTmEY2ERTBNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MywdxNaRUcpG/4IYyF1dD+ZNfTOvve92l8nb47ouqm8=;
 b=EJByHBDeGSbodLrId4/3l2TBq8pPTEE23z+X35RsmmJvb04+EfXxqI4kPF0jKe1eFhQKQuMTy+6SCwIRanQC+NQuRJ4M/srl4yZIpHV4399VHfWn2AJmSinflk32sfLtq5X5fm7IAVW6NF4X0K8ev7329MO/v1Ds+lYdfbabBho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:08:24 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:08:24 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 13/18] irqchip/renesas-rzv2h: Add field_width to struct rzv2h_hw_info
Date: Fri,  4 Jul 2025 11:07:19 +0200
Message-ID: <20250704090724.669848-14-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: cc67aa05-a2ba-40e2-c149-08ddbada54a7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uglXMelKlGILJRLALghyisYGJV2huS09jVpHm/7LKwLLqqm8IJ93/PfUNvhs?=
 =?us-ascii?Q?2HU1oXttYUVAgrxWr7xY9Sr0kel4pT+Mzi7VUmvjMoIJd+DxvE7mXSiE6Tz0?=
 =?us-ascii?Q?TWyCIGfoCBZdeshB1hRhvsfl0HVMLjnSXUDAkntiGLBqxfNk39DNr5VeW+nS?=
 =?us-ascii?Q?EgNZcwaGX3p95pD2Jo7PTCbNZXo4WmPalvLqgBKu+1PNOzLxQOumXpZMoKNf?=
 =?us-ascii?Q?adw9Bf6XYboJWGOrG89CeiE/5JlkLzlRXvhC5aMhqUQrFw9w8aLFV16ekrjA?=
 =?us-ascii?Q?WTi7mQ2HeHSDqJ+CFgVR+oELZ6DP8UbaDHW3Uw8/EtGrglkvdWZ3GTIdxQUB?=
 =?us-ascii?Q?CrtpHr3e1VGGEEAubvH6BN8NakQo5o1LknYCphki6AndOJbcwVwVLIH6NtKW?=
 =?us-ascii?Q?QKl967/1Rub6hcUCg9UeERtcMA19vw1Vqn2Tpijur9hhbrcMcM+ni6D+nlm1?=
 =?us-ascii?Q?m0Es07AK33tiTHVWi/WRrrj/NHY6bMaA0WFvxyy4eSYyouSTmafngbgt/Hw3?=
 =?us-ascii?Q?yb1Bt3h4toDC/oDA7HeS59EPDhMFYGk0EpXtM/KC8i1aJkuOtOxQAUdQyvO1?=
 =?us-ascii?Q?jQ6FRsBzms+PYZQzG0x/FfmF+DgD5IlIRAena4VTg1RynuXytP8438afIi7O?=
 =?us-ascii?Q?ps0TNqpL2nORRqzwHEMN2W3mkFgxmikuCYQjYVCUb3i65ihFxnTzPkoz8HHD?=
 =?us-ascii?Q?/lJBshJ48zjrNujru2Mzd3d52K//7ECJeyp2jw7Kb46rV4R0yC0W1NSW4fE7?=
 =?us-ascii?Q?NShVwPOAUqCTqW9QWDLo7LcCxEXjPgSs69SH8pWneQ/wpi6ROkCiGjkp1cCY?=
 =?us-ascii?Q?y8u7qvJ8bxJXFbg0SioDmOF87eRp8jqRXZEsBGYGA/SVau1/sdhVYqcCQ1oO?=
 =?us-ascii?Q?CUuhIAUqWQ2c2egQ+x1SuiPr91tU5TdoSeCfrFFyToUC185Qdf3XKvINlJv7?=
 =?us-ascii?Q?OmJJx142bSZ1lT7Dh982G/1boiCW3PmsJY+RxMMGtxnTtxjU73MevhAc0Fh0?=
 =?us-ascii?Q?vvKYfSYnavZ/96xIfNCsCJfYozqG1xjJ0m579ZNUGwOCpSvT/iZY7EYJ5juC?=
 =?us-ascii?Q?1L3V2DVCw4VJBiUflTy99aJO2cVGrIfmVqLbZVs/A6AwZDTfoFx1mJekb2on?=
 =?us-ascii?Q?/JO16KRqjNQhSPMmTRYElPbG7BzK2FE05Gn8bGF+CpQwHTUPEol+DcF9Jw9d?=
 =?us-ascii?Q?RD76S4ceE8Nslp2d2b4DkPJ0egkVNx/vZ3EI+by4UmEPMt4VOs9KCPN0OuI7?=
 =?us-ascii?Q?X3vnb1I2OdjjHho3xQ+w2j5MxQQFg9U3gzGIm6K50TgMR5hMtSUr3bfZthGo?=
 =?us-ascii?Q?ISpocOiVBoTSl0YgizHqumvl2Ndq/e9MltCv4B/NZt+8MMQfAxudArx3PX6P?=
 =?us-ascii?Q?BrG8Tfs4K48v9Cbyl2ytGfq0K7CDvjLCHhApmPJgSKdE72pUgDMzQzBF1zEi?=
 =?us-ascii?Q?yhdaPpxohhshWUd/FvcT0xHSedEaESaFNIow0JOOPZryydIp28DICCdpYw33?=
 =?us-ascii?Q?MyX7YFWC4SSredQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rzD3PYlIghQeGxzITIPdoek5sSoVAf5ILwRGNZTJsE1oAFPEC8tPXmbt5hNo?=
 =?us-ascii?Q?JudA3hakgQndeQ+oKs3MmT0jSSg6Rx1yngDNAzWzcNi090EEvuLgKQoL+6Bx?=
 =?us-ascii?Q?pSyUPSd2WdKQA3Xdlw2P7GW9raTAx6rgWGpxKX+LyD6TKgBL0oNd37NSdvLY?=
 =?us-ascii?Q?jD1TUBRxEVCFmfZ84MI8ipL0mPw7Ze7BKOFV0p6xpROQZLisDCZqx7/yPRIe?=
 =?us-ascii?Q?1/ml3bamxMT+zONULtIa/+IUPz6lBIaG/v8ABLUShn8mpWbu+HwCG9J2lQzh?=
 =?us-ascii?Q?LFBeGTqviwg5YzigKqlN4YSObxtZheDQn7CMnKFSQxHMzmeZNWzCv7brfifz?=
 =?us-ascii?Q?juXpO8oo+k+Exa0peyNnhmkZ2io8sjWTqQIQe3O65Hz13PQMVDtB4ggaOYag?=
 =?us-ascii?Q?uV7+kaOqmiqIzIFkgTSrHvFbyTZ677SCEKrEfT5fFXOjF2e52yUE/iqEeNqk?=
 =?us-ascii?Q?Uguc9diq4cNniH3RdIa5Oox4MLpCTpJyG2YkGOwnZRMp9KFymcC6/kj43NTt?=
 =?us-ascii?Q?im1w4rfL9TOi5Pbu4IR3CKyODDnpiDwbBOQzudtuyMhMynljDaTCX8qGh8+i?=
 =?us-ascii?Q?WgVLDfbgNmCo4+2IB5lccZVMua5OQi5XW2UYJo/W1rk832KQ3mQmV2IChZk8?=
 =?us-ascii?Q?TzE1gL/u4akn1cj7Rw7eJbB89tbokYWY+e+UY31RlEbnmCKat7Q08TyX/Q8u?=
 =?us-ascii?Q?OOtYJh+2eFVM7u0fxVN3Mr82Vmf6L+yUtoXnPkv1fxUU4l1b93p+KeXLrkxI?=
 =?us-ascii?Q?CxYsYuL9mMUVHC7BM62JXiXDDtchTjZs6+0BmKR/nFpw5w5LAdS6cX9ATkkB?=
 =?us-ascii?Q?qIyU0Cpe+df9uvaNMwqHG4X+rPnuH4kqEgCtGvjr3MtP6EIA9sVXERQpQCNN?=
 =?us-ascii?Q?JlhDPOTBh4wYkVR6vlkT07NYCYuMKSTsXCrJUbSh3obyO0gcK9L3jb7OYQCm?=
 =?us-ascii?Q?3UHu9yhOJLhctS2LMP00Pbtmluyr5sgVcT258SqtUrsGxbTncGHcy/7ylHyc?=
 =?us-ascii?Q?Bt1+yQEbNm4Z4NofXmkkmMBr2bXx2siktOcnvQILqkMIgPCdzab3GdUm9yTk?=
 =?us-ascii?Q?zW7w4iKMrAo3iCFMMxoN0ETEzN0Lba//uZLD+I0UNJEtkHWHhWvPNvy3FIGK?=
 =?us-ascii?Q?AKHtBXlsSOJ+JTMAa7logNe34RXsAJIIdRhvp9s2Bt+NqK37F8OmCxHzwvhF?=
 =?us-ascii?Q?2q+zKR9YcXvPPyNxUJsltDOxre7GhiHqETL24KZMTMWC36P4U6ie8Kw499PY?=
 =?us-ascii?Q?jUBOs3TOzf/CyHDtgXJghp00Au7hdfWuT6w8lNIq8ECAmqUoD7U0/OQCkw6D?=
 =?us-ascii?Q?lKRi5ts1Meppxq3+F/MbQquNNKbIFrOM8Atvx0SZYhaZXsotcFLYXjrNme5E?=
 =?us-ascii?Q?+cUEuMMN6czf7um4LZTYNhEfLvpiYQqNdDn2Iq4TrxfyobhQrhZAgjKAvW+s?=
 =?us-ascii?Q?xL34p2OQQKCqqlJv8XK74MluOxKYt+m1FH5UYxAzi65paLyAWdl2CUeqIaMo?=
 =?us-ascii?Q?e1Xz0bAUADNas8Gcf6pEqpZhkOLNyVFI5eS+Rl8cMzK7oJ6p1roGTeWzHA4D?=
 =?us-ascii?Q?38FO5ecTfY70mOozXIA+Nl7rvgREdkp8z3hq1fuRLVJXJfbrZ7Z2XYGIvLg7?=
 =?us-ascii?Q?JLFp4y5pfYbnGO1MH42+1rY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc67aa05-a2ba-40e2-c149-08ddbada54a7
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:08:24.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2y5CgPS/CxVt4WsqvOk78iXwqzKtQ0ey4MVrJPdn3HLq91GQAnr92lvnqodhWslPXFHrNC1WePYclPSZy+Kfg3rKJov4Zqj85A4drkVWsKGsLGwfE9209aQ4shgvYkrh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19357

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
index 2fae3274c015..98a6a7cd3611 100644
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
@@ -519,6 +523,7 @@ static int rzv2h_icu_init_common(struct device_node *no=
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


