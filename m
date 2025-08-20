Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357F5CA0FE1
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:34 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.33])
 by mx.groups.io with SMTP id smtpd.web11.1041.1755706170643256266
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XMH4wx8W;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.33, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9X5CnX09PIQbe+Z70AagSAT6ZKYBkZtkZsP7kafkfgxOXWLszTVLHGOIMtEOA3sOUKCs3hnYOUfGWP/USCDbwH3a4of/uaqDFXId3h83QuzDChbYJDcp8mJGle4n5Kl6hWSgSB9HRKCOTyhJ1HLfvZaYzB/5oNOwd1ZPtUjm/xJ+WMQqA60F/ijLCyEOVp/AltUo8xVo779JwaNIn3q0UbolgVmuvJclLFukyvmjtV7VOKw7UFuv0pfScFmm1YHradTKK1x91FfbXvJsYT2zrgf5mE5IFZAeSQ5TUlFBqz1Y1sI0ujFitAjwAURQ0ooEDlTdHps6i5VVV0JJClbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxiuVkDiZLKv55ZsIiBmPkgA1uPbdGkvsR4fbd0b0XY=;
 b=XhNi8nv3swafIu5YvOipeyF7LACLiigNPgQApmTkCvehN3cXxxmxFl5dKjj/oTv9UlMbZJHExKXvU5+NHUDR91eWMVU8v53gonswucNrL8R9fNyCNTk5GZWf6QtiaoUu/e5sKT6iI1g6FFxajdflLGBlyUCLKsXO8SLv0FJ32x4T5RtBZFCxjwQnhF2/w7sSYJncbmOtqLRvOYUgm5iYrBldoP5EEDUmARvt+ghgT3rRFW1d6FtCJqYKSrEw2xbsehdtBYOCyTI2s7MivXjH1/mHnGkSfWBnGTmtrg7G7/7OL0eeZXPMum7CLN7VG7jEqjKflz8sm3di+4rqIH5qkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxiuVkDiZLKv55ZsIiBmPkgA1uPbdGkvsR4fbd0b0XY=;
 b=XMH4wx8Wdsp3ArAJIOgNZakmnBaQ9dmrA8mxomo00cDgcRzS1BsdGkd60xNXDuVqFYkgNI+KSL2y8jcqoRw0wTqwvpzgqQIJfsapD2QaswVku8DqG8I7K+ozm+6DwtIMsu0gHgK5IjOxT4gNyH9xGsoc1Abrv1i4UdRV5PTmJ5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:28 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:28 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 26/55] media: rzg2l-cru: Add support to capture 8bit raw sRGB
