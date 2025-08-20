Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0517ACA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:34 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.66])
 by mx.groups.io with SMTP id smtpd.web11.937.1755705992044249304
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=npP+Pwt8;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.66, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOMpXZND47ZYhVpi6Q5EXXibGFLHUVqfMb0nOYIbt66q/FovSpKvaTpQiczS9INLuFx8TI3D1O2yqSWRWGfIQqsJpk1YvZpIjGZ2/2v32O4i4fAGJmoPf9GIq1AfdcpItn5a5Bb59cI1Uv/OW9yLiNrTDYrIJQYSYAkRJ0mCyWSlBy122TTqZzoLbmXkoF2Yn9LdIiziTCik+rVfBU8VTgmQAOTEmmUIvwIgjNSq9+szIveA9HxZ4Xkq5nLwrj12Y2P0NK+3KjJpnYXEiyDQRVu7Z6ZI7NHa+4SsU729wFs/KPcSJmDd8cWkq4ma095pGq9n+TtcPMVY3QoJf1NDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+8ij0ejFiEF6yN7QwvCy6WUa1BkcgaXNe3JIe32mx8=;
 b=DvTkK7eTLv4u9RCVlVn9Q1aqUJvDtoj0A9mOoXUOQ5UpuapFpRF7Yr/o8hHWdAWdCzE9wE6JWSP5887fZV1wEJWp/kAKLaY6q9OSmuY9mgNBkIG1wgEQDgDHkuUh2BDMceRcLeRDPChwI9PA20Wqtdtak84LRKgenkCIm30SWzGCGIlDK9Kh5wg9wrkG04glqlRVSFlE4fOYAiK3XwmpkS+biIiB8C6Cf2F5AlqX0h7iabqmvxmi3wrVPRkXD/j8nglwUDerP84cE8ADCCWKhiOElsPkNhVDMa3r4JZO0TC51AsN5j3Veb6iq/WZEATcEdrbFkQT6hBuIgvP7EwBtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+8ij0ejFiEF6yN7QwvCy6WUa1BkcgaXNe3JIe32mx8=;
 b=npP+Pwt8QWKbZv9HVHizgL3vwQ02iLmQTsZo2UOpFEMpyt1ikd6deQKiRNCMgCXC0Ha/gP+HERQuqR/goGlM50AzG7pr2zjpnDbZMvy1asS3gZLff1zXEPj0uN2TaKu0tKgMI5k0Ne0413mHMNLDfB80Q7MHIHtw5tJZQiTJqaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:30 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:30 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 44/55] media: rzg2l-cru: Add vidioc_enum_framesizes()
