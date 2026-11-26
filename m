Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.656.1795708931158566017
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 08:02:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=oN0eqPOQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.70, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ai1Gu6hkuF8rz6FOYP9HLRLOpErwBf86k2W5qyOCUzzvJczeFq9dyB+pwZBzVQNghy0wGQM6/jq/BUKUWPi5JCcZD2qgdg/caDG/yMKP9mz1w2jEjGuwooRq4V6KbAots0i2CJBY0Ma8J7r8Q/tnhVUqFNXg5+QpvPZRVv8dKj3HPS9/uQWOWjEa7FREkgQExBKXk3rUNR4g/+vyfLyH7wM6094A9xHAkQcPhzrEZFzNEiE/eZSiocKZ/YjReB4lNug4/oJaKZZNd+sNtVv/lNg9WkNGn8inlVjqEiI+3OTUlQjFu/yQkggSn/Tp9Ra+Za2ZOWhqMHsgQbzgz3kqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DM/bsAoHAmrJ3F/hTlAHgBQszG/sXt6ck2PvRktIOSk=;
 b=Bcp9ulAEzsavhMhhfa5/senvevSHDWVVPCevzEzoAN5rDu9Shxb0nAMGFEKlWUJI0zC7ELEhuiTn9pjZaCFqMtRAOwSXySnJ10uCZ/a+ujGujC+CkPVT4uYTOoDy1K5cLQiNpAhfto909adPg0iGZisxIp+PlD7wmnN6tPf4tF+7akj7pKEVFX7ShfmbnBt8IE/bjfOOQ0aU5HA4mGXmMVI79m4xyJreHzPr1d6vp9tHufzOBOuWFtS9oB9L1FT4+Pe5MAlMkJB7R6bz8kyp2E8kt5gd2yFV7ddB+98b3gPeuKdxA3TzLjyJxbmwRW5twXYm5lRWcQRls8qqF+qVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM/bsAoHAmrJ3F/hTlAHgBQszG/sXt6ck2PvRktIOSk=;
 b=oN0eqPOQXV38yRowprB6q0pp+peA6I+5rocoWf9hVKgPZTZFL0xdxn5qc4qABHNY0LPsPUW97fziRZRLSpPODVlyUw5K94fIaeSFVbKWYg9L06CkiJD04aoRtk0+EYBpiMnpRUBgw9Q35uC9kvj0/ksS4QJvQ5GtaO6RC1rhqZQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 16:02:08 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:02:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 7/8] ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
