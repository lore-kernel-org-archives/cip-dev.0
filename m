Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0B4CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:53 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.54])
 by mx.groups.io with SMTP id smtpd.web10.960.1755705948223398128
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=VAgdXU/u;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.54, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izcv3flrrcdswwGMQmI72BsqmY5mwcBhn/6gmebQVzz+nHEs8IYZ7GlWGU65zwFRmhCHzBu1/7ez+LPScOj7QVxG9WyncjacV1JudsSkihBxFpJTxo+TJFivpBnlNjGOeuaVQye6V8X3tKukFpNPzxvDb2Hv3p8qzVPo5F0pAW49Y0dpMthhc/JesF4RxSj/3wfwaaVBB9uGBCXtwKYjvBxlFSvkruOhJyGeV45d4ZC5qISKXmrJ3A3BPKO9J3fgEquVpHKvEIXd8avcfwGMxkD8U8z8b8/bVCN4s4DVROBgMbVWU+B4xLWx1x+AEGq8lq6VYQKRrf87j+7q+eJLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC+qrS4jcN5AyjPPnDE8x6jK4vvJeTVdZZYSZZ7B1pA=;
 b=dR1U1jAC3y0MILho7lc2zNpD7wFvS/T+Kh2usBWDCg+Ral4w461BqS5W+B8Oalw97zZdnPmoWmfKLgpGdF9X9xgVVYRbrKiwWPS47zuOw0CukmYbLzUrpr8Mi21u/eBHHZjeguT6hdnM8PctaUKILqnsIRVDeMjVI1UOqGHb10MbzT90dA4XZSVWX7fsW81pX6KdykGHbaTvfhmtp7529qyNO1wcz+jtVaCKF6G9AY7s3nmBpKIVTM7rjNKXhg91EKs+lHIus5wWrOqWiraSys4vhrlI7OQTz4kkn0lxwuGJpXy5tm5m2orHqak8bNRQ1Sg8O3mVUKwN87HpRmtdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC+qrS4jcN5AyjPPnDE8x6jK4vvJeTVdZZYSZZ7B1pA=;
 b=VAgdXU/utsJV3qdwszZXuaSUaNaOOSK863abIlqTrw7oD3hr1spTQo1HrZUEaW80YE6XRLpIjORw+zsrjm7HoUxx4GbCofC+D/kH1J9vvmIhbZMYiJ4DnqtP/oRyWXeVvExUe4pNGMXKFkQ+rCdlxWpUFxZspMx7qgXFW1ndpRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:45 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:45 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 26/55] media: rzg2l-cru: Add support to capture 8bit raw sRGB
