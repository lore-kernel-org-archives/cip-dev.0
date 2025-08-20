Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9418CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:53 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.71])
 by mx.groups.io with SMTP id smtpd.web10.967.1755705952775270777
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=rr0or2TG;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usemfV04zxyTmHbQm5RVLz1OhlROqc6/FC2zD/XOMzSa16WdQveqLvchImPIpwPeee4dGeYm6FtaP5UeXwzOIg7Tharm8MC9pdxqpfbKU5W33lYCscY5Z4ZqbTonjCIpjZmZKkQqOIpbMl3qelTzUCEEoSpZXR1L58mbzjLk62br+axt0Z1qmK75a2iWyvCqRAD8vBYAmemwhoUY5ACcQRgQu8/nZnoZWYgAHKvKztB3VovaXcjHaNKWlSkgfPVBd+AUE06ocyeqzFLOeNctIBUz3cigwnOCUGRkao37zIDYtklcDclpjxH0otB14kYV7lJpVQT/HcASH/sbZO3VaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0S/dq9rRBTS1ePimSC/cWCrA3Smy//jbieclNJin+tg=;
 b=OCWH+r0CuFg2Wp8+pnc+GnE4Mhd9vaAPjGaq1wJUYYyYUKi0xXsJPQ9E9HZur4sUyyRrbhdjc0ttIhRCm+1RguIsKWcSiehZKcQ/Hqwbh61lCG1LEtRp1sR1FVzaK7o1jGoH74NcGP4/DtmUN8VD7SCJi7LJ6nbtea4VEvt6F5EPozo5XIriYEIZ1l8p+JUMjSoOPv2zFBDkKV+dk9+FqqCLPYdvvjU3LU43L0810Sv4maiTO6g8gW+theSIdiMvD60k//FHG9Bgq9u3zG76CRWiK4mxwdWrQ4wGvCQtOX/9MntN7SsWTDq16KyQaUJBRhS+bGigyHH2q+1Y+Y6cBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S/dq9rRBTS1ePimSC/cWCrA3Smy//jbieclNJin+tg=;
 b=rr0or2TGEitFcutJjDtm5IGJHzb/sM2qBW8X1NI5AAfb9ntx4GSCTuF1YNii1I5+ymNzXfBlenOOZvjLkiYfrPdKp0ZOVTBsqVgKoA7RCEtDithyTRH5ZgkQWYjjOA4Qg7LdN0CO4g+MLwHxB/D/C//Uup75MLnccBy4O9S5Bb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:50 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:50 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 28/55] media: renesas: rzg2l-cru: Add 'yuv' flag to IP format structure
