Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520DFCA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:10:04 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.37])
 by mx.groups.io with SMTP id smtpd.web11.1071.1755706203059261230
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:10:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=fSncvEgx;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.37, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVTGcyOz3PbSmAOjKxZTRIvNsbt1Cks0thEL/wlhLuOLAea9iBwifndUH4c64V8+aHTTXvL00lK7T1iAXZ1SCPwlYa/99AuriPSNg02cmX7q0lqv9o7pyzOSBv3/zPaEG8oX4KGR6Pjkx/+2UK07eQbdqKoCGf5Uj2GIljUja5ks6lN2cLuOdPtVd6ghGTCnbPVKmiw99kIWUFpmLvdqFVYWF/6/v0lo/E9meFutcUYXd2pXCPOQ/hNj8Y6vmKNnxUr5se9ADrIDTSZZ7+N5m8yPFVt1TWA1JFReMbWInkR1KPu1paZqDXsQ6sbmoZ8tf/rc5y5QWyTvmlKj4V1dyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPFJHFQ3er5dEdb+fCCDhPaIntEY1q3DSc/45Cb7qcg=;
 b=VVEfHGwjH9rXYYvDpC3JLiIWN16nGKckXc1Yks+5+2/oBLhCM7OaiFAUZAM+4fG6z6DDbSfsHHB8XAeeL/98QyQoLVjqKROrOt2T0e8aarleK3PXbVZ9te3ambg3JIdoKJUISBx5/g+xkcxrkBr5XfsDXeotgBzDjahjcVB8ak527IdUpAcpbJkgxG+oKGl+zrP1U2kE6lAnzDf55oG9mRcPqfnfvoYngwTg9HDQRxMZMAIkVr657YJ3MlyPWS7GfB3NsCTDxAOHpG/RZFV/g9UTGkS2goanqpSzp37jI8z3Yy9we9pho2A3w0QCXJH9d2FJQ7TS1yAZTKkZC7ljGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPFJHFQ3er5dEdb+fCCDhPaIntEY1q3DSc/45Cb7qcg=;
 b=fSncvEgxHNqPNb48aqZwFBudVKO4K7GuNwAY+zD77AAL8GFutAY6vfjPQIMu6SSgoHKFQMJK2YlDmN4MOk5Bcjrqun8ma8vWbOPC3Gx84loKnysnXogguS9Z5mTi9xuyXgsimHZWDMIiOrVEXbQpAeSZ3hOr0UIIOIHuaQrqnhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:10:01 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:10:01 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 39/55] media: rzg2l-cru: Add image_conv offset to OF data
