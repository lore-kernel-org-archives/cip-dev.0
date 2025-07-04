Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596F1C83F05
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:36 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.35])
 by mx.groups.io with SMTP id smtpd.web10.8435.1751620112468133993
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=kFgStW+j;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.35, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qy8RiTiMIckMc1u7n8JnFUnNDCjr+Ne5OJWrFN3+b/1/11qk7HIdvh++Eql4hDAVeGdO8kOBscOWkYFCI1qOopQmF7TTxP/bEPM3jGkguyjmm8PFi4LaeJY/Uayht6Cj3nREi62i8iZ7exC0QUuhBaAzqmxy3HulTKCPKDUDm6maPhIWZfv+dA7qomcr2hX411WgvUN8/wZXmqjr9LiCWv4wh8uci3IhtmS3FzS3Qm0RSX3Jrtko2gUqoMe+hVedjvrebFbjbLyi5geegkIG2UX8X2/Grcn1yT0UHXUpwshTakZU2wUYg3gOOZ94lprHQYOkfmFBsXQ/tGuMZsHXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTDCVltUQxW+6eYVI9ZS5HtkDNJA9Vo4tYQ9xFGn6UM=;
 b=Ybga10sZb32lxoLH6b+O86wKQwSmlD1LY4cNIofJ2+cks9O+j8jzm6AOLtNC4DmqMKnUyOBiDePTL9vuLugcYX6SXniuKjbGkB66L3SLUV6YR9+ldxdIhi9rqzHb07FWpbnz8UZ0w6kJZO0AaFCp0mIYEtWw779Trq9nDQw6+4gI6brlGJnbpB/hSo+7stpg3+aSXt/vGM0TSzDYAjycV9Trfrc34K5oaguvl/SThInQaUVQZYsbBsONnOUEyj8TWOh4UdK9p0rKywTCa0CLKUiRDtHDenZLR5UqEnhMR3t8OfNZXrDxGX4bhn3LWKVTe3E/3OUxy7VuTsnPopesCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTDCVltUQxW+6eYVI9ZS5HtkDNJA9Vo4tYQ9xFGn6UM=;
 b=kFgStW+j1Br+XBKt8e1icIV9OkJ8insM/+8phXcCbOkKbjk9/ir8w4NDvHYn/kRuIyqeCd/A6ACkG3+e+yx39DYmYRQJu6ZG+etA9GGqyXYjJbMBkrCWyye/IMv1KAMJVDq8CELOTIzFuauC/Lksj5fblM3Z2m1xM5Y+CNCj6f0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:08:30 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:08:30 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 15/18] irqchip/renesas-rzv2h: Update macros ICU_TSSR_TSSEL_{MASK,PREP}
