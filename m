Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5327EC83F0B
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:06:46 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.10])
 by mx.groups.io with SMTP id smtpd.web10.8396.1751620004511631375
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=J83/SajQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baDAre1GZAe+At4/rlwWT0zlTHcXcGQ87uPKVGC0+Kq7htBd1rlanVZnYnlYckMTeokVxfFljJZrrrwhw/KL26GcGdZ+9deINk53lNIglm23XMFvfbuD0tap816oAJprTVn2ziVLz26CxcT9Kp7pwaXQy9RDI9BK4VEnKxplhvNwsBZZ5A+fh4ssyesiFA/sqdmHbaUebFvecNLE0VtdJlOuHqvBCQx8dvOe0mOAAZmXMvICmQf6LILYwDNySSisQGL0BDMVDhMpscSgaLHhrpl36WWdSfzpGjPG9CdiP2iR1Mszf+NVeamPcLL+hdJVTLwFhSuKqAZcIB0k90/x2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNBHfWLFMbCL/XrtcqZVZqcgao6NJKfWqyhI+rCB+k0=;
 b=ZOC4kZOfy5zdFX3ATtQL9zhaEa20Fa5Rqzhx1n5XQczD+ypJIguM/om4v4LxGgsX1jyE5sltkjIT7L/gCoZ/XuBvjfKNS/yKt58d/vefb4TnYOkx+CA5N7xUTrlEcab4YNZwY2s3kok+YPVnvt+Wku3xq1UzqT2fZH0e7RL7JA6rTv+1QhYTetELSGFVZZHF8DKvq3qoOdytJk7Q3SsL9f7s7yY0aKuX7dooPk1+65aRVkvsUZMtDNDPQZYQflN+HWDrlpkeb/G4i7OrZL1O0qDZudcIV6huHjg5rDlKrLc/uN/koMtMpP4RO2MaA+hO39mJIcll5woZCjTP2NOxpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNBHfWLFMbCL/XrtcqZVZqcgao6NJKfWqyhI+rCB+k0=;
 b=J83/SajQ1tfu6FLK31pyQpNOSuzMB5vvnR0oj9zVzS5TUsLnndP7y3pA09QJ9Dh6EcP6nkwy5TFYucQqNrlSfyqmk+8VGoeHCpluv3kxv6kOmPAcLscivS/13tD4NgiFb/U6za+zWE3PSbZ+rSQqwPyt7iEAA6H2JY9Nma7U2a0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:40 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:40 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 08/14] irqchip/renesas-rzv2h: Add max_tssel to struct rzv2h_hw_info
