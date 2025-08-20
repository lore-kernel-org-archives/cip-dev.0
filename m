Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2175CCA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:24 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.30])
 by mx.groups.io with SMTP id smtpd.web11.1034.1755706155731676052
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=biN8TB6L;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.30, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxdNbx5qkj8LXRWVwE0ffUy7+kHa57RCHl/eqmmQlwAB3+6XggLbRONE4mVG1myx4cSPfSFQIQ3zn3wxjo731mIaT2/sMKAKJ+fzDTe/eMOD2MbYaXepz9iat9zmuibdhb0vvbx+z6w4OLZdH5qm39ZPgj6gH3/CDnte/MSblB2+jgpDlbJAbWil8z4fFX5LgH3LHqlDAfMrYrO8MFCL2Fzuy/0PcEHBHmj2fJgUBgIrnOJi1Q7qsqhiWSC82eLBBY03QcNJ0uBQj1nkOHYgIhhSnGM1D2aMkpbytCaT2IZiYwbUAiuxZVvIHtaEFw/UW8JFdAJTTbHAc1u7odalAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLKbBjlkCI0GF5AsG1gjSS9TRWJ0GCkt5V+jfqhUxO4=;
 b=e/erGmcoR77x8eB+lTnGyF58jGTKZKhpOcgW0200AoYEusYc3GoaaHDvXMQQfHMwa44vsixRLI7ctLKVXkWVkkg5zkqE08+ymPpBZAnSkYTwLWVHCo+esNdfNGOY4anRyncsm3DEYL4R6tt17Sd6EKv9xslk6EPtzhL9u/30QtyAyztW3/P6jlmkQmoZgIv/0t+qWuLoKJmJFXa26xTOYgVa1WdpHSkIv9mVbJQcI2QkoIQrpf8x7TbZ7Rh8S1kfMxotzQ4vl6+ITRvDfaDSPYkMyoYnWpHJJYfwoudHqergdQ3jW+IboUZ3J6fTH0MnKitSS5griEQxoV1js997RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLKbBjlkCI0GF5AsG1gjSS9TRWJ0GCkt5V+jfqhUxO4=;
 b=biN8TB6LvL/RtofxWnLGGUKPD/iBRUsnvldVeQ2/jCz+QGSz13UAwM7aiwUntp/Mnr8VQXfNJvLtQGkOc4QcEDtx4I2aejFcuUNc4PN3hUuHwoKaCfufKHK8BGK5FFKUG6aRgQHV8bJWxQZaT7dHaufEq0zlMOPQShxV5QBIoLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:09:13 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:13 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 20/55] media: rzg2l-cru: Make use of v4l2_format_info() helpers