Date: Fri,  4 Jul 2025 11:07:21 +0200
Message-ID: <20250704090724.669848-16-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1590bb07-66d3-4aae-9990-08ddbada580e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Xts6MKv9FYqKCHJbvBUtH5oC1keaxMjTgIXOT3ErQYtrXSPARa3wqLeRwFHe?=
 =?us-ascii?Q?G58Z/7SEaRUKaF6w0Hy0GsdZM2kDhs8AmsIxGolIXFc23e+HjU8q8/8GqfaH?=
 =?us-ascii?Q?w5WY1pCzgeBjVuEEmXJPoxJhk2BtwS3s5u2j1SM5Pq44RPzonVxiiMc82IqW?=
 =?us-ascii?Q?v53Ih0xVgib1DOlD2lRGaYOQVRLtTMnHbCINlo2+9WTBc9qnaz1Vu8pEENvQ?=
 =?us-ascii?Q?jIgE7rrX0BHMPJfJEIkdt4cX0D+HbLKk3jLQNa6zgKQMsznmVu298dAhDrOu?=
 =?us-ascii?Q?myPF+dpVxgbHUimQZiXr7nIyIsVKAU7bznacUkW9YoOTVo7/mwl/anA+p9bD?=
 =?us-ascii?Q?vtFxu/RNNcFkR4bYmEjNAlKE2nNDMs2q6N+dJOrIa3zEa15I3wAwBVi5wCu7?=
 =?us-ascii?Q?zvb4wDC5+P9cbUSp1tiEAxCeWxYPML60AyCXkGuLOdBNdrbJx+k8u77fGYDv?=
 =?us-ascii?Q?V9voolPM/spcu/HroERkA7l2Q3SSZa95n84BP24JWq7FYH4Gr4vkLskpbhfx?=
 =?us-ascii?Q?RJBTSbhjocpGoZeA+hos44hmaXmjFpimAmJmMLirNYewRBGVHKcdcSH5V6nm?=
 =?us-ascii?Q?9COzqDbAN1v0Bz1nyRwnbO966vsOSlJDos/TJifcD/ESlwF2IQzSImuUyxbf?=
 =?us-ascii?Q?JDHb5DADItwKttOTmKtxeo8xjYKr65auVsAgHUUat9WlLxWTAdx0cyuo0772?=
 =?us-ascii?Q?lXPLyej+Gfe8wTeHpmgc8qYwBOLSci+sR3CwGnKXgBWbz8Q7sI6eb5Yh1tp5?=
 =?us-ascii?Q?B3x6/7meXG8umjZuvHZUGSEv5teAzJRov9PiaA27vTlnb/GRsrROBBCvdBR8?=
 =?us-ascii?Q?3hNTHjubFH3LOcLEnrd8qpu9BAqQvb2JBsZUu7g5QrnkZmxnujPCXsIpoNJo?=
 =?us-ascii?Q?xDH948cQxpF9DcIGR9+aJbqKhQLA/cGQDjZ8nQS1LOM06rK6gPLRV7jbxbPz?=
 =?us-ascii?Q?ecSNw8o/LQGkjMFHLW8V/8QPgO3Ff+mdZBw93IrHWStvf+uyUY6QH+JYE9Ho?=
 =?us-ascii?Q?5Ov6tO4QX4E5UT1alGOlQLEEW33cttbI1qrKp0RkQfjRZPjMjD8yY/Nt3CCN?=
 =?us-ascii?Q?Y7kJrmfGchCk80ESc4Yn0lzA31m2IDSNnQ80ZCkMbohatmNbJmeS4dOVtOlJ?=
 =?us-ascii?Q?MWiTpEXEq9GH3xjNWPreoKv1Ku1sAYEu5qIZ6cIjCi/GcBwHRq5/MDmtQ0//?=
 =?us-ascii?Q?s9AZ1spISc+b0azXydPinkzlYi1u8U5BBNqSDtel0Rxy+FE7dsG9GI1vUM0a?=
 =?us-ascii?Q?kvv8zX5dSsA5NTJRXUEUuPuezVjLnDE3Yr2OVJngRxwmnX1NjYd/tPayOfDn?=
 =?us-ascii?Q?UQtgsk57Q0alRhEU8z1mktNH1CsTgQIWO2YRsPkpxGN0e1Loemk5YU0E404P?=
 =?us-ascii?Q?gDyWq08ofJA22bGkSKhwaqCBtHMRw+gBzZ19Z3+tV1MCXRV1ILZkv8gGOwwD?=
 =?us-ascii?Q?XDwHw3EhAWs3PuiD2Z5y0Ixnc1l/ZDOp07jbWJEBp8zu5BYfXG3IVw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fDVGRqepnvEqqSnEHD+Bg6C69rdhUQsRmgXfneskCNhEnmro7J1JdZUj2D85?=
 =?us-ascii?Q?qvLMoT82GoGSYOEJg2jYpSlhZ5oqPTLcukM/2WNt+zKiCdPyIL1mDROwlG6Z?=
 =?us-ascii?Q?bVrfPLkznx51WW9jWhdihp5lq5jZ1w9n7vX9maPj7xb1c4t23jTgpIIhZCQh?=
 =?us-ascii?Q?srcrC88y620qixSjnE26ynf0NGVwkMeXFZ23GSYn2lD0lYeeq5QIMDtFDzAk?=
 =?us-ascii?Q?y7leZLe4Xulb9N6d7rDvpcudqj0pibrhrOr+exmR16KBMCu6M1WmqWrk5Y5X?=
 =?us-ascii?Q?gs6Ot3jkuiZWjbvwS7d/vR46I4ZIx8BlPwAP6Gfy3HFhx2oNq84qvnZhWS2y?=
 =?us-ascii?Q?OBiOtXwuLBs/a16hzJpZUPk2WV4Cw3MqcgeGZuFt8vwqwD9+DKkfjzlcEQ/N?=
 =?us-ascii?Q?dblwlM/61elKcYDqSyidA1EYUqzYp9aWhBpXWGdyI0hjLol9D90+KDlD1B5y?=
 =?us-ascii?Q?LlJPiZYnrwzF9nFIZ6voa2gQYHgt0GqvW2jezXowtbJejXeVeibVkAbjiRpY?=
 =?us-ascii?Q?00LOOf8sapMqMnV6YuyN9rjfuyOflOlyDh4Yud2mCXAcLdrPPn3kmfG/TL3a?=
 =?us-ascii?Q?bqC3aCyiLDBUvhsLekUw+jQZH+PYiAGQHVVfHwZex7l2MFVUvL/4Ucin/sXm?=
 =?us-ascii?Q?ul5B9vkl/k9I4FhIlHyHkyvZrYNjXNAPCF0QZVUURt0Yd2020Mm7KSfy1tpC?=
 =?us-ascii?Q?2xBfM6kVeot3Ee4hhg8zcd3pzqNm3Jukry+Dn0eTAVQ6EpPw0EE87Bzlf6j8?=
 =?us-ascii?Q?PDi0GmldYGTEhtJyaZNEYcyE/7T7nzjNiqknXqb7bmcc389Fdcwa8YBGytwa?=
 =?us-ascii?Q?CP9Bx6HytbpbZDdQHxUdZ0jMoj26w1Kwd5DTD9D/m5KOMU4PYIU85Nm6XFfc?=
 =?us-ascii?Q?J8xa2qaAmZAhmiohc9QKr5lqE+lA/hoBGLBEe0FjL35BrQbaSuGeW/4LXcJo?=
 =?us-ascii?Q?7kGlzs4ZTTtzFYq11iG8EcmHZaGw0W1q7V60PgWSAhzK9l0PQYxuubMP0gyO?=
 =?us-ascii?Q?YNp9UCHNOIRgWIbTqshqy2p45bMyhOr4m4pYA/CdkIj4WhdBeWuG6M3onhQB?=
 =?us-ascii?Q?v4x/uZZjF3xN3WMmICHoRTYbP9NGPy58VzYw9CQt4T8mNLrJxGxVffq1Q9yF?=
 =?us-ascii?Q?wKiFDjZnvTo9NnQtGWa+5uVktN8nfDWxlCjcJF1+SJ6wZN3NPfRG+eTGi01Q?=
 =?us-ascii?Q?znyMEyJRiD4Irg+g8d2QL45tbrlynBjaHDYXoQvvwp7WnKWH8OVLMPrO/GsK?=
 =?us-ascii?Q?AgZ3LbDwFWwORthGHyPewBkUYkWNbadjVF3oi06xxjZ/3BCN4SVD9s8J2PNJ?=
 =?us-ascii?Q?AbHug9C0IL2McDyHKCLMyo2pJdeDu0lO5XLeYWbBrToQAI3jxWUflKN22NMF?=
 =?us-ascii?Q?HDno/ZV+F/ShBu4i+C2qQ6V9/u27USvOx4/69jbtTDyG0bD49/ZuhE4CdUUA?=
 =?us-ascii?Q?ks/XARUw8BYc6iWLhlHiJ1vMprG9h54IdfhKBOI1lBllyIMKEdeIODt4PbLE?=
 =?us-ascii?Q?B6ejDfFjGFP2gzKu+piKfuYuTGJLkrKnJ7SMbsO20AmkIitjsSynNzI523KN?=
 =?us-ascii?Q?A7ErHbGz9thVxJu1MGKquRV6lbO0/uL+Tta5RD/o4z/xtWcge/76aRP5XrOF?=
 =?us-ascii?Q?cnAufbALiiyHHIUEKKq2dkQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1590bb07-66d3-4aae-9990-08ddbada580e
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:08:30.2769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgAmWzDG+wN7ctegm+EKMOhWkq1kqswsDyRl/7rnFg1Cm+OxfUtx6j08O4bI3lTJEzUBKTyWGi/c+V8Scs7mg4Go8JK/uWvifRyu/vfwSeo0fyBx4y3lYnhVPNRApO/z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19359

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
index 8d0bd4d69de2..7bc4397ec149 100644
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


