Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A8DCA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:53 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.57])
 by mx.groups.io with SMTP id smtpd.web10.958.1755705945206999175
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PmmLhznk;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6TBoA2EjySlzmLmG+AGfbI7W41xakI1n9oovQ0isbTm2ESkLLNDKNiQcFOv3Nkb4RmvClG5T7SOD3McU9UZLGkShnDWnrSZY/lXbWU/Mjmynmhr6niAXB+cvpl0Hg9GrQmKUEQdlZGSeANoBxlBoG70Zq+1TLq7TvzAiY0gJIvS97TKhPrnEaowz5DDv+IecO8gObbmUscPt1p4v+U9/p03bInJOfT+T0RigW71r6qBxK6gmcBeay3VmV3cJ1kE4VOCulEMzx1tmxkLKLHNSrf9Pd5/g0Atq6LISDYo+hCXvgy1PCk/wN9C2yn/Dz3cYCgtVxOMbUim3cN2ZL1TgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHTBRUqfvYAjchAHMa6fCy2mqX/ophi562UId1utrbU=;
 b=xXU2i2H6HCKiOl70i6/5mLx258xM+UQkwwEA+g29/t3QDCNw/ctVfDMfUf5jAZ0yOBvi922QyWRMN+njXuh7iJyLHImEdokYdQsJ4B3e7NxjEx3NMmJyn9fQ+/ege/lItPwvkIoOr96xS7h7qIngzBDCaX0iIXYvVZUtUFnOhzGsnvpar744Ha8sj0yqOJlRIlmZdgD6zXNJj60zoZRHLxJoOTKAQm6iWllKmsZnvF2J5qXjt0jw+hT7n05kA3/SudKOPGZngL9+3FcNt2qlp5rgQsh9k8P6rzB+ByI5gbngw6agtbSvTzA/Nr1dWd/CSE5dcXr/pT2pzvKboPXiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHTBRUqfvYAjchAHMa6fCy2mqX/ophi562UId1utrbU=;
 b=PmmLhznkH4x7Fjr0V44j0FuYlh0u4wkq6ECSXj40oT5nHWOsq/h2igpOY5gD78T4TUBEEh5+u0wW/fHHTePem3GjvU3rAPgzpUVTMSdtk6rpVdQlPXBR26k2nlj/YR4aYCiU+weZVAFXU5J6lBUOujwhEbjHgkoCJu/fcMjeJlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:43 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:43 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 25/55] media: rzg2l-cru: Refactor ICnDMR register configuration