Date: Fri,  4 Jul 2025 11:05:50 +0200
Message-ID: <20250704090556.669652-9-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8974c946-e821-4e76-07fc-08ddbada167a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KtYIw9vwLClyp+xI83b1bVCa5Aaa/5Je5PBN0/ws4dzpsHI4QfpHP+Q1fa+F?=
 =?us-ascii?Q?F9GrW1EPOeA0WJH/jAl/Pu/NDuV0kTNrx8+2+mUGqSp3fn54yBJcBiDvAbYu?=
 =?us-ascii?Q?NAxTwJojx4IacmrTlkzH060qtMNKsAW/mTVAIICauqk71dE0WkOKGMs7/yQU?=
 =?us-ascii?Q?e20u5q9XP7vW95q5dCZZQtknwAvIllr7kpN+lKrU0c6VbwDEcu6E6X2G8VDe?=
 =?us-ascii?Q?a26gictCmXllzKqYBD/N4CDY4fBjFBWoWSsLL1NgRyMEwGGnfmJmAEclVOME?=
 =?us-ascii?Q?+ddX/OJHJPZpFI64DRyeRJfT8wJMS7/svElomBc5jNebD3Ec9WIWacCOvx0J?=
 =?us-ascii?Q?Uq27goBBizE2zJBa5S2iNrmHD+IsBJ/hMhC7va0LJSEXiVKkTTrGi178awfK?=
 =?us-ascii?Q?knmM9GA5RSF+6adfBfMKxHe+5/xVWzvREfEvHVU1dNAphT89gdK2QRG9h+mb?=
 =?us-ascii?Q?Xw2Fw9WPSu7qU9knifNOcvjyHg6pyjTupTt2K20BdX390oNiQpBUl27KCbpV?=
 =?us-ascii?Q?CZbT1Y4JZvmIa0Ifxoyk390kMJaY+kcWy8jCgHFhvMiCMnVyByEpOBroMRWy?=
 =?us-ascii?Q?MUaaT3KW3mb7R999Yb6JvW13t7/g+RAQ2YGEoDJBMGcjQza80oQ+GAMoJIVM?=
 =?us-ascii?Q?sI13JTXf1G/vUb+bPH8GYqQuvNamXji+Ap3tcyJHLcp955ebZOUYbXunujdu?=
 =?us-ascii?Q?L9uFMNqaw+LpgIKBTqnviH2KxGNqANApGyFfiKa1SHvfoqivrXiadQjdhA4p?=
 =?us-ascii?Q?zm4ijj97EYRXq9KFPf0x8QH8683gLUPJS5mFzukKt6i4pdPEetMrujZqd5+y?=
 =?us-ascii?Q?uJAHFNltdZyCGZKphNc+GWU46J7SQcTwfY1cBj0pGRAP852BSpKmUHT2ZtHf?=
 =?us-ascii?Q?AWU6OeT23xBBMlj/49yV7ERQRgqK1wQhweU8o8Hnvk3VaCljHKvpqLAhjcyM?=
 =?us-ascii?Q?8yySZg+9TYGHRPccDez0YpwZa2wc+LIXcI+sWt9QOQyZhT2v2K4nUfr5SnO6?=
 =?us-ascii?Q?99QlaZiEEpT7NMmtv89UdWzuVPJVs/YrfIhY7cO4NYe+LneE0picOnDYTK0G?=
 =?us-ascii?Q?iTUnn8zmJGGyuIzhfyTl76y+YYww6PeEblfglDwTybkTRRu40GcxVmu+XDSU?=
 =?us-ascii?Q?1rMzU/y6SCar7HPexJEt6gBfr6u/UZe2J2G5ZJQqW/+r/CaZ2qqtQQ6ifDhq?=
 =?us-ascii?Q?RyPPTQiNKMKfoQDJm29cWb7FRZyPCmm5uB6CpvODoAE2glp6Eii8oGqfiSes?=
 =?us-ascii?Q?PP+1dnq2FZxKO8kxj4nIUH/35ponqyjKl8b1JMWMoIYykjoG7HzCfUdV+/cW?=
 =?us-ascii?Q?GqEcS4+1LSDEJUobB6QlCHEtgmGSPmE/v4SCSbcd4Bp7sVOuIflqVkRSMDeJ?=
 =?us-ascii?Q?DTpXaCYUl2rcD0ZY7lpK1F0GvC4HgAIlMdRT+3g4hMs/RyCmPRCTnFoeTbTw?=
 =?us-ascii?Q?KyxdQKw1hfhXNDQUGT4JggN/vQon2hEEEJr66rNATTOwZ+IHXNT3eCZU+d93?=
 =?us-ascii?Q?A3AYStGg58eLRBM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9rfhmcwspSyhcAzKoKbAW1RWGCSPz+YCYS3LaJXHgFxpe4BZREc1rC3kZzuK?=
 =?us-ascii?Q?h0hrGKtKXU2R10IU26pfgJeTy8bvLqzd+mezUDMnbpCa9LsjSAsAI8L3k0d4?=
 =?us-ascii?Q?lwBKBGzT/bx1pkdmNwTreJ0wq3AyHqczUb06wqQIEq1SI/TUf9kDQbGccLc6?=
 =?us-ascii?Q?lOCWIpfJ5O37z4PVyPX9HnjK0Ba3EI2MlPrFwWUiFupGCt3Yd7jNvGN+4mCi?=
 =?us-ascii?Q?SgDsFDaoBL/Uev60opF8RSI1GGgEVT4eUltVc3l52iZZzaig2H5w7whQtP3S?=
 =?us-ascii?Q?/9zbO4OghRJJU1oOYk8vZwstgTgK8WPJqjf67ExWWUJGb8uOeE6/nsRgTWw8?=
 =?us-ascii?Q?LovlAf6FCElmQ7lnBt0xnm7PDlPWhMRoZcCM1KsSCLOGSgVd77MBB6p64TcT?=
 =?us-ascii?Q?rK5xuaRY3ccQ+1kOQaHTuCdEx4eoI7pmUZAyPrMzB3fD99nvv8EyA2ubEHpT?=
 =?us-ascii?Q?YAzL8R1ZtT4bccv04J/H3LatWP1nmFET/QwyfaCRrlMFZnv899SU32wy7kc6?=
 =?us-ascii?Q?NdtzOnzDajRrhpquady8TVT4+JMpi6urAyv9h4UlPbDL2yqjgcZ0teHjDs26?=
 =?us-ascii?Q?zwY/WKzyiaJ6JSHN4zM2ks3GQhu/TZtGtcORKaMQ3+mxvd6+5SEOPl+A8j9T?=
 =?us-ascii?Q?p5fnkcaGuTem10lcTj+iV2DOIUL77PXtiU/At6R1Qumvw4NenSHYXo0MbGTp?=
 =?us-ascii?Q?0VUwTTb6OfT2/zgb4HIVtpekOe/cCYmDH+vhAhNJ+XeiIcOPFHDhKv+I9t6N?=
 =?us-ascii?Q?l4GP3HuZjspQDMosgwj4yN1PwuNni7PSCEXq83+xIfiTXaKlVs8Aeu+I6N1T?=
 =?us-ascii?Q?I1zguhJJfZidMm1j8Kk8Rf2BdEHiTWKiXH5ZKUxr5XSDv8qsgyslM32gFXt4?=
 =?us-ascii?Q?mQCf0ZqwntCqivvIjI3SAkC33CzkUgmDCTfGrwgMM2RgWAU9YhM8y9tgTyC1?=
 =?us-ascii?Q?4cb9sd8692rzCcRPOVRYvIIYe/+Ky2bIaq+aHJGi76zZOnKoBHvNpQ+6Naqa?=
 =?us-ascii?Q?2Q6S7UnuHImvDisFFGVczVtCnMsf3c+ZImMV1QV3+bIbrsqTy8p4BzMGtX6K?=
 =?us-ascii?Q?Nv8MowVQJfkKbEjCBa4cFkj+oywrNgutTZqGtMid9cNUI+AR0dZDcxNF/nXP?=
 =?us-ascii?Q?vbJOStlZBXnUSeSwO2Mw9GQO3jI+9xl8JbWW1zlXtlmHfBlROp8fa5GugChO?=
 =?us-ascii?Q?OOfCthzqXq4GR9ETihny4DpBpY9sqpkZi9viNTutF1GS4s4n5CgCEoVTxG8f?=
 =?us-ascii?Q?isG7NgP2wBf70Gcc/yI3sAU/wxZAPj+X2Wz0qcByArZqOf0GqC0d3sqK/8sB?=
 =?us-ascii?Q?PZJRiEXJZQFAKahu8Eq605HUul3VUKoiwWHgDTcReBQwkUIGGsn8X5SApTTA?=
 =?us-ascii?Q?khW+1Cd0pA7xJPsW5YgFTYeNvVAoGWhaq+rVDPUZWQih9tHMJwJeqfyaCjZb?=
 =?us-ascii?Q?XT1hXcCcsy+4BZfOmcMUb28jZdI+An60vfBM4sB1PjMy1Anly17buj0vvMx6?=
 =?us-ascii?Q?Cb4xO8msWWuURG95IXWVlvpuiLoL3GYD4Q+dex+k926Hcg7FxamvErpZCGkN?=
 =?us-ascii?Q?I2M1KcMbaPdGBT9BRElTWuiASnpwBAQaZp3+wbXjva7f0uHLFnBtEdedkIF4?=
 =?us-ascii?Q?UwbbEkKgnoShsIuhSESJSIw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8974c946-e821-4e76-07fc-08ddbada167a
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:40.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmnFuLQvI2geNEHCLjzrBtelBZM1Oz275fI8P361BU3jSKExTxSpqL1KwEDcA1NKF3DQPJZn9Ji+ZUzsbstBNkQsUzpYYLYXUh1tEcOcoaxP+HE9AUsiHb+lUNFGW2ll
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:06:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19337

