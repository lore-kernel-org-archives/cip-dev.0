Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03732CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:54 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.53])
 by mx.groups.io with SMTP id smtpd.web10.1005.1755706004722158992
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ko3/3/3n;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.53, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPcs1WCYJMArbOZLu2Ja9J/YEXuct1JGvw8OmFmHEPh6Loh4QC7YwCGGLSTJZJvIZnZFJ9j/sK/6xxyKAHMy5NIID4eN3ZOXhsGRPZlAfCSoaRzhgNd1GyWTSYof0DI6A40lmWaxv8PxGNDrh1fSmC/3dFhKpYeeVhoErj8mFQgxe4t033g6sHtdI/QDv7ASBs6YuQw6diC0zJvvKT2WOyIn2ddvd6hinnhMHqs2QPcs0Xpxwwu0t5/feoWwsjgc/bef0VSiXgz7MDvgfxBvL0gG/rO1d/6aTJIJq+I2gHsG5AhIs0CzPw80nCeX5Pig9/hi8SN0gaJ4c1VEduMQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt5EfXdecjkm7IHmIA1vBVZ6qtQkycXnBxEXWH0A8fc=;
 b=CIvrl8AfSQD+pV9W+LWI+o+rtanBUZyArs7m0eljNdsflPS6YNlb/fR4u+6vP5xdfotB6RmZjflSJ9Rgn90BD80ONe8Nw2x91oTIgk3Cq6Uo3nT7LhxcUBoxk6hNH32rulrzNvjbscDU1N/nISpbFrBl+UnEgYqamToMwB1GGyeqOlxJfarQR4fSx3F+ARHfhx2l0xTcE0wKZGPhbiQJPo9YNU0LsYKHxoJFmGyjQbqQakpiYuKIE9VWzY480b7g7V2UH4/+oRqu49KfyUX4mWIP6MNS4HWK9nGZJP3vejbX75JcdF6jGzmIc2P///WVKWEzgC9EXKKdBnGVbaeWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt5EfXdecjkm7IHmIA1vBVZ6qtQkycXnBxEXWH0A8fc=;
 b=ko3/3/3ntsASmtOPf3ze4ELM4a25dmclK8DuvHabKkFFfU/vCbAKJca4uK1QtR1FN7ABPZdCRXfWenBuG7t7Hty4RRyjsLie3C+myFw+YZiTafnbJxSRnTAmOMVp9s//ZicKOO7/RcJJ0d/1NsX2N0SXui+KtqTVLVdhQkUKvGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:42 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:42 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 49/55] media: v4l2-subdev: Refactor events
