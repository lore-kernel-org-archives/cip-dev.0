Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1664CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:43 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.31])
 by mx.groups.io with SMTP id smtpd.web11.896.1755705934534822841
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gpvfHmrv;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.31, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCRcozK5W1TyIPwdzg3AeXT/THmrCfk8TALZp8M52PdJEzGLf3o2ywJ5iqWJKSWclwjd0eaBmU5EflJUWMFXSmibH5G+OCcxOo/vGDQidlhtA+PpOUqaD8rMmlk6kPTYFPIVfbbKsr+RUwBV9UNMkQnaWs718Zv+dhyLEPj8/BOluVic55vLwtXSJ2b7tx2I+qT8QgqvosHYCgPLGHmZj+7hHqZ1z7cZNBr5cqg7Txi+q2Ckb7NJKxsnueH4qjlPmuZeB+c2hQ3Uhhi+JBc6fVSaVAlYRhHk9ua5Kjkd8NEsgYGqSrXSEUM+J0UCNMaH3qrjqDf3zdFKtCoYxn3g8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXe2ryLmmKwXC2wEnkr85pyski1Io3GvQZb1jQmBzSE=;
 b=uvwwgAFN+euJmzkXnL471vp5TcWvzSyYuCszYdkXTfwLKIfgWu8AVNn71FncyLG+QUEFRfznlXuDQ1QUXyAvt9WWyILiZ6m+UaXDkgCGYhVqFF5qC4s9KDe2WlOTdnPwxijG1gjOVJv1b+qgpCp8LDH7+Qe+9X94DvQRt3aKATvP2MajhV1iNkmT9Hb0c7c9Y4K09mt+Xtm4RwDTkeIYHlu1VtUnbAqyNf1WsDlpklPERfVBmYzZFdBY7+OTX/b9Aq0uJPZCzVPU60P4cvpqqfIbCKuIMzSBUfXqVrgSlhEttlkCl+hrmuooef+dlVH/Z5/Jh8BjY6j2TXyfhKnQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXe2ryLmmKwXC2wEnkr85pyski1Io3GvQZb1jQmBzSE=;
 b=gpvfHmrvCO/kLzUzjay6EvnwT6vHuT111BoKETFZE5IpFClKN/ykp5RngRUo9XAgAayosxSFQ7PRpbkYV6fH8ZPcQ9xqbpPmWleRnP0yqkFLN7+YXia6lWfDY8QE00aKx+oiofzgnCjmUaOkpbDGOajDrqN5AG7OfgFAJcsoGkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:31 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 20/55] media: rzg2l-cru: Make use of v4l2_format_info() helpers
