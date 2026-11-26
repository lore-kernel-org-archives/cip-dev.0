Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.6])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.292.1795708133632189477
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:53 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=WGe1KmLh;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.6, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBRxKOlpyTltDsVl5EH96MxvNN/sZFb+mbQNlkYCJatgjGpoSjcmf8Is+gFVqiGxP8oS57DPw66dQvzXVFkrf3GE94ld3Jz5s8Zn9CYoSkCi2tRD6u4sUSHqnmTVa2c900425bVr2blXCil/9O2ntTtwBX/+RLuhSEKDTebwFsmsqjq7e5+lGKaR6vREJkKnAomD/0tAfY8Q4m2ia/xjzYQMOYTp5z3pGtPlQGqTyKuTu4Gn6HhdU3H3Bb3AmxIkh4RkVAJFsTSrIDso5CceC6KByJOPz3VaxyDq31nZrxd5wXgNDn+9SzctPB5VixqIfc1i/M0BaFpGsZcCgrzi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds5FKJerjMMQ7e87hvoEoZezNWquLhZGNQ5AdEUAd30=;
 b=TiUBC503pr1ZkKJ+rzTGwBIVdCNfs0Rok79sE1+0tHM6GvalCV3fdjEvGMuC2FKM48slv3SPvC18ZBjPGOWQWo6jhyDPA+kMc1Nd6wWjDaaq3i6CtrJ91QTWDfF8TyzpkR2f7bigvawGbanEeFjBE4DeWxAc8HUvmvNjQM1/1eG+wgknrbTDDMRoXSpZn+guIZO573xPcU4P7Q+tPsEvfZW6b9G5iXdgR1HaSYvM5296ZFkZmoZHxdMLojH1x+J/9VabrAhOWuq03VuruP2XHCzapwx59JILSJlDjqGJtoNdLWEE1x1LEI5j8W9Y7Qspy4ZDcjCL6cz8Gy4A4zrSvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds5FKJerjMMQ7e87hvoEoZezNWquLhZGNQ5AdEUAd30=;
 b=WGe1KmLhKdSk82wrOXQbwwhGhc+gGYaePUkpL/S6HwLj83H8w/CVoSxxmqxOuonyedblsGaTCf+8j/DMjtthAfbhyKN8nR56InloIMvW5evfTOOR0DjXb/in4WV8Do1oWjBqn2llwvculRgVn2s/ZXTQdF8CZCWNV2i767q39KE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:50 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:50 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 14/27] dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