Date: Wed, 20 Aug 2025 18:04:00 +0200
Message-ID: <20250820160413.801341-45-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c95ea8d-5a5a-459e-18d3-08dde003865c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pCSVwp4cre8iBTLLT0F2YIMjosVVHGQLhFH4kV3VN3dMfN1dJ6cSlmJRFONo?=
 =?us-ascii?Q?P7CAzuwnoAIZNcSyFt1VUnUfjcJhKbD1p0hGZAZPM2ydHyfZaRpXFYm9TnSd?=
 =?us-ascii?Q?ze0HfjsO5VDHXxeC4cZnAZ9efXBOanxhAl1/vyMfrKAP8pG3Cpuvksdw10tG?=
 =?us-ascii?Q?lLdX71wGP18woPQEO4/m5CiDaaYHHh0j9ofO6OWl/UVrrvys/H7KzcO9D295?=
 =?us-ascii?Q?4B+HL/04OP5VZB5FY2vsDutsS0P3fwKLTtbjl8JJT3Ms80UIrmamVUn0O/Dg?=
 =?us-ascii?Q?HY7LkahOCIA1fV/fxlUdKGaEZEUX145xKyv5ZsKLA5ayYRc8j4k4EJpFk0B7?=
 =?us-ascii?Q?4CX7o3en4jEE0VnpD3YXgqeohBzooxzO12+7K5JgKhCUa95qGuMs1WhRV8+f?=
 =?us-ascii?Q?iSYDGvdftScbCug+w1MLWE+Vt3zCtFEzqx0ZSpCxGC6Z7TJvV16Ssd8MCz/0?=
 =?us-ascii?Q?i6nEjeLZKu2oa2Yh9U+kBmYGIXWvqrUzoPf8m38A/bcEnXch8LA01NKr8Nk8?=
 =?us-ascii?Q?25ddlgw59r2b5BxOBtYlbZWOdHOWDa+P9pQY2qUSzJJay+7D3oC0nPd0LQga?=
 =?us-ascii?Q?gYuG/r5I6kXNqNwWbSJkILyb80S1GHvOQxsXboFn42cqWVTkGltrNSoaJQ/a?=
 =?us-ascii?Q?Kj0jMxYkgYf8gmVwuwIj9ugB3FcuUHSOkIq8J0Y8jJisdkNVCR9hd+gD9ZRV?=
 =?us-ascii?Q?EZ+WjeDxJhewYe3HkLqMtFzGLNpYi1D/TGT0nirTNIx+7aeQQ87iU5Kelc6Q?=
 =?us-ascii?Q?66FU3S45GT0JnH1YpeNTC/JJBpP7K5UxNHQ45rx4wBZqgLhhwEXUQJXGHQ2V?=
 =?us-ascii?Q?2NNFw1sRteSi8HCooY44kq2kh1owvHdauBpfvfll4WcjPHL1BxO8qHWK0hiF?=
 =?us-ascii?Q?sEzB6Rb63tmP8e0N+BIfEJ19mHhwEfUoyx+rCE7xnZ6EliWgwvDn1MK+bUFs?=
 =?us-ascii?Q?P411FpM5JlOadRCP0B5/W42v1g2Hc+fST2yg2WNeCzDledu58CqQGqFZvpf7?=
 =?us-ascii?Q?RRy1yld/tvRz0AcOuJgWzkh9Bapw01OLqJoKfQQa1nOG0FchAU/se3MXfp+a?=
 =?us-ascii?Q?32MDtTe4YZzS9SvirmcW3Op3PciPEP9aZax4nMO6BOqVWvkm4onPvu/WsAk9?=
 =?us-ascii?Q?maO3r+os+e3aOM5k+ekMYZQTLwG1qzfpzCxnHW5Q6GaLSbLozwBJat5dNFAw?=
 =?us-ascii?Q?8A4Hu3qgSFIfhXkc3q7esMUQ4HsbBBcnAsjJO3o+c92VWnQh7Up1q5cVc+8L?=
 =?us-ascii?Q?x90QAO0mlSsrEx3wCJUlpfi7YTCFJz0enkp9g2Q9IshskBxEmYe1NlouvpBw?=
 =?us-ascii?Q?unx+kg6+esoQ9oZvxc/+y8Mtrn2EhtXGzl2t6lyGRYbWpeXFl1/a6CF1ZoKC?=
 =?us-ascii?Q?aEYq+eez0GeIGnhCZcwVQd6xaTyNax5fVyc+VA7B0b5Mx4b/7LrPfANygmqb?=
 =?us-ascii?Q?iCeSNqLX7RYRYXhItONQ3z27x7Iju8DTowBYHhyOG+I2sRpOq0cssGvmGzGb?=
 =?us-ascii?Q?+7x1Ez7h/xXcOBc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o3KCqXbB9zFl6JndewRZMwP09EqDmsOyI6jZHLhgmz9p1E009+GDM1BnfUQW?=
 =?us-ascii?Q?otzd0HtbU98QtKl0Tfw6yeyAk9Xvq2Z5nSZqE8yiDs9B7pqCSK+nXlKcjknZ?=
 =?us-ascii?Q?Y1lWChNFV59uYmR40usXxQehQGTP7Brl5AOejhH9SrRScC5WGyzUs4fYvlIk?=
 =?us-ascii?Q?NsAY5lqj652E0VVD24NBsYQB8t7gsa+YXePl4KWB64K3ljQFLXOAWtPFRHMo?=
 =?us-ascii?Q?nTYzuNDrTsYRf7Bep8xVWFBCk+I9pN4pEKStxcVUkmrpcNfZji/YJgE7qeCp?=
 =?us-ascii?Q?xt4um1U17czPb1RBJ580ljS40MXcO5gJISKR8YheduM+CXVe1FbQtmWnX4O/?=
 =?us-ascii?Q?7EJF0I+q7Yxd8P2y+Dguc4OIITIWA4Vob3pgOKDk7JAibkD5ErOOQkgj/ZQA?=
 =?us-ascii?Q?xIOWoI2tWFhvlehvmT+Z33jX8N4yO9IoUP04Vt+A2kEdYGFt3nTh0FumZdiR?=
 =?us-ascii?Q?7Bljd1Y6Fg0rsbLe1sGO3T72TalbHfKkWUyT2BWAOea4fLr2erhVGNwljAPe?=
 =?us-ascii?Q?Bf4AJrSuaNN68aIrrIYJ9KC4if94McPP+S6GXCaysPFE5xHbzvr1+p7yjaKN?=
 =?us-ascii?Q?qKbh0NG8DhYv7eH5J0rZ6h0iEyQwcsiji/aSFSwsx4N2HLPiW3ybGGaPovvy?=
 =?us-ascii?Q?csuJyXNMxgRULEYEM7OCNbYLaWEYq6FNyLV1Bqmq/COJumzkQ8L5VlTjmP+v?=
 =?us-ascii?Q?mpgH5ueo+QtBMo5TDewhw2bMvKlLgNnLTNTSDBJLiuDd5R4BiwXur7zrXjsY?=
 =?us-ascii?Q?JxUjHykYOw0UmRWMmW56H0EN/bQ9XIt2Njkqw9CL2PaOS9ROqatw5ZpbriFy?=
 =?us-ascii?Q?AsQ2YBSdYPp+dsVy17lr+Q5es2CiSEpcFkoyZmiF1Pn0vq0TRy9kN3nePXx4?=
 =?us-ascii?Q?laftHyTOEPeWvDrGBuPtdWsZLLwe+eb/8grwFkoa3JYiV3CXj6zqB8QA3KaH?=
 =?us-ascii?Q?K1H/rrozASgzvow0bCKDjdSUm/Rq65n1wR71tkVyiPyuRFhWv1JMklIMoICr?=
 =?us-ascii?Q?ZI/sxcRzylZkNSkcgm4tILKRVCgq4tTSuhLgQGaXFkaLk7w35MUdLTY4OwlE?=
 =?us-ascii?Q?ZJ2VIoDUouHGG3oh+gRyKFFoVIJBmsJRqRqQzY1ZzZRad6ibJwDNpDuF/yM6?=
 =?us-ascii?Q?PsexudifkMtAy1/rub/QRLVgG+lA7Vch9flFsoS+5JqiZx1PvlEg7GLhPZf3?=
 =?us-ascii?Q?tGo7KIU/xZNx1bYRvRicjQ23nouobRqi+VPdWGU/Ey8jGDdidagZV0DKW5mY?=
 =?us-ascii?Q?YnnAQpHFLXMAzfpaq9215QV49P4ZCtxFUYS8u1GP8/TTRBWhjqy2wESwc4ZY?=
 =?us-ascii?Q?lCPGZoHLqex/TdITgf4ck7NDQcxnPvnHy4jmaQXDSK8hc1TnZBzmC1iQ+OLT?=
 =?us-ascii?Q?LblPk8R+eB6YV7ohD/fjcUpJpUtCiIhYw3tEnq5ZIcRUSE530p/eivTjdmcy?=
 =?us-ascii?Q?LD4rAA8B+g7cKwnNcgZWU7CntV2y2uzL7ZvgrBX30m4CsK1loBGvCTBD13R0?=
 =?us-ascii?Q?VFZlXQjDsYfEnfAMrUhBlI+AdU1sdgszdMnEGjEF4ySZUnhQr4GZ3t6LgOcG?=
 =?us-ascii?Q?vdUjsxyawV4fRKOJZNmxpBkfiWy0/+eaF/JbXagXOhu+JKXgGFQ/87vn3RNy?=
 =?us-ascii?Q?X4OtILH4wRKvBtWx0OeUICY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c95ea8d-5a5a-459e-18d3-08dde003865c
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:30.3124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tybQdXcKC9ZE7i40GvAMBdSrj1BqCtAmM4OnirvMvSNToAV1v0SHqjaZyguNFwcSNFlksSzZPCwdXrHZoh2ZbeSnCQLUOkRVYcoBVUBbovXYGbeXD1peCKi2DK/gNC2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19869