Date: Wed, 20 Aug 2025 18:03:44 +0200
Message-ID: <20250820160413.801341-29-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9ac605aa-ee95-48f4-6dc0-08dde0036ecd
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3wxlFLB9b8zxa+fCI+iIDuAKc/MxFyLNM2sAGqo8ybS+otLXF7YLH3yNGTKt?=
 =?us-ascii?Q?pw/fdsk09JKGVvRiM7/WcVNSaylksfQhtIcyA3+NaOQnDR4sorYXsu1kEPHI?=
 =?us-ascii?Q?VH19+C8liGW/zZ0XchHYV4JVhnBn+GK7n9UmND2RrRjP/VkLBbF29DsI5lQt?=
 =?us-ascii?Q?5pGifWLCt2YcUNkAqi8dqn+4IbbSD6E1a1tvzUdq9ZnCIwAPkqmHbK1kIEDR?=
 =?us-ascii?Q?zqHQF7RFGZyIr1D3dHJq2F1bECb3X1eZSFdqyzP8JuV/ZBjjxDl57ajP6shs?=
 =?us-ascii?Q?Xd+oLCj7BLE8zBRc4GJJ8n6SmDA+ZjyxRThAnfF3b3EWtgabqnebOSBGRWGe?=
 =?us-ascii?Q?lBJRuy5a5nY6OqdHdqbdCNLumi7hAOZFb4mriEMgkayLN7KGeV9qOnLHHL0W?=
 =?us-ascii?Q?wkwKl+UGECTAQ6EBpTtEdT9Q0nYSJA3RarPnL+ZPVGXb1j29RKjdwghW/08A?=
 =?us-ascii?Q?mX81pPCEojXZ80m0AU3CllnCd5KCRnhUmJBCoGK9tK+uvO0YZ5CZduQRl5uk?=
 =?us-ascii?Q?jtDVJ8gvTjktY/UblqimFgA9BdqpQv6Uz30g7FbdD/+oZegpcs7xtelNDOCS?=
 =?us-ascii?Q?x0fv/++4sRjaEi2HC3mQwOWS0kDLgzkKSdmTBsQQffQzlAs8/R/wbviTWCFN?=
 =?us-ascii?Q?GbeLZmkWqEgpWJA66zih8tqeBCeju5nmIq29GWuJg8KgCX2Lw5THb0DGi4Xz?=
 =?us-ascii?Q?D9mMz+NUhtrUYlbioetlJOC0AWSvVja2Mx4hplTuwIsSOJ/mHcbpzqmf4ZBB?=
 =?us-ascii?Q?PTFTbLurQWDOnhi8pAYayFiqi+iCHRgPePjiZYbgSi9FmUeASYaZNZaM3YQm?=
 =?us-ascii?Q?QAPGNBe4xemDVnq/2IwiaIIM2d/QfwEiPPEezRsxTk3fBfkCkZ6EqgM/RNc2?=
 =?us-ascii?Q?QsDe7QD65BoLqTDu2MZ1oPXAEsLM3lpFfbaK7waa5/zhNAnhQYDi85NBiQA8?=
 =?us-ascii?Q?s0Axbf52UBLuXsBfm24qamm/CCMjcx5NPyk+vGIcjnpygpJsznZQc5YjSss4?=
 =?us-ascii?Q?KQkfkFAPYd+JhHn+1YzQbNQyYa3wrJdSPuQp5Bm7Y4jH3HuXQLVJi2IqnvSr?=
 =?us-ascii?Q?83QhO5KGzviTFxAGm47NICvcm3GWw5OUsfBTxNau9/5SjdDCyaulNf1N9MCt?=
 =?us-ascii?Q?XA6FjYXzT3lbjdidWzKIJ5TlTWaeeddCSOTb4uOOcggmG4lA+NGPiPY2/Le3?=
 =?us-ascii?Q?VaBb11KX4RN3cfDfX0Wv0YC18gYdwUZZbQkfbrKCflzHsVMURR5oL4IwKWWn?=
 =?us-ascii?Q?CChxCrO3gnUurBzVKMsd49AYUsA0eOR3VN6M9LAQWVloWosEzo20PFfMjIKb?=
 =?us-ascii?Q?gGBPKobpMAea9INRK2NYmemm95xBLGbOfMMXZUPuoD/R+9+JPzlvs+s7uRg4?=
 =?us-ascii?Q?zgtSkeY7luL0vHa86+WnteR1VT2TyOQKic/wwSguVyEi/FtlJbOoABh1Qilh?=
 =?us-ascii?Q?u8RMu5luiYeE+cV9ldHjD89LGnH2vsrRVqDmjU7VflNvaALYup2OjEbUWmcQ?=
 =?us-ascii?Q?+cqYvWZSf9pEHEM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?A/E8mvry6dcOFgCS7pKZDysEmdShb8DKVQnXKHyyDMppl6zH8SMhjd+I0oI1?=
 =?us-ascii?Q?CW70dQn54XEpxo+ldOSEKx1a70r/MKfxis1I63R1rufXWqbVrP7/7HqXhTPJ?=
 =?us-ascii?Q?zeRjwhikxb1qmT2eYLdxl4StEWuicg8H7/gP+0A0BNFyyL6zM1k9m+UbFgTN?=
 =?us-ascii?Q?k7p7R+0mKBpHW+ZSLV8sd0WsekVzxEp2nYM7JvkewcNrdlQiCfFM9ny6QSmp?=
 =?us-ascii?Q?NdHezNwSaOwZeoAXItpSsRMbM8AxGqJCWssRFKXH2CeSm/a1hxX0Vddw6zeT?=
 =?us-ascii?Q?MsGeV+/GA1MIDLGBzvY37vp/09hWIdDBjqGqI1upwwGhf/DFEeAav88DUGmP?=
 =?us-ascii?Q?GigoSLEX0drSqNWu4GesFNxAzR4C6UUksXpQ+IYhx5BsFnmXViFH5kSkimm8?=
 =?us-ascii?Q?6T+5q7wQYSKvvy2xLDoY/0pU0cYcW3hnh+9veD9srifTRJYt5J7vMzPmqSzm?=
 =?us-ascii?Q?jsUvv0zvyhVzRuQDI2s+2jZ9GJt29BhYsPbQT36KrBoYEO72CGfOYyudsugm?=
 =?us-ascii?Q?U01tUG/6YjA3s3voaBz5Pbv2FaIzKQMJYd6UuFeLgnU8jd2X5FBEB0inIpxR?=
 =?us-ascii?Q?fRlyPZVuO+M+Iqy52aB/jokJ9y6aQ8+HkI615UV/NdTeCNIbi8lmYz4MUyID?=
 =?us-ascii?Q?lOH53eJKJCYVlEN5eRnoPYtE5NLoratbAOyCnCR4IjT3MCzCObEwPPxzENpE?=
 =?us-ascii?Q?sPW46fhZs4iNHA+KGvq8xHPB1mCvptBq0NdPw8g8wahsOKsDJCCqrYCyZZQJ?=
 =?us-ascii?Q?H1PJGO0aoPA5UZw6v+TN+WAwcy6BLyxAcAKGF0kp85ujOL2iRU4waFEoRfs4?=
 =?us-ascii?Q?U7z+VglwnYtOjkKz6ECSoshNe3aa0/uPQc6NvdtJyxna96I+ZlCrM091jNrk?=
 =?us-ascii?Q?UhCLGqbj3KZspd9p20IjRWAwAUTuumFDfPKqiShMy199pb3PpOMi0HVLC3Aj?=
 =?us-ascii?Q?t10YtKI22sD8VYVQC7S/FkW44koz1SVLAzVkrT0T2VNbPKfqHcPQlEBiu378?=
 =?us-ascii?Q?IBe0QSUmZ+aQv+JUlmkPwmBnuyQY2htSXS6WY8TL0zatIEFJwqBREdeBq37q?=
 =?us-ascii?Q?TeuIeCBobh9nyvQjIflGTvC7o61/FyiX/Dsuc671GyHndzKyJf0XH9zYv63k?=
 =?us-ascii?Q?9vOpMloIp5M/ttxH2v8yBTmomLeDlshBzIBFB4ghb5G2JGl1tnbXrnPino9C?=
 =?us-ascii?Q?RKQGrnkkKDcXeUWgll2UinmNjCaRHsiR4d1/cRXc+HpMR+PZqHMgly4DW+nj?=
 =?us-ascii?Q?KMNx0Kijfxi75jkENdgegk+31mU4d8CooIThUEOeXMKedcrU9AWL0CyGrODR?=
 =?us-ascii?Q?k2BSnbrbECuzoBiUQpx/APqSQeofev4zQ1Hi7h1FAsAcpORq/u8E5FFtzWMK?=
 =?us-ascii?Q?w3/qd5bQ7lCDqYELmTISarvJ/CHIe2atM2VkMtQS1dLA+f26IaiMmWCeqBVs?=
 =?us-ascii?Q?sE3R34AmgY7JZVTYuLOAg8JHPy/pW8NIoBkQ1Vkta9aAWA6C0RC7PEbwGN0H?=
 =?us-ascii?Q?hhX2acT+PkVOibOZzBJfu4ByaoRdySQkEmwAsRLo6QzJzbNIvQEnI9XtfbRv?=
 =?us-ascii?Q?6fugRU4tvY5ZHK65fVBXfcpAPuOQjMFNgi9ZcstvTVR7cDq+mNLbh5JNe0Ju?=
 =?us-ascii?Q?XyfohJLFtjJjxgDke88cMNM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac605aa-ee95-48f4-6dc0-08dde0036ecd
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:50.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dam3hj1uCcYWzy8DDWvCyLmYNJmfzhGMe7PnPVTroUGnCRmo13S031GxKbjITj5USwBKdUdn+lqlhdvBDNHRZaxJlAddGdkFLgXijanqpCGDbrDJfjbrqhF98m4WCQ3b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19853

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 2269e399b3f0f9d474606cddd9cb6a833fc62b7f upstream.