Date: Wed, 20 Aug 2025 18:07:27 +0200
Message-ID: <20250820160758.801813-27-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5498ee6d-5fe7-4d6f-7226-08dde003f0b3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tpRqZJcqp0NbQ8aM4WDLy1ltG6SilMRGBG3sqf1xTETMQmAvaX2jdNyhulGO?=
 =?us-ascii?Q?uBneuTjemDA4LcqoaUvfsRlzE7E4W5RIyvTyOxISQMgfobHEfpQ7TJLe80PY?=
 =?us-ascii?Q?M4GKs9pvAuS9p8rw54HDVJlDECsJoPnPD9Ix5+5lY0hkiAYb8HbXx3/CD3cd?=
 =?us-ascii?Q?606H1MvDF73/kCx2U3m/K3jYrauknAWm8N/xIzd/TcHzfoVhYCZZoRB/JQCR?=
 =?us-ascii?Q?dSkVTBPwfOjqgFRcUSlEMPVTTn8cp5leCMQlBqlMg98JKRVxLtt+ympIcRdb?=
 =?us-ascii?Q?z8REvT7F/E94Efr9Xc1RY05A+eN+l0iJiEz3B0aSsZDzWD67h7ICm5PjLUvv?=
 =?us-ascii?Q?6cbQHB2N4pFUutVSzn4wH1zVzZsO4pP/Vqw3d7/Hq0GJhv+/axFfROd8L1f/?=
 =?us-ascii?Q?Osb1B516fsKxtipYmX/5ayUaEkbVjdu544kxCOLECRQ1LIfFBndNriR5UwMN?=
 =?us-ascii?Q?nHemFKsuDJnvVl6IUqhsupkLJYePHDSBJQFcFGJy34Uct1VlxgZfYle8RZ2W?=
 =?us-ascii?Q?OzDZ+JbcZkInqT2OShqazp5mCWR52k+zYuOzNDe/8XLcOJVBTrhQGJr59lah?=
 =?us-ascii?Q?/LSsKFmL6PtxEf9Mx+70EcbGCfdpXFzlmVMUwOnESOscWkrPKOFUuuRSSHO7?=
 =?us-ascii?Q?kN0kEEOKSXzKcCcRbhsdsy1vNT7wfMBuAlnOeSJzk+Pug1Z7z9wzzH6XfXhG?=
 =?us-ascii?Q?8RsadbfDD5vsUSLIYW8Wu8lc+7G4IiaB6p9RMajkAZYE6M49uc6TK21TZz1i?=
 =?us-ascii?Q?eg6/X4MJV8FeRBWDTlYXrYLBxrSLinUG501Q9SDvL2Mcy4jqK9XepTkd6SvS?=
 =?us-ascii?Q?cAeoS5Z5WRk9Ll3bOt4gPxNeAW1qxLfBjDKK+t9xUDgM/2YXurSP/wH4qt01?=
 =?us-ascii?Q?Pq84WbcLEsqsbq9ANukdgcdDfIxzY/toq/3T1gMYo44fCD/XF+P6+zNlRjSl?=
 =?us-ascii?Q?n1Bm/mBJyuOr6D8q9OFDWfULtC+YBTgpJTUnBA8EFmeed4sAfinucE5ki1Qu?=
 =?us-ascii?Q?jF7dm9Tsj6by6nzHWBYJ7nSbZCS3hCyIWg9/NfpzrzVjXaV52f6GI6KpuwXk?=
 =?us-ascii?Q?pwspWZAVXJbtU/sIflgMVhBlCZbFu3e9ACb5Pk7DTr6KcdIuKuC6Hnyb63V1?=
 =?us-ascii?Q?+jlut/kQmpEDI5FIjogBtATKLgISysnUS3NFPwiat0AO/h7pE8XQC9i421py?=
 =?us-ascii?Q?x9aihLOtOZrzyeRxIrnoCKABjc3QVdhQ5KWv6kFviKeg/K7+UaO+iqNeLZ02?=
 =?us-ascii?Q?AuMVPPNk/MWUXBomwUYhqD4iC4JkwUHI6M6Nar1HFzkMJnkmzhHLfg8EMt06?=
 =?us-ascii?Q?sKVHxc+gYitHOWD0AKnw7HSyCpNdpvc6hZtApyqOQt2cAewU6MLgjlt9KZ5e?=
 =?us-ascii?Q?1HL5iHGoRtEEstRv98THHzQUeJ/KvCNKEcVwFZd2EgF1//K7ZXW4dkM6f1ks?=
 =?us-ascii?Q?EyyJAesmOrwjciJArjisKQjmsFhYkaYp/YNXLfb+0NfzgJvJGX9SlwkTjz+M?=
 =?us-ascii?Q?WTAujPP1wbH8JHo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?O7wkdjMXyE5PouzGKq95fYv5rSYyQ7pR0RC2151ozGdpVt0O74wEock2yqQ7?=
 =?us-ascii?Q?JiR+7xRqZykOsLVnCp4uUtzLQ4aXmzp2a02X45atedsaZ6WXN1+ZZWKxJz+l?=
 =?us-ascii?Q?2/SmEDU6xPHzVhP5kpBe97t4jX0jtNpBy5kAtOgF1LWQdYSkIEQKUoE6SVui?=
 =?us-ascii?Q?UR4F5uohbxLoNUt36H2BLZ5AGR+DV36JcGbBF2SFxcVmJk/0QjpWNtx7Ydqo?=
 =?us-ascii?Q?d1Cpy/AIvB3pn5wEgBWDU4rE3NqjvhW0OcAqOkIsDW4pnukiSqp963nmpOJ8?=
 =?us-ascii?Q?zIasVK7wT6XZKGywvOWSGXr3hjVWoRaARlsYA7aXSXNpEvp4EVnaco6uS2hT?=
 =?us-ascii?Q?H2tIN8eq4vPWM6THPD5mkAj747Fut3BS0PBeSNS/+ufucyZuuvuu9xNBZdYg?=
 =?us-ascii?Q?eMgux9aw9mEBJMKNW66+jOBwI2zj2rDUiRLqNyQqPZ+ucuznXW6dO+gl/Kui?=
 =?us-ascii?Q?CguI387+DRcIimpPkci7keZpPbdmyX+DX7K3eNqQZuKjXVD3Rf2bvi/Ia6cS?=
 =?us-ascii?Q?J5Hqav38/Oue0K6VilUdtpoMSUg0zEE6lqY+Ia5a3yE1ft21ODU+9SI8l16A?=
 =?us-ascii?Q?SsWaMTjgzbNxvsGZQ2bo/ia7NXfyYvKfDl4ZiRzGEwDWSpsWDfv5qckxd8RO?=
 =?us-ascii?Q?s9ND6cWLNip6dl+KfZmOZCETE1VS4iONIcmKxlB2qzFnZI/4+SHU9r1GUmZo?=
 =?us-ascii?Q?tqx2M8Shg7NN8Vyw/NmarGgh5PgLmFaaSC496LEEDwU7QlY9wPTVMLUyGpeX?=
 =?us-ascii?Q?spDvHzDblW/KMqa+WdsEKZBF+k1a4NG7X/YiK+9TOujRvCoGJ/HHXgEfILca?=
 =?us-ascii?Q?J/kkmJIPNHROMrVlF5n/QVHUmb4xu1FySbV9g/ISPKe9oaQgPbtLjVxk6ZXe?=
 =?us-ascii?Q?eyH77Wpucdsw9270n2hXgQ8GOxHZO2o4fI96GVWetLgCPmpcq9/fMcBpyoGk?=
 =?us-ascii?Q?N0kr3PthIr29WZA2CXzQlsFSwi9PyLbNpEysvtbGXu06B2YPCbrBjv8IDX4h?=
 =?us-ascii?Q?DjsTRavPtDMmWEuRd25XyNh+qqlErVhzu6nI7xjke/t1D2ObZIfYSjgVFxb5?=
 =?us-ascii?Q?Gr/CcTOogXN6VNhp9yxZQqr4sggQoFVmB6nfPZ+NTGC+iLjsZB6rWIwc23+c?=
 =?us-ascii?Q?TQAtl/9uzfUQlWZYPO7aJnQTJdcxXC1Ywsz9kGZY+rfUppvLg6bzbM6fheKT?=
 =?us-ascii?Q?OAa6/BzR4X9ksXladXJVPBITax9jqS5I/0Rf4aiLbTHqVgIBZhuP5p2T04YS?=
 =?us-ascii?Q?nORY0nkBwgIrtTCResxp5trxb+dwoRCHijDeuoY1O/XAyIZab5zFmFVhOAxT?=
 =?us-ascii?Q?0kaLZlIOYfjyusQDh1U8iLDtqQwlyJWjBnLMX14YKikNMwVFUqxIwrsMOEZT?=
 =?us-ascii?Q?JdKaea5NWwB4nB0KsfJfs6dCNe03HUcYe0eLTr1ZLtnlgs1Myv/vXoBktUW+?=
 =?us-ascii?Q?OC9I7DYVJHGP0V0euctJ41Ju32FgT3tz0pJc+Q0/T8QRyt3RUGEVKBMQ0CPg?=
 =?us-ascii?Q?QEkJMGwDbioTGdrY7pTd8ycjMDTUrAAdzA5YvnOF84eg+JjukhBEwv5canMk?=
 =?us-ascii?Q?Z7h+QvZFD77y8/xF7wEghESXxt5nMSh9FgvZ9KnLN37rMRwk88/iQw975J0D?=
 =?us-ascii?Q?mSkYwttGVufEJXiZRZEr02s=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5498ee6d-5fe7-4d6f-7226-08dde003f0b3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:28.7179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7e5hMmXYBNxNKCcHtldfXekzSn9p/KnYqXc6+sdqjfNW77jN10k/9WhuBzZDrmjnYGyMLUgWHp8T9ow490dcasM9F9otUoYm6AXEH0OS8a6rx8J/2sTkdEbzcpC+J4N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19907

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
index e21142d3b67d..84230926875a 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -188,6 +188,10 @@ struct rzg2l_csi2_format {
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
index ad470de440ad..982c996cc777 100644
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


