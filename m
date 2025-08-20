Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224DFCA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:34 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.48])
 by mx.groups.io with SMTP id smtpd.web10.1087.1755706163021056235
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LWM1OAF8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.48, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqToCqbtS6U38SLOJiscnQM/apQSu4VDpegs2Dq38I2LXcbUy585JoT5jkD8u2fQ6WEoI2FgwLcT3bPbHCaHD8XzfmovhVwijfY1NDUUM5dhBefk2HkBf23XcYeG8j2fdbAw8I/jdD7+CVbdaO25StSCcgwLNAIrTkcKZsNFwMZ6/YQQq5KMsGzUPSduVj9fU7hYIUV79Ie/bNGoZRPibpyIyAtuoleGLonNZoLeUmia3LA6Wkc+4TkGIPnTvRhO1GgdmJ7IAlMh10n29tmcVM8nXLCZ3wvyKHy1n5eEr1dzrPhHH6W+h6gY9oluazQRWnpwxuo5hZKfs453301ybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzhvTtPNdRKNlJS1XnK5liaX6nySMZ6GUnK5el0LFRY=;
 b=OW4ErhRY6JHkGq6RBaz7Bko8EDPZnLa0mYPTE4T6q9TyrXBg0UZP0uRdsYDU6XHYtbsT0wQ3M5FkAjjZANfsYitp90OdyBNCndiKq8DRHb21Nqxmc2UyZ0GAkLtx2uGem1/UgQCdLQi1bWWB/p3BsC45fyk5RIFx9jZCu8mkR+ZGno2B4G6RauvlOMreIYq91Wn3BPSVBV+w41rCVIXBFoW0gRa9YmHvh7N4fPXrJMKU5XeinPBX4CUDB6hRk9RNX2Fxx3YWeagB4O6iC6zvcPa9XLqxTuOXq5D9YEVuT6JwNDfMCGg2vL71AxfnG5Ygv+V8PpXF1JNWcCk3KMiJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzhvTtPNdRKNlJS1XnK5liaX6nySMZ6GUnK5el0LFRY=;
 b=LWM1OAF8nqxak7nbLpSFc3fh0RerRq4ysxW9d4L7MTWB2QE7PjZfTJtgH2fPnmTFLRyISp0FONUD984Hp9QJSHaG5OafFZGGBzDMJePmmhvLs4d9wnIhPc92QXdxQ6lts8HsBzZBI1Jtr3ZsEdtE+HK7NTQu2HIXw3BFSpumN78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:21 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:21 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 23/55] media: rzg2l-cru: video: Implement .link_validate() callback