Date: Wed, 20 Aug 2025 18:03:42 +0200
Message-ID: <20250820160413.801341-27-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 990c0054-e17d-4b3f-7ecf-08dde0036bce
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wvl8USJHz/le0uIxoNvhQeiUj2302ZNFkFDvAztjgLE9p/1DO/BPXf8X3AOh?=
 =?us-ascii?Q?rjJlgoYhvyId+lhc/bF/yicQp7+ALLjK+EGrBF9YPFytfqg+3urYfyYVPAuw?=
 =?us-ascii?Q?UVQklEZvBQHmCsvlZ2cEI9d6UCWxLwpILVW71i3Ru2giIF2pnFRcrzoMONwt?=
 =?us-ascii?Q?zg5lDNRwFJNsT5GiSBL2Vx9420hM3lAh0tHhWVNUaAEWzZKK9trwb4VRnG8+?=
 =?us-ascii?Q?nb4OMvyVI4cbiWEpEXG+xqTv2jRr1GtgnzIhnB+rZXSG43OOhoacG2eluk1U?=
 =?us-ascii?Q?mB5B1HHbR6lDbjPGvA3+f+Lm/vfIErWK4siNArTbcHAt3fU+uG8hxsWxkNuk?=
 =?us-ascii?Q?xB8XqABfrr1LI8svxBcFA7DPrP/iAvh20RpGN4+WTwqs/Q+hNtBfrdJ4oqV6?=
 =?us-ascii?Q?frb4i+2YJIzSP8MSycoAH+z/0PXDdngXM50G+FkpXxm5+Q5YvjkGcivObJV8?=
 =?us-ascii?Q?t37pgQ5mfoDJ07Z1S1VCr81H7g6FbKosHXpwTTRYEEeHjciMDtriz69Hi+gO?=
 =?us-ascii?Q?aDIKsMrmPGf71wXTm7ErwzIyLD95FCCtR6WBD8Vs0zahad40qSajSULu/nzn?=
 =?us-ascii?Q?YOnKlo0A3tNzCHP/MWn0SjfFG0bBLfAPW9HEB3tfrPQQkS24d6ZdUozbw96e?=
 =?us-ascii?Q?+jJyaga+Id8EzAuXOyBcg2sBHzDKbRbPYLo5vZpgvVVhlIXbtgyokkSXLykJ?=
 =?us-ascii?Q?FfdC77ZXX0eLmUs4VMSUdRXg76p0kUpVpvuYSW7w1qsneF5hgsPqGqa6HXE4?=
 =?us-ascii?Q?1NSbQE2V5zfpW8lQ/5rorrbG0dvMK0ox1U0JHNnA7OKDrpRftuBi2TC7fjay?=
 =?us-ascii?Q?j7xcaR/51wLW4bOo0vnpEXL0mFX071LKBPwhRRKxBpw6qTFpG46zZ6Xf9r+Y?=
 =?us-ascii?Q?AHhCZCbZVAJOnJgVP9fUNbCAgiXa+IJb93fgs3KOeSJyknRSwrpbrJSXi+bf?=
 =?us-ascii?Q?N3yxt5dYCeQ1tbe9yIcr620iA6rGSxNTaGlX0u9b6s9ZsfDhyPw/AI0QDtnx?=
 =?us-ascii?Q?Chv9zZjgvTnidZWzo2HdnqK776nlPMGfvHIEdP9Kk7cei6Iz7c8fs09U1vfS?=
 =?us-ascii?Q?IT2x3l6+Ww4kcQ7pHiJkuYZVmm3VX8zVQ5C8lxa/9govbUWbEIrNm5a+FQGC?=
 =?us-ascii?Q?/l6qzFWrxxzyh7vy/jkq4gRIEyXZdW4106YHq/lZDXJXqZz/hbUxEHjxKPZ3?=
 =?us-ascii?Q?53HeLCAAtW/H30OGktTFNDaAqwMu2j+4sxxudDbl4bYVMSLwGvYWR83TgZ2q?=
 =?us-ascii?Q?QEoitAz/+WWUEbhPlWLjoe8zbjW1H+RcUoVUM3Qqa1do5eqkwIMHmLZoYpM/?=
 =?us-ascii?Q?2qk6u/LH6qxeUNpWZ/VSFE1cydtXCKP6/xjklwt9XdDjwCBsSOcXHX6eznpe?=
 =?us-ascii?Q?yiqWYz8waVC8SXtU94hcaQdlXvRJcwWVys/8X75IyHqeECKOMXYFtOrp73y2?=
 =?us-ascii?Q?7djsS3B2SAmynsf68p8YmGcdaYLFyu/tb5LXkAyILcWKBk4TSjXGgGLlZ8HD?=
 =?us-ascii?Q?/RCJ3mAfqt8cMCo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ulU3YAa0iVFFr/yrjxmPJbNZibxzERD8Hnn82twxznqN9oJ1Q5O4c4b4GB18?=
 =?us-ascii?Q?OJm1ZVTct+AcjF5K/8JR+eGbW+IGvWY29UxlawazdbvjxpvvXj4l3B3BTAn+?=
 =?us-ascii?Q?P7D9yl2dIXnVwN3ZrMaOD0zcPBvmKWDpLxCdaUVTq4V7fdcZqBazhIABSvBa?=
 =?us-ascii?Q?BDVzQJfpb0da/NgXANmMXhN2d/TnqFUYI4tg2d17eGFDhvQH4cORy6Za/Sti?=
 =?us-ascii?Q?mdvypJJJEGQ8okoX0UKI/k8yd1imaFEQYGdHqlgZdX5M29txdWyJPRJmdvqe?=
 =?us-ascii?Q?IKAkLWpKkOMnv5mT/3ICAq/DgIHNTJNnNbx4UaA1/t1M3rtq06ZS4YyKcC8f?=
 =?us-ascii?Q?cEOpVjvlPCZC4kmr26GTk+cVNnaSNAuZJAyeQc499P1EP9J+JhJeaEyIkG03?=
 =?us-ascii?Q?NFfPIe+t2gfkZ/Bp4s3tUil/KEPSM7z15wrxVNFVSiBgd6X53xjlx2vAfbWU?=
 =?us-ascii?Q?vQvlCXwB7B9nd9fvNZRD90sJKADkIOEG75MRI/2D36VgoPR3CswrpKliuRvp?=
 =?us-ascii?Q?Ryr2S/Kbdmh2ncl/wzHnRulYl995V/nm9ITkzsWfAUTdpR7kP8ObHCpJh0/L?=
 =?us-ascii?Q?VM0BDJKxZG+PQorlF0eDG9FympYyQ84N7aLceMZqsRjhv3laYIhfIk1ckAPV?=
 =?us-ascii?Q?Luj6WXq/m0zw3yYn5QO51rZU9GhEHy2xJwLj8Fmc5cfJM9A9XumAJsM5igNa?=
 =?us-ascii?Q?tJJr8l2G2KC5ucBzmtelmHU0f9/YVDmcqISgB3s757TorjHvd61Fk1q0qE5e?=
 =?us-ascii?Q?om1dux+fy77007MLnK50cbyEb+/Q8E7B8RvhzHVe+7NXasIUzSjpNCKiBQl3?=
 =?us-ascii?Q?5RtzLseeYSRhhSLqy1m32PsY+clTW1IVu8UVvWTKgXNqDmHJ6U8FhZYpMvbO?=
 =?us-ascii?Q?i5Zc0RWSRJcbwtKBhGB+KreFuuPvTnZBXDYWFi5NuPuLRtbqY8m77zBAIPJF?=
 =?us-ascii?Q?27IsaTGJW0VY2Fn2Ovbgg1AoOWtL/coxdjKIId3mog8ZlU08kPJKowO8cegl?=
 =?us-ascii?Q?Pa1+AOuOCdrauKqNF+d3CfCp3pHfiPhaRFSZPoN7bYq3Wf3m+LIRZTvqec/B?=
 =?us-ascii?Q?GET707/2ykL5OARiGWD1eEfFqEEm7wPSo1hH0LxD+9PQYXJFaKvaXxVoZFIV?=
 =?us-ascii?Q?hYU0fyvqHHnXQNRPchyzNATSYP2MCo7pu2aoJWe2dLqcR3eYrPLg4WaOSYsL?=
 =?us-ascii?Q?ZgFEGNjVm7DZAF60N7MjMsvJ50/MdGPbYgYYplKKudUVs13Y3jvcdey3PjCh?=
 =?us-ascii?Q?wqFw64RpIXBW/hbMDd3q3XK7y8XKg3x+dEGwYUMG2/yknNdaKiKqGzndgvZx?=
 =?us-ascii?Q?yTJ+4jQ9VkoV3wV5i///c5lU7/6UhTDFiXa19ghL8HrmPMaJyKVZsVP051nM?=
 =?us-ascii?Q?YSQQ04IThyy+mW6MK4z0tlvARtJy0K+xmHai8D6/q2kgGDOTWKfXFB8kzGcq?=
 =?us-ascii?Q?lo8IOXHe/Fcgg298R0kxzKUMi/E7R2euVRCVi3SVIBPH3vsu3TMWGz02O4sj?=
 =?us-ascii?Q?0fx0s7IGxWofZXJ3On+0pQK9EkoLNys7Y5y/LQyCuxfwx5oaIDIkRlOimb4r?=
 =?us-ascii?Q?BCYUxAUWVgLIlf6IC8s5rC4EiGAb3C5CIHWauM09dbyP5Dv7Xy2WBJEyatuL?=
 =?us-ascii?Q?Osm6OYd4rHa1kVGUlL5dI5I=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990c0054-e17d-4b3f-7ecf-08dde0036bce
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:45.7577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dlhNpidQqSDaxigEZ5BN5BfimbrqNOpMtER5fuGoweKkwaFrbCM8b6S9mJ2f8Z9eZ+HrH2yuoEOxkYmDzXYtwi66QlGNXOWxWC63/UD9rDsECrsdfoWfPalu+cbYimJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19851

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 0477b0866cd92a71c36b08a62a092924ac3191a7 upstream.

