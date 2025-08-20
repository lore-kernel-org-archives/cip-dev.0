Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A2BCA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:14 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.2])
 by mx.groups.io with SMTP id smtpd.web11.1032.1755706150904109392
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=CkUngj1R;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.2, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xM3DDJlFhHOiCYgPTxXmwhJpHGHiZoLC0N2Fq7FUGgRNjNqR4uaOdxB0Akk9+GvGAvagcLh9IkBxq3yjZppiiXuChMEpyraby/VC9Vjti2UNgB1rvBuIsxjbkH69YYyli0AMDkiqyo2NIWSR1qBZbTA/BLy/aNvKuc5TLDZ7pUaCSpo0H4J6CncW1W4LJAMD3V/kwwbYl3nbptzER9c5W4o4a+ADd2YA+Fst47W8D6jwHquYT9kydyLIhwrtFaHHJhMLQtaonyskI7olFvVckCRZK98sDY2skxPAheXTb5MSk3in78I3cpgf1qkSjrxaH3lo4o6zX/cIPH7OsAPieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EX42WJbAIeAMEnSzjackU2wJfkUR669YQ6YMS5CP0IA=;
 b=R/EXWH+sz4lFxKdHMmtGHWsIMEuXvu8s+dAHed6pxedwrK/tEmR4Qyw5aFAf2jfpi9xaZt3Awe9IANVa1aOWHtCR82ENsg1l8Yci7vLbcbBXQ+67wZbKDBT4biWtr8j6FXa8RmDudOR7GDAqqfEfHxcagKDnyzL3NxpW1g3TVjCYtcombbPKTXNDGkxI63s64t89uMS3WR2KUn8+f9liX5QNqTo6Ta2GGATEGqAWWRASRfCaR7SpYE8WwmaiG6IH+XF64zqQPrp43fnpDkNsa2B/aOxu2d7zcotIZwx9FJHMCi8xcXBHU9PmCkP2pzuCCfbcHEU+WJ8j5FM1kRhpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX42WJbAIeAMEnSzjackU2wJfkUR669YQ6YMS5CP0IA=;
 b=CkUngj1RWFTZXui8r8+xi8ZkWREp30HHCfmmvqTbV5bSbMc02I3v1Gcv8vssL6mY9ThM6g0nDCSoCU66kq7qupZiiCpca3M/c1sGJUUzCMmTarXCh8WuJIM697QgQSBkKIgcX1TRsmP2FUevXGoR3lNIjmkffTn8qN//99ZJFAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:09:08 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 18/55] media: rzg2l-cru: Simplify handling of supported formats
