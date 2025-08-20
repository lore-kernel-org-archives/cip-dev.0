Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB49CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:33 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.44])
 by mx.groups.io with SMTP id smtpd.web11.894.1755705927610990692
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OTnXysuj;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.44, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVvrDzMOHZcMJhUQbqFPZeV4QxwER9daiCk+jF3Rzv+euZQHQJC++qL/YOliSfBsKWPsAC1hKAKIfcceEZl1ciLUCT2kjO7t96BhjK5+NQNWakzCKGFbJnljiEyTtoRTVkuFeQOBl6sIyy4nSy3CrdoAqw3noi5uFBewjt5lqfYoY68PWKsmZIQLnOTlMEIVLq5FuC+zTjFxbFHsSKX+chcb1w2esjvnFk84New0iZ+w7OJ2M1CNTCu0qHRmAY6upKpPp6T8QbgtrnSLHUS0zwpH/zlwiNfQyoSz5Dhg/2vIrkMXWc0PgHvzM5cVDaUgMXLzfJfdUVGsMmIj9gxc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpcI6u7ekJSFWBD8OESYMxwol6F9OOaZNY6tNsAlFpg=;
 b=IXZl1ihp5Nzy51ppicv1rkYwUrJLIGNC5FLCCGVgK0+j7wuIRR8iTg7s4o3DVUZCYUBWHwi/tUyviW6f9QyoXIgyYFmEUwfNBOA0XXaih2myRuK+AFW26SYgODSBbCA3GLgAKEyL/WD+gxOr6DunRD/VMXwYV8jK8drfsP5isA8bNgQ1szJayIytRUFZvkVGb549S5fx4pEn083++WJ3Tp69GWE9774IBnHYCcibcghLEy4h5MLXOH2LpwkZBgWbsUDOSqYbTwYuzY60bYa0X3t05VR0N8xzvK7niqpY92znj9Yl/5kn5Wu8SQ9xziGEpJHpZDjO1xFbldp8QnkbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpcI6u7ekJSFWBD8OESYMxwol6F9OOaZNY6tNsAlFpg=;
 b=OTnXysuj7mkoxhJsvK0lTAngJFE9qX6GUGXutS2TYf3kFEQpEafLwueRs0+WDVDVwupl98FOxnER2M5GzFSirhRx8u84S3MuO3N1/XsgvGAjZnk8uJ9QRATq1yYnH5gYoGlE34hqULHIhmLjUprva5gdOAvmvKQ6tj4nDs4exKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:25 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:25 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 18/55] media: rzg2l-cru: Simplify handling of supported formats