Add support to capture 8bit Bayer formats.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-22-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   |  4 +++
 .../platform/renesas/rzg2l-cru/rzg2l-ip.c     | 28 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index c11158f5fea2..e592a363d531 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -189,6 +189,10 @@ struct rzg2l_csi2_format {
=20
 static const struct rzg2l_csi2_format rzg2l_csi2_formats[] =3D {
 	{ .code =3D MEDIA_BUS_FMT_UYVY8_1X16, .bpp =3D 16 },
+	{ .code =3D MEDIA_BUS_FMT_SBGGR8_1X8, .bpp =3D 8, },
+	{ .code =3D MEDIA_BUS_FMT_SGBRG8_1X8, .bpp =3D 8, },
+	{ .code =3D MEDIA_BUS_FMT_SGRBG8_1X8, .bpp =3D 8, },
+	{ .code =3D MEDIA_BUS_FMT_SRGGB8_1X8, .bpp =3D 8, },
 };
=20
 static inline struct rzg2l_csi2 *sd_to_csi2(struct v4l2_subdev *sd)
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 7d10c61d1304..1a3d33bf5b13 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -18,6 +18,34 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_for=
mats[] =3D {
 		.bpp =3D 2,
 		.icndmr =3D ICnDMR_YCMODE_UYVY,
 	},
+	{
+		.code =3D MEDIA_BUS_FMT_SBGGR8_1X8,
+		.format =3D V4L2_PIX_FMT_SBGGR8,
+		.datatype =3D MIPI_CSI2_DT_RAW8,
+		.bpp =3D 1,
+		.icndmr =3D 0,
+	},
+	{
+		.code =3D MEDIA_BUS_FMT_SGBRG8_1X8,
+		.format =3D V4L2_PIX_FMT_SGBRG8,
+		.datatype =3D MIPI_CSI2_DT_RAW8,
+		.bpp =3D 1,
+		.icndmr =3D 0,
+	},
+	{
+		.code =3D MEDIA_BUS_FMT_SGRBG8_1X8,
+		.format =3D V4L2_PIX_FMT_SGRBG8,
+		.datatype =3D MIPI_CSI2_DT_RAW8,
+		.bpp =3D 1,
+		.icndmr =3D 0,
+	},
+	{
+		.code =3D MEDIA_BUS_FMT_SRGGB8_1X8,
+		.format =3D V4L2_PIX_FMT_SRGGB8,
+		.datatype =3D MIPI_CSI2_DT_RAW8,
+		.bpp =3D 1,
+		.icndmr =3D 0,
+	},
 };
=20
 const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_fmt(unsigned int co=
de)
--=20
2.43.0