Date: Wed, 20 Aug 2025 18:07:24 +0200
Message-ID: <20250820160758.801813-24-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2734c0c3-ac46-4782-f8df-08dde003ec3f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?I539NsWf4YHz47B1PtdSoMiF1wn35d2/PDEqPe5EtKvsZOIMrYfSISpo67Fp?=
 =?us-ascii?Q?YTFu8et0Az9Z7n9nfpIQxgV0P+RSIP2fgWjfXOL6YZT6tHAOQYWa6dusuBKX?=
 =?us-ascii?Q?nK7zqp1pWqa3rPTBZADtxvrQk6Q3Dz7PP6iBeD+/t/70O+7xobuNR+4SRCdZ?=
 =?us-ascii?Q?wQU09aUSql3PEkeDp48cTik1XVWnAZ1RHJBpGwcdi75jyJvK4HdNnpL3Xjgb?=
 =?us-ascii?Q?xryZ3hTCUAp700e9c9m4ksK0dRi1JPWgEX9LmCQwN9CIWq0LnGcDUYQjmvQ7?=
 =?us-ascii?Q?pYioNws3rA01EO1PvV2QpPgeJMZghBbZY+0540qQ2KH417TymQfoyA/WPvh2?=
 =?us-ascii?Q?a6+mggKzimfIhKvFzYUZEtOzXiBi1uWEqAT+cqERhYaX0ecKnLriPxKNzX3a?=
 =?us-ascii?Q?x6R3x/ERukyJZrn1n4/LB93OaUTVKRGcHtfnvbsp0nsvkkFm/FzKmNDMP5lC?=
 =?us-ascii?Q?8BSBJNpKSN/pGC3HmK/SD+HX1vLWEbivRAqtRWGx/U9vwD2GDY0Bumc3Es//?=
 =?us-ascii?Q?eIq18oMLCyLiHFOBEioLqCvOmlBGuPTbhUidHdCWgy5xfk9OP6S/BTOakhl5?=
 =?us-ascii?Q?wcxB9OiOo00WZjhATmDq1iVXMbiI2SPaAH8btAWzmhCuACAN7TaYfBvCmNGV?=
 =?us-ascii?Q?6aWgffaEkkogL4Q9MHHXpaXVx5TiyzjaB9EjL1Lcr3EWLnh883f8KGJTGY0J?=
 =?us-ascii?Q?ktFp7PHHukW5igglw0Iq5YJxw68hvKSVY9SvJoEJoS07f8dq3Y6LruCTmDGo?=
 =?us-ascii?Q?gqWb0xFLJRvIaKwP4kDiMbmriNdfU1MbPXlM6isM61c8G2pyFYER4gGzdI+S?=
 =?us-ascii?Q?ylCx3r7PRZEj85xXjI3Hn3PoOF8OomaUfTLtVUABnRERInjV+ACvkLwlhZMz?=
 =?us-ascii?Q?joaknrnwv8GYGjhqLUrpedS3KjDR4/d850ybcLGyH0orEnoufYK8uguP5sKu?=
 =?us-ascii?Q?XBMmuXzEiumJQpp/LSVY2KIvTVDkZD2Ekt0ksOVmnYBQLFdGerm8G6rOh71s?=
 =?us-ascii?Q?ubYLoupVslU/2oDu8y1dY3YRULNDhSLPCpDGaHXn2VRxHza1eZLtqLBdgYga?=
 =?us-ascii?Q?ltVS/F2q8d66Yj9q77ZcDuSnsLRFUWtBBvX2ITm/aeJ1DUllKHBW/D7zkMKW?=
 =?us-ascii?Q?r8WkUpiYnd+0M09lw2Mk9Q5rBlaNkMnl9ShGgeVuCyZyfs9chHsoXzVlghee?=
 =?us-ascii?Q?tNULlr+tq4NEUuamRtgAJesbQOw9Fr1nip3Ll7GEf344PLh1lEPBLz1y650H?=
 =?us-ascii?Q?OjGKq0hNbRI7KBxineTc0TgB4g9nm4htzyBSh++nnIMQyeSHXqt4SA8CMk8B?=
 =?us-ascii?Q?OxzY1cBQHoZjaoI21DOWO3CK0bkAejnWy+BVVmQx+5LHrmfWByy4zr0lwcbi?=
 =?us-ascii?Q?7mjUHLXTJXfEf2E6J1cnPqLwIHQCS1ToIkpuWvKGBBWZXzcdVwcG5tF9ODhH?=
 =?us-ascii?Q?Ausb6/jCX0o5U0quSNUY3gLwM9MlwDs+YKTz+gggjqEZgx0M/X3Udw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zOf3yYBx21vSKkrJnTRk3xXZ/T4vk1P7G7aAY/8ThE+GrSDud8IZByiwWn2v?=
 =?us-ascii?Q?Gt57mANwq0Ux1UM/SsbQP7QNVPjT8jk87Q7+qrVQxJN7ce7uaq5eHt6Qou8A?=
 =?us-ascii?Q?XtnaDXspL5WWPZ+ahFOSolidpffHVUk0Cebc/NK94npSuziRMnEnlyDluhYW?=
 =?us-ascii?Q?ncQSvRV4tVJSjj/JwleFtOrD/bGRKSUTBWDyxXU4liM4yOlEdVmv7JOfupEE?=
 =?us-ascii?Q?xVxLJ8m1GA1tNVeDQn1hiw7lqCFs/PbLjzagu91iGHQu62t3PtmhGlDFN86Y?=
 =?us-ascii?Q?0YuM7PKFv+vHUKWuU2pSYJ3IapuLFEh3sFREgJS3KLglcKhQkrFALuGOlgd3?=
 =?us-ascii?Q?Tce6Bih68qA+X5xvynckoXTTqlnOl7kiHu5SAQxoLjJ3OO97BLVxmi9ia3c5?=
 =?us-ascii?Q?9E3ldPvqsfveEOwKxX0IzPX4z2M870+o5C6Bm649KLJSASqU7bzq1ZAaxb2U?=
 =?us-ascii?Q?R8cd42iTm/1zkXx5YiT9nJKOTYQMMqOZLuvJqnPVu2FqviV7brioWcnT0Dtk?=
 =?us-ascii?Q?x6bta3g2aKHvbRkBvhwNMsGk8E7witOVhhjufHcOo+RuVOjBdNUJiveddZ5p?=
 =?us-ascii?Q?gdEcfk/VXOqto6l8IBs9u77+5UXHcQASJq7OGYMvObhzrq18+VK0mp9H4s91?=
 =?us-ascii?Q?jD+euCZJrWo9etxWeiP3DfEa4On6TxYNWxFYBeMOWJR9c8CmyeV7Gj7ZmtpL?=
 =?us-ascii?Q?wN5DtkSFynF7X1NxZL2+4Gyr41QRX2k/cBBw8hxxNqMSkyGYDOPcaDROn1k8?=
 =?us-ascii?Q?FwtIs0FeWrGK8IU6vEGO/cjPjLfECN8EMu50jbTa+7bM3CA/YyJ6sMmGuf+V?=
 =?us-ascii?Q?xC7gYlG/Sr7MoDaQJ9MgsG22Mrgdmz5PX+ub/qGlah62Wtiw+/jf9EcI8Sdm?=
 =?us-ascii?Q?v/HGFe6cQpcxs9aL5Y+PvPGgSR0qsC20eUGRSeVlfBjtT0uK86R0f6TagLmE?=
 =?us-ascii?Q?CEhEm7P01mJ9YD1TZGbT5SUb4g7Hzm+RFg5Gc/CMKuKTPPim9WcG1Ht/R1pR?=
 =?us-ascii?Q?iyH3UWZmY9st6RbgHYyf81OiCZJuGkzJ/Ez4l0Hu5EiTRgdSV8SRHItk6yqR?=
 =?us-ascii?Q?uOv6W8jTblOw3ErFQEVGwUZJOITwLEAC1xyqtjCTFobDiHma4vDHcPqdg4bf?=
 =?us-ascii?Q?LBfuFMNHAEv8PxgZg3zcfftxPQQFP8jrpUO3vaPXsLD6kJByP8fSNl2JTR5R?=
 =?us-ascii?Q?YlW6G1OBCIKLpe/BAGdWRN3sjz482zKrE3dM+DudgtqAvLG8KAzWQIn/6vEH?=
 =?us-ascii?Q?HucaCWxyiQQixikSB7VXZN8iRb9FGoRfZ2c4PRo4bouVacqLuABoAs0vflML?=
 =?us-ascii?Q?+XpzvFs+ijYcRwUofGNF/5ZkHNBEySNbrtdEqglkp4mLl7WKSdVmcbheztba?=
 =?us-ascii?Q?nlKa3731gLblOjoFEYBtZU4wSsunxiDixDojaNZJBRaIQ8m1BZc5LwI/zNUo?=
 =?us-ascii?Q?sXgvmX6P4mdo1gd3tv6JYgMb8SnyfIMpj0Y2dvFwkLvlD01l6aRa2JYCbCiD?=
 =?us-ascii?Q?uZDTZIUoH3KRnbUQVWXxjK/qlmJoTFj/TJxFKR6gUlxLJuUDZ0OV9zZHFCdW?=
 =?us-ascii?Q?OFajsbiHCTeNftF2IimJ+jcOJeP5Xsxi/s7dpiJD6e/v2K8PKUIbmsNilzWR?=
 =?us-ascii?Q?HiCH2Sxv0Vlsks2JJ4CrPg8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2734c0c3-ac46-4782-f8df-08dde003ec3f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:21.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96riEwiEa4Gb7jRLFOaTF/EFbanFelu0zQCww9xc+Ec2IjOVFC7MarFWrc7eoHxShVhONpVdLvEkWV/sQsUWEWUM//bhDG46zcGCErWtomnnXn8jyw24oBeT4vqIufUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19904

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f7b55b77bc09bf80076b1a4eb326f03f82ae78d6 upstream.