Date: Thu, 26 Nov 2026 16:47:34 +0100
Message-ID: <20261126154747.3832917-15-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSCPR01MB12784:EE_
X-MS-Office365-Filtering-Correlation-Id: 5569d6ec-5d98-4bdb-6ae7-08df4bd4c3ab
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009221227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ngu4X9jxkwEEr6oPNylb/MoeI4mB/GLNjQWhQq9w22LnQ7yJPGXLsjRE4Jw9/gkLzTW42ezUZQVGj1xPRBF2KYbAAX1f0eDZgLlbUKEOJC5uzZIBUHfbvZl1/vtAOR6uhPQ0EjFgoeOL/qNY/VbyRaChspmtHGY2iokv84832kjyG+PeJELJZoUAaKFZzws5O/UQI/YqzdxVYqU+soDJ5z6Ziqra+g3ceD7R4wMx0T2Us1k+aZiuyX1tOoWzg25vWQws2QWnABKksY1wRRNU/r1WySXbkk87dJuq+LpcZeLJIs2JZ6o2bY0F1nOFJwWWneEwss+s6Oa8lMhmRc61Kv6mTkR0TiKx+DVlnjVfepWrRH7mvzB5GeX57zNvnSeWecLGaYsOmRCPLrVCJQcuGIv6UrMhQeWbuKYqRV7eHnGezmq4uO5J7LGy8pWbrycUA5gqpsaJV7cHTYK6AoXQcqhVo9BFsdXDe41HEiEitRUZseao/VTO0y0Sh6Fz3pvf0Dnu8J2sjwZ4Jp+68he3raIaUjgSsYRYhko7Roqf7oLZRgNfkMJraFvuc3LbGS6kAhNSItuFhpqvgkdRBaEkNQVM46x1ZJJxvnTQpMTHUb3153LxxU7dgjV4vThfsF9MXaU9ELUMHCJ1P+ftRNB+3ocqYoP+VpVvhHYnQEt+3ZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/5OsxxPM22BVv24mLcI0nSFLSXERcEbpKgtzfY15HW25c2fcX84B8q1Kf8Lr?=
 =?us-ascii?Q?TlnVtaPsRFLvM2g3fQgSH419xc2YiOOaujehPXEMZM666IRieK61dhmiOX8F?=
 =?us-ascii?Q?+xF10PJxqqNjjpbgg11uT//XsrQ4J45+DPli5B0kvfpyFilrWxAc9C0/NFR5?=
 =?us-ascii?Q?H0mxBpJ1mB7LzuXGPUwysMlWnN742p85ixAOZaweKSKt+yICJ4Jd5aqYKYia?=
 =?us-ascii?Q?aq9JNw6h+QpPc9PR3ippgWFZxLFtH9mHmBKD2GJYPfqxYV0xAN27Pr3/HGtO?=
 =?us-ascii?Q?otA9f04AQvawkO6GebD9rIxqJ6fgTXQfB+/CvmQMtKjyWnNSGnAED0QdO4UO?=
 =?us-ascii?Q?YQu9muAZi7s9YPT6quIFlZLyb82YjIOsJdUt1uKqfyP0eXtjlSOFhr4iEPfT?=
 =?us-ascii?Q?GEfY+vjlBDxh3Do9lYkHDXqjtLwVB8sxwfHsy9vlTLAMfEqsXn0QARhAuNJj?=
 =?us-ascii?Q?Bvah+07VG6Tu0Dq5R+zAlIZz5mdoMoOcibDpw8bwyz0JNl1COuG4ipMQ58pZ?=
 =?us-ascii?Q?jZUXOxJHsjebSHZPHuYyOPrVH1y4pGVp4iR9qBeffOhtZ22WeOpgR7TVgFmT?=
 =?us-ascii?Q?9Vpjc7R7uUCbLF4yxlUxkZqTg6kyu4lj74wp8ahSzRzJq/ayJ2/r5urf8bhH?=
 =?us-ascii?Q?QLVUGie1Ze3n+Sy+CV/r/CNxvbFEQ/zDiEKqhxtelo9Z28NNc5GbOr0bFvkl?=
 =?us-ascii?Q?lir/rDF9RTCvP+bXGQlZHjT4T0VrzBNxNSIVqdSh71nvKOWPnbD0QX+ecNk/?=
 =?us-ascii?Q?bMWLPaWvFocBu1e+g8Xl+YkBiYHGFfHxyHr1NVNTr7A+ve1BcAWV693F5o5v?=
 =?us-ascii?Q?gw1JTVzDFJLWWgB0Sn0c9RIor7/VWLaMTyndSEfJfeRAb1n786iWy+KbU4SJ?=
 =?us-ascii?Q?1rzuMC8MPavVxx+lSUnK7rqCkgqZWo6OKjqjErky0T6PsvaDXSecJy6q9JE3?=
 =?us-ascii?Q?Xc3TS0AB2BvNHDtS0RjbvgFIJvmSU8qkgMZ3NbYgrJJVbD9eaBe3z0Lum3sc?=
 =?us-ascii?Q?377C2WhDhdeTCikP3ztMMDGqOjrfDCPa2FJcN6Ribe3RERBQeR7wTXhzcuc4?=
 =?us-ascii?Q?YetngSGeJ4Gg3PAaeDfisZFs/3knLG3cE6MUKjpcyTMfUfpfDk9ipipTQQja?=
 =?us-ascii?Q?OycDDyuQeJvkcGWcxRh+mzGlWrh920KbvHAUYHFotPJ6I/xlvKu5exvSVOH7?=
 =?us-ascii?Q?C/3YmstSGPOCaH36FQ8myPAt8I0hL62qEbToWEuo9oDUksaUtWP4vFFzNdU9?=
 =?us-ascii?Q?+FYUzIBAI1KoqcsxCjJCtHftE/XqhXBM3qUyCp5wwWPeh5D0y6YY/DlNUrHn?=
 =?us-ascii?Q?S5lIoXSGnn18WDZ5X3efmJS6KkYClbgBUQp39pmDN9IVCO8g1t3K+SMOe2Fv?=
 =?us-ascii?Q?N35RF+wQ5UKWZLgra4aZKlRHvlI52pgJpqBtYwhJocFkfAfApJeyhzWV5TWi?=
 =?us-ascii?Q?CJQu+nWZj9bVX5BTnYajJTknvnuMBbmlK1M/MW1rMAYg9MBA29bFf9I7fYS3?=
 =?us-ascii?Q?UjryXmLp2Qd+KUQrMhlBtDBphVvYGTJJkReT0+j7p9bFM8lDh2IB9hGanoFI?=
 =?us-ascii?Q?aRxp8yey4arOpAZPHMDiujOwBXNx8kWMZIw8tMYTNTjD3qz+ozus4/8fUDDd?=
 =?us-ascii?Q?O14O6L3pyysmjZR4vxzJvwK8qYjQv7asA99jtzkfbRuLrCvImXwX0P2EDVBV?=
 =?us-ascii?Q?20BLUhLzCZgQedSQLrewIlf8L9p84OB7pFMQLVcd9sQLUXOjVLUvnpDkZyBW?=
 =?us-ascii?Q?J7/exRk7gqCBwwNo5hOee853slEdG0pAt7TmCMiu8pGP2O0Iphbj?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5569d6ec-5d98-4bdb-6ae7-08df4bd4c3ab
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:50.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PL76qLAV3bQe+4ylLhONS1YFm1nwI6M9TvdusGqFAvs4faciabJ+Hix9TZQveiDTlXQOX/AFYG7vgmBJsGOMraSy9wVYVI0/SS+ssXxgBtSG/Thj+bET7XIY80UIqy8V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25164
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 38d4d021228386b8e3fbef2bca5f1e91eacd4fe6 upstream.