Date: Thu, 26 Nov 2026 17:01:18 +0100
Message-ID: <20261126160119.3836850-8-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3f7a4416-0933-4468-392e-08df4bd69fba
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|6133799003|261009223027099003|261009221227099003|261009220027099003|261009221727099003|261009223327099003|18002099003|22082099003|3023799007|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026130827099003|261026121527099003|261026140227099003|261022105027099003|261021130227099003|261022113327099003|261022075727099003|261022115727099003|261021121427099003|38350700014|261021123027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: 13Cgle9aVlMuxtUImgUC5NmqcjUHJNIWIrKiQfomR3G8Prrd1UPqxvQeLTC/miEKx1K5IMlduPh8RKaIndBXQ7mn5FQId30ap0NIPsMjcCiPqeNLjyFsYv7WVn74vnwE8r55hiTm/Cq11uwVLiai88lv9bKJHOHY4FGgNQZTe53g7O1cNcfbfcPttuICxthOR9BUobrjt0bsXgcLGYhSQy81Es6bm+vMKzeR131+yg6sT71B/obe/XcpL6gRX/I4KQFxnPOA+XWeyy82nGr/wYl/TdxiJE7IxBZqIOkwxuGc4NTnM186LA7CHciNefMIr4pn7nyPmppOgZN+57yTvIUnrHRO/x9drET/BoyyJXmPGRSY9yyR2m7WU164z68zbfXkVEFx3JK+F3lkwyPYC4N1fIkeSpCKfUE9kY6BwBBMVHqpOkB+TCuiL2I38Ik9u42eElAUPo73uKDQb4tDt1wD+QIV08UnwrTm5WMXJTexyl3S2q/dhtUGD9QB20Juq8ocl4c2axXUGwQJ50st7lIjYkEjQWPGUWUZ5iPvqEJqSvo7w6s7ukJgTL8Zg6rzlJcZxTQrPhRHn+Ctl/e8LqLEQAz4HAVUC/1FkWgxBcW1u63nOsTF68FVMG5n/4LhtFwTmEOguneT1xWCvZr1uFk1odidzJCumTexcH+qcN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(6133799003)(261009223027099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223327099003)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026130827099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261022115727099003)(261021121427099003)(38350700014)(261021123027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NgpYLC4QDJdDZ9+l91cdZwhAXBs4bbZhVsLO0nRqmHA4EgRe65xEiIo7KhV+?=
 =?us-ascii?Q?goXqxK96BPTUKh3psmbqdiuP2YOiEAszt2gArEypK3zIq1SYKX15DYydIstO?=
 =?us-ascii?Q?q3zLD3NGIUK2hI8QNYBdgmK1atmZWA5KcMxcboGTW4uLdUA4ETm8KAzj7sRq?=
 =?us-ascii?Q?Sb4aMNPQrugylhhTo/f/i8GloDwe72ZKYGPMgRaqmxEevB9sek183XDeQIGz?=
 =?us-ascii?Q?jiHsT6KAy2U+AW/wLIhf4tInB8JijzHLIcQEJ2MlC2Cr2euHvIMQT0zm3e3g?=
 =?us-ascii?Q?vrPocaoH3urUpK+dlEJxwtCHZ6aCjm8L6ZaWA37i9JMnh67uQKM/49GDjgEs?=
 =?us-ascii?Q?p8rhEYTYg8oKoJWAVk4PnG1ogEoC+e0xu0rn3kBCA6lsZG5v9wy47EhiOTE3?=
 =?us-ascii?Q?k0ogoEjvtJ/zct4MDfQHnq9ZFZpN5MKZEqzVV6yO8zhuphutUmi79EEaNVuk?=
 =?us-ascii?Q?SU4d066YcwrxQCrLRL5WCGGUdcD0qfEUTqpqb+DRh8ShQgoEcKE69mQrmp7u?=
 =?us-ascii?Q?LiLzJJ4hjpEO1spQLQLBHS2Fbf+u4RMY8K8pWpxrMOym0nQEoHCcOPM8G2rt?=
 =?us-ascii?Q?2aQwI9mYj+3mxWwSR+dauGHfsFoR2z+VJGF7H99yOg7Q0Grw8DAgEOYhz4YP?=
 =?us-ascii?Q?VQN5i3rq5dt+T8tVv9YGKpncEq7Ye0P524F6UTXleFlpnbBl+MEzYRSLqeqJ?=
 =?us-ascii?Q?XP0jM/0x14eCGV2S5iy91yYXxCecwFTeKHDvU7bgmwJOPWjPqNryX72/9WsC?=
 =?us-ascii?Q?JABl3HPnllkOjeuJmBGObG/1MlaQcs0pDlZk+bjcjiRVxFTeHSl6yRb9h8va?=
 =?us-ascii?Q?PS9uZgrVXe6GAjPwQZh+NKUbc+O/I7Kdiduk3Bdkq9YG7jUxx6fCWd69KZKo?=
 =?us-ascii?Q?NrWKvpFzic6Yw91En57anVMCkPi2yBXu8hXaTb9yGORV+1JBQUBfSjg7jQnz?=
 =?us-ascii?Q?VP4n+fHLPyBAgrUVlzsv4YFDZ/NszSzFpor4FxTqm1dxaCCP6h3Z1DguMatQ?=
 =?us-ascii?Q?yhdFcBWQKbMtO5KZRnMYSBCUF666TA1vN+x4g7f3cE9DfYJpMZTn3gcyDlX9?=
 =?us-ascii?Q?6DS2deG+JasyVptdd7aHa/l33SHP6gns94nHiTisUAHpoDf/VaZB0aFZj5TS?=
 =?us-ascii?Q?A4J7ODr8U9MgYCRHTdWKv0jNdZAJlswa+A6Gl5YecKQUJwSCqxgtq/Qk4BMd?=
 =?us-ascii?Q?FmNh+yDHhkWY3B3oNUj5Dns8gKdIJODvoW8gR9QDroLkAof7eeMRQ+X6Hpfd?=
 =?us-ascii?Q?bYJi9O4DERG0Q3Db76FdBVuqVseX8dytBiyXbjswa6Uyv7tLK6D5d1YjT+Y1?=
 =?us-ascii?Q?sMoaoEMtGlm1VsPXU4i86QXOSgquqGywdwootcFGslqT9ul/eRWUbhGxfqMV?=
 =?us-ascii?Q?Vg7tjc8EszK1hqx9mNcCy+mA3yXYyjqAfYRN59og1bb4UEYouR1lmO1/Sygz?=
 =?us-ascii?Q?D0PXj5FJ5gVFgAJK6FpsRQPvRpagn0Xn8FZIavCI/W4b9YABLgGAS756L5ju?=
 =?us-ascii?Q?shYGQi2YKmsvCcacTjlMFPcHzFag9h0yOmdtPXYAx1JFwfM//47ZwmLpErY2?=
 =?us-ascii?Q?ijmFZZY8H03N5JukUtvP5WGN21+a7p0/Xh2KxrYyXqe9OdqNv7iGV4a39Yy9?=
 =?us-ascii?Q?YDfPF0sB85lRg30EOpPj8d6zh9ioZZIRLAo74Xp++3hI3gTKTligCtfewXFr?=
 =?us-ascii?Q?ENgBtLh5NRMG5wTz94nGBD4N8IVVAu44sUbUrLX7tixX9b+LGqGNlHiU1I53?=
 =?us-ascii?Q?MDAXUc99ntFFdXYA4Gh65k2Cn94wf12nf2aKxh6eLFGAd3I5JtZY?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7a4416-0933-4468-392e-08df4bd69fba
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:02:08.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fByArh/ouow7Hdnlpi7SZE7dPj723SR7f3huK13e5Gu1YmXtHB/QJ5nrOI+mvGjNrJY8DWAipcxl3fzoxiPVsZlxO7WHapqkijidbL7796JxlwhlHj2D/1vpDNS+ZhaZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 16:02:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25222
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 9fcaec81ac56c9d2c5d779ffb5a76b622b4d0590 upstream.

On Renesas RZ/G2L and RZ/G3S SoCs (where this was tested), captured audio
files occasionally contained random spikes when viewed with a tool such
as Audacity. These spikes were also audible as popping noises.

Using cyclic DMA resolves this issue. The driver was reworked to use the
existing support provided by the generic PCM dmaengine APIs. In addition
to eliminating the random spikes, the following issues were addressed:
- blank periods at the beginning of recorded files, which occurred
  intermittently, are no longer present
- no overruns or underruns were observed when continuously recording
  short audio files (e.g. 5 seconds long) in a loop
- concurrency issues in the SSI driver when enqueuing DMA requests were
  eliminated; previously, DMA requests could be prepared and submitted
  both from the DMA completion callback and the interrupt handler, which
  led to crashes after several hours of testing
- the SSI driver logic is simplified
- the number of generated interrupts is reduced by approximately 250%

In the SSI platform driver probe function, the following changes were
made:
- the driver-specific DMA configuration was removed in favor of the
  generic PCM dmaengine APIs. As a result, explicit cleanup goto labels
  are no longer required and the driver remove callback was dropped,
  since resource management is now handled via devres helpers
- special handling was added for IP variants operating in half-duplex
  mode, where the DMA channel name in the device tree is "rt"; this DMA
  channel name is taken into account and passed to the generic PCM
  dmaengine configuration data

All code previously responsible for preparing and completing DMA
transfers was removed, as this functionality is now handled entirely by
the generic PCM dmaengine APIs.

Since DMA channels must be paused and resumed during recovery paths
(overruns and underruns reported by the hardware), the DMA channel
references are stored in rz_ssi_hw_params().

The logic in rz_ssi_is_dma_enabled() was updated to reflect that the
driver no longer manages DMA transfers directly.

To avoid software reported underruns (e.g. when running aplay during
consecutive suspend/resume cycles, or when the CPU is nearly 100%
loaded), rz_ssi_pcm_hardware.buffer_bytes_max was increased to 192K.
At the same time, rz_ssi_pcm_hardware.period_bytes_max was set to 48K
to reduce interrupt overhead.

Finally, rz_ssi_stream_is_play() was removed, as it had only a single
remaining user after this rework, and its logic was inlined at the call
site.

Acked-by: Mark Brown <broonie@kernel.org>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-18-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 sound/soc/sh/Kconfig  |   1 +
 sound/soc/sh/rz-ssi.c | 394 +++++++++++++++---------------------------
 2 files changed, 136 insertions(+), 259 deletions(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 426632996a0a..182d3800fc6a 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -49,6 +49,7 @@ config SND_SOC_RCAR
 config SND_SOC_RZ
 	tristate "RZ/G2L series SSIF-2 support"
 	depends on ARCH_RZG2L || COMPILE_TEST
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  This option enables RZ/G2L SSIF-2 sound support.
=20
diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 5ee356c78cc4..a1dc0d786bbe 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -13,6 +13,8 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
=20
@@ -87,8 +89,6 @@ struct rz_ssi_stream {
 	struct rz_ssi_priv *priv;
 	struct snd_pcm_substream *substream;
 	int fifo_sample_size;	/* sample capacity of SSI FIFO */
-	int dma_buffer_pos;	/* The address for the next DMA descriptor */
-	int completed_dma_buf_pos; /* The address of the last completed DMA descr=
iptor. */
 	int period_counter;	/* for keeping track of periods transferred */
 	int buffer_pos;		/* current frame position in the buffer */
 	int running;		/* 0=3Dstopped, 1=3Drunning */
@@ -96,8 +96,6 @@ struct rz_ssi_stream {
 	int uerr_num;
 	int oerr_num;
=20
-	struct dma_chan *dma_ch;
-
 	int (*transfer)(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm);
 };
=20
@@ -108,7 +106,6 @@ struct rz_ssi_priv {
 	struct clk *sfr_clk;
 	struct clk *clk;
=20
-	phys_addr_t phys;
 	int irq_int;
 	int irq_tx;
 	int irq_rx;
@@ -148,9 +145,10 @@ struct rz_ssi_priv {
 		unsigned int sample_width;
 		unsigned int sample_bits;
 	} hw_params_cache;
-};
=20
-static void rz_ssi_dma_complete(void *data);
+	struct snd_dmaengine_dai_dma_data dma_dais[SNDRV_PCM_STREAM_LAST + 1];
+	struct dma_chan *dmas[SNDRV_PCM_STREAM_LAST + 1];
+};
=20
 static void rz_ssi_reg_writel(struct rz_ssi_priv *priv, uint reg, u32 data=
)
 {
@@ -172,11 +170,6 @@ static void rz_ssi_reg_mask_setl(struct rz_ssi_priv *p=
riv, uint reg,
 	writel(val, (priv->base + reg));
 }
=20
-static inline bool rz_ssi_stream_is_play(struct snd_pcm_substream *substre=
am)
-{
-	return substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
-}
-
 static inline struct rz_ssi_stream *
 rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd_pcm_substream *subst=
ream)
 {
@@ -185,7 +178,7 @@ rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd_p=
cm_substream *substream)
=20
 static inline bool rz_ssi_is_dma_enabled(struct rz_ssi_priv *ssi)
 {
-	return (ssi->playback.dma_ch && (ssi->dma_rt || ssi->capture.dma_ch));
+	return !ssi->playback.transfer && !ssi->capture.transfer;
 }
=20
 static void rz_ssi_set_substream(struct rz_ssi_stream *strm,
@@ -221,8 +214,6 @@ static void rz_ssi_stream_init(struct rz_ssi_stream *st=
rm,
 			       struct snd_pcm_substream *substream)
 {
 	rz_ssi_set_substream(strm, substream);
-	strm->dma_buffer_pos =3D 0;
-	strm->completed_dma_buf_pos =3D 0;
 	strm->period_counter =3D 0;
 	strm->buffer_pos =3D 0;
=20
@@ -248,12 +239,13 @@ static void rz_ssi_stream_quit(struct rz_ssi_priv *ss=
i,
 		dev_info(dev, "underrun =3D %d\n", strm->uerr_num);
 }
=20
-static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
-			    unsigned int channels)
+static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, struct snd_pcm_substr=
eam *substream,
+			    unsigned int rate, unsigned int channels)
 {
 	static u8 ckdv[] =3D { 1,  2,  4,  8, 16, 32, 64, 128, 6, 12, 24, 48, 96 =
};
 	unsigned int channel_bits =3D 32;	/* System Word Length */
 	unsigned long bclk_rate =3D rate * channels * channel_bits;
+	struct snd_dmaengine_dai_dma_data *dma_dai;
 	unsigned int div;
 	unsigned int i;
 	u32 ssicr =3D 0;
@@ -296,6 +288,8 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, un=
signed int rate,
 		return -EINVAL;
 	}
=20
+	dma_dai =3D &ssi->dma_dais[substream->stream];
+
 	/*
 	 * DWL: Data Word Length =3D {16, 24, 32} bits
 	 * SWL: System Word Length =3D 32 bits
@@ -304,12 +298,15 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, =
unsigned int rate,
 	switch (ssi->hw_params_cache.sample_width) {
 	case 16:
 		ssicr |=3D SSICR_DWL(1);
+		dma_dai->addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
 	case 24:
 		ssicr |=3D SSICR_DWL(5) | SSICR_PDTA;
+		dma_dai->addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
 	case 32:
 		ssicr |=3D SSICR_DWL(6);
+		dma_dai->addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
 	default:
 		dev_err(ssi->dev, "Not support %u data width",
@@ -352,7 +349,7 @@ static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
=20
 static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *str=
m)
 {
-	bool is_play =3D rz_ssi_stream_is_play(strm->substream);
+	bool is_play =3D strm->substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK=
;
 	bool is_full_duplex;
 	u32 ssicr, ssifcr;
=20
@@ -431,14 +428,6 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct=
 rz_ssi_stream *strm)
 	/* Disable TX/RX */
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
=20
-	/* Cancel all remaining DMA transactions */
-	if (rz_ssi_is_dma_enabled(ssi)) {
-		if (ssi->playback.dma_ch)
-			dmaengine_terminate_async(ssi->playback.dma_ch);
-		if (ssi->capture.dma_ch)
-			dmaengine_terminate_async(ssi->capture.dma_ch);
-	}
-
 	rz_ssi_set_idle(ssi);
=20
 	return 0;
@@ -466,10 +455,6 @@ static void rz_ssi_pointer_update(struct rz_ssi_stream=
 *strm, int frames)
 		snd_pcm_period_elapsed(strm->substream);
 		strm->period_counter =3D current_period;
 	}
-
-	strm->completed_dma_buf_pos +=3D runtime->period_size;
-	if (strm->completed_dma_buf_pos >=3D runtime->buffer_size)
-		strm->completed_dma_buf_pos =3D 0;
 }