Date: Wed, 20 Aug 2025 18:07:21 +0200
Message-ID: <20250820160758.801813-21-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSCPR01MB15595:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b25681-1f31-48a9-fb8f-08dde003e7d8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NGZDI2wl58nvJT097FoETdchHTmyDVOvAs4Uio57EPPUgCl8dzHz817ZqVx1?=
 =?us-ascii?Q?1Tv2yOEofKVoWbxDwnAt0Pb2dSXUTUq9kQFqiL3zbjjpyWZxJX34NSSvfzJ+?=
 =?us-ascii?Q?RVSGkOLmSXgIQjEATWOlSexuHtkG4DSEHWQiPXKwAdMCrdTr4pmcb8GfxqRO?=
 =?us-ascii?Q?h94rnqrg7taYjsxyGFprDt/2o2Jw5pfRZW+GJEgk+s58u9a834IfCU7shr8P?=
 =?us-ascii?Q?qWo1ZtMc6n+GrugO3/reY6sG+zfW1/KwMQsPuW2i/xrGhZ6NDBs27JkaR7DY?=
 =?us-ascii?Q?GDAnGaPRViWKldnPPYDxpnV5pzVG2WfIfrQwa3IG2R2qC0C5TufMOdHgX6Yk?=
 =?us-ascii?Q?ryIyzCr3pSlBsilG195NyDVr/Jy9nwzAtDiTTIBS94G0iw3BKGlpzaHn06f4?=
 =?us-ascii?Q?Ix9rC3E8agkko9+Vjgs4CEimA5w5iQKZSwaETHRqouWSneAROjbm9fdNC0qJ?=
 =?us-ascii?Q?Z55eNqv0pcRXGAkemidJ+cSsLJIhuOOHKLzyTsE8KjI6qDFYiQ4lkhFDL/iT?=
 =?us-ascii?Q?MILO6NDBYoPjrw9VVjFjDzlq1Q9bjjXpepagwufKfHBHp6NceWWFgbDdEahq?=
 =?us-ascii?Q?Pb8HN/k37NoPtlD035L+h+cDnt0o4ViJeT4M2aQZs2tYEUYYm4iwQ23R4XlE?=
 =?us-ascii?Q?CWco6bVm1DO5d9xD5LN+D2lWx5UjQu4o++2c76yrRay/SQU1KsglQf1oNGjZ?=
 =?us-ascii?Q?Pc5zy+I3aEfiv7Snb2sJm+bjObmAi4a9akmeQToKFTekxGZkbFN0llcgh1t2?=
 =?us-ascii?Q?XmL3RajXBQU3Cp0WGJp8toVp6Iv5xBZ7OjAiSbDqUHD6nJRBlDQegjlLiCka?=
 =?us-ascii?Q?HiOiQ9p2Y0XuQ2eDoUpdeZNNxbRyucuXfvvqfh/mpWjIu/yJY7zt+DXVxEkA?=
 =?us-ascii?Q?QxWLquuG5bdtydGgY5IHkRJq5zh3yzT0Ud97FY/1kzbIP1YqLbin9Z37U4jD?=
 =?us-ascii?Q?cqxq1cIC4fjt4fM6jteBBBPmZ51nczzAnSvQnN7O+n4kDeEFJBKUo0bDQRxu?=
 =?us-ascii?Q?kXH9/HcSFgGk++oMaoAT7U9C0IfovX7CBgqjNf+mFVNTm6/kJRfrt5wlUFOI?=
 =?us-ascii?Q?rEgHr7utCn/7BgMsC5jAJQgJ3BLCCxtZhGPWOXzL719K3iFLnDdAozvW55o6?=
 =?us-ascii?Q?Ev6oxpcXQ+U7/XaAylbwKl/uZC7JLXfnnxJYHb7BQLaDoES2NPtHrGKiWCUA?=
 =?us-ascii?Q?eZ/gtdrHxj50nwd7A6qpGUV9VPhLaynJJ5V+6Iy3pgL5B5MF5rCimPerrMU7?=
 =?us-ascii?Q?bH3Q1583+aNeIpVvLHlxfoICcI/H7qpqeoWhlQ0xBB1DKHitU42UJrzCS2iM?=
 =?us-ascii?Q?DQ0ptJlxvlJzJE822Gdc7kcTyOlsWrRN/tr5YaZHBZDToV8Xk6UMh1IEVfpl?=
 =?us-ascii?Q?thHGm+/Rz3+o3o2vq52IIfgy9K1ChdWyIhdhVAeOkAUQ7ITyfttowq7nl2gi?=
 =?us-ascii?Q?JZvdLTYWzhTke65S8y/XQOJdSoJziEf/OcTX1twXxyNFAOtf0h+BXVzxYuXJ?=
 =?us-ascii?Q?adbL+4SMxOlwd5A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?g1mUmFJkxxPhFXeRXdLM63QC2KaeSXiXN8tgJk9G6ertxDblDmM5e9DrmVlg?=
 =?us-ascii?Q?uRaritw0BQZCtJjOIlvzi01av4zYfv8iBjGvPxvaEuPbXaUbq1nSYce9jHCU?=
 =?us-ascii?Q?jjgTP+g91q/O6gUXuYuRuepEdqRpcOP5otEtBA+Ml6aeDEQ26gfIjmzFYGty?=
 =?us-ascii?Q?t+mQB3TqCVZm4qEaQ7MJif5oS5KuLzshQgjdMEGZioWr8KbW6Jom9K2PqvYd?=
 =?us-ascii?Q?NezULW3R8nMAdHgp0QlD6otkNZ3jjdBDkmBOisD1cDAfyOpaZNCGCPQyUPly?=
 =?us-ascii?Q?lxwDndUrjsgCi/7BIclBB8+yhm0yMV4S0V1QQImaFgYdbEUU01IZU33Zg1Ko?=
 =?us-ascii?Q?cY0Q0nuM85NUcY4c3vRIYjVdH2qfu8FRCON2kA4MMiZ6WdCRMlj2Cguur1wq?=
 =?us-ascii?Q?XGBV7PtYcmxHrxcMIfXQTPMK63wMk7hbdZQufdrMI05Qu2HPrnKrArWE6FVl?=
 =?us-ascii?Q?rUaPIxhPG0FoOULfONs1HhuK+Jxcyb5LxAN7kX9tapktCULzpqS/CsThWwGV?=
 =?us-ascii?Q?XmVznJU+2PX8V8hN1DDxbg/RpVik3yhX9fL34jydk2uv+dhNv3H07V9CXmMG?=
 =?us-ascii?Q?axkkwg0d1Rj6WaVeI0jCyz+4Uhztbz022v1D5tBWoDQOr1OwddjHylHUs9P0?=
 =?us-ascii?Q?eB96wp7BESA8tnLxcmFfE09cuJoL0bz3NoN5SuqiK7ImNUhLD8MzKViHJr5V?=
 =?us-ascii?Q?g/uu99nihnMSIuHbXV8/b/BWGMWAHu61GcJX9CHmE8gg2t6GHQuIxXzXlCH5?=
 =?us-ascii?Q?eppae0DmL+KAI1gnkszDaj75lpJbvxBZII4T7kRtBaWJMSIBnxU3qosjl1mv?=
 =?us-ascii?Q?puBR5J2PCx8xk7s01yQtSr84leIXliOaUZX09G6oRjJ8cuAFRwXNkVyenVPV?=
 =?us-ascii?Q?kkFJktkS+hl3MzzxK+6IHl9alXM2e0rj5JDRzPRzPJ2JOOMzVdQAL4PVCICQ?=
 =?us-ascii?Q?Ms20EaPVuVJmAxUwsjL1+rGI68KA8dFWBBriESNh7dwkeI2oNnlQ8EFMYhS1?=
 =?us-ascii?Q?1SccQdwEgWCErpircC8SVjrQ22YO400nmhOZWq4VM0K/bDcrL/7m1t3KPqdq?=
 =?us-ascii?Q?MxlR18qWhaLGYUcVQEvhf6mO0xltYyN60TMcDH0dc9gLTXxug9bi3gL6rKJ+?=
 =?us-ascii?Q?3PfeTCk0OixX/I6XIOsZtpyIpuuZ1NFOLp15rCyS/Hf7CPKSZXhYuP/xihpq?=
 =?us-ascii?Q?R6j2Bay7WaG1FsiEXPjbiub25fo8Ti+KInJmUENY6AkLI/oTNPHhr0MLRAga?=
 =?us-ascii?Q?MyCKSV2fF9rVxLQBYZNJv1A2IFvRQZtIjNjVrjw9XbK63UV721zv2XYaO3sf?=
 =?us-ascii?Q?7uN8nz28XmyYxssC18ZpKrHYojKLMAVy7AJnE/vhmvuoZ3jQpZcjXv8aAqyD?=
 =?us-ascii?Q?sxvnxOR5afoJNHly2znP3rujOHUaOzsL82lMpcwsvJv3y+waJtA1ETREzH0R?=
 =?us-ascii?Q?IYnnQlHtRjoftPkSfBTwKrhN3BIoHbN487I6FsWPFP3Az/fOt3VWMiQoBHu0?=
 =?us-ascii?Q?6TUUwrvOZSpkigG1jzteX2w1/9K7A1q9eGZK0XAypMlbl3Lgbs5s4KdEKM7W?=
 =?us-ascii?Q?i8VfBFzG/COWAEZo+mkAdd28VnmpHc27uvvp/b4PAdao6v+Z15LZzqFs4ET8?=
 =?us-ascii?Q?Ybupk9svcrFrh9HFDv/xZV0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b25681-1f31-48a9-fb8f-08dde003e7d8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:13.8614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBIdyGw/P3eSnwIt65GV4IOkNyCNgc+HGew5cbjICkf1TaiSBnm0ptNJSZgfllBEd7ta60YbdNAqMnBde8Tx9QYQkUSzJjHZHjdyh5JfoJYHMhReOsok5XcL3TjLzb2b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19901

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit fcb8f9bb3560e598da0b26976bb1f576199b4301 upstream.

