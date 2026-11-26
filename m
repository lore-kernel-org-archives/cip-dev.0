Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.588.1795708926365728708
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 08:02:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DVUgZ8tO;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.16, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6eluv64s7IzfktMFcATXAkerv9Hlh/4vz2KpxG1k++m4ujdWGe+73+q/u3Rim9gRib5857b+V7UzqvbICLKQD0Wkc4M1DXStfE50PPw0nOEWCGBeK+npK9wIezDDNSj8DgwPBTI0S6ReRkd/cT67o5rI8/SKhg9xkR5ZEvMZ390xqcZmqC6e1ersWt6J72pyDifoWbdTJA+jq6vm0hYMcz/VOz1+omg9sFa91bzxaQDwvbzxPS3c26jB05UC5WVoZ8PxPC6+BCRecQ0V+0J+xDRJGyEgkfl5pMzadTyhWDtCNWrtAy0FHubThPYA+xn1vC55uXZhp0aEnBR3NvtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dds3q5hlWB8y1OoC/x+2eEarH5lh86DteKh6GC5g/ts=;
 b=uZ82f88Qoim9mHqcP55LZ6dTAPJ6whLf1Gq+PHiTVr37JYYvqd60B9OOg5u78GNY75kd+nY7QtmPrBoiVSfmPzUwAcbkQ+HFDKu42QZWnGG2wB7U+DjI5NiZoX3zfRqIWFkGgjz8b1AZgiArm1U4VjHH4dQ/FtiPDdezsR3jhS9o7321/+NXxMEqJXs2IPPM0UyrwCHi1yA5BgHKnSMMyQE1HaHKOV8isIOJyd72csP7JlVL2j1TvtrS4YC3o8sNq2yhA5a/8fFv1I1cJz2xmKrO7X41ijD9slbuTxkm3RGo6aETn6lOPrddPPbk4WzvMKjwx3GQ4GXZCBuwUvQIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dds3q5hlWB8y1OoC/x+2eEarH5lh86DteKh6GC5g/ts=;
 b=DVUgZ8tODFv5lyV429StH6eZvC3x2K+rhsDWJoe3sGR709/AUh4ro8/5Rq8G066LlV6Jt5S2theipmuQRPZ8ounJDydkj9LnxBkDpUVKpNN9NqCKNF11rYjm+2pZpuEFswQ79vAFI0NSUW9scXegUTuSpuJk8rpiHZOymj1KISE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 16:02:02 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:02:02 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 5/8] ASoC: renesas: rz-ssi: Fix playback and capture
