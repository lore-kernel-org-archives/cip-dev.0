Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.430.1795708441471882653
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:54:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=cM8MrrFa;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL775RQ9NuWjrYFBtd3Z1z+JR0jhlJUkmz8T1hnZhcNpAdt/3QM5/9WFfQqFxoUGGhClAkud99AgdcHuQG/+iuUWfwqaFWjFoLa/r93MwsncUh5pYQndfRNqlb2tV13jopKRSLCjn0hG2x1W+B5WHXcabJZY/3CjlkbPUv6nsTrkLFRzMBftPrNlVLtHbdVXBtdNoQYuZAxclymCGe3GcideZvsntnDbEQRCW7DxIOqsvPgJg9UbZdx20O89JkZLV4k3vuYqjSoTnD7Wr1eNWRqNtXj5p6q6Kq2N2rPlb+CDNgIEe09SAhPbKiblV6t8j1uN88wQYyr93pJiOZhv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaXPs+fpoa8ry7hfPDNC+qmq8ULryAFHu0eRVBlcT8Q=;
 b=Srgm9p5o9RUXey70uv6FHySNo3Aj/wpY/UmmSLzq0v9lzplMwqWNpDBt+Wfs6RuJ2qyKaJsMgtDCegcCJcL6mN0k2xfw/Z2ggtQwnAwSoBThdhyf6Rrqh0J/veb5StERiUz77Q2DHt71BG8RGh8c/CJVQf2FHokuVI+L2f7TzYEe5GYm+ht9xi7/t682FcPVR0GyyZRFT8hmVQ7CGAEU5+KwdUucCU8/ZrF8gJvgUtgYyzA5Fo/X8fPZWYS2z5U+17bp9Eb/feWVNr6bhcYljN74djSldOlXvxq+6D5DJrIggB0PI6rwm495gI3ocTjaKMkrSYW57OORU4MQQzb89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaXPs+fpoa8ry7hfPDNC+qmq8ULryAFHu0eRVBlcT8Q=;
 b=cM8MrrFaaQLzFHpo4V8g7xyi1+/Rmk/D7KqBSi/FMg/XddKJNwpcdixCsdXVZdUxLbfZOOcH36DCIUDgmhxtwKNnPGHQrZKoaVrKcdyDMCdqsCOu1O6mzPyNGjTmGZ1kjJcPXtc3ckJ8C2sR3T7PyAC5taGMrZYg4Q6Ul+q1sjY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:54:00 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:54:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 04/12] ASoC: renesas: rz-ssi: Remove the rz_ssi_get_dai() function