Use rz_dmac_disable_hw() instead of open coding it. This unifies the
code and prepares it for the addition of suspend to RAM and cyclic DMA.

The rz_dmac_disable_hw() from rz_dmac_chan_probe() was moved after
vchan_init() as it initializes the channel->vc.chan.device used in
rz_dmac_disable_hw().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-5-claudiu.beznea@kern=
el.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 0adb1e372116..882a8d84219d 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -872,7 +872,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_c=
han *channel)
 			channel->index, chstat);
=20
 		scoped_guard(spinlock_irqsave, &channel->vc.lock)
-			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+			rz_dmac_disable_hw(channel);
 		return;
 	}
=20
@@ -999,15 +999,15 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	}
 	rz_lmdesc_setup(channel, lmdesc);
=20
-	/* Initialize register for each channel */
-	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-
 	channel->vc.desc_free =3D rz_dmac_virt_desc_free;
 	vchan_init(&channel->vc, &dmac->engine);
 	INIT_LIST_HEAD(&channel->ld_queue);
 	INIT_LIST_HEAD(&channel->ld_free);
 	INIT_LIST_HEAD(&channel->ld_active);
=20
+	/* Initialize register for each channel */
+	rz_dmac_disable_hw(channel);
+
 	/* Request the channel interrupt. */
 	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
 	irq =3D platform_get_irq_byname(pdev, pdev_irqname);
--=20
2.54.0