=20
 static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *=
strm)
@@ -614,12 +599,6 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *dat=
a)
 	if (irq =3D=3D ssi->irq_int) { /* error or idle */
 		bool is_stopped =3D !!(ssisr & (SSISR_RUIRQ | SSISR_ROIRQ |
 					      SSISR_TUIRQ | SSISR_TOIRQ));
-		int i, count;
-
-		if (rz_ssi_is_dma_enabled(ssi))
-			count =3D 4;
-		else
-			count =3D 1;
=20
 		if (ssi->capture.substream && is_stopped) {
 			if (ssisr & SSISR_RUIRQ)
@@ -639,19 +618,41 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *da=
ta)
 			rz_ssi_stop(ssi, strm_playback);
 		}
=20
+		if (!rz_ssi_is_stream_running(&ssi->playback) &&
+		    !rz_ssi_is_stream_running(&ssi->capture) &&
+		    rz_ssi_is_dma_enabled(ssi) && is_stopped) {
+			if (ssi->playback.substream &&
+			    ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK])
+				dmaengine_pause(ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK]);
+			if (ssi->capture.substream &&
+			    ssi->dmas[SNDRV_PCM_STREAM_CAPTURE] &&
+			    /* Avoid calling pause twice in case of half duplex. */
+			    ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK] !=3D
+			    ssi->dmas[SNDRV_PCM_STREAM_CAPTURE])
+				dmaengine_pause(ssi->dmas[SNDRV_PCM_STREAM_CAPTURE]);
+		}
+
 		/* Clear all flags */
 		rz_ssi_reg_mask_setl(ssi, SSISR, SSISR_TOIRQ | SSISR_TUIRQ |
 				     SSISR_ROIRQ | SSISR_RUIRQ, 0);