Date: Wed, 20 Aug 2025 18:07:19 +0200
Message-ID: <20250820160758.801813-19-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6c00134-b1bb-4a74-36b5-08dde003e4d3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IvcWKDtWh9GUSlG2YmDljEuieUZ/tYa4LaS4yECZjVk/K/BtrztNXBTstd0x?=
 =?us-ascii?Q?oVTO3lPd+cTQIeTTj7d/OFz1H4IcGCW71d8gtEQd6JUCNpbOlCQGrR6PWaKB?=
 =?us-ascii?Q?oPBGi8vIOBZ+sUcPekI7BPdG3YEKwWrGhdZEvy33bkbx5w9eaYb1SrWSLz1Y?=
 =?us-ascii?Q?zc1l9B5md4GKRNwlRFbZbgIvX8tmN54j7MFqK0ckBDaKBnWW1xde0fBsj5GT?=
 =?us-ascii?Q?a+0V29zgAyl4wMwbgsv+k9yDmqiSldLhE7NNd8U3AjYwP/S1aq8HdrXtBrH0?=
 =?us-ascii?Q?c7QhMydTvyeSBLpnPE+tOzKKW3KE0iv2J6goOjkLwxqsaoPJQzhTa4kUeapT?=
 =?us-ascii?Q?Wl4oq9d1tSst5Bjmv5+rDI80gZ0IHVma51Yyedj5gC39oVngtWj4dNd6wsnn?=
 =?us-ascii?Q?HBY68HqFKq9K+CLYREGtwPj+XxtQVDrm/elxANOlBSLJY9BmF9jGWTqbKXqo?=
 =?us-ascii?Q?nT4CeWsR5ZxOKU627bj2+NHIEM2cEvBlCz2T3Qj6y0VrDTORNvctTh7DH3Uj?=
 =?us-ascii?Q?UVPDEj8lNi9TTI3zajPIrQIHh50BEaw8g9Yc3E1PI7U2OAuC6/Ta1oQuJNv6?=
 =?us-ascii?Q?z9CVFlo3LC6RUNcWe9oCY1417ZYzupPOumxAVYXEyvur6GXskU5VU4ooaWKH?=
 =?us-ascii?Q?PTdVLG43/n42qD6tbgEoo+hSPIx6eE4UJYX74VvdZEzatkK2AhCBpivVRVQX?=
 =?us-ascii?Q?YvH4aQei9a7Kgt+Bw7CDYWwQru2CSzog2kcB3tvsQLaalSO+/JL78t9CC8AY?=
 =?us-ascii?Q?dwt1uhqXwipIaMwoCzt4acV1OVNiRPWCLvrvUghmSlgI/RbsQ+FTVG4s0jr8?=
 =?us-ascii?Q?xxJo3KnnpjroyLkXq7CCJKkFXXc73rOqes/lEIXauktjLFhGvb1DajwRojRz?=
 =?us-ascii?Q?Ytf6gC50Iyrh2ECL6tz4Iw113TwDeVR/P0gXKIqNrG2JzBYs2Nurizg2vxBQ?=
 =?us-ascii?Q?j0RJi5x3h483JklvfDC6+mtjJixXiCV35gt7Aw7hxEqS5ZYpFo45caO59T4z?=
 =?us-ascii?Q?MZ/DmV8dhXQLU2d1mMpV3F7xPt9NJjJ2YwhVV4UYxVungVFlNAR1rVoC2uQ7?=
 =?us-ascii?Q?8N5gUvK70H8cum7gqx+NCZpZPE6eN6kB2wFrk/uBx1sS9sdThsjcwjq3/HS6?=
 =?us-ascii?Q?isvxYT0A9e/f+N2mfYCkj2y2RkEJjGQn29PyU1LEV9etIF1TUSRgD8fEjgHn?=
 =?us-ascii?Q?xxeJS5pHc5na6MDhFDWsSc1iFcxQreCutTCCWEQdAdMF5y9Z7ex62yTkInkb?=
 =?us-ascii?Q?0tJzJgjU+BnYq6bvK89AszIuFWWNPNhl5Up0sfgPQ983BlUw21rC1Ou7OPN+?=
 =?us-ascii?Q?Cprd1iUSLqUndFlHbMhG1+RhA629dgHwYJTcpR5sK/VRa4cyvj4Vz2JglNuV?=
 =?us-ascii?Q?dzZNnThMzWQa/VERD7E9LMuAjRbVm6f4WDf+08A/BypvKhJvkbOzFB//g/zY?=
 =?us-ascii?Q?+/+GGPKkF2h6ww9yiup8wi91pNdU3O4fhwHoJpGafrnQoDt1G34d2YEHm0TF?=
 =?us-ascii?Q?EF0KvopuYGHGJ6c=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MJL94pN+mEZNbmG/FsSJ44VBBqxD0verc3PxrHIv5r2ZoKIHWcduj13lriq7?=
 =?us-ascii?Q?utZQbeFVRZnAyXGFN2LlKokzsHU0qIhG/N+H+kyiMnnXl9rL2N3ixNrsIl5L?=
 =?us-ascii?Q?iuJoW7UlGZ5g5t7z9fuCpJ+FgZV0w6fq1OLiAwXd1R0x/KODXOhZgYz3NWMm?=
 =?us-ascii?Q?IvmEGMlRQV59Lv0jR6owWSDb8Il+2p1X6lDTGNZ9YodsH0Y6Ob4QANUbpRID?=
 =?us-ascii?Q?2IO6QhHwHsKYW73pEZADO9o6akp9p8AyKtyHwcVQoewwC/IRngpMLSAXVG8M?=
 =?us-ascii?Q?CsY8Vy+icMm5B9jsdlgumlIIHq4UFRmKZeKfT2fX08ZwUIlJ3+F/y9aKQS/2?=
 =?us-ascii?Q?9fpwcbUrhA0+fmhX/2dFk7tzl0kUKGjzpPUdwzqleD1TRqtudWCmrzIOzRS1?=
 =?us-ascii?Q?gKAE6qVRuBwHK25uQcZ3eZfxaQozzTtznhlo2UD0nAB1E6oqbu56QSSRXnzd?=
 =?us-ascii?Q?hwKkQksYBHiPEMpYHmvt34y0OHYn0A5HzLB33guZNFL4Zsc+skXUDwyDWT3P?=
 =?us-ascii?Q?cn3TN2psHbZxI1YcwBCIs3nYYciQdDC2YDTIoMNcAunLr/RT458wXE14jbGg?=
 =?us-ascii?Q?m89H61O4ZplRD9cANVv9avGdEgMEoAXZSJXzXhbkYRisyZxdlRirmMjYGcMj?=
 =?us-ascii?Q?dsqNDPQfTXdAAqnpPhfU324d1yOVbRDT5Set6SiIg29+K1TA0ReU2dV1Acjv?=
 =?us-ascii?Q?uqnoTlLvnDHTymN9265gyWPRygtTgP2cmnclO8fd0aC9zX2aoVJ0dQE7Tk8f?=
 =?us-ascii?Q?pA6+W5sCWK/PIjMockScsVQtaEz/SjMHOGPICjdKS2h7E6fGIVeGnOQE291B?=
 =?us-ascii?Q?Zz/fo2O6KS6ZlHM6VXtj++uOcMqs4GM2BbkMWXNlpVKjCHYHuuF2PogURDxT?=
 =?us-ascii?Q?OGO6sJ4anLnqk0+Bb7ddOwuHeIi+opQ3J2UXejyc53Sb6KHfkemE1tj+6FlU?=
 =?us-ascii?Q?vFks18i7BSL/LLHcH2Cfr9ENvvc61qGDtA3H8Mh6cP4XB4wJfFlKU0LJ3Ug7?=
 =?us-ascii?Q?Bf2a3y1hd4HD1K1Yp7EGxkC81zF4bPHjCtKsne9dDj9GH75shewBAxQLpZUK?=
 =?us-ascii?Q?zn3Z1RoBVPYiypojXi8dZhyUav6cForZWG2jE/uQzvwXldZ5sHO518ZK3Lfo?=
 =?us-ascii?Q?AmaZ7t1jfr8tpDiYsAsiluyltl/mGPVuWV7o25dfqDciKEdZO8F1ndHE4cqV?=
 =?us-ascii?Q?Ka/wTAU9qvQGeIM9FB0BoAnTsTlmK7aH2O3mB35Kdyp0NKRHFJXlJVRaNCAt?=
 =?us-ascii?Q?+Cg7E7N8dkyp6w5mf+h75y0VEB3BJ9sW5DtoRV7iYZdL5UMgG2YcUa4E6mpO?=
 =?us-ascii?Q?oA0O694TeCitHmhRMSECqwzi0JK/REZwYiDKtcZ+DtGqrGz6lBnC/9NTvztT?=
 =?us-ascii?Q?Fn4E1YjEmvskD3oA5iw6l92NjObkfmbld7sT6b7kkicDqIlJQPOty5GdmW7O?=
 =?us-ascii?Q?nSj5L+Pb3d6LIn0X7N7enidGsYW8ISKdgu3JirdQzy1CLmfXIMiNUWzJRlX9?=
 =?us-ascii?Q?ZlhuMRGQQiTXXULl7hUosGIMSdSGMtea6CZ8o7ckMhXZhWkBQsec9krFCPtl?=
 =?us-ascii?Q?bsR1RhNePX6yKiXo0y3bB0Th+XjbuxxU7lTgMgR4IDHHaR0BJbAGsIN5RwYt?=
 =?us-ascii?Q?L+VzHNtVdmDiZQA/lMSRV6c=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c00134-b1bb-4a74-36b5-08dde003e4d3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:08.7921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N61OgFXghLM6jpAYJ0Gei+wL16pijqcyIB+NqBfLVT3CQOCucbRNuCvUT7K2bums79OQECQD3hvY82KTtoFaWD9NlTAFRwQYrph/JGUlB7ZapR/p/uSuHjvaM7kaG/AC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19899

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8853467c41e8edd77a1dceb22c085d1d483946c3 upstream.