Date: Wed, 20 Aug 2025 18:07:40 +0200
Message-ID: <20250820160758.801813-40-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: b4881e89-a30a-41f0-46eb-08dde00403f5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0y6gDVgf9v4WNU19ERrfaM5X0pk+NlYlTtQjqXf9RkiMrnfuYk5XWslk6imq?=
 =?us-ascii?Q?jzEfiGJ1PmcANWzm1ZspS3OOVIPirax+JqU580vqOTQMCFtwkjBOD7WAHbTr?=
 =?us-ascii?Q?RUV0Iwic7Xsiyjbo815IhnxN0Rph1q2+mEjjm1/ZRhuUIxJg2O9YPmqLAPC6?=
 =?us-ascii?Q?rk4hB8/gpGYo2sODA7BVzylP8giPAGmwwtf9Lb5Fc9m5qitbK0IlyRw7vL1I?=
 =?us-ascii?Q?snqqbAU9r25MSBTi31yeuLRBF5KRexoMazx1ZgV1zEBRP3TSg104bfx7QfSP?=
 =?us-ascii?Q?PzCOyip2j+Oc2jADM6y8lcqi3TfD0bEPyCb36kws6u1NQl+zK+Bb1jo+9D3M?=
 =?us-ascii?Q?ZCbvnHDf/qjLPrOLNiu1f8VwB997L2ZtBh2Qmj0MGxiKTrr4qO1rtYiKeKQ3?=
 =?us-ascii?Q?JJ7qDZYDDrzLRjm0kH0NyJsOXiDrvkPW8Pifruew+98pUzdcqO/MKrGyUOZt?=
 =?us-ascii?Q?FPaZ8WfRX5jy9tHEwd26c3bmSan1Uorl+aVraCUnqjrPQ5RJI8tGS/s540sw?=
 =?us-ascii?Q?FonFBXjStRpEVgz9QCoCAmyc+WQ15t1IYOLpBOejYin58DdTvJq56niQ1On2?=
 =?us-ascii?Q?m6k3V12qgnAg2nqy6mf2NxcsG0VQgkoxrsd1k3zkdvwT/jfK+uOzGq0BDHuo?=
 =?us-ascii?Q?zlHKpd6zSMVa4C6pAOkf9cQ+cGNkkHXkofgpQlIj4MXBbpKImmIzrPC5J0Wz?=
 =?us-ascii?Q?a7muy0Z0BVDnbUPR1fjN7pI8Iv7JWJYh0EPE0oL5vvCZJAox+a0spVxiKUWu?=
 =?us-ascii?Q?VXnxWFE5SBYXh1V2i4WY69bzNDThII4j6XZQ/gNIXKyW6k1Oc7oHqULr3pdU?=
 =?us-ascii?Q?p0gAtTrcI7zLBe3h5H4Hb0v0nnnJpVm62lArb0vBzrp5z6LUb7XNs/0Cj39e?=
 =?us-ascii?Q?osV8a69hfPzZJHmqJkTx/D+udWNfnBqW/qccl3NABPcbPhNVglxAKQ5rA4xM?=
 =?us-ascii?Q?aDoiW0QNbhgQ+K9WMoHnABBJXzOTCTACoFFU6E2k5U8XL94lTyO6SrqEMLpQ?=
 =?us-ascii?Q?9pIQ8XSfL+HH2FXspsdjPkLydJ+2WG/07BV97gZiUMdCPtAcVwi8yR2MdReZ?=
 =?us-ascii?Q?wL99iDrpErSAqLNVmIsDCxozQ2HuCrypuVd4cjnYuC9iju/1M7N1bT3yZtnS?=
 =?us-ascii?Q?vWJDhoy9T0BHvOEXT2nDxBGZ7VdVwEXnz8fPFSls1sDxws2CUQ2MbBvgUw53?=
 =?us-ascii?Q?jOIDGGJNqAvPP1rbsToe9DRY40F2HUnlSSZY9Eu1njwrmznWht75x6f3hYv9?=
 =?us-ascii?Q?sLnwiBzf+DIb/2wAI+htms/h3bzpyl3507pU6vUJgpQvpV0KgsnoYYnahnk5?=
 =?us-ascii?Q?w5JRD/suK6PpXxmbXUQNMw1KMxt2W9JulQporYuNGJNK6pP0XdLkzhfslPRp?=
 =?us-ascii?Q?Tobehv3xoFssk6W73ynbyARIRkVIFVL9ACA7lXcmGXrxgvPwyc1yV0gPiFXR?=
 =?us-ascii?Q?qP5bCfFMY2+jomdDANxr51dfhupTnMk4JAjVMgpX7PiHT390d9+JrqKWbFUU?=
 =?us-ascii?Q?0/p2R/0GhWPzJN4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gpFBO/UcuSkRxgR1zPA5NaclKBBKr62fdxBfpaEmtsLCAdZcSTR1lORfSo3Y?=
 =?us-ascii?Q?mCH14MjravJAgkkSKOm99Q33oDDOxBdXFuemILPpd4Unb1t+iwcQ4dDq2EHx?=
 =?us-ascii?Q?0zF10mYNRRzQaXheEAOD8xLDLaMxBW+Nob5+9SiORlvfAVAcFs8vAAqFOCZZ?=
 =?us-ascii?Q?tlwZXnCJKlRK4koE3VPBUh40EmxUlqRqObV/D8mL7ZIMZ910tdNVoZGtRmfA?=
 =?us-ascii?Q?/B5ImDKUjlOHoqk+3bBAIGfwa1cTzqzT7APu1/Hji159f0zhGgVg5eKCsO7q?=
 =?us-ascii?Q?BV1P2fWKwNgepHe1Lw2Wa3rz9/DUfQpqoUbISo7U2oPlDmV2vhtIr/TCTtqn?=
 =?us-ascii?Q?59Smnsp3xrtRdxL44ru3UUImQAAmVvBd1lQgjmHHoaAYfuDY1yQVoteUu6HY?=
 =?us-ascii?Q?vRJntQgzkkwpkm/bcS0Wt2xYHFCifKvygN2Y14L8ghPz+yREJmXk3rH/uSAu?=
 =?us-ascii?Q?lo5w2Y3/ijyhkJU34Z/I0lgLn4hmSgZMXUM8SdUiD3KmMEIvAWzSS/nyA99w?=
 =?us-ascii?Q?GYCfZ7GjkDkYD5mydV7SfnhdN0wQdBVzwyTXeqoHfUGyP3h5XjTdp29Z7FwI?=
 =?us-ascii?Q?tVr5j7y+ddNRL/227v0O/9/s89RaLZvLmYbJbU0/y+mgKiNVVeuWIny8PpI5?=
 =?us-ascii?Q?MJ3sSJt07gU1NbVh2wI6/7lcegYGrQhKKfLCuna7Lw20C9Nyo+F4MFd/9+KE?=
 =?us-ascii?Q?KnxQd//NsR4gnyKv7M49oGL2R+k6zETWlXBojh9pEOciLHQdwagG2kUMWNwo?=
 =?us-ascii?Q?f2woS+gbGKLKzTCGZRda6OBcQJHB9Acak7DGJwx4CHj2p3+TRtkBaJKeAx19?=
 =?us-ascii?Q?mY/2n2Uawc3fVgm0OcjhB0ITVE2WmfTriLqaQokrTFsk7+0GSIN82VJWHT40?=
 =?us-ascii?Q?EsB274OucIXGm28TGwlW0ap2TX4Kijfk8ZCebjspai8MQK9DVjvqnb1BKhaa?=
 =?us-ascii?Q?ZQWuBLoClc0Y2czr4yW52WdYdXY4x4pbycjU8/mJnaF3QkD2bCXZSYHbpI/p?=
 =?us-ascii?Q?0UOdTkQzniZWNxAIujBAcFIULgXKPU78OhibkJY8udV7YYxxVu0zwO2WIgnE?=
 =?us-ascii?Q?FB9uWRn95hGQYRPZdVFzyIVagF8IXJQA6N5yC+MOo5qu7y8HFb6OpskxcTZA?=
 =?us-ascii?Q?Z3K3tv8PB52oplsCybx/7/iwoHOB6D4LS2IyauSxA0008PWKEG4rMXbelThf?=
 =?us-ascii?Q?2D2dBpzHZQvtRNP+UQ4FXlg6s/p++KrEtYl6k0KA8EBAnbCbLhAfinjKh1RH?=
 =?us-ascii?Q?1OZdaFS2nK25q6v432k34GoYvgLceqQR6pAGGPacFD0uk8+vNk0M8Vu35iES?=
 =?us-ascii?Q?wk6ifEENOPreMS4lgRtqICGtlPCG/B+cUNHwjBXMA7WJbf9w3ASGHrLisQpC?=
 =?us-ascii?Q?CIct16ojkJveUHdhvBB5R2HJyx/Dw1Bf/Wx9UDRyt8kIbCfB6Fgx/yXbDoy7?=
 =?us-ascii?Q?53tOqR/7w5WplpoeybbAAD4bgCeV8SrYzt86Bey0MSl2IqMrPVKSgIBzRw4e?=
 =?us-ascii?Q?SQu7XUjaq7f4IVWf2YXE4jCPe/+vfuEe/9fxsGO6ptTCEKN/q/Gyjy+fWN2+?=
 =?us-ascii?Q?Szw4/96ybjlRRA0vLauxMUm15lqxJSnmsFO28EAct2pJ8nbodKimW/STGUTw?=
 =?us-ascii?Q?8FPCfauhAb1SxIOhlV5jg1g=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4881e89-a30a-41f0-46eb-08dde00403f5
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:10:01.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oV/3VXHo1qJU+8gIUCJ2PIB6z2LieoJV4PSrASoaBA5AGNWpLaMNHn4YGKkGSSBGCrDdlEW3IN3J3GbyCWhVzhzvvl3+ko+Z40xKzK5iVNXyI5S/jMsWSnLwAUMXDqX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:10:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19920

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 48ce5920da1d65f22b4808564f6f5c9c4ff9d976 upstream.