Date: Thu, 26 Nov 2026 17:01:16 +0100
Message-ID: <20261126160119.3836850-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126160119.3836850-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126160119.3836850-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VIVP296CA0010.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::14) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY5PR01MB181845:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ffd950c-c842-4714-dbb1-08df4bd69c2d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|6133799003|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261021121427099003|38350700014|261021123027099003;
X-Microsoft-Antispam-Message-Info: tgvz6THqG8dnB+2YgLToWs/CvgqfsCPxquw0A96ttuKiwl4ahk8ytwq/vAraH+6oPtWE9ZRk5A8tIM9P9oYaEvAYph4fOon49YBpy6Bi8KlZ9qQ4uxVrlKTZPkXEanTjxSzGMn6FmpnSRS6aE3xNj9SHEY6X02wUjvEJUrPlKgpxdRGKMgd1Mrsa7rNNJWpiG7NNMkSU3s5wiNIq792b+OhlCfDRMh1KCou2Tli4ousRj47ZJNBOSymtviYdu0mdp8KTPflFnX7lsI9XhpvLwC4EvfyNbP8LSdDfJs+KN0iyQRbn2AHo6tY/Tma3fEU6MjrmTv9/iHSPDs55zgqBbqvaEWiOY6zMpVIFk+TCPzU2j7AoKb33fs0kMSQJXzpxaS4Ul2rEc8nD+6XxglRsT9P/53YE8HZ3/nbOxOtGFUJ53aPjYnO8KL0xnqlFtjqQqARrC3LRt3JStMc4JCsfYstkFsH15rKTsdXgTGN4HdOWcEYmw0tBWxyNiRrmPRwArfo4uw5FMAT9Po3UYH0PM+ZyIvcz9u9LQ98nHWGNVI3Aw+fWH3YVv6RZfFHKo+bPhSeoHg/75kMOQY6qFHbutkDI8WQGwHmDBbxjyddVDNkVIzTw5Vy18BeT23efacDin3NZtp5VRMfOT0s7vhs67eGjatsLtxHq5AtxX6Q6kfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(6133799003)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(38350700014)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BEaF5cf95UsHfxDDG3HN0/f3dhkRaRXuO06hRGbTJ9OqdBNE+dFfeIYQ5bmF?=
 =?us-ascii?Q?g5STp/Ydovv97/fC2aLqAYCdI+CR9fWqb5ta3McJB0PdxeeYil3nIFzascJs?=
 =?us-ascii?Q?MJgXuftmpbhpbRIaYtLtqUxd8IDjcaXdG7Za0Hc37Sq7A4oUFX6RpDprFr2R?=
 =?us-ascii?Q?uH/eVU7UQYBORgnuYkAFnVgmi9tGdzO6kVM3Hf1m1mYuUK0kUvHzkwouEv6F?=
 =?us-ascii?Q?ls66GVXaKF9D5+vDPG77zB3Xtv5ill67XH4QkwmpoYpqUr+iubaUQ7B8jvOk?=
 =?us-ascii?Q?AF4ynz5wlyqo+VS1WKOeW6NfLY57u/MD8mc0wJdckpgtXepgQtPnwf4lsVYS?=
 =?us-ascii?Q?qVPqUpVN7idIvUPALGqI4Rn9je3EDe0ssLulYLk4r1AG1OrrNphHMB90vwVO?=
 =?us-ascii?Q?63H7uj3lNJpExX9D96JzqE/Z37G8WCNa+C/mNCUg0vyC049Q8SycoZNT5K5m?=
 =?us-ascii?Q?AHClWK6clwl9A1zec0Y6DAMpItU/4rB9g4fN9Oi6Xl7LRWISEzcTdMLg0Z3i?=
 =?us-ascii?Q?krKPk8LJjJHQDXqe+LIuqKS1O44fmdYHk3Y17gju+04jsrNz6YEmRdW06LJM?=
 =?us-ascii?Q?k3tI2ur2SbubfjqkXlvsW+kVukmArbk5p7WUUyLELBVZ35O0prRgyu0rCBer?=
 =?us-ascii?Q?yrjpvb4148i/fEajSJaoFPGr6lPphwD05T27k4anmsuVtSMW44QDebH8bMdJ?=
 =?us-ascii?Q?B7lldvf3JiFh+33EWlu7WZUJhmbWCu3zj4XX7+wS2sikJXfQoKsO/HkmvjYH?=
 =?us-ascii?Q?kWL6F5HDzhm+Td/uNbTJfZULV0uFtrMXSTpG5dAEfmNyBStD1SgGtidgyGgd?=
 =?us-ascii?Q?VMdS2NNZ/HJ3/aaY6aOwE33VqS3X2t9iCHksKC9cYbrdCA5EiDYxdKnpF8u1?=
 =?us-ascii?Q?cVDqEwzUYCa0u4JZtndOfNQqpCxJPKNKijAZIBmOyMn1Dn3wbJZXcRy5jn+2?=
 =?us-ascii?Q?95fs8nFPDqmsLzahvBG+y9OYz2fpfe18H3j2u4ng7bkaxJE9a1wQgGC1/86f?=
 =?us-ascii?Q?yaWbBt/+5nbeqx3iyVMGDfd2Hh1incJF1J+nQKVSLcp7RsjnojpF5ZMRYQHT?=
 =?us-ascii?Q?YJVNHlZHgaJOHyG4Nspr9KF6C0gVpYNzn56YH9gBTSrOrLjBoXg1dvqyM8H4?=
 =?us-ascii?Q?gueowrfesPXf0yIBOS+lOtoqVz1c8P7iRXCtlMPjVX8AeOHKg39Kp27+QKN7?=
 =?us-ascii?Q?WqudkXT7oABRJucQa2jPn2kWTnuPhK8SRA3y7/VGCBDjZAiEvn2o6TmjasoL?=
 =?us-ascii?Q?3HGeyXl0HgiWbQoMoOTBEIXvYsuo4kCITWhzR3qeuH/YQl22UlJP0IDJlQEm?=
 =?us-ascii?Q?nAPFTzYcTlkAJg8l14IMUHB4nnOBwbxQNg3t5qNm1YM6RC3JiHhE5McyTRx6?=
 =?us-ascii?Q?coBEXxykLTWxtupO3pqBpLmofL/ddhkRCO8d+/xU9H3yrx9qqElZvhWMyZgZ?=
 =?us-ascii?Q?gyDRto+IjmXPZjS1jWv7ZhAG3IARg/LUGLm8hB6ja9T9zXFAgKWtTTpiSL5j?=
 =?us-ascii?Q?QGCbS2MUuq1vMmO3eypLiGNwHLbr+qxcnDKnwP+zVViZHWJVzcXxxfBZ7KcK?=
 =?us-ascii?Q?GzNncCIbeHPlcV6I6+0/w9uARgItIOEjDI+Hvtvvl4+lbLyqX0PwhFWkaVqO?=
 =?us-ascii?Q?/913rXLCjndqXZitIn0FEsIjj31LwnHsvwb4zwGJlv929hcypTYr2itNcXtF?=
 =?us-ascii?Q?5/eGac9hKl8r/pLiBK4RAEo+R3JhXiXsLwx3KyTRNIgz55SoVZxoidqLcFs2?=
 =?us-ascii?Q?H+kUn161hOc1fAKaMh+U2Hd/JTGUvELu25Nwlox1jRS1/ZqkmN/E?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffd950c-c842-4714-dbb1-08df4bd69c2d
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:02:02.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7m3iynhOpLttPEOvVRBqtyO26B8vS+Kq+NaNqiiEUr1VPsrWwL5GotHM0Gqrc62xSawb8p/PoCXGx+pPTz60OGB5wc/Nm5An/5omPh9YTiQ46cOF6iNSRc6wT5UVfPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 16:02:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25220
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 82e3265487c018814b789e251fb8aee8e683674c upstream.

In the current codebase the rz_ssi_stream_get() is called at the beginning
of rz_ssi_dai_trigger() before rz_ssi_stream_init() is called.
Since rz_ssi_stream_init() sets the ssi->{playback, capture}->substream,
relying on it in rz_ssi_stream_get() is incorrect. Fix this by checking
substream->stream instead as the original code did.

Fixes: 53dfb2ad6fcf ("ASoC: renesas: rz-ssi: Simplify the logic in rz_ssi_s=
tream_is_play()")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260213172434.3801015-1-claudiu.beznea.uj@b=
p.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index c892dcd1e619..90bf7ceddbe8 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -180,7 +180,7 @@ static inline bool rz_ssi_stream_is_play(struct snd_pcm=
_substream *substream)
 static inline struct rz_ssi_stream *
 rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd_pcm_substream *subst=
ream)
 {
-	return (ssi->playback.substream =3D=3D substream) ? &ssi->playback : &ssi=
->capture;
+	return (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) ? &ssi->playb=
ack : &ssi->capture;
 }
=20
 static inline bool rz_ssi_is_dma_enabled(struct rz_ssi_priv *ssi)
--=20
2.54.0

