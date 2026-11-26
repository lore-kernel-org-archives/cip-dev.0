Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.59])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.440.1795708457599933162
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:54:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=QsWxS6PO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.59, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqdnTyDaBJe7IN7JpuoZ7j9R+a8ucRIDQYLESq96B07pJMUl/j9iNVOkS87ifGVTON3ntNQfHeZmY936p8GmkABVZRPrxTjaAQEA6iASeU5opNyIanJhruRdlP82avRE87N5zWiYwSJ4ElwmlWq268TePxOQ0cQHxjImDeyFyM8hoZLeiuSInQxYkx2eMwzdxldw8sPpjf3Z4kUCW4+30VWPVxybUEZQ6r+bNhJIs3KkwG1Ke80gLSf0gjFMaB5SA1fQnBriJ9gKK5Ra3naNWyQLvYaEhkucaW3EYa06jGH6jSon/77N3VyKkCrroRTsFLOAIh4RqkMGsqoxyLx9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FLNALHp2h0XQcdHyQxe8b6xbaTV/MdAggk0rAsZDRs=;
 b=LMB61H/0pIYu0SLKjicOZiCFYX5W5EAEToL76UskGy97mVaeXWjuuHh6R4m48XpZIKcushuvZRluRjkJqENK2xKgTPOu7mJVphypYfDMi5kZtXiR9n0nZumU9gJ+t1TreX9yAOscBRKAXPvNqSjT6bgjfupNO36upGn3eU6r33qZGrMT+/diVbazlZ7/KvCMNWuGKTU8cYQNW7CqYUUfWU8pka/r4nRVNzqxw/hMgXhKL5pzQeSUE1P7qCQBiqR+5VhpfZwGO8gzJMfLRoS8xjhjcfnaPpuRp8Mxn7YyUmY0YkuGiE9BqoL1e4OGhFRMlN69Pxs72AcRAwN6Za7i0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FLNALHp2h0XQcdHyQxe8b6xbaTV/MdAggk0rAsZDRs=;
 b=QsWxS6POYxsSsiyNjnopYfxJCpIDRKPjyTPc3ZabkY5dpSMNJMk4kt5k8AHWqh3LPgBpzPk8+u8UJXNabHym4mUOUu6tMdkLD8cXUheEyrlMq6mqy6LdzeM0m5T84aflxugch7AETyjyFnS0Zt6FIvMMYc2YmlirGxQUZjbdBno=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:54:14 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:54:14 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 09/12] ASoC: renesas: rz-ssi: Fix playback and capture