Implement the `.link_validate()` callback for the video node and move the
format checking into this function. This change allows the removal of
`rzg2l_cru_mc_validate_format()`.

Note, the fmt.format.code and fmt.format.field checks have be dropped as
the subdev .set_fmt() handler ensures that those fields always hold valid
values.

Suggested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-19-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 82 +++++++++----------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 0cc69a7440bf..df6114cbe5c7 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -189,46 +189,6 @@ static void rzg2l_cru_buffer_queue(struct vb2_buffer *=
vb)
 	spin_unlock_irqrestore(&cru->qlock, flags);
 }
=20
-static int rzg2l_cru_mc_validate_format(struct rzg2l_cru_dev *cru,
-					struct v4l2_subdev *sd,
-					struct media_pad *pad)
-{
-	struct v4l2_subdev_format fmt =3D {
-		.which =3D V4L2_SUBDEV_FORMAT_ACTIVE,
-	};
-
-	fmt.pad =3D pad->index;
-	if (v4l2_subdev_call_state_active(sd, pad, get_fmt, &fmt))
-		return -EPIPE;
-
-	switch (fmt.format.code) {
-	case MEDIA_BUS_FMT_UYVY8_1X16:
-		break;
-	default:
-		return -EPIPE;
-	}
-
-	switch (fmt.format.field) {
-	case V4L2_FIELD_TOP:
-	case V4L2_FIELD_BOTTOM:
-	case V4L2_FIELD_NONE:
-	case V4L2_FIELD_INTERLACED_TB:
-	case V4L2_FIELD_INTERLACED_BT:
-	case V4L2_FIELD_INTERLACED:
-	case V4L2_FIELD_SEQ_TB:
-	case V4L2_FIELD_SEQ_BT:
-		break;
-	default:
-		return -EPIPE;
-	}
-
-	if (fmt.format.width !=3D cru->format.width ||
-	    fmt.format.height !=3D cru->format.height)
-		return -EPIPE;
-
-	return 0;
-}
-
 static void rzg2l_cru_set_slot_addr(struct rzg2l_cru_dev *cru,
 				    int slot, dma_addr_t addr)
 {
@@ -532,10 +492,6 @@ static int rzg2l_cru_set_stream(struct rzg2l_cru_dev *=
cru, int on)
 		return stream_off_ret;
 	}