Add `image_conv` field to the `rzg2l_cru_info` structure to store the
register offset for image conversion control. RZ/G2L uses `ICnMC`, while
RZ/G3E and RZ/V2H(P) use `ICnIPMC_C0`.

Update `rzg2l_cru_initialize_image_conv()` and `rzg2l_cru_csi2_setup()`
to use this `image_conv` offset from the OF data, facilitating future
support for RZ/G3E and RZ/V2H(P) SoCs.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-14-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-core.c  |  1 +
 .../media/platform/renesas/rzg2l-cru/rzg2l-cru.h   |  1 +
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c | 14 ++++++++------
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 6c3e6c20ac6a..254afe5e594a 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -354,6 +354,7 @@ static const u16 rzg2l_cru_regs[] =3D {
 static const struct rzg2l_cru_info rzgl2_cru_info =3D {
 	.max_width =3D 2800,
 	.max_height =3D 4095,
+	.image_conv =3D ICnMC,
 	.regs =3D rzg2l_cru_regs,
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 6a621073948a..ca156772b949 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -81,6 +81,7 @@ struct rzg2l_cru_ip_format {
 struct rzg2l_cru_info {
 	unsigned int max_width;
 	unsigned int max_height;
+	u16 image_conv;
 	const u16 *regs;
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 83e8af1d7ef2..d9135e2825fe 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -246,20 +246,22 @@ static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev=
 *cru,
 				 const struct rzg2l_cru_ip_format *ip_fmt,
 				 u8 csi_vc)
 {
+	const struct rzg2l_cru_info *info =3D cru->info;
 	u32 icnmc =3D ICnMC_INF(ip_fmt->datatype);
=20
-	icnmc |=3D (rzg2l_cru_read(cru, ICnMC) & ~ICnMC_INF_MASK);
+	icnmc |=3D rzg2l_cru_read(cru, info->image_conv) & ~ICnMC_INF_MASK;
=20
 	/* Set virtual channel CSI2 */
 	icnmc |=3D ICnMC_VCSEL(csi_vc);
=20
-	rzg2l_cru_write(cru, ICnMC, icnmc);
+	rzg2l_cru_write(cru, info->image_conv, icnmc);
 }
=20
 static int rzg2l_cru_initialize_image_conv(struct rzg2l_cru_dev *cru,
 					   struct v4l2_mbus_framefmt *ip_sd_fmt,
 					   u8 csi_vc)
 {
+	const struct rzg2l_cru_info *info =3D cru->info;
 	const struct rzg2l_cru_ip_format *cru_video_fmt;
 	const struct rzg2l_cru_ip_format *cru_ip_fmt;
=20
@@ -276,11 +278,11 @@ static int rzg2l_cru_initialize_image_conv(struct rzg=
2l_cru_dev *cru,
=20
 	/* If input and output use same colorspace, do bypass mode */
 	if (cru_ip_fmt->yuv =3D=3D cru_video_fmt->yuv)
-		rzg2l_cru_write(cru, ICnMC,
-				rzg2l_cru_read(cru, ICnMC) | ICnMC_CSCTHR);
+		rzg2l_cru_write(cru, info->image_conv,
+				rzg2l_cru_read(cru, info->image_conv) | ICnMC_CSCTHR);
 	else
-		rzg2l_cru_write(cru, ICnMC,
-				rzg2l_cru_read(cru, ICnMC) & (~ICnMC_CSCTHR));
+		rzg2l_cru_write(cru, info->image_conv,
+				rzg2l_cru_read(cru, info->image_conv) & ~ICnMC_CSCTHR);
=20
 	/* Set output data format */
 	rzg2l_cru_write(cru, ICnDMR, cru_video_fmt->icndmr);
--=20
2.43.0