Date: Thu, 26 Nov 2026 16:53:13 +0100
Message-ID: <20261126155321.3834347-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB13015:EE_
X-MS-Office365-Filtering-Correlation-Id: 854f7285-35dd-4a6f-bc37-08df4bd57c9c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8XGpdzSno1kcwBj6fi0m266sKzeq4y43azjByBqHX7v1jIeNRK5WzgwkgChHQDRMjD5A98X7UVXU5HQvnM0mIGTOEVH5O+5aiKiTALUcpSBl50Kj40jSYnaP3eYd6v4Mes3AJSt+L6tStay+K4TUG4E+Q+lXFwZnKYia03UChbyl0IHLWL+uiGOXClK6WNUZzI//sK+2Z8Y4dZtaAo7NxGE4exPU9wWrXoAPGQFtlCYLpv/NENYtdtU5+knsv4xWfLxEDzwy4xmwUEeNrtxU9Qr2LcauP/K80f6Mx2hGp75K3YxnqTXY8cSdwzcqPmAVWd4nhMvwwfrHHQCqOUd9V250FC9x9Idu36w+NJC9UEQp8d7/nN/m+FCJHlE+z4Uhtqvt0UKHHR82YLEHpnZQuYJkr4jNAB8IKvj8RosgvAnPsY0yqtKrPZLynwvWZPDWTFAHVR9of3tDisPJI0s3d2HGbmDdrLWyBm0AM1aNniiyjG/ex5jk/2RI5bf6WjRJwgnGOFOIL9As//XxmWw7BtacllU6wZE4i3Vy3KhCosh5VuVXRIkvF6mseN3lL0SzWNxHkkRleMx11JlApIu7RX8LpYnxJZV3eWTFtWJdK60Th/MxBlHuCe+Yc79iUHaRKH+BpNsW0IPBK/lFQw6+PSZTLGRscaMNu7K+/+x7TNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Byi84v/k+sC85YSdXdsgX/DMIXalra2cgRRZ9RaVtkSS+Br069P2NbCGc/29?=
 =?us-ascii?Q?6n/ljh7doYUU+X9uKP4Bi3Fml43KIGx94VkQBvkCe3ukOYJzT84XBRfCXjCi?=
 =?us-ascii?Q?EwaelEjEBxZB9w9P23bPJ5SyYruv+twYlhxeo5ZaOuqy8SZlv/Ab8ealQ7vI?=
 =?us-ascii?Q?YL3trIbyunIYK2aIKCEyZGrt/xws0ItWfVcTkrqNXhVYXg18Rc/Frx1H+tv/?=
 =?us-ascii?Q?zg4N3LqxtDyZtykjxyx4F0/fhQTFYSyatp1uxvGAZZ4bauyviGjKGfWGf0mE?=
 =?us-ascii?Q?S8mZV2fJElGBrHkobWikVzPKBJtZsbtJ23veWyKrQCKi3ToTTLjENumGkimS?=
 =?us-ascii?Q?xP/aOsGp+YFj9eC1d5A8bK7syidl1vO47YlSzBwyPJJHhNq/jglNyRuF7Mj3?=
 =?us-ascii?Q?fUe1/f5xOHAN8C/jigyxPXn6eFVJXOCLkAM2tpG5O5xIfR9ucJiNisRh6ki/?=
 =?us-ascii?Q?yTcOA4n5qhEckzN3QKhd3cW4MOaJxEbm+FFbfEBiBWzzK2YY+W0905UFqtMH?=
 =?us-ascii?Q?6o8II6djOSIP70GZIkksI1h885K1xlqnSle2kMp2F8aFVaa3xOP1GTYW6Gy2?=
 =?us-ascii?Q?d6tPtg/1OkJ6G2Jk6RlwIDt6DqUlSnFqeK5c9FFWUfzKRg2S+ShoxUocILW6?=
 =?us-ascii?Q?QSTPeGDFxpBN0PLmGMxifmLIiARDNU5z+6vAy2DKLfNM7loickgvf5hL+PH7?=
 =?us-ascii?Q?NE2O8VLTzgcsiYq2FhM2CalDW5sHfw+Z1s4rWSidS7AKBrWm1ofUtuNfKD8b?=
 =?us-ascii?Q?9LD9Tjreh5JvDaNkJRWiDfTwSVUj5ALLXYeL8vwmHNVZSuMX9sI/bc04za/C?=
 =?us-ascii?Q?7bxlNqHE6zmtutSBqZLM02g0GN9WUsBMMmAzXVrtayFtFfZpAjlwDDDI7M3C?=
 =?us-ascii?Q?TR5w1zAFzwTqL5n41pB+HgxoNBLDF8gc6EuJgKUlZ5lLmVV47IGWu0I9K+4M?=
 =?us-ascii?Q?Qfe6rhlOBCFXcj6R+mar1R4hjfOFOUTR3a4a5gA3aCc1L1fqY3Zr5KUfrJBR?=
 =?us-ascii?Q?+dSXlAYRBnmyJ/Q4Yf3F3/Z7/urkYeRxbC+iMzwd807bizs7+3lpEFmRaB6t?=
 =?us-ascii?Q?fZAH1rSZzXeLAC9rWQDAVpuqMDlnrAftaU8pP5GPKQZiIpnskgZcqEmRDdkz?=
 =?us-ascii?Q?vO1BJpGgXGuXtyVgA8JaC0ig97bUQWfXaIoXiumscaBVXJpTNnWrkViMoIKN?=
 =?us-ascii?Q?w9uVeiaiZsgR+RWII/DJAKqFaaocdVSlERegkR05CPe4lNclrpP30ZF2TPrI?=
 =?us-ascii?Q?8xMkq/8yfPJCCZOtRUgv0CSy34VIBRq5HHHM0O29zUZg1ma/RpthCU+B2ckG?=
 =?us-ascii?Q?FhzuD+dnU500aJsRf5JKzM57nnlKN6iUHAf56auuU+xhTrh8xkp0NMaAKGNd?=
 =?us-ascii?Q?RdzsRFIjduARTOXOjcGkuYtjmfMb/OlmBpA2Pei5KzqSA3KLoboj97KqMnFu?=
 =?us-ascii?Q?Edf0wX7j2WtgLuv60wD7V8feLg8w5RX2VdrCm8nqE6z032LWG0Cjg6J81HBx?=
 =?us-ascii?Q?KIrLV5UEywAr0oterLFOv5A5KO8WAmSRepCGDznFs6kzJ0du/OHfijxPKtPY?=
 =?us-ascii?Q?/tUC+GFZe0eAN7pyfN0FJOHC24bwB51620H3OJcEViFkGdmwGce98EZJXKcU?=
 =?us-ascii?Q?tRXk8cskz7UAWi52y3YvCroXVv7Dic4er4iBPUwI6C2F40Fw6X7e2BGHD01X?=
 =?us-ascii?Q?Smf1PS3YSnhNpBg3Ol3ZnVM3nQCU1gp/4gVHQ/v9QDx19tbUhrN+vzHJrGKB?=
 =?us-ascii?Q?b2wOUykTB/05At+ZNL4R+1Fp/A/fwxLD++gYpBka7Vr0eDeK0vi9?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854f7285-35dd-4a6f-bc37-08df4bd57c9c
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:54:00.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /M2uYdex4P5DoAYTNezG3c2Gq2rQ4WmpPeyLwYl5h2ZRgiD3vm+7DdvJcR2QceYYEuv2f/8KskqN2F7+mUgvTGjrrLcB7PQpWmJFyDUc/5DtXaokSN78c3avjVOoeC0h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:54:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25182
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit dec61e16e72db196e8dc1daf7f7022fd98e6d921 upstream.