From: Biju Das <biju.das.jz@bp.renesas.com>

commit eb23d23d082d097e2a8154a57da72061cb7e33b3 upstream.

The number of GPIO interrupts on RZ/G3E for TINT selection is 141 compared
to 86 on RZ/V2H. Rename the macro ICU_PB5_TINT->ICU_RZV2H_TSSEL_MAX_VAL to
hold this difference for RZ/V2H.

Add max_tssel to struct rzv2h_hw_info and replace the hardcoded constants
in the code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-9-biju.das.jz@bp.re=
nesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index a2e831efc23f..0df8c3145ae4 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -78,14 +78,16 @@
=20
 #define ICU_TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
 #define ICU_TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
-#define ICU_PB5_TINT				0x55
+#define ICU_RZV2H_TSSEL_MAX_VAL			0x55
=20
 /**
  * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info =
structure.
  * @t_offs:		TINT offset
+ * @max_tssel:		TSSEL max value
  */
 struct rzv2h_hw_info {
 	u16		t_offs;
+	u8		max_tssel;
 };
=20
 /**
@@ -298,13 +300,12 @@ static int rzv2h_tint_set_type(struct irq_data *d, un=
signed int type)
 		return -EINVAL;
 	}
=20
+	priv =3D irq_data_to_priv(d);
 	tint =3D (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
-	if (tint > ICU_PB5_TINT)
+	if (tint > priv->info->max_tssel)
 		return -EINVAL;
=20
-	priv =3D irq_data_to_priv(d);
 	hwirq =3D irqd_to_hwirq(d);
-
 	tint_nr =3D hwirq - ICU_TINT_START;
=20
 	tssr_k =3D ICU_TSSR_K(tint_nr);
@@ -518,6 +519,7 @@ static int rzv2h_icu_init_common(struct device_node *no=
de, struct device_node *p
=20
 static const struct rzv2h_hw_info rzv2h_hw_params =3D {
 	.t_offs		=3D 0,
+	.max_tssel	=3D ICU_RZV2H_TSSEL_MAX_VAL,
 };
=20
 static int rzv2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
--=20
2.43.0