=20
-	ret =3D rzg2l_cru_mc_validate_format(cru, sd, pad);
-	if (ret)
-		return ret;
-
 	pipe =3D media_entity_pipeline(&sd->entity) ? : &cru->vdev.pipe;
 	ret =3D video_device_pipeline_start(&cru->vdev, pipe);
 	if (ret)
@@ -986,6 +942,43 @@ static const struct v4l2_file_operations rzg2l_cru_fop=
s =3D {
 	.read		=3D vb2_fop_read,
 };
=20
+/* -----------------------------------------------------------------------=
------
+ * Media entity operations
+ */
+
+static int rzg2l_cru_video_link_validate(struct media_link *link)
+{
+	struct v4l2_subdev_format fmt =3D {
+		.which =3D V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	const struct rzg2l_cru_ip_format *video_fmt;
+	struct v4l2_subdev *subdev;
+	struct rzg2l_cru_dev *cru;
+	int ret;
+
+	subdev =3D media_entity_to_v4l2_subdev(link->source->entity);
+	fmt.pad =3D link->source->index;
+	ret =3D v4l2_subdev_call(subdev, pad, get_fmt, NULL, &fmt);
+	if (ret < 0)
+		return ret =3D=3D -ENOIOCTLCMD ? -EINVAL : ret;
+
+	cru =3D container_of(media_entity_to_video_device(link->sink->entity),
+			   struct rzg2l_cru_dev, vdev);
+	video_fmt =3D rzg2l_cru_ip_format_to_fmt(cru->format.pixelformat);
+
+	if (fmt.format.width !=3D cru->format.width ||
+	    fmt.format.height !=3D cru->format.height ||
+	    fmt.format.field !=3D cru->format.field ||
+	    video_fmt->code !=3D fmt.format.code)
+		return -EPIPE;
+
+	return 0;
+}
+
+static const struct media_entity_operations rzg2l_cru_video_media_ops =3D =
{
+	.link_validate =3D rzg2l_cru_video_link_validate,
+};
+
 static void rzg2l_cru_v4l2_init(struct rzg2l_cru_dev *cru)
 {
 	struct video_device *vdev =3D &cru->vdev;
@@ -997,6 +990,7 @@ static void rzg2l_cru_v4l2_init(struct rzg2l_cru_dev *c=
ru)
 	vdev->lock =3D &cru->lock;
 	vdev->device_caps =3D V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
 	vdev->device_caps |=3D V4L2_CAP_IO_MC;
+	vdev->entity.ops =3D &rzg2l_cru_video_media_ops;
 	vdev->fops =3D &rzg2l_cru_fops;
 	vdev->ioctl_ops =3D &rzg2l_cru_ioctl_ops;
=20
--=20
2.43.0