Remove the rz_ssi_get_dai() function and use directly the
snd_soc_rtd_to_cpu() where needed or the struct device pointer embedded
in the struct rz_ssi_priv objects.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-9-claudiu.beznea.uj@b=
p.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[tm: Resolved context conflict: the local rz_ssi_stream_is_play() already
 has the single-argument signature from commit 109e60866f11 ("ASoC:
 renesas: rz-ssi: Remove the first argument of rz_ssi_stream_is_play()"),
 already backported, while upstream's context still has the two-argument
 form. Used asoc_substream_to_rtd()/asoc_rtd_to_cpu() instead of
 snd_soc_substream_to_rtd()/snd_soc_rtd_to_cpu(), which are not
 available in 6.1.y]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index d1e21e08bbb6..401fce5b1918 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -173,14 +173,6 @@ static void rz_ssi_reg_mask_setl(struct rz_ssi_priv *p=
riv, uint reg,
 	writel(val, (priv->base + reg));
 }
=20
-static inline struct snd_soc_dai *
-rz_ssi_get_dai(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substream);
-
-	return asoc_rtd_to_cpu(rtd, 0);
-}
-
 static inline bool rz_ssi_stream_is_play(struct snd_pcm_substream *substre=
am)
 {
 	return substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
@@ -245,15 +237,15 @@ static void rz_ssi_stream_init(struct rz_ssi_stream *=
strm,
 static void rz_ssi_stream_quit(struct rz_ssi_priv *ssi,
 			       struct rz_ssi_stream *strm)
 {
-	struct snd_soc_dai *dai =3D rz_ssi_get_dai(strm->substream);
+	struct device *dev =3D ssi->dev;
=20
 	rz_ssi_set_substream(strm, NULL);
=20
 	if (strm->oerr_num > 0)
-		dev_info(dai->dev, "overrun =3D %d\n", strm->oerr_num);
+		dev_info(dev, "overrun =3D %d\n", strm->oerr_num);
=20
 	if (strm->uerr_num > 0)
-		dev_info(dai->dev, "underrun =3D %d\n", strm->uerr_num);
+		dev_info(dev, "underrun =3D %d\n", strm->uerr_num);
 }
=20
 static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
@@ -1094,7 +1086,8 @@ static int rz_ssi_pcm_open(struct snd_soc_component *=
component,
 static snd_pcm_uframes_t rz_ssi_pcm_pointer(struct snd_soc_component *comp=
onent,
 					    struct snd_pcm_substream *substream)
 {
-	struct snd_soc_dai *dai =3D rz_ssi_get_dai(substream);
+	struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *dai =3D asoc_rtd_to_cpu(rtd, 0);
 	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
 	struct rz_ssi_stream *strm =3D rz_ssi_stream_get(ssi, substream);
=20
--=20
2.54.0