Date: Thu, 26 Nov 2026 16:53:18 +0100
Message-ID: <20261126155321.3834347-10-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS9PR01MB16957:EE_
X-MS-Office365-Filtering-Correlation-Id: fa473a1f-18c8-4079-7393-08df4bd5851e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261102123227099003|261009223027099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hnbaBsNAlitNRkF20WP1Ovn3Yz1fLDoHfCT1x0m6+La7mlXz6Y2VnFN6Wa6T1hrh9U7B6lQ9uZWevn+j3TFwyknpVNRxaa5l2Qbc98SNwOOEYnMrSL6QHzqXAgSI8JwnZPzUnmpSmgDSDQ02hepdSFvM51HiANxv1oc80gZpkx8nw5Z+RBxMonxMyUHYau3UjnWYiAP8TfvQezpc0AyITyGF/llSISAIVX8p/J79mAanhWqwCFEZ9jlwiJJhpGmFPBqmStqTykcIm+FlzLTR3QA9gIZgzm1NckFfntMpnWfmotVtxAp1cUE/V5thyV284+6pGkIchfYKTn/i3Ss48uMJIYywb+vGFDCAGM8pA2mw4WbewypFsos1l4fzi613gp1hioEboQx//0YEgefZ9jXzhzTWWBqX8rj6skfXOu50ee5BgFQ9otIFWS4Sig27QxhesTfDoXwsDaD2U2cyCoYEO3HiXjZpfyvcWXg+Q8O7zQDSDcfOlhipEk3IqW1X5BN9pMafywTRgIQ66AIPEkH+KLf84R+clGB8IgPorXYBhOSlWs+NUJCGjHuZMUTfj7DlreZAm51HNB+OUMLsHMqjvRPQ+b+TekEeXoSy9WCSCKC29YFtVTPWbJ7vwVnI71Ugx5MjwIVm62fgxXvgLToqsZbuEvMzgK757Mol0Ho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261102123227099003)(261009223027099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2KbPWqcc3img7vLlwU27lv7nB5D1i6HGIpvzawuv4P9K2SVYoumc3yJdmQ1F?=
 =?us-ascii?Q?TILTWaJBHoVLab5m7PZNwVOKuEH+26YSnktmjBg75V9owETru11HctK2alQ3?=
 =?us-ascii?Q?1jKxIGKEezahv0KUrbn7ccJmV7GO8qiUqM0c5E1XO1uTpgQ8R+Hvo1cUX5Uu?=
 =?us-ascii?Q?f/uNt1igF4KazHytQlMKCI4gXRvb2QebK4Pgb/7zhIQH+MFbXRaM0VnRvGKy?=
 =?us-ascii?Q?5VsD3imMjNEOAXqiwPMT5dxVNiRAbzJLuNoAUssXc2jvsYMsxyTQ1lmeMYUM?=
 =?us-ascii?Q?QkmNeivNzfrOjPd4FCY4jn1kS5aXkSHDYQTyF8v+nqoRWI1eptqweSr0HOcp?=
 =?us-ascii?Q?WHKgJOrQOyPKAPq5kXPTiR2XgX9xggnMG4gj0dLkG0w4aOjTO3YiB9aXr46c?=
 =?us-ascii?Q?B7GB8ka9QXInhSnfpwiX+AYyP3ghuOSiQ6JCC3UA/ppoB6xo0afooU4hYNas?=
 =?us-ascii?Q?P52jzof4LwY2xkNi7ZwKOAtuE7P/xX4A9GAXqZRnQMFjvIxqMxOxO0Uf6eg9?=
 =?us-ascii?Q?VL14fZbvsuM7Owz2HAHRxLzTPOEaydEDHr52qlBLpe4o/5oPgPLGbZFXg18o?=
 =?us-ascii?Q?qb09FhJVkanM6myBCN8tQ8LviHPf43FNymM8nAfIwIsQ37sWMq6vD7R78Vup?=
 =?us-ascii?Q?oq8Aqf5zwRmVkbjO5ThOw3NI8d8JMGWg0GXweCjaivsZpzA9021Xyc2Cq5El?=
 =?us-ascii?Q?qVMZ2jzmYifH3LvH0Z7Yn1ONze/aPpq/KVs0dj9dxgJdZVM50aJo5HqG5DS9?=
 =?us-ascii?Q?0PBkcddgQCCdSSiyRl14r2XSj1gyIhDjGU1KqGXj80pdO92Mq3An4LQzRncu?=
 =?us-ascii?Q?wZYyRWFJ4vsJOKQhHdIh08gcv6FfOpZdIHvJvtXPIpBKN+kpeToHH1k10iN2?=
 =?us-ascii?Q?alRsFrixBvIBPtbW4Ta5vtzIxp311c2lb+vQT7diyIKnxz0LTLiXe0RrlDqq?=
 =?us-ascii?Q?cCnyReSyfIuWZyBjWXMelvFNszGP5wCriaaTsCCK6Lyix4CB3ppP+QL6RG+R?=
 =?us-ascii?Q?PPLQtV7BNgSzNSRhS+SA35xRZ2D+PatN8VO95Gcn4FTYTL4gY9tcnXgviFZL?=
 =?us-ascii?Q?uAo53P+6A3uHDH2nWcTMG7rrfUY2otdXhT0bEc5V8aEirac98cvfpn9S4WRJ?=
 =?us-ascii?Q?wA5xhDfibtG1mBI9dCQHLGMunPd1BMhEgHnnvyvQjzlge8kZJ7w+ny02ZhhQ?=
 =?us-ascii?Q?P8HxEZRrAprdiTVMQaJeHR+m2QavN/InowhGhPGYi5C7TQdaLBcCAOKHhzE2?=
 =?us-ascii?Q?kMsDbl0e/FBSiJgs+6umFWbwSSd6qpUsBo3TRdi8B/bF1bfHFALFDDXWAvvc?=
 =?us-ascii?Q?IAE6Iod+ktSna6gKCVuuwcHQqHrreU76obNXwel5zBZP0C4jXn2nmUwOICc0?=
 =?us-ascii?Q?YN6LK1o+nc1leU5Q/+d/cza4b+9JQK8+tnqXYyOdx/NXPSF9ffw4D7ZqCdQL?=
 =?us-ascii?Q?lJSB1EO4gP2V6tOWsiJumaIAtrjPC+I8xNSOwWJaOMDPzCpZVYOo+xNDMpTo?=
 =?us-ascii?Q?RdeBK0G3zlf5++i/qeodsWC5eWrxMfAHwMchAr7FjL7w9dSQ4Sb1DwjvrK63?=
 =?us-ascii?Q?DdGNNSHuYsrVrnsT4FoaqiGGualo2y65GwJkz54OEmOtY+ta+BzZEqkGLsA3?=
 =?us-ascii?Q?AQ3ikmzPYQKkILCw7MrI+x033BV7hcRrMPnH/dE6MhM/2f7hs3XdaKecKoOi?=
 =?us-ascii?Q?WmwOv+ONj0eki4P/3DHyYNVqkanTgBTJ8zUz3oovxvYnFNi2BZrMoj/Z0J7z?=
 =?us-ascii?Q?NygdRPw5XMpYfoUw0EqmeDG7YyfTFeq7I4somxy9VRdEixkhkfII?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa473a1f-18c8-4079-7393-08df4bd5851e
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:54:14.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTgJn1ZINiMkr/ULY/hmvu/TQlUIKibWoAj3vRgvfW+cYy4W4INbMlFLsA4wIQMswal+QLuRyiCxXsoPMuHVil6Cr8s5UUFZ4Dk7Nux6XYBb268vaL8qztWUL8FfwWE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:54:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25187
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
index 42eee8c480a5..0491f0e46187 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -181,7 +181,7 @@ static inline bool rz_ssi_stream_is_play(struct snd_pcm=
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

