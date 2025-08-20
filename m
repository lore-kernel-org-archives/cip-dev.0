Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E91CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:43 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.56])
 by mx.groups.io with SMTP id smtpd.web11.899.1755705940630823298
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=QWGWFCZU;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.56, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCFObbQc7BdA3YeqFqHcSkb2zNQx2ZmoJNIALIHpqA4eDNax2kEL/DajtHNX7FZH62Mle1qbwFDgqnoK/wdVNZBhVI60Xbkgh3Pte1ecM7/1t4FN11m4ZJj9VTvbIpWc6m/U1GhEoAe2Y2KN2bmyEV8HEKK2/1yJJdVFBVwr/CzT91yF64mTbUs2epqIumkDqX6qlJYAafeNysHnXBnxHheuHwzMkYOhqaQjDo+vdeUkV5c5OKc5LtTmOKnDkTPsxP6VqQL7NEyzHuBXvtAgGOXzi+8YbPQMAsK4V0alSLzXuPGsH3VTR2bDl17DYtnOew/tfRzvDtsxsQPaRBQ6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKes8OSIVJi3/t2LfPNSjx/EljyAq5/q8C7oYD32ReY=;
 b=kJTQS3DJzJvTWkg/VaWPXNDe+vlCkLdPVhU2plQIUfMsO1BIlNAmya7SA5NOvvzwWdBS0Skw0pcaDfMovAq8pAJ2S/FQ/WTfN0ABHy6/hUVQGoPK36S52njpBprXZFlI8HRMmzF9MiOaYHK1mRmpDqgwPCxRVf2uKOSheCwEjRS33CvNnhNEEwbfAaDm589iz0WEZ9X6QK4vPE4siVAwNrUIwM3gsxvVyeOFsEYycKxzuW7wmZxDddUrI68MyPphHxjji11nw6SsrQB75RiINE3f0QzA3Xz6Fqzy2vtVXmFYNzi9CMHuVyzddeXGGt7TBCmpbq0nP5lz0EleFFh9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKes8OSIVJi3/t2LfPNSjx/EljyAq5/q8C7oYD32ReY=;
 b=QWGWFCZUxUCDEcx6xiQ6c6Am8gccHTmgfsrXUIRsyfGnPTFEpw2FArkWMD6P9XUsL/eqsklVERf38KkXcR/8lQWN/Kb2kxyu+eLxHtTbmTK8pRki3YPRcSTHqcHwU9q20rj4vHC3jq2X3Q239cWDJkKnmvHccMJLnNuBgUJXJtc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:38 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 23/55] media: rzg2l-cru: video: Implement .link_validate() callback