Make use of v4l2_format_info() helpers to determine the input and
output formats.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-16-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 22 ++++++-------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 8932fab7c656..0cc69a7440bf 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -300,21 +300,12 @@ static void rzg2l_cru_initialize_axi(struct rzg2l_cru=
_dev *cru)
 	rzg2l_cru_write(cru, AMnAXIATTR, amnaxiattr);
 }
=20
-static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru, bool *input_is=
_yuv,
+static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru,
 				 const struct rzg2l_cru_ip_format *ip_fmt,
 				 u8 csi_vc)
 {
 	u32 icnmc =3D ICnMC_INF(ip_fmt->datatype);
=20
-	switch (ip_fmt->code) {
-	case MEDIA_BUS_FMT_UYVY8_1X16:
-		*input_is_yuv =3D true;
-		break;
-	default:
-		*input_is_yuv =3D false;
-		break;
-	}
-
 	icnmc |=3D (rzg2l_cru_read(cru, ICnMC) & ~ICnMC_INF_MASK);
=20
 	/* Set virtual channel CSI2 */
@@ -327,19 +318,17 @@ static int rzg2l_cru_initialize_image_conv(struct rzg=
2l_cru_dev *cru,
 					   struct v4l2_mbus_framefmt *ip_sd_fmt,
 					   u8 csi_vc)
 {
+	const struct v4l2_format_info *src_finfo, *dst_finfo;
 	const struct rzg2l_cru_ip_format *cru_ip_fmt;
-	bool output_is_yuv =3D false;
-	bool input_is_yuv =3D false;
 	u32 icndmr;
=20
 	cru_ip_fmt =3D rzg2l_cru_ip_code_to_fmt(ip_sd_fmt->code);
-	rzg2l_cru_csi2_setup(cru, &input_is_yuv, cru_ip_fmt, csi_vc);
+	rzg2l_cru_csi2_setup(cru, cru_ip_fmt, csi_vc);
=20
 	/* Output format */
 	switch (cru->format.pixelformat) {
 	case V4L2_PIX_FMT_UYVY:
 		icndmr =3D ICnDMR_YCMODE_UYVY;
-		output_is_yuv =3D true;
 		break;
 	default:
 		dev_err(cru->dev, "Invalid pixelformat (0x%x)\n",
@@ -347,8 +336,11 @@ static int rzg2l_cru_initialize_image_conv(struct rzg2=
l_cru_dev *cru,
 		return -EINVAL;
 	}
=20
+	src_finfo =3D v4l2_format_info(cru_ip_fmt->format);
+	dst_finfo =3D v4l2_format_info(cru->format.pixelformat);
+
 	/* If input and output use same colorspace, do bypass mode */
-	if (output_is_yuv =3D=3D input_is_yuv)
+	if (v4l2_is_format_yuv(src_finfo) =3D=3D v4l2_is_format_yuv(dst_finfo))
 		rzg2l_cru_write(cru, ICnMC,
 				rzg2l_cru_read(cru, ICnMC) | ICnMC_CSCTHR);
 	else
--=20
2.43.0