Date: Wed, 20 Aug 2025 18:03:41 +0200
Message-ID: <20250820160413.801341-26-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: b7a9f9a4-975f-4fd0-31ba-08dde0036a4f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4308UyvoM//QIssMzQN3x660GBAzCeSygkNuMGw5XeGwXhzgeMakzg+s9kep?=
 =?us-ascii?Q?Z/kTTlHD8t4I6BGUpQrM2ZOw9/vx4VvLd8lpVAEOU4QbGPpXjPb+wKXaY+DX?=
 =?us-ascii?Q?wwmuFWyBg7Kw4i4r75x7ZIDxxi6L/2mluuakNshlnRN1JsCxYnWKra4Q2FZo?=
 =?us-ascii?Q?ZCXsBAXE/z44lhw0b6aeePdf+ep0t2xeisqa3ZZog1akX/fzrQb1twUjVX/G?=
 =?us-ascii?Q?jNttC0pAMiSsatDAB5gzoDB4TSPA8Nr8odTGeVmQ2VPwdPrpCzuIhffKlW47?=
 =?us-ascii?Q?vgCcBCWWNsWaLVxiMq1noQ0mE2I4SNw4pqEd4lKvd/udRNv7mANCVPXluNmP?=
 =?us-ascii?Q?kMO1LNSfyl3LVVwt0YD4MCfo12x95sGHFunP5jA3RhTxiM4vXRIRFVmOCEtS?=
 =?us-ascii?Q?qdKdDEhiAJWkVUyVjaiKF3RNYbSqGckFQ7t1XAYypYhPhrw/ZACKTOHxL3tg?=
 =?us-ascii?Q?6i3qk6RhBzOHj8+znZkmA3/3jKW4aUFYEsD6WjRh5tl4teaVC2ePqavzjZ06?=
 =?us-ascii?Q?bGeXURfWwxGLFXaqcULlvLX3sk81OUKOh5P7rqPAHEORxrEY+MmIqecNax+f?=
 =?us-ascii?Q?rVxRini7b4SQfckn3xN+xj4njKQLyeIyqftxXi3xAZcCXiU6N7RUzALZXyuu?=
 =?us-ascii?Q?MSw6AfjH7j3JHnPgVp+38Uw5gqJMvBHX7ZVcipmjzW9Cia71jApW6MrVEMmj?=
 =?us-ascii?Q?v9n9HJC7EozNnMphY0vnTX44HDo/kVCqij0lrZ8aNqUAuiItt6DkZ8LImtw1?=
 =?us-ascii?Q?TeX/73B3QOLyRfaazzjwLHFYjk5A/5W2G72xqnwkLgvZTcBvAj1tiFP5jp1p?=
 =?us-ascii?Q?yp1fGPtAkWmaObK+6McWnHfSZYDe+7Q77uFo9XgiZswr2YOins93BnNIj0Xn?=
 =?us-ascii?Q?CkXF/thpxu00A3btMTO3HKZlkcb5gARY+kjXrhaWFRAQOZYNkwTs+mQwBx0U?=
 =?us-ascii?Q?bGMCDMBjsZYyWmQaedy4IHvh+ksPH2nYwi/RNEJyAp+bLzRYn/4a8xQ0PZQe?=
 =?us-ascii?Q?pKsCqNGHoAZK+iTGllK+r1o7CnUE1qZ1O2CYgie00ZHufC/WAnIm4fQqFXpn?=
 =?us-ascii?Q?NvJv4uc7ouB67dVlotCGzTcrxEl2l9j4KPruyv2BDewBKKjk/Bx1zhAdvkQQ?=
 =?us-ascii?Q?IEPYeoplXBvbh0ucd3uvOOS/F86tDPnxnH8F601o6r5JK3puiYFgccEk8cvk?=
 =?us-ascii?Q?77hJ8ToNwtavbwt3jm7TcFYVJVdvm/LWrqPv2nURajqA+TUfeMLYRL21u6ps?=
 =?us-ascii?Q?G5Oolrd+a4eFhtgS03tsqrN06hf2qH0JWejKGcUJCldw7QvH/dnReei7RWYQ?=
 =?us-ascii?Q?54TlLuwhY4abolsg25NNxI1YY8lw5ZYjXuiTyVBrfbpesmuzt1hnbHgosl/h?=
 =?us-ascii?Q?8gi+mSknydJ9uM6ODgS8fcRRWCue1XX0lZ8hvJr8kBTF13uKN6jkfmeTpbSk?=
 =?us-ascii?Q?hldYxMiqwDWbY9ArnAGqokVEh8UbbDCyXhY3AlBXGYZ8nPtGbKkO4g/SsdG5?=
 =?us-ascii?Q?8H3wMKo4VNpEFPw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?H/c30lSgKAo4sl24PFrJQX5o6FjOJ8UYuEpB+tKV0rOcvxqsW+r0lny5Zi1H?=
 =?us-ascii?Q?h0cC1OkBEEgLF6tR4dZF13oZSqeNleL8TzzFRC/UOZpnpTMtKaPu1tCmP9Dy?=
 =?us-ascii?Q?n4S/DV6EdKYYUh1dUfjv/810fVCE5WX2EYaaBF5tFrRcexkcP4IhfxLb4iHt?=
 =?us-ascii?Q?k8MHOhbI4zXT7T+zMSNXpP4VtF1ImKb6/HegzAIwmqLUwVoBGh24yt5Wqz98?=
 =?us-ascii?Q?zTVrtRDA82xq4W9lI1g59xFV5CSNcsCN37s2tObi1bs1HpVuqivaBtjTjq02?=
 =?us-ascii?Q?tbd53dcKccdF6FlDx4J+LstietQ0lX1KQsiE0HntJwlLfThAxHzXUHw5tT/F?=
 =?us-ascii?Q?P+URRS47LYxh4ayB+5WoZzyZZnRmwewgP2EduoEWOcEWtq+Hv87go7Y+vPbc?=
 =?us-ascii?Q?0HqDaW0tfYBovIQ+Q+oampQrb2NXBCO2zYRcIjs2PzOBUFQKlbO9HFDk/gtq?=
 =?us-ascii?Q?aPfRSedk42uKDzbbZEUcBbovO3is8mmLz3n3UFcKb6Rfbo65PQYVosjiVr8H?=
 =?us-ascii?Q?JwSmtgaODj9inBdpfQ8sDD6vHRA1GLIjcwbnEhFFkQQjnLcxgz8HQdEVYCM6?=
 =?us-ascii?Q?kwyfQy8YeJze9F9YXtXERzWUww+iOXbvf8VwgzS72PlBnERyv6QnFRJle6NH?=
 =?us-ascii?Q?aN3WmvWv5jrYwiAedOKO3iElAGiE/zkUxM7CXpf1fzqRGJyaQLXLnWurawgz?=
 =?us-ascii?Q?NoDP1yCaC4S0iIl/+YJ9nk1FSTAb9ph7bx0nCJvfGjVU/Rl6V/PpysUXpRdw?=
 =?us-ascii?Q?5IwomK003L4k0Ad4UfupcglZeP4pKPCBYe4Vcwgw+UFZm21krY9UQ4UcAogH?=
 =?us-ascii?Q?JnlRtnGyWMxR+srP/cJ+CSL011abl/XNmCpSc9kX6KUw5+3QKHqgBDWek5rT?=
 =?us-ascii?Q?dcxy11LkCdFZlNK8x1BoOM4PONjZ8ZFuv7kdCDKPAEAD6hCnNQxdfZUSsb5P?=
 =?us-ascii?Q?fx5zFkuds+4Y/S9OkIqAGUjvx28ZpjTmEmnntZ12VcB4yafNnyXrFWv6hMQS?=
 =?us-ascii?Q?6dM36QKmARPYTUUt8reAaD6Okf8XSoNreWvSojZsGhOOA3proI5i264rVQdW?=
 =?us-ascii?Q?769oc8iHb6hmDt0frEl0yWTcA9QjAZup/rBdCh/8FrnoAbj7tcc2Q3IoY4pg?=
 =?us-ascii?Q?IQS3pQbN0PKyUsRpwPpHEbpgR3V4+sRjvEGICnFD8ynx6mRZy87ECsIk++iI?=
 =?us-ascii?Q?9efjlIFcrNiN6Srxi+TvdKNopl89rEFw41ynkOLzdgu2JZsPcXEn9VGxF1qK?=
 =?us-ascii?Q?Ck5nmVwu3aWZQuF0JVdT6tZnLs0WlSVDvFQrjXAB6M2YqGqn2D0MdMWtO0hW?=
 =?us-ascii?Q?Aape2TOTXSraqm2zNk3ologcCxRaK/w7w9KbGyPy2iPzcEWGrSZRLrWW0hab?=
 =?us-ascii?Q?guf7S6gMeCNiFT0z3vezfvnO1oLb9z7jy9zYqLvON9+byNvbcKFiHgNCLil3?=
 =?us-ascii?Q?yXRAhVCzS/k6SJA+uksEvcl+lNx220NaFcvXosYJRmwQpqUqHzlVYDDdKB/D?=
 =?us-ascii?Q?gMKFSpd9oiJybWgkHRBqwKKpv+YKD9LJ/YTq5FpFVauIRxK83akJHZXb1Ryz?=
 =?us-ascii?Q?xM3sb7s5PLRDekmV7tJx2kgZh4bp8HGR5/tQA+PPOSVDEpOXFUKNKLrn4oCo?=
 =?us-ascii?Q?DTEzs05yqE+Y/23/9OmrSwc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a9f9a4-975f-4fd0-31ba-08dde0036a4f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:43.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqmBYHz7gGe4osjdo3kA4qxnxnYnuCK1F61H67+A9VVLxkoEuxpMaieaOwXQSAMrQ/YVSuyh3v2OXCmD6S/xfU8dxNxM81RbTz4kbfT8NBV7YU2VS8l0TiT0k1Xnxxku
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19850

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c6ed80fd67438c113928f4d0d883f24d63874794 upstream.