Date: Wed, 20 Aug 2025 18:03:39 +0200
Message-ID: <20250820160413.801341-24-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB10458:EE_
X-MS-Office365-Filtering-Correlation-Id: f63918bb-756c-4a25-c902-08dde003676b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0t3WT8t77TEXRMyKlMFjRDakZWSZKSEnIrlH9hZB6qeF7adNSkU0LWvVyEYC?=
 =?us-ascii?Q?yjRjlFn/Gdt0rbam7LnSkdRQvU7wNXPCTye399DQ1YSBKPBqnEUX6v+ego2y?=
 =?us-ascii?Q?cD1Nj+Kh+Hp2jtwD90hw+t9BRs4hxi0pcjgC91EvCGq2tC2x2elFjnxMx/pK?=
 =?us-ascii?Q?7qAhP2GmNzmmaEHY/NoIQyxgrpU/O8ah+2SQcESPKFL7QG0wgk6Vgk7IOGEi?=
 =?us-ascii?Q?jJTeaUi3kForH7M1eVj0t2wKS/e9Ls3uLL2eFBbN8T/DIclC1Td7xhHzbrbd?=
 =?us-ascii?Q?zEqPqEG7QOwCzNI0NgZlcZmo3Doc81iLphWYfPdsnRjJtu7ORihoadonBnIS?=
 =?us-ascii?Q?2xCxq2Yy6dZMI1t/sALjTX4Cd6JkAvEmuFh5Yd3Y/pOqtIof/KC+YI4hWswV?=
 =?us-ascii?Q?13DQJcH+LtL7nt03RbYo0N46HqbvRU9xJZ4WqeYxN2vDcmB1tEQBY48WLlkz?=
 =?us-ascii?Q?iQQTr0eJe132ZOL92qrppqdn1xKerXG7Cnor/m5gcSWcYOb/PKE4QHanXoBl?=
 =?us-ascii?Q?DagGa+02MVwh0sGSLe1t2Vbpy3zA/F5aCLkfe0MjMgOOVGl6pXSBBY0lGXq9?=
 =?us-ascii?Q?3RnGp2R2LfY0vrPn0onoJSAhA7vfI7KJxw7XlCE6P7BktALnfhBttzko59s8?=
 =?us-ascii?Q?UtnW+Q2nIxvrXXirbpxVAp459IUuXOOx7IcsUuL2pI7aAhDhc2AdBL6sVgQt?=
 =?us-ascii?Q?EohQMibe06T27h7SvJa0Yb8WiDOdNLjwfGRBVHZ72cvRAdNS0GHGoNRhVFZQ?=
 =?us-ascii?Q?GqkctC1gCvh6WsnWN0E874iZKRO7wFZrPGUYmutCVpSlpWXm8App9k/zqrRq?=
 =?us-ascii?Q?zsx5LcKW6S8u+BRSVghckaMl+euy3b0ZCU/pzPExOvYrHaaVnMW4aoWUUYer?=
 =?us-ascii?Q?2kDBU1fbfFmUtGHCYusmrc7xaCGzVVEFBkcpavbeoq/RbfrShbEfBcppMyo8?=
 =?us-ascii?Q?A7HgKvpwff16bZnAaWoqpwGffQQh1HQv/m9+Ytbgavj+yyiMh52DzN8S4xYB?=
 =?us-ascii?Q?0ZLeRi87myjgmSQLXtpFtLQR7lkZHetXX8U6BCozTDh+Ks8G+zZeFnCRMrru?=
 =?us-ascii?Q?V2vnAdm6ZtS6LuEmhyeX6o1nZYPvPfKOZ+8Ggg/EhpzP6LF8ojyXvQdSfLed?=
 =?us-ascii?Q?0en3An3zAp+0VzCwXIAgSGX3/wdhL95MygQkUG8Nu7iDXIJHaX1jSBJ/N+cS?=
 =?us-ascii?Q?Ykd5L0c81f0bMhvg+mu9xl5wgYd99wD1EPq7vg5FCiTFzhyalmuPbe0mdqph?=
 =?us-ascii?Q?0zpyYEDsKqk7l/UeerzctVtHVZ3PmJ6naiGiC7ezXP3k1/Pe05ItWFMkDJ2H?=
 =?us-ascii?Q?0eSoFhPhrlskxHvqwBpvO0iXTtVhNiLetXV5GZn37+03mXLu55+XYJmQuinX?=
 =?us-ascii?Q?tkd0PWDLe2sDzEsV+37+wGmj4+/GrZJswMklNnoU39FWtNnEecTSVDE7fHEK?=
 =?us-ascii?Q?kVGNpCKVRQ9RHS/hNQ6Xg4s/gv2AYtwRXAKKvl2JBhhdiYfDBlGP0A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FrXW5KUUFArRW9lMkKgiV9RGJW416OVpB8WXUH6GIJixWuprb7c42jb1rxxw?=
 =?us-ascii?Q?V8SDOiVagL0zEE+HJA9wD6E2wCfhBFs5FF9Ixh8UB5e3DHvxg7+FE6KdVJEU?=
 =?us-ascii?Q?BIwhgd1nGLckQJN/jJl+mib6fQN5tphI+KIRE/oTVC2P01tlDtZN39OYR3wn?=
 =?us-ascii?Q?Landx798d3xOIKwOSkJxcP9e8qtDsiCAYDOTuFKv/d3eHighwWFQc66sgF9Z?=
 =?us-ascii?Q?7XkHZwcMZs0svO1gR//I3B6v2/kUCse7pZwPAxB5kA3AQAyEv0bp+Ow+IbMO?=
 =?us-ascii?Q?DceESu0z34ORZE1J++OnWqLHSb1DWd/MHsHOXIJXbk2DQUkBrfeEX0paPXPG?=
 =?us-ascii?Q?5ZE7IuVgvxLkPJ0OKRp9K66fE8Um24gpSt1QHbPjzFWvjhz/eXjpmoTnqCl5?=
 =?us-ascii?Q?qKWadlCvERUeDS8sFdfWXhZqes16HususYL60IiOMh6GSnC3HuMkic6RLF5P?=
 =?us-ascii?Q?LhXMyOuQLbe9k9Pt8Y4YOoIW9r/A9B8aAPV6SVLemclKuVTdyFsl2t3GLG3S?=
 =?us-ascii?Q?ABXs7Fb0PPa+QafRs3EUpAbCoXw7sacLnpm5z8kcv8dyzx+jMirYcJwO/CCn?=
 =?us-ascii?Q?2RyEFmA2ZgcBreiq/mR6Ic2I8uCsD0ikGv/3w9UnQY/DR1c4Cnvw/SjFvTJZ?=
 =?us-ascii?Q?wNA0YqrzRGE8SCrNZPPJ+mYIFAKIVEImyTb+qvqDtYS5iy2H1+1YV+zOi+20?=
 =?us-ascii?Q?zjnefsvJwNUv85pITGbZ0dzVqRZ16J+aWb9AV4XD0OVMjeT/QkWCAWe2Sc4T?=
 =?us-ascii?Q?R7C3nSdtfn890SL4TvMjzQtlX9wPdDyA6E/+xppnJEY8+kLRvyznjhKyOFcM?=
 =?us-ascii?Q?pkepPuPoSxAUcdleUMch+aAajZNwTpxBj5JiUxOEZKP4Gl6/HRqgnDl8XHkc?=
 =?us-ascii?Q?iFDjPFRbTW8sJFKIiuzBfLIOzPQh+cqMZ7yUTqpq5846gQhjZ2lQgvDqfR20?=
 =?us-ascii?Q?qWapBvps4XBRNpCbYrrNYibNonxSNEuEs1uF3uOPRwYEdOmdA2znhblyj3RH?=
 =?us-ascii?Q?uRH7X9wGGjTwCJ4ctiT9H1Y9gvTR1WwXKr/+HylDesYCu3kpKpbZuo+TOM9f?=
 =?us-ascii?Q?YGjdeeJD/yufgqRt2Wsnps4kWexo8AL0fiodFlBD/DJJEMITs8kIwX8GpxCD?=
 =?us-ascii?Q?eZ+k6mXBZcc0yl4wq5jvxroQcK7nULyM30xjZ+/urJ5seJB7lu5cAS0Ty8zp?=
 =?us-ascii?Q?SkWOgLu1L32AJKJIePKQGcY/Sjc7xGrvhCl7yYkJGjZhPyMjQCqxHyC8Uirv?=
 =?us-ascii?Q?JbsMTolUgWrKRbqtEbxd0VoR5EGvhI0HBBd0CS5BdvVqhDEzOY7rurlcded4?=
 =?us-ascii?Q?HAnI25XlTLkbdNVlDMV6GSMd7gPncTyAufFZTbat8y+RsVbSEjyjdwMLs9Uc?=
 =?us-ascii?Q?XdzYIl4Koi1ihtCrqRBm9FtXjX51Zqf7WNUzbvYMV5F8XOSJ1uyUK/CYLXWe?=
 =?us-ascii?Q?5hE5nfICw6sp6MBMOT81A2IbTE0o2fSfFDu5R015leawdURN05cdRXvrXQZS?=
 =?us-ascii?Q?w5b9A/1ZOjwnWM9EomcSdUDCyr6A9D1lFqj19aQejPDMElwBmeRmV+X1o3Gh?=
 =?us-ascii?Q?T59gj0NUGd0Kfny1oK2LAR40O5TVAdxmgHhgMZBhZQv0cnML6hltQ7vvvBTK?=
 =?us-ascii?Q?lpr8MOn4vLPgFCXmgGE7StQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63918bb-756c-4a25-c902-08dde003676b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:38.4098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rnc5lAPhQ0YjTug9AH03EekvVpSzYsH1lQ8g1EBG2utLimbqYgZDm5s4rH8+P8NgvhphIx4x32FXkCSD1bSvqCxjCG4HXWRvvMcN3cgC+Dtguwyasoj5nJGdz44/+Ku2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19848

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
index 7d7f3329d93f..1a30ad172d1d 100644
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