=20
 		/* Add/remove more data */
 		if (ssi->capture.substream && is_stopped) {
-			for (i =3D 0; i < count; i++)
+			if (rz_ssi_is_dma_enabled(ssi)) {
+				if (ssi->dmas[SNDRV_PCM_STREAM_CAPTURE])
+					dmaengine_resume(ssi->dmas[SNDRV_PCM_STREAM_CAPTURE]);
+			} else {
 				strm_capture->transfer(ssi, strm_capture);
+			}
 		}
=20
 		if (ssi->playback.substream && is_stopped) {
-			for (i =3D 0; i < count; i++)
+			if (rz_ssi_is_dma_enabled(ssi)) {
+				if (ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK])
+					dmaengine_resume(ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK]);
+			} else {
 				strm_playback->transfer(ssi, strm_playback);
+			}
 		}
=20
 		/* Resume */
@@ -687,153 +688,11 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *d=
ata)
 	return IRQ_HANDLED;
 }
=20
-static int rz_ssi_dma_slave_config(struct rz_ssi_priv *ssi,
-				   struct dma_chan *dma_ch, bool is_play)
-{
-	struct dma_slave_config cfg;
-
-	memset(&cfg, 0, sizeof(cfg));
-
-	cfg.direction =3D is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-	cfg.dst_addr =3D ssi->phys + SSIFTDR;
-	cfg.src_addr =3D ssi->phys + SSIFRDR;
-	if (ssi->hw_params_cache.sample_width =3D=3D 16) {
-		cfg.src_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
-		cfg.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
-	} else {
-		cfg.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
-		cfg.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
-	}
-
-	return dmaengine_slave_config(dma_ch, &cfg);
-}
-
-static int rz_ssi_dma_transfer(struct rz_ssi_priv *ssi,
-			       struct rz_ssi_stream *strm)
-{
-	struct snd_pcm_substream *substream =3D strm->substream;
-	struct dma_async_tx_descriptor *desc;
-	struct snd_pcm_runtime *runtime;
-	enum dma_transfer_direction dir;
-	u32 dma_paddr, dma_size;
-	int amount;
-
-	if (!rz_ssi_stream_is_valid(ssi, strm))
-		return -EINVAL;
-
-	runtime =3D substream->runtime;
-	if (runtime->state =3D=3D SNDRV_PCM_STATE_DRAINING)
-		/*
-		 * Stream is ending, so do not queue up any more DMA
-		 * transfers otherwise we play partial sound clips
-		 * because we can't shut off the DMA quick enough.
-		 */
-		return 0;
-
-	dir =3D rz_ssi_stream_is_play(substream) ? DMA_MEM_TO_DEV : DMA_DEV_TO_ME=
M;
-
-	/* Always transfer 1 period */
-	amount =3D runtime->period_size;
-
-	/* DMA physical address and size */
-	dma_paddr =3D runtime->dma_addr + frames_to_bytes(runtime,
-							strm->dma_buffer_pos);
-	dma_size =3D frames_to_bytes(runtime, amount);
-	desc =3D dmaengine_prep_slave_single(strm->dma_ch, dma_paddr, dma_size,
-					   dir,
-					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!desc) {
-		dev_err(ssi->dev, "dmaengine_prep_slave_single() fail\n");
-		return -ENOMEM;
-	}
-
-	desc->callback =3D rz_ssi_dma_complete;
-	desc->callback_param =3D strm;
-
-	if (dmaengine_submit(desc) < 0) {
-		dev_err(ssi->dev, "dmaengine_submit() fail\n");
-		return -EIO;
-	}
-
-	/* Update DMA pointer */
-	strm->dma_buffer_pos +=3D amount;
-	if (strm->dma_buffer_pos >=3D runtime->buffer_size)
-		strm->dma_buffer_pos =3D 0;
-
-	/* Start DMA */
-	dma_async_issue_pending(strm->dma_ch);
-
-	return 0;
-}
-
-static void rz_ssi_dma_complete(void *data)
-{
-	struct rz_ssi_stream *strm =3D (struct rz_ssi_stream *)data;
-
-	if (!strm->running || !strm->substream || !strm->substream->runtime)
-		return;
-
-	/* Note that next DMA transaction has probably already started */
-	rz_ssi_pointer_update(strm, strm->substream->runtime->period_size);
-
-	/* Queue up another DMA transaction */
-	rz_ssi_dma_transfer(strm->priv, strm);
-}
-
-static void rz_ssi_release_dma_channels(struct rz_ssi_priv *ssi)
-{
-	if (ssi->playback.dma_ch) {
-		dma_release_channel(ssi->playback.dma_ch);
-		ssi->playback.dma_ch =3D NULL;
-		if (ssi->dma_rt)
-			ssi->dma_rt =3D false;
-	}
-
-	if (ssi->capture.dma_ch) {
-		dma_release_channel(ssi->capture.dma_ch);
-		ssi->capture.dma_ch =3D NULL;
-	}
-}
-
-static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
-{
-	ssi->playback.dma_ch =3D dma_request_chan(dev, "tx");
-	if (IS_ERR(ssi->playback.dma_ch))
-		ssi->playback.dma_ch =3D NULL;
-
-	ssi->capture.dma_ch =3D dma_request_chan(dev, "rx");
-	if (IS_ERR(ssi->capture.dma_ch))
-		ssi->capture.dma_ch =3D NULL;
-
-	if (!ssi->playback.dma_ch && !ssi->capture.dma_ch) {
-		ssi->playback.dma_ch =3D dma_request_chan(dev, "rt");
-		if (IS_ERR(ssi->playback.dma_ch)) {
-			ssi->playback.dma_ch =3D NULL;
-			goto no_dma;
-		}
-
-		ssi->dma_rt =3D true;
-	}
-
-	if (!rz_ssi_is_dma_enabled(ssi))
-		goto no_dma;
-
-	return 0;
-
-no_dma:
-	rz_ssi_release_dma_channels(ssi);
-
-	return -ENODEV;
-}
-
 static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi, struct rz_ssi_st=