Date: Wed, 20 Aug 2025 18:04:05 +0200
Message-ID: <20250820160413.801341-50-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB12116:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed5d274-ac5c-459b-7e82-08dde0038dcf
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|4022899009|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wek4B2Jsm8PHwAaK71sc1vnrb5hKR/0ixgIEYjlgT/EDhEifzTKAmMJ3pLKA?=
 =?us-ascii?Q?w6+X2wjm10jYKLnFUIXkfyoU9iZ434V1bLep1dsmSCkkJ/beRoURtTM7Ia37?=
 =?us-ascii?Q?VUiLKYayX4Uq04cYvjSwSKB7l6xhHK/mIKxye12L+C8jNgojXdiIWZx8O6dB?=
 =?us-ascii?Q?nyMFUpViUMo6mnauepIQz+LZxRlMorgFWfOpNDjfSiJSY4bu6xJMO/QAfZTL?=
 =?us-ascii?Q?kSDxlfvj9tRqc2OvKG4iX2H6W72GDSg7zcjifFuTpz38VMG+RsALE9BLMMXc?=
 =?us-ascii?Q?zJOcOQDKBrcMRa1J3wIX6yaII78Dv3bBrYbr27Mh5KGYQewT+c0P4zLQgY2n?=
 =?us-ascii?Q?tzGiL/ShjfnjCAD/ngcAo2hbCZ7Nwfz15t6p1YDaJZv1iSoO5ERTh9OGwfpL?=
 =?us-ascii?Q?7bhxbThFUyR3uv3Q4p4uNlG7CY6pQ9flW1NqtarCFwSBE9Ep7e1Cy7KT9Uz7?=
 =?us-ascii?Q?Va1Qe7Cz8Wo91yI+kAwda1goVHLo/deovepU7RvOrO4vhI33HzThOcXqNyrA?=
 =?us-ascii?Q?ShkZSIP/1cFXPbpZepclQphnGVXdkx1I/sp5XlFUdwj5uqrDNtEtj91wVFVc?=
 =?us-ascii?Q?aezJ+OiK8uJFQxTprYrgqTcND04pHsGCF2JCPOhD+Jzaa1x0XChOqBBlmQU3?=
 =?us-ascii?Q?dS8ftKrky3EM434yBpncaif7omUPQ+Fp47EsOlmuz1Kx5iWz0w4QWM6KWom7?=
 =?us-ascii?Q?Dn/gAQ1/Fih45gyXhidrgqKB5aviShkEVhwa2D2tM3tDiNoSCAErrfDQi1gw?=
 =?us-ascii?Q?KCx89VcgwxI7JP7rGeSnGCGSkT7SpWJQztF563VkRlg/hvo58oM6tnfWivUG?=
 =?us-ascii?Q?E8z7wSSyOOXqZOjhTgMK6pHPiCNUQFG3zQ/2PxuMHcFyMGOCpetpVTiSTyWo?=
 =?us-ascii?Q?rg/SIqvyWu94dDxuUf+v2iuScqQcbRA3anvbKkj/xIu+SNdiR0xFDYRzAdJv?=
 =?us-ascii?Q?9Ow6fFX9eQJcAIlvsmr1qeIbF6O6n7dU4IyKQy4a7ILjROl+ih04VGshsb8S?=
 =?us-ascii?Q?cgC4K1X+TKeezv5jo6Dyx76XuB8b/8OZwPUtGXBcwt+9yH7mgzEhaWqkQAp8?=
 =?us-ascii?Q?JH4P1+dFMFwk+VJTFNkLfSu0Tx8hqKMB9kv2SfcGuCkN61pmMnMO1KKSPfm8?=
 =?us-ascii?Q?kGN7Xb0URWA8JSdQk+ezNpHWyrpEmglt1rF53SbnJaNR1Y1fpMfOp78g8zIU?=
 =?us-ascii?Q?Fx1/RlENOgFxQYfyWGFYrPwaOT2gHGaTxmH4dKnrhIAQrmCEAembtp4jA8Q+?=
 =?us-ascii?Q?5VRnKscc5zGLpHabM2ETigudIO4vLuf1Wx2beWXtF4odBrGxY/pepE25XBUz?=
 =?us-ascii?Q?GsyXoYUQRXlK0Dw3mYCP7W20g2VbUL09zQGfPhPBHE/6pe6AJAuinhn3x2Ya?=
 =?us-ascii?Q?4Hdmv8pL8Bh4haDfAjeK9XYzfPmRjBcmizBZtRpaml0MCTYI5WQ2GZ8fKWMs?=
 =?us-ascii?Q?fgs6ycV3YgRnJ94Gan88dgXk3qK7KFuIH1nt5nAyGnnS2J/9maKUWA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(4022899009)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cQ2pOWz8DAbec+jxP+LVy9ZA8hXxuFHXF3h78fK4Koe4TpHFvrEhlEA+mtPf?=
 =?us-ascii?Q?5t4VaAJeJDEbadQ5CXxAzYLUSoKPal9ptDLGat36cUwg0XbjiZ0r+Y8VoVr5?=
 =?us-ascii?Q?+Ic9OE5ernnif11XVDNMtJ6CW+Nfyg7Zj71b2n8AEgNidcgAfsw7vu6zvg0O?=
 =?us-ascii?Q?i8wASeNIj2Ih3y+asGXbVxMxhUV7c8HXygWENTB7a7VWxczCscVLtwPy8rfS?=
 =?us-ascii?Q?R7foONZqgs2ZZ1qNeRUQJz+K/c6kB9FT75UWhEpvAto7KgCYnh+N/iSBF/5E?=
 =?us-ascii?Q?z2+ym7JEq2dFnTrz8mE15FVVKWFRKpBFxqXOU0GYctiSauHWDKmrm/FieRjx?=
 =?us-ascii?Q?u0SFJqi2jbSO7vKitd3KAJNto8PVWyyYwDyNZTbhY9uwDi8y98WVRiRGF2Oy?=
 =?us-ascii?Q?OkCpksR2ABtGldJb0TiLt1P8qoSpqkHIstfG+0tU2HuswYekPTQ3JgceKXH6?=
 =?us-ascii?Q?p7MJqa7e36Skioq+LWFxQ6+uashDNEyMICycZdrcPanlbpLwf4khiBKwpKsn?=
 =?us-ascii?Q?Qj9qow9sOalPH+AhlsXQhKGZvZScPUO/YFNREfZW+uAHleOGkjXMJYSOqFao?=
 =?us-ascii?Q?ScviEaHcqE0ZZqTwuCw25X+r32WkRd8gwyldL45+5EjAvK9tlL1fNwmBq0xb?=
 =?us-ascii?Q?4xe01hYR2dMorVZR4EdsJtudvGpIxC8QeUc6h/NAYBFF9nw44V/KbUZMx3zu?=
 =?us-ascii?Q?LR8ki31wnWLeqiGohGMe74qzq1Xp0e+65Z6EhxxcNK4EZpWCa9cHSpY2xukf?=
 =?us-ascii?Q?SvGimXC1QCBtEDvH5wvd1E5tS6ac0Fvfo7ycIPjSPfG2kZZbpJdc6L6DsCZx?=
 =?us-ascii?Q?zGImRhAYjF63FUshKu2vtonJ/4hCfz3iG4+weHwpQ/q2MIU/uOKod+tcZLxb?=
 =?us-ascii?Q?d52eQfeJLU6evHtcAoMNs4T5lYhrQmtlpypo35TFNooSNmD28U01m0O4+daJ?=
 =?us-ascii?Q?MDGqQsD9A8Gw9CS60AIsR0Gal19AEaFfKnxBWQc143uQYuK8i4pdV0XPHHlS?=
 =?us-ascii?Q?l0ZGCwglH6TCZQBVsxxFqNE9ihMoZOX6TBjrYsp1poxGRsUjKBIZoNjAhzv6?=
 =?us-ascii?Q?mK0ZYHkoV1RQOlmyA0JIeUB8/lmxpvJmT3ncnIjQVbMEBdEau2jh8/p4WOWn?=
 =?us-ascii?Q?5Fh4lWr7o52zVm2CzidJE+WFjQaslI2aCL55Z66rb7LAqpDOxdFjbv940vt5?=
 =?us-ascii?Q?m4IT90ARxJ/bbU2t5XllbaPo5K1pP6u7tLfdYwYul62IMDCtFCzJT7vwqpu5?=
 =?us-ascii?Q?KKtXscj5oJV0LIolT7zAs2b9j8SmXSqIEw/PUOd5fcEi+Ojv/oARIk1GFQoB?=
 =?us-ascii?Q?DgCs7oMMw0S3UT8e0PxEYmL4gpCzTAnsyUp2zwlnFgpiHieMsFJO6c+L3CRs?=
 =?us-ascii?Q?WInye37nh+AnTA/52IyLt7kJHep8eFawA0kbP6KLaOjmA7/ly4p/aNkg1rAd?=
 =?us-ascii?Q?cZ+L3Qu+swfZpqTPvmTR3d9gt1AEDm1bX3VmY7s7X8tFE7j1cTJT5S/Hhhzo?=
 =?us-ascii?Q?z6KSfFaZbDHfh1TRgNUNhzB9ukrvjgNCRUMyhsIL/r+eRTVD1MZjOPTK2/x/?=
 =?us-ascii?Q?cFIH26O3vruyRaA+iD9EJcEO+FjgvnwA3QQa5iHZZm9XmiyWjOHnmKYJE5C0?=
 =?us-ascii?Q?sepDx8Dfb59yK+M6Q9o8DJU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed5d274-ac5c-459b-7e82-08dde0038dcf
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:42.7903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srEg7xdbnGHVjHfOwxgb3EzT+CKvJfd6IfsXw1ES5XWN0Xlc55CGPRP8MgX49zHZqKumRlIUyuvqNbai6IYoOXjTlP34Tbwfrx6Pe0qSSAYol7FXZTPsRFW6mCEaJxf4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19874