Refactor the handling of supported formats in the RZ/G2L CRU driver by
adding `pixelformat` and `bpp` members to the `rzg2l_cru_ip_format`
structure.

New helper functions, `rzg2l_cru_ip_format_to_fmt()` and
`rzg2l_cru_ip_index_to_fmt()`, are added to retrieve format information
based on 4CC format and index, respectively. These helpers allow the
removal of the now redundant `rzg2l_cru_format_from_pixel()` function.

The new helpers are used in `rzg2l_cru_format_bytesperline()`,
`rzg2l_cru_format_align()`, and `rzg2l_cru_enum_fmt_vid_cap()`,
streamlining the handling of supported formats and improving code
maintainability.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-14-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  6 ++++
 .../platform/renesas/rzg2l-cru/rzg2l-ip.c     | 22 +++++++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 33 +++++--------------
 3 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 9b1ba015df3b..327516272e53 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -66,10 +66,14 @@ struct rzg2l_cru_ip {
  * struct rzg2l_cru_ip_format - CRU IP format
  * @code: Media bus code
  * @datatype: MIPI CSI2 data type
+ * @format: 4CC format identifier (V4L2_PIX_FMT_*)
+ * @bpp: bytes per pixel
  */
 struct rzg2l_cru_ip_format {
 	u32 code;
 	u32 datatype;
+	u32 format;
+	u8 bpp;
 };
=20
 /**
@@ -161,5 +165,7 @@ void rzg2l_cru_ip_subdev_unregister(struct rzg2l_cru_de=
v *cru);
 struct v4l2_mbus_framefmt *rzg2l_cru_ip_get_src_fmt(struct rzg2l_cru_dev *=
cru);
=20
 const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_fmt(unsigned int co=
de);
+const struct rzg2l_cru_ip_format *rzg2l_cru_ip_format_to_fmt(u32 format);
+const struct rzg2l_cru_ip_format *rzg2l_cru_ip_index_to_fmt(u32 index);
=20
 #endif
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 8f9683bf31fa..a40b0184b955 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -14,6 +14,8 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_form=
ats[] =3D {
 	{
 		.code =3D MEDIA_BUS_FMT_UYVY8_1X16,
 		.datatype =3D MIPI_CSI2_DT_YUV422_8B,
+		.format =3D V4L2_PIX_FMT_UYVY,
+		.bpp =3D 2,
 	},
 };
=20
@@ -28,6 +30,26 @@ const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_f=
mt(unsigned int code)
 	return NULL;
 }
=20
+const struct rzg2l_cru_ip_format *rzg2l_cru_ip_format_to_fmt(u32 format)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(rzg2l_cru_ip_formats); i++) {
+		if (rzg2l_cru_ip_formats[i].format =3D=3D format)
+			return &rzg2l_cru_ip_formats[i];
+	}
+
+	return NULL;
+}
+
+const struct rzg2l_cru_ip_format *rzg2l_cru_ip_index_to_fmt(u32 index)
+{
+	if (index >=3D ARRAY_SIZE(rzg2l_cru_ip_formats))
+		return NULL;
+
+	return &rzg2l_cru_ip_formats[index];
+}
+
 struct v4l2_mbus_framefmt *rzg2l_cru_ip_get_src_fmt(struct rzg2l_cru_dev *=
cru)
 {
 	struct v4l2_subdev_state *state;
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 6a4f0455dc9c..a0fa4542ac43 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -812,37 +812,19 @@ int rzg2l_cru_dma_register(struct rzg2l_cru_dev *cru)
  * V4L2 stuff
  */
=20
-static const struct v4l2_format_info rzg2l_cru_formats[] =3D {
-	{
-		.format =3D V4L2_PIX_FMT_UYVY,
-		.bpp[0] =3D 2,
-	},
-};
-
-const struct v4l2_format_info *rzg2l_cru_format_from_pixel(u32 format)
-{
-	unsigned int i;
-
-	for (i =3D 0; i < ARRAY_SIZE(rzg2l_cru_formats); i++)
-		if (rzg2l_cru_formats[i].format =3D=3D format)
-			return rzg2l_cru_formats + i;
-
-	return NULL;
-}
-
 static u32 rzg2l_cru_format_bytesperline(struct v4l2_pix_format *pix)
 {
-	const struct v4l2_format_info *fmt;
+	const struct rzg2l_cru_ip_format *fmt;
=20
-	fmt =3D rzg2l_cru_format_from_pixel(pix->pixelformat);
+	fmt =3D rzg2l_cru_ip_format_to_fmt(pix->pixelformat);
=20
-	return pix->width * fmt->bpp[0];
+	return pix->width * fmt->bpp;
 }
=20
 static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
 				   struct v4l2_pix_format *pix)
 {
-	if (!rzg2l_cru_format_from_pixel(pix->pixelformat))
+	if (!rzg2l_cru_ip_format_to_fmt(pix->pixelformat))
 		pix->pixelformat =3D RZG2L_CRU_DEFAULT_FORMAT;
=20
 	switch (pix->field) {
@@ -934,10 +916,13 @@ static int rzg2l_cru_g_fmt_vid_cap(struct file *file,=
 void *priv,
 static int rzg2l_cru_enum_fmt_vid_cap(struct file *file, void *priv,
 				      struct v4l2_fmtdesc *f)
 {
-	if (f->index >=3D ARRAY_SIZE(rzg2l_cru_formats))
+	const struct rzg2l_cru_ip_format *fmt;
+
+	fmt =3D rzg2l_cru_ip_index_to_fmt(f->index);
+	if (!fmt)
 		return -EINVAL;
=20
-	f->pixelformat =3D rzg2l_cru_formats[f->index].format;
+	f->pixelformat =3D fmt->format;
=20
 	return 0;
 }
--=20
2.43.0