ream *strm)
 {
 	struct snd_pcm_substream *substream =3D strm->substream;
-	struct snd_pcm_runtime *runtime =3D substream->runtime;
 	int ret;
=20
-	strm->dma_buffer_pos =3D strm->completed_dma_buf_pos + runtime->period_si=
ze;
-
 	if (rz_ssi_is_stream_running(&ssi->playback) ||
 	    rz_ssi_is_stream_running(&ssi->capture))
 		return 0;
@@ -842,7 +701,7 @@ static int rz_ssi_trigger_resume(struct rz_ssi_priv *ss=
i, struct rz_ssi_stream *
 	if (ret)
 		return ret;
=20
-	return rz_ssi_clk_setup(ssi, ssi->hw_params_cache.rate,
+	return rz_ssi_clk_setup(ssi, substream, ssi->hw_params_cache.rate,
 				ssi->hw_params_cache.channels);
 }
=20
@@ -851,7 +710,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream =
*substream, int cmd,
 {
 	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
 	struct rz_ssi_stream *strm =3D rz_ssi_stream_get(ssi, substream);
-	int ret =3D 0, i, num_transfer =3D 1;
+	int ret =3D 0;
=20
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -866,28 +725,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream=
 *substream, int cmd,
 		if (cmd =3D=3D SNDRV_PCM_TRIGGER_START)
 			rz_ssi_stream_init(strm, substream);
=20
-		if (rz_ssi_is_dma_enabled(ssi)) {
-			bool is_playback =3D rz_ssi_stream_is_play(substream);
-
-			if (ssi->dma_rt)
-				ret =3D rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch,
-							      is_playback);
-			else
-				ret =3D rz_ssi_dma_slave_config(ssi, strm->dma_ch,
-							      is_playback);
-
-			/* Fallback to pio */
-			if (ret < 0) {
-				ssi->playback.transfer =3D rz_ssi_pio_send;
-				ssi->capture.transfer =3D rz_ssi_pio_recv;
-				rz_ssi_release_dma_channels(ssi);
-			} else {
-				/* For DMA, queue up multiple DMA descriptors */
-				num_transfer =3D 4;
-			}
-		}
-
-		for (i =3D 0; i < num_transfer; i++) {
+		if (!rz_ssi_is_dma_enabled(ssi)) {
 			ret =3D strm->transfer(ssi, strm);
 			if (ret)
 				return ret;
@@ -983,6 +821,8 @@ static void rz_ssi_shutdown(struct snd_pcm_substream *s=
ubstream,
 		ssi->dup.tx_active =3D false;
 	else
 		ssi->dup.rx_active =3D false;
+
+	ssi->dmas[substream->stream] =3D NULL;
 }
=20
 static bool rz_ssi_is_valid_hw_params(struct rz_ssi_priv *ssi, unsigned in=
t rate,
@@ -1034,6 +874,12 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substr=
eam *substream,
 		return -EINVAL;
 	}
=20
+	/* Save the DMA channels for recovery. */
+	if (rz_ssi_is_dma_enabled(ssi))
+		ssi->dmas[substream->stream] =3D snd_dmaengine_pcm_get_chan(substream);
+	else
+		ssi->dmas[substream->stream] =3D NULL;
+
 	if (rz_ssi_is_stream_running(&ssi->playback) ||
 	    rz_ssi_is_stream_running(&ssi->capture)) {
 		if (rz_ssi_is_valid_hw_params(ssi, rate, channels, sample_width, sample_=
bits))
@@ -1049,10 +895,21 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_subst=
ream *substream,
 	if (ret)
 		return ret;
=20
-	return rz_ssi_clk_setup(ssi, rate, channels);
+	return rz_ssi_clk_setup(ssi, substream, rate, channels);
+}
+
+static int rz_ssi_dai_probe(struct snd_soc_dai *dai)
+{
+	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_init_dma_data(dai, &ssi->dma_dais[SNDRV_PCM_STREAM_PLAYBACK],
+				  &ssi->dma_dais[SNDRV_PCM_STREAM_CAPTURE]);
+
+	return 0;
 }
=20
 static const struct snd_soc_dai_ops rz_ssi_dai_ops =3D {
+	.probe		=3D rz_ssi_dai_probe,
 	.startup	=3D rz_ssi_startup,
 	.shutdown	=3D rz_ssi_shutdown,
 	.trigger	=3D rz_ssi_dai_trigger,
@@ -1066,9 +923,9 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hardwa=
re =3D {
 				  SNDRV_PCM_INFO_MMAP_VALID	|
 				  SNDRV_PCM_INFO_RESUME		|
 				  SNDRV_PCM_INFO_PAUSE,
-	.buffer_bytes_max	=3D PREALLOC_BUFFER,
+	.buffer_bytes_max	=3D 192 * 1024,
 	.period_bytes_min	=3D 32,
-	.period_bytes_max	=3D 8192,
+	.period_bytes_max	=3D 48 * 1024,
 	.channels_min		=3D SSI_CHAN_MIN,
 	.channels_max		=3D SSI_CHAN_MAX,
 	.periods_min		=3D 1,
@@ -1076,8 +933,8 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hardwa=
re =3D {
 	.fifo_size		=3D 32 * 2,
 };
=20
-static int rz_ssi_pcm_open(struct snd_soc_component *component,
-			   struct snd_pcm_substream *substream)
+static int rz_ssi_pcm_open_pio(struct snd_soc_component *component,
+			       struct snd_pcm_substream *substream)
 {
 	snd_soc_set_runtime_hwparams(substream, &rz_ssi_pcm_hardware);
=20
@@ -1085,6 +942,13 @@ static int rz_ssi_pcm_open(struct snd_soc_component *=
component,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 }
=20
+static int rz_ssi_pcm_open_dma(struct snd_soc_component *component,
+			       struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_integer(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_PERIODS);
+}
+
 static snd_pcm_uframes_t rz_ssi_pcm_pointer(struct snd_soc_component *comp=
onent,
 					    struct snd_pcm_substream *substream)
 {
@@ -1101,7 +965,8 @@ static int rz_ssi_pcm_new(struct snd_soc_component *co=
mponent,
 {
 	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
 				       rtd->card->snd_card->dev,
-				       PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
+				       rz_ssi_pcm_hardware.buffer_bytes_max,
+				       rz_ssi_pcm_hardware.buffer_bytes_max);
 	return 0;
 }
=20
@@ -1124,16 +989,30 @@ static struct snd_soc_dai_driver rz_ssi_soc_dai[] =
=3D {
 	},
 };
=20
-static const struct snd_soc_component_driver rz_ssi_soc_component =3D {
+static const struct snd_soc_component_driver rz_ssi_soc_component_pio =3D =
{
 	.name			=3D "rz-ssi",
-	.open			=3D rz_ssi_pcm_open,
+	.open			=3D rz_ssi_pcm_open_pio,
 	.pointer		=3D rz_ssi_pcm_pointer,
 	.pcm_construct		=3D rz_ssi_pcm_new,
 	.legacy_dai_naming	=3D 1,
 };
=20
+static const struct snd_soc_component_driver rz_ssi_soc_component_dma =3D =
{
+	.name			=3D "rz-ssi",
+	.open			=3D rz_ssi_pcm_open_dma,
+	.legacy_dai_naming	=3D 1,
+};
+
+static const struct snd_dmaengine_pcm_config rz_ssi_dmaengine_pcm_conf =3D=
 {
+	.pcm_hardware		=3D &rz_ssi_pcm_hardware,
+	.prealloc_buffer_size	=3D 192 * 1024,
+	.prepare_slave_config	=3D snd_dmaengine_pcm_prepare_slave_config,
+};
+
 static int rz_ssi_probe(struct platform_device *pdev)
 {
+	const struct snd_soc_component_driver *component_driver;
+	struct device_node *np =3D pdev->dev.of_node;
 	struct device *dev =3D &pdev->dev;
 	struct rz_ssi_priv *ssi;
 	struct clk *audio_clk;
@@ -1149,7 +1028,6 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	if (IS_ERR(ssi->base))
 		return PTR_ERR(ssi->base);
=20
-	ssi->phys =3D res->start;
 	ssi->clk =3D devm_clk_get(dev, "ssi");
 	if (IS_ERR(ssi->clk))
 		return PTR_ERR(ssi->clk);
@@ -1173,16 +1051,43 @@ static int rz_ssi_probe(struct platform_device *pde=
v)
=20
 	ssi->audio_mck =3D ssi->audio_clk_1 ? ssi->audio_clk_1 : ssi->audio_clk_2=
;
=20
-	/* Detect DMA support */
-	ret =3D rz_ssi_dma_request(ssi, dev);
-	if (ret < 0) {
+	ssi->dma_dais[SNDRV_PCM_STREAM_PLAYBACK].addr =3D (dma_addr_t)res->start =
+ SSIFTDR;
+	ssi->dma_dais[SNDRV_PCM_STREAM_CAPTURE].addr =3D  (dma_addr_t)res->start =
+ SSIFRDR;
+
+	if (of_property_present(np, "dma-names")) {
+		struct snd_dmaengine_pcm_config *config;
+		unsigned int flags =3D 0;
+
+		config =3D devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
+		if (!config)
+			return -ENOMEM;
+
+		config->pcm_hardware =3D rz_ssi_dmaengine_pcm_conf.pcm_hardware;
+		config->prealloc_buffer_size =3D rz_ssi_dmaengine_pcm_conf.prealloc_buff=
er_size;
+		config->prepare_slave_config =3D rz_ssi_dmaengine_pcm_conf.prepare_slave=
_config;
+
+		if (of_property_match_string(np, "dma-names", "rt") =3D=3D 0) {
+			flags =3D SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX;
+			config->chan_names[SNDRV_PCM_STREAM_PLAYBACK] =3D "rt";
+		} else {
+			config->chan_names[SNDRV_PCM_STREAM_PLAYBACK] =3D "tx";
+			config->chan_names[SNDRV_PCM_STREAM_CAPTURE] =3D "rx";
+		}
+		ret =3D devm_snd_dmaengine_pcm_register(&pdev->dev, config, flags);
+	} else {
+		ret =3D -ENODEV;
+	}
+
+	if (ret =3D=3D -EPROBE_DEFER) {
+		return ret;
+	} else if (ret) {
 		dev_warn(dev, "DMA not available, using PIO\n");
 		ssi->playback.transfer =3D rz_ssi_pio_send;
 		ssi->capture.transfer =3D rz_ssi_pio_recv;
+		component_driver =3D &rz_ssi_soc_component_pio;
 	} else {
-		dev_info(dev, "DMA enabled");
-		ssi->playback.transfer =3D rz_ssi_dma_transfer;
-		ssi->capture.transfer =3D rz_ssi_dma_transfer;
+		dev_info(dev, "DMA enabled\n");
+		component_driver =3D &rz_ssi_soc_component_dma;
 	}
=20
 	ssi->playback.priv =3D ssi;
@@ -1193,17 +1098,13 @@ static int rz_ssi_probe(struct platform_device *pde=
v)
=20
 	/* Error Interrupt */
 	ssi->irq_int =3D platform_get_irq_byname(pdev, "int_req");
-	if (ssi->irq_int < 0) {
-		ret =3D ssi->irq_int;
-		goto err_release_dma_chs;
-	}
+	if (ssi->irq_int < 0)
+		return ssi->irq_int;
=20
 	ret =3D devm_request_irq(dev, ssi->irq_int, rz_ssi_interrupt,
 			       0, dev_name(dev), ssi);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "irq request error (int_req)\n");
-		goto err_release_dma_chs;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "irq request error (int_req)\n");
=20
 	if (!rz_ssi_is_dma_enabled(ssi)) {
 		/* Tx and Rx interrupts (pio only) */
@@ -1244,43 +1145,19 @@ static int rz_ssi_probe(struct platform_device *pde=
v)
 	}
=20
 	ssi->rstc =3D devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(ssi->rstc)) {
-		ret =3D PTR_ERR(ssi->rstc);
-		goto err_release_dma_chs;
-	}
+	if (IS_ERR(ssi->rstc))
+		return dev_err_probe(dev, PTR_ERR(ssi->rstc), "Failed to get reset\n");
=20
 	/* Default 0 for power saving. Can be overridden via sysfs. */
 	pm_runtime_set_autosuspend_delay(dev, 0);
 	pm_runtime_use_autosuspend(dev);
 	ret =3D devm_pm_runtime_enable(dev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable runtime PM!\n");
-		goto err_release_dma_chs;
-	}
-
-	ret =3D devm_snd_soc_register_component(dev, &rz_ssi_soc_component,
-					      rz_ssi_soc_dai,
-					      ARRAY_SIZE(rz_ssi_soc_dai));
-	if (ret < 0) {
-		dev_err(dev, "failed to register snd component\n");
-		goto err_release_dma_chs;
-	}
-
-	return 0;
-
-err_release_dma_chs:
-	rz_ssi_release_dma_channels(ssi);
-
-	return ret;
-}
-
-static void rz_ssi_remove(struct platform_device *pdev)
-{
-	struct rz_ssi_priv *ssi =3D dev_get_drvdata(&pdev->dev);
-
-	rz_ssi_release_dma_channels(ssi);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM!\n");
=20
-	reset_control_assert(ssi->rstc);
+	return devm_snd_soc_register_component(dev, component_driver,
+					       rz_ssi_soc_dai,
+					       ARRAY_SIZE(rz_ssi_soc_dai));
 }
=20
 static const struct of_device_id rz_ssi_of_match[] =3D {
@@ -1315,7 +1192,6 @@ static struct platform_driver rz_ssi_driver =3D {
 		.pm =3D pm_ptr(&rz_ssi_pm_ops),
 	},
 	.probe		=3D rz_ssi_probe,
-	.remove		=3D rz_ssi_remove,
 };
=20
 module_platform_driver(rz_ssi_driver);
--=20
2.54.0