From: Tommaso Merciai <tomm.merciai@gmail.com>

commit e7724e23196ab1b4bc843aa60e917967d95697e4 upstream.

Controls can be exposed to userspace via a v4l-subdevX device, and
userspace has to be able to subscribe to control events so that it is
notified when the control changes value. If a control handler is set for
the subdev then set the HAS_EVENTS flag automatically into
v4l2_subdev_init_finalize() and use v4l2_ctrl_subdev_subscribe_event() and
v4l2_event_subdev_unsubscribe() as default if subdev don't have
.(un)subscribe control operations. This simplifies subdev drivers by
avoiding the need to set the V4L2_SUBDEV_FL_HAS_EVENTS flag and plug the
event handlers, and ensures consistency of the API exposed to userspace.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-cor=
e/v4l2-subdev.c
index 5c27bac772ea..423e9663d149 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -502,10 +502,25 @@ static long subdev_do_ioctl(struct file *file, unsign=
ed int cmd, void *arg,
 		return v4l2_event_dequeue(vfh, arg, file->f_flags & O_NONBLOCK);
=20
 	case VIDIOC_SUBSCRIBE_EVENT:
-		return v4l2_subdev_call(sd, core, subscribe_event, vfh, arg);
+		if (v4l2_subdev_has_op(sd, core, subscribe_event))
+			return v4l2_subdev_call(sd, core, subscribe_event,
+						vfh, arg);
+
+		if ((sd->flags & V4L2_SUBDEV_FL_HAS_EVENTS) &&
+		    vfh->ctrl_handler)
+			return v4l2_ctrl_subdev_subscribe_event(sd, vfh, arg);
+
+		return -ENOIOCTLCMD;
=20
 	case VIDIOC_UNSUBSCRIBE_EVENT:
-		return v4l2_subdev_call(sd, core, unsubscribe_event, vfh, arg);
+		if (v4l2_subdev_has_op(sd, core, unsubscribe_event))
+			return v4l2_subdev_call(sd, core, unsubscribe_event,
+						vfh, arg);
+
+		if (sd->flags & V4L2_SUBDEV_FL_HAS_EVENTS)
+			return v4l2_event_subdev_unsubscribe(sd, vfh, arg);
+
+		return -ENOIOCTLCMD;
=20
 #ifdef CONFIG_VIDEO_ADV_DEBUG
 	case VIDIOC_DBG_G_REGISTER:
@@ -1023,6 +1038,9 @@ int __v4l2_subdev_init_finalize(struct v4l2_subdev *s=
d, const char *name,
 {
 	struct v4l2_subdev_state *state;
=20
+	if (sd->ctrl_handler)
+		sd->flags |=3D V4L2_SUBDEV_FL_HAS_EVENTS;
+
 	state =3D __v4l2_subdev_state_alloc(sd, name, key);
 	if (IS_ERR(state))
 		return PTR_ERR(state);
--=20
2.43.0