From: Daniel Scally <dan.scally+renesas@ideasonboard.com>

commit d225bdb6ede7595cddead722503aa9ec7b0a646d upstream.

Add a callback to implement the VIDIOC_ENUM_FRAMESIZES ioctl for the
CRU driver.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Daniel Scally <dan.scally+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20250625-rzg2l-cru-v6-2-a9099ed26c14@ideaso=
nboard.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index a3c7c8fac337..3906a53c1acc 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -1031,6 +1031,31 @@ static int rzg2l_cru_enum_fmt_vid_cap(struct file *f=
ile, void *priv,
 	return 0;
 }
=20
+static int rzg2l_cru_enum_framesizes(struct file *file, void *fh,
+				     struct v4l2_frmsizeenum *fsize)
+{
+	struct rzg2l_cru_dev *cru =3D video_drvdata(file);
+	const struct rzg2l_cru_info *info =3D cru->info;
+	const struct rzg2l_cru_ip_format *fmt;
+
+	if (fsize->index)
+		return -EINVAL;
+
+	fmt =3D rzg2l_cru_ip_format_to_fmt(fsize->pixel_format);
+	if (!fmt)
+		return -EINVAL;
+
+	fsize->type =3D V4L2_FRMIVAL_TYPE_CONTINUOUS;
+	fsize->stepwise.min_width =3D RZG2L_CRU_MIN_INPUT_WIDTH;
+	fsize->stepwise.max_width =3D info->max_width;
+	fsize->stepwise.step_width =3D 1;
+	fsize->stepwise.min_height =3D RZG2L_CRU_MIN_INPUT_HEIGHT;
+	fsize->stepwise.max_height =3D info->max_height;
+	fsize->stepwise.step_height =3D 1;
+
+	return 0;
+}
+
 static const struct v4l2_ioctl_ops rzg2l_cru_ioctl_ops =3D {
 	.vidioc_querycap		=3D rzg2l_cru_querycap,
 	.vidioc_try_fmt_vid_cap		=3D rzg2l_cru_try_fmt_vid_cap,
@@ -1047,6 +1072,7 @@ static const struct v4l2_ioctl_ops rzg2l_cru_ioctl_op=
s =3D {
 	.vidioc_prepare_buf		=3D vb2_ioctl_prepare_buf,
 	.vidioc_streamon		=3D vb2_ioctl_streamon,
 	.vidioc_streamoff		=3D vb2_ioctl_streamoff,
+	.vidioc_enum_framesizes		=3D rzg2l_cru_enum_framesizes,
 };
=20
 /* -----------------------------------------------------------------------=
------
--=20
2.43.0