Date: Wed, 20 Aug 2025 18:03:34 +0200
Message-ID: <20250820160413.801341-19-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS3PR01MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 82355c13-11fa-4970-6f05-08dde0035ff8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?z1hBJp3CPbIMkIsYCAeq/UfG5djS71t8/fguofvU4UO4AFvSHX+zP1C2LHRE?=
 =?us-ascii?Q?Pw1dFUeTJpR+P5yNyd9lr8QqX2TWxSTtz7jyMocqwfWe+fVGNOF3I+F7DJkK?=
 =?us-ascii?Q?JFFD9lgscehbYWxDHDhBJiVpAqKaVXAawpNAg6TF7+HEGLnxLFMszcVhZlzR?=
 =?us-ascii?Q?2ZpxsaHl30D39g2bb3MCu4WTmbpmP/i+YxaBzYcyogt5wtICE+z2uTggm4RJ?=
 =?us-ascii?Q?ZiZ4frs/Cz4Rf0mG4JRo60fcKT09GM8EGsXl6Ps6nac03929EbH6KnHgPJ8O?=
 =?us-ascii?Q?xjNFNof+7915I1rQKbsaBHhpsJ3fhAJrAhaSEDozC3Pv1sm0hrVJFVPv7l2L?=
 =?us-ascii?Q?eQUwZJj5UOIdy+o+F8kO8asMSa0qQKBSj2IJ86AHc0UndB4NIUh3aKwQDTwk?=
 =?us-ascii?Q?7GNpM2yEJmRojv9bebuOan62Ut7164conqmftL4wr3TyWRXfMIAK8RmIggBK?=
 =?us-ascii?Q?qkeb/l1vEKE8K9QYCqh9iJS9ikAIweuti69reJZkQXRWaGBH7nO5xrUvsc1D?=
 =?us-ascii?Q?pmVSO56vrgeRF6cZztYfc9spWz9MBzZdYeqkn1qc2tMnY+EsKY3ZKzeWLtn2?=
 =?us-ascii?Q?d1n0D75vydYHIfz4oTZMIQyep5o+VaLMmiT4vp4wDW+LTCvjD7TdcnausmsK?=
 =?us-ascii?Q?qP54DeZDQQ/x3iS3GAYniSeWzLk7usorQ66YJ/oe6fWe4BAzYMVOAEN1Iv/k?=
 =?us-ascii?Q?aDy8QGWreUTGJ9lRFbAUGDs2ThzM2KpcDbfuIvkdfFd0bzwS3RVgjQiKwXqm?=
 =?us-ascii?Q?ug/aILu02K2dQzIBLZUBJUJp7TT/W9+QhzBBOmMHq/YBn1LxuC8ZzEbpwsrI?=
 =?us-ascii?Q?40lNwnGPOdfrhm9IUHUjgiftJqV1KdWgTP0so8KkbtcWxQ11VbIaax3SYPci?=
 =?us-ascii?Q?j6Ddb+RKcC03j6Lhg1RSQVD+xZzLIDZ4zNl/cvizwsLjXBwO5Ol0DB9xyv49?=
 =?us-ascii?Q?/0spz6+iTEymYzVOcO2pK1rNYXrNGsqywMhE/V7sCUG9dZfnvdOud441iMHu?=
 =?us-ascii?Q?cp7cPYtse8nP3WZGRqt4azBZRfIekoGXTc5G+xuR0Y/vpRuJQg2XwPe1lbA9?=
 =?us-ascii?Q?u5XEyDxgX16dGPmlT75E8653B70tOcfxDbLSWeN1uck7HQaIweca93hcXliw?=
 =?us-ascii?Q?atwSC7zJsT+H0jrXt+VAFeM8AwhFOeYscwf6f4sfq9GG3pLgC1zvgfE90X4P?=
 =?us-ascii?Q?0PvV0FcleKxXmFmJc4ZSnhEFYoSvF4EaagOuDEX0NJLZmbm72RJK0SeGmLf+?=
 =?us-ascii?Q?/kwoZY/2gkPWq/VKfw9R9XmKu8L4K4j5Sm2RbQFpHfqMwt/Ul6w8mASa1fW5?=
 =?us-ascii?Q?5Pqlx+vrx5UbYmugbHHR9FnHPfl+vQISe8uOSI7ChZmkQjYLI87tr5PD7V2M?=
 =?us-ascii?Q?F708PHG69XZl4A9ASHc67ktxiozJkWVKhMMQVnkZLnD9R069me7vIFgNrpws?=
 =?us-ascii?Q?3fbm0F9j6WvnPs67EYQ6adW6YGsQM22d9urAhA+zCou19AUzoVbcrZyJutS1?=
 =?us-ascii?Q?dgS50qUnwTJ3Lpg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PgJ5EeCpwBk7QNotdwet4e6SX5AlQSpIPIfoFwJk/0HqX23L7ZU5fHSYF+nQ?=
 =?us-ascii?Q?g+Btz17SN/ixMle4dA0u6oDuW1kCZMQ53/WEZDEd5nNVyJaa+fgC/YYft6hy?=
 =?us-ascii?Q?HdyMYp3SIXdhGSgNwImVP/kRa3y8s9wNNJkKQTeI0ROV3qc9UVUKEC71zms/?=
 =?us-ascii?Q?cE6/e6rBAoJIxect3oJTUKyCTJDCXMpy0uC8cwb0NLoopKCEK34ROUUlHcoF?=
 =?us-ascii?Q?rFixdYOn+j2CHB2V+VF+Sqx5PhChvciDveXXREu+S9J69vaY89gvkzkeTi+h?=
 =?us-ascii?Q?fYCPIqpOmppS7ZHPyFvUbTB9e+0Jsa4yDfuwh3G+bHqYNVI1hjNvVc3ZxNrz?=
 =?us-ascii?Q?YMlNuKXw/8qkOMf+fodKD6B5L9hW6t/zcX4D8SI0QrTjjeOBgf4jRUmBImra?=
 =?us-ascii?Q?apBU9x9oP51BMJZcGG/ndR8DeHUSBUf6shWeHW6FowkbZH3AZHfOEdgCy9lv?=
 =?us-ascii?Q?rLqLPpcFYnLgtW+YeNw2B1fppZ12rYV5awDgBBO9hdeaYWQUp3yJQ0qlwrh4?=
 =?us-ascii?Q?LX5XSoZ7SZaGgfRY9x7lwLTYRbwzDagjHgg3rm+ymARRHq+kTjAHQlPZLqH9?=
 =?us-ascii?Q?16j0Hc9ztuUGe7+mP6cLbIrcigDLBw3tkhJ08BpEHQPUJxBYK/OtOusj531G?=
 =?us-ascii?Q?S7VMoDmfai7WFzmnNPi3PRqNyTsUU2vBWkos7e6XCsk6SSb6x0TNW9zkbyOT?=
 =?us-ascii?Q?EkXTIn/PeO5BCkTKvbVW655z2waQdYubPJ1knxvoPNOm75cRvz1SnR9Pl4uD?=
 =?us-ascii?Q?MgR131C0oi+4J5wO4N6YnW/tSqtIXehRPlouHFKN38F+uRjKCdejxfwbyIwM?=
 =?us-ascii?Q?lJWcD3q06GLBFl5cackI2vSnnifleNAfqqDNnxZICZRYFfWDRZ3yQKjUp4uj?=
 =?us-ascii?Q?YOpiGinTMywqzjVoejpK3UMxm15QzmlfCg9pKHLd+VTJmo1KzSQB/hqqoubh?=
 =?us-ascii?Q?2cULDHLH62ggqA+UAhv+ttNqPXNRUdOMVPWv/h2twDREhNGHmJ/huAPrknXa?=
 =?us-ascii?Q?uso8V0wWpXtm7SdxrWI3T0juC7j3+tBSRMk/SKy53d5trBZGa1qGPcJkGQhT?=
 =?us-ascii?Q?lxdi0kwLsiB79F4O0Uspcs0BVpz/xb6DHOBqOOQNaw4/FrIki33kJVknz93Z?=
 =?us-ascii?Q?F+f5Re/nS7YCwQXo6jykp6v/m1dYA7qcVPnDxo4lFak8hQ62pDdVHu1GVTCG?=
 =?us-ascii?Q?Ir9FZRXqxXorP2CCtLTejzGVefyPygi2B68bTG9tTh76EKcYOOOn8r4IC9gg?=
 =?us-ascii?Q?8cHc47tdhlEQaRUfJWifX6DM+YM89AgkKyIXOUFH1UP8PNlgfXn3I48L4ID1?=
 =?us-ascii?Q?otfrtlZN3HcYynTyW3QrBefYBPYJx7ulPCOSxufy0kNWj8id1D3I4kbLxTYJ?=
 =?us-ascii?Q?5ijvjFS0iV56beqtgB8DkeKgOdz4gXnfncrwwNV69g2wozV0nkp9xkdYq/8l?=
 =?us-ascii?Q?FIN9lGOioDW4igl9PYWU+a+ocUv4WeziBfTADO+L9QVDhrXb+LuOeu+VN4Qy?=
 =?us-ascii?Q?Fny7n0Px4d4i4ZZ5B8u7BUDQs2UeQWvdd5+Qkobc2b/y4NvaTFt05Vo2dIT+?=
 =?us-ascii?Q?qnRApuNr1DDrdq70E5vL/H+k+EKlM8K8BLU5bV3WnhnANbrx+gh3uBt2WDAH?=
 =?us-ascii?Q?37dlwDcn8vVqAhkDLi9q0zU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82355c13-11fa-4970-6f05-08dde0035ff8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:25.9032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwgd7e6z1rbwRZBij9ZJYbYdM7hzN6nOXfaRT2rSdhuInEgzgu1+DZxdUgXYqR9vGBzgRp2cHgnCpHZfgK9cpGWi5fc8uOkdggqlllQNayfuvXWUaZ7V8pQQwN5Ti63G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19843

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
index 1637366e666b..63402b9b5e3d 100644
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
index a85852c926d5..ecc353eca2b6 100644
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
index 51d3ea3f9f1c..f119171033b0 100644
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