Add a 'yuv' flag to the `rzg2l_cru_ip_format` structure to indicate
whether a given format is YUV-based and update the `rzg2l_cru_ip_formats`
array with this flag appropriately. This change enables a more efficient
way to check if the input and output formats use the same colorspace.

With this change, we can eliminate the use of `v4l2_format_info()` in
`rzg2l_cru_initialize_image_conv()` as the necessary details for the source
and destination formats are already available through the `yuv` flag.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-24-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h   | 2 ++
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c    | 5 +++++
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 6 +-----
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index e4c9a7b49302..c496a5f2fd1e 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -69,6 +69,7 @@ struct rzg2l_cru_ip {
  * @format: 4CC format identifier (V4L2_PIX_FMT_*)
  * @icndmr: ICnDMR register value
  * @bpp: bytes per pixel
+ * @yuv: Flag to indicate whether the format is YUV-based.
  */
 struct rzg2l_cru_ip_format {
 	u32 code;
@@ -76,6 +77,7 @@ struct rzg2l_cru_ip_format {
 	u32 format;
 	u32 icndmr;
 	u8 bpp;
+	bool yuv;
 };
=20
 /**
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 581bdd372ad0..4094a480db21 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -18,6 +18,7 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_form=
ats[] =3D {
 		.format =3D V4L2_PIX_FMT_UYVY,
 		.bpp =3D 2,
 		.icndmr =3D ICnDMR_YCMODE_UYVY,
+		.yuv =3D true,
 	},
 	{
 		.code =3D MEDIA_BUS_FMT_SBGGR8_1X8,
@@ -25,6 +26,7 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_form=
ats[] =3D {
 		.datatype =3D MIPI_CSI2_DT_RAW8,
 		.bpp =3D 1,
 		.icndmr =3D 0,
+		.yuv =3D false,
 	},
 	{
 		.code =3D MEDIA_BUS_FMT_SGBRG8_1X8,
@@ -32,6 +34,7 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_form=
ats[] =3D {
 		.datatype =3D MIPI_CSI2_DT_RAW8,
 		.bpp =3D 1,
 		.icndmr =3D 0,
+		.yuv =3D false,
 	},
 	{
 		.code =3D MEDIA_BUS_FMT_SGRBG8_1X8,
@@ -39,6 +42,7 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_form=
ats[] =3D {
 		.datatype =3D MIPI_CSI2_DT_RAW8,
 		.bpp =3D 1,
 		.icndmr =3D 0,
+		.yuv =3D false,
 	},
 	{
 		.code =3D MEDIA_BUS_FMT_SRGGB8_1X8,
@@ -46,6 +50,7 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_form=
ats[] =3D {
 		.datatype =3D MIPI_CSI2_DT_RAW8,
 		.bpp =3D 1,
 		.icndmr =3D 0,
+		.yuv =3D false,
 	},
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index a0fd84e5f242..5ded0a1f5626 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -210,7 +210,6 @@ static int rzg2l_cru_initialize_image_conv(struct rzg2l=
_cru_dev *cru,
 					   struct v4l2_mbus_framefmt *ip_sd_fmt,
 					   u8 csi_vc)
 {
-	const struct v4l2_format_info *src_finfo, *dst_finfo;
 	const struct rzg2l_cru_ip_format *cru_video_fmt;
 	const struct rzg2l_cru_ip_format *cru_ip_fmt;
=20
@@ -225,11 +224,8 @@ static int rzg2l_cru_initialize_image_conv(struct rzg2=
l_cru_dev *cru,
 		return -EINVAL;
 	}
=20
-	src_finfo =3D v4l2_format_info(cru_ip_fmt->format);
-	dst_finfo =3D v4l2_format_info(cru->format.pixelformat);
-
 	/* If input and output use same colorspace, do bypass mode */
-	if (v4l2_is_format_yuv(src_finfo) =3D=3D v4l2_is_format_yuv(dst_finfo))
+	if (cru_ip_fmt->yuv =3D=3D cru_video_fmt->yuv)
 		rzg2l_cru_write(cru, ICnMC,
 				rzg2l_cru_read(cru, ICnMC) | ICnMC_CSCTHR);
 	else
--=20
2.43.0