Date: Wed, 20 Aug 2025 18:03:36 +0200
Message-ID: <20250820160413.801341-21-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f888f207-590c-4df8-eda1-08dde0036300
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aIXwQf9vTX3zO75clmPSRCUdkO+74PoaMqYT0H2M65ItY5awri/F2f5st+Q3?=
 =?us-ascii?Q?yXNVLzuS9tz3KagAO48g74gHNyRUW1qnLxi56q7N08C2Nm4VTKnLdR5McJeo?=
 =?us-ascii?Q?kSPIeuJ8ECccLfX22RiwXltqmtRzH7XR0w95apJw6GhFogcwH30tIVPALo7k?=
 =?us-ascii?Q?8lPCU3iHryhZgAan7T0CbP0bbC3550emMRMwg8lAcARij+tOIc0+1NnDvkwW?=
 =?us-ascii?Q?fCf6ky+CqMgJllh0IwZ1abqILuISCoz2B6447eRcABtSCzcbTIsJCydwK8W/?=
 =?us-ascii?Q?m4prvplPGfhLoyAh1zI39UPVOqzQ5g8cp6n6Sk4GpCpfiwq9tx7UiowQWQxw?=
 =?us-ascii?Q?mP0AtEHVL52j81NruPSkNMc0wPg3n7Tipr3YaUlAQXLPZC2WknFFTx/+q4aO?=
 =?us-ascii?Q?vWPeigWQJYQuUuWu/zzLK+SCIYK9w8HXIbcJXLqF01tASMNOEAiCLni4ww8P?=
 =?us-ascii?Q?4JL24FuDa9cr+AUmAunaS9Kfpka0ytddcwSzOkaAccBAy5ZR6LO8iHbGcEX/?=
 =?us-ascii?Q?9MyoHmq2oi8tCNdPJKTkALNdS1fxPLWlCpYHgTI1icEu9N+ETzUadjeHY6Cf?=
 =?us-ascii?Q?JAji1hIu4w2NhB1kQBNdtBx8vpzEkihO2w38uXru/l3FuNMYL+NRQJprtOBp?=
 =?us-ascii?Q?i9JaXA2PYO+wMkJv74Xt3lKX2jwzL0TTMx2l+XeWj+Cy4nmoOuGyDPvl5Qwf?=
 =?us-ascii?Q?98bfLFSIEhJex5/84EmWkVFTofqz15jfGLE8r4Z59buwZoahEXwJJw8JRh/f?=
 =?us-ascii?Q?1PaRaTHYqsBOv2lx32N5vYFqCvWgWhekRUZMZbkpXQKh7LCzwF8UT3AJtS0z?=
 =?us-ascii?Q?z1ZPiEGcDv1ToryKxQ9vhSAYF+d5TBvMVWlwGNnq777SQxIRpjRtBtAzIkT1?=
 =?us-ascii?Q?GLMOq8XAk+PoHfd5S1k7ls5DD1s0TIpvYskPvA7NuMPY/mD3mithSznTWCrN?=
 =?us-ascii?Q?RLDfydwb+3AWH6SrNewRv/bnEP6fEg+aTt1ZzMwyA6FQ1WIeCLp4+Sw9OklE?=
 =?us-ascii?Q?E2cvmAhOF0CQ2q55bYcaRnXaJCtgWBXFmzmkeHkb5BdXLQQC1mnW3zkZswua?=
 =?us-ascii?Q?tW9K4gac6n6yzHJqBPUE0ArDGJZux22dndHhvw6dUaayPbHt8fserX0Zg32f?=
 =?us-ascii?Q?1+V3/5DWtMyGYvLQmu875gBWqsKLR+pwdbjvoNlFS6Gu9SPZ1OWr3FRnN6iM?=
 =?us-ascii?Q?82tyJWwrSASsPojJ/ItqQM/kWR72dk+wzwX253Z9uOU3Qs+0yr0ai91lRNIn?=
 =?us-ascii?Q?NWNvXMIhhMytdwAkUixArFZtSQdx3QhWo9tc4O/LUi1qKM9GPOcAckWSd5wV?=
 =?us-ascii?Q?H2uZwRRDHJHOgYjJw6L3VltG2hNDNxWNqtaC/i32Zk3WzO7IQpjFAZaNVgNV?=
 =?us-ascii?Q?8N6AVmZBbNrDMYfecDu+qa/rFhSqtxV4W8XGybjRsvdOjvHHBT8DeoQQ+p0V?=
 =?us-ascii?Q?eQ7ymGfK05/T+4Ky4BoFnBGXtoMFsBKFWQXIIwEo7YYzf91nE0P571JMSEwt?=
 =?us-ascii?Q?F6qv1FYOMjqQAv4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CpxQ/TqBmC/BMDeKysZ7s2sOpGQp/wF6t+qw1ZMOSv5xFKD4Sh75TwMh7s19?=
 =?us-ascii?Q?c/rPAJRT6zzCJfZ6U1lUgTe2pLzK88PXWVZP+7pmzmqxyb4UpB10dE0J5V4j?=
 =?us-ascii?Q?s0YSkbdwc6n/dRoLbY5M5IUIE3TY1xntTPIsfs9F6yABF822Oi0NHMHLiPmD?=
 =?us-ascii?Q?tXpNTgD+UdF3IwsG3FxGA/t/3U/O7cPmhuopcmOc5eSMQBTdGlF/ZEU/MeeZ?=
 =?us-ascii?Q?+GdxoD9H8HEB8lz8XmSl60dwav9T2piN3KeIYoEwPqlqYXIxRgV3auluIob6?=
 =?us-ascii?Q?8HLXrWUOCE/8JalEDU3wVmMWFsVh9LnLVjAkVRr9v8RPXmZ1/0j9LPoW9Cro?=
 =?us-ascii?Q?W6tj46HkIKYoiax8sOCPrzBbqSenx8qXfWda7uYfjwfXkf5mdAabpay0UGbm?=
 =?us-ascii?Q?Mo+myNvrFBG/9PnSNhXgPm5J7YPOAADmgAFqbpek+VfLsX0lw9gHOQSLM2rm?=
 =?us-ascii?Q?7DoKTdjAQGTZN0FM5f0o89mt2iE4jqK2zGoIs0fK0wU0TqiQr9P1v0MHipQp?=
 =?us-ascii?Q?0VY5EfbZvF5HOnWKyoyljCJme7f6vZPkeGJlV9FP1s4ni4GwDbUF7qbb6x8i?=
 =?us-ascii?Q?lG0fY82nSnBkkkFozcTsVrozIWqPTbvmCgUevG49uhoR/K8+jYaK9s7ztK27?=
 =?us-ascii?Q?6pKG5fjTnpjnMI4NHWVemcFHNRZndcD75HAmEdjakXDJCKHoPf4dRnwzCwD/?=
 =?us-ascii?Q?4rk4GuhUuPBVNrJcCC4HDD1WUmMCG0bP4CzTBfqCcC6PBkq46kANStq2jpUf?=
 =?us-ascii?Q?P3clTZurFW57q3MuI6higSxNesGl4SyGY94rRz1DY603epAbvwuXxbw7NE5Z?=
 =?us-ascii?Q?LX2I4xo9bEZfm3eIVQhO6Zgfr8kgjh3qxTOq1Y3CHIYfoP1g2WiTZCTkb81I?=
 =?us-ascii?Q?xUeteWRsQmFgojpPq3pHWPpnCLFzV36mgjCCUHP8ZjhgsOsblLiPZkIxtQzS?=
 =?us-ascii?Q?ReKlBFFEEK4pzS9zEEjiYRcH8b88+1AGXKQhQ0ZNGAv0Nx5QIhF4roMI7MHH?=
 =?us-ascii?Q?7xs15pjlqZYTKcFDRt80obgqghUxo5Ew4iSZHbPQtkGIikIPi7VRPB8E/PM6?=
 =?us-ascii?Q?uQRkDJpP6QEjAjNT9gEJIdp24JTV/0lwnAaiVTJtFpxbdJopIIpaGqO88rn6?=
 =?us-ascii?Q?cmXciJNne5fDnKAfx+y8dvRAFGhi7uDuY1vRz2l/DZ9+oRKfnEybeeUxw63P?=
 =?us-ascii?Q?doMNMGgXZQDy9boF3uIPANFjamLIeKURp3xW1SoIzP+POD1/qPDt9qke0RPP?=
 =?us-ascii?Q?ep0MKRlwZnVWtjbLY62Ej9IssAbaHIA0cdFR5Zjjx1oNXMo39X8pijSw5HCi?=
 =?us-ascii?Q?uQZuNGzDDWg3Bhgcb5yspPNu/1PAB0dOsZDr/hATklxJMbT1i525hX0BoKI5?=
 =?us-ascii?Q?mfg/6rubo9QAyj8h0uEscuztVHXlX3KPcHo5W2VDy1NfWAbYnA8s6FmqJGaY?=
 =?us-ascii?Q?vcLVIU7rmNCMvWSbMXhcDbbf9VIkQbt4ri3mN5nZ4WMwk4KZ7NokTCyHIhn6?=
 =?us-ascii?Q?vikvejPVbqGN7AAXSW9etbR6GUX0luFn2qO9ZheV3yVkaR8bForM3X3UmEBy?=
 =?us-ascii?Q?/PD7AiWZweGUWe/SkEtktKyjMKmO1U1dUXfnlQzwOlX1qCq2P9eaDPr8lw6g?=
 =?us-ascii?Q?PubNSAqNNyFu5PqZNTvUtq4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f888f207-590c-4df8-eda1-08dde0036300
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:30.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baTzdjUhiGuLFBYqjLQ7Xo4x+S/AWkp5iI3uXmeEaqUnSxEshWShzF0KpcTh75RGca1tStcO209PW0Tn3l1yFobgkL+7HXT1yZnzItwd7N4FPO/4EzLxXI8Hc+j5zluV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19844

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
index 0b53e035261f..7d7f3329d93f 100644
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