Refactor the ICnDMR register configuration in
`rzg2l_cru_initialize_image_conv()` by adding a new member `icndmr` in the
`rzg2l_cru_ip_format` structure.

Suggested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-21-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h |  4 ++++
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c  |  1 +
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c   | 12 ++++--------
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 63402b9b5e3d..766ffaaa6130 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -31,6 +31,8 @@
 #define RZG2L_CRU_MIN_INPUT_HEIGHT	240
 #define RZG2L_CRU_MAX_INPUT_HEIGHT	4095
=20
+#define ICnDMR_YCMODE_UYVY		(1 << 4)
+
 enum rzg2l_csi2_pads {
 	RZG2L_CRU_IP_SINK =3D 0,
 	RZG2L_CRU_IP_SOURCE,
@@ -67,12 +69,14 @@ struct rzg2l_cru_ip {
  * @code: Media bus code
  * @datatype: MIPI CSI2 data type
  * @format: 4CC format identifier (V4L2_PIX_FMT_*)
+ * @icndmr: ICnDMR register value
  * @bpp: bytes per pixel
  */
 struct rzg2l_cru_ip_format {
 	u32 code;
 	u32 datatype;
 	u32 format;
+	u32 icndmr;
 	u8 bpp;
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 9ccecdb67688..7d10c61d1304 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -16,6 +16,7 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_form=
ats[] =3D {
 		.datatype =3D MIPI_CSI2_DT_YUV422_8B,
 		.format =3D V4L2_PIX_FMT_UYVY,
 		.bpp =3D 2,
+		.icndmr =3D ICnDMR_YCMODE_UYVY,
 	},
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 1a30ad172d1d..dae952e05944 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -88,7 +88,6 @@
=20
 /* CRU Data Output Mode Register */
 #define ICnDMR				0x26c
-#define ICnDMR_YCMODE_UYVY		(1 << 4)
=20
 #define RZG2L_TIMEOUT_MS		100
 #define RZG2L_RETRIES			10
@@ -279,18 +278,15 @@ static int rzg2l_cru_initialize_image_conv(struct rzg=
2l_cru_dev *cru,
 					   u8 csi_vc)
 {
 	const struct v4l2_format_info *src_finfo, *dst_finfo;
+	const struct rzg2l_cru_ip_format *cru_video_fmt;
 	const struct rzg2l_cru_ip_format *cru_ip_fmt;
-	u32 icndmr;
=20
 	cru_ip_fmt =3D rzg2l_cru_ip_code_to_fmt(ip_sd_fmt->code);
 	rzg2l_cru_csi2_setup(cru, cru_ip_fmt, csi_vc);
=20
 	/* Output format */
-	switch (cru->format.pixelformat) {
-	case V4L2_PIX_FMT_UYVY:
-		icndmr =3D ICnDMR_YCMODE_UYVY;
-		break;
-	default:
+	cru_video_fmt =3D rzg2l_cru_ip_format_to_fmt(cru->format.pixelformat);
+	if (!cru_video_fmt) {
 		dev_err(cru->dev, "Invalid pixelformat (0x%x)\n",
 			cru->format.pixelformat);
 		return -EINVAL;
@@ -308,7 +304,7 @@ static int rzg2l_cru_initialize_image_conv(struct rzg2l=
_cru_dev *cru,
 				rzg2l_cru_read(cru, ICnMC) & (~ICnMC_CSCTHR));
=20
 	/* Set output data format */
-	rzg2l_cru_write(cru, ICnDMR, icndmr);
+	rzg2l_cru_write(cru, ICnDMR, cru_video_fmt->icndmr);
=20
 	return 0;
 }
--=20
2.43.0


