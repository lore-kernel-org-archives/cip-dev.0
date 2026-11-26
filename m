Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.310.1795708124618921798
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:44 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=K3mtEdP5;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nz2VYNh8IKmcx5AU9CwhFDc1qoo9Ns/oNQGZB4RnVKBwNjtMr6nFKJ+KZMR5hFZijb58myZXHoVRRrHWctVgJwKWE06g6uPFL2+ycCpgXY1JZBvwtaxhEuHo6Ig2vW4iroU6K3RyOiBwZD7+Q0rHG6jwGkT+Wn1FN1AlegAJFBjQu4pt0tCR9CD6o6C891PwpW5CUj2sgT+wr+8WjhxBFeX2dOpkqcJNy8f/20k1wziQCHuAEG6Eo+PSTr7P/DdwLd21Cy2H/BoPxwPeFceFGtnLJDd/ScWMg2Y4GB+UAA9AzPJ4gF7TBmv3fw4rzOKdq5EmEofieX+dVLbmNu62Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzm+BV4M8/lyM4jBkyra97rGf5gib7icMXYcUMVscNc=;
 b=BGu87lwCeisC2spUhvbtqPTvyXv8bBxnDzTxoRyCz/B4i+0WvlcN0yTBExsY7OTrgDbsmL9FHFZlRR3lMB3SVr9UgPWWTyJHTfx07M6i8Ym8EzzGrvhsnFGniwV8TXTkSrMFnfWac0luy8sXxP/iI/Tk52tzXiRiLiKohfy8PT1POgGLDQTP6XXIXa3oKG3tLO76jCfQvnvZtPJWb6kFyfJV1l/yNCvPmIJlfHnua3OuXooND5RRX0v6cosVTF+2ahAFTkM/cC4BsXLDzoG+A8PEIx/HWIFiQ8LAfcO8x0JXmQhRee8ANfgFR6U7om8NTYpvQzZZ162mEqZLa/6iHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzm+BV4M8/lyM4jBkyra97rGf5gib7icMXYcUMVscNc=;
 b=K3mtEdP5BgwLaWss3/8Ltl4wP58xh2tg87vME5mOCyeeKze9EH5dtRNUtHaUWIvH05XJhFtE5INMY4kW44qp3YDohs5i5QA8Bw6Q04V2t7UubgB/HU26Fh1SZLggJzlH6CqTUB+1bnA4LRXp7FHbmVsetyCywRF4r9V5LZfHH7E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:42 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:42 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 11/27] dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
Date: Thu, 26 Nov 2026 16:47:31 +0100
Message-ID: <20261126154747.3832917-12-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 29a8b1c4-e66a-48f7-a803-08df4bd4bf2c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009221227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: pF6Qd9YbkDCHDFodAz7JAu8ZSvZfk0+/heN73TzO2O8JQPAHQOYskQHQiTNNE2gnQo8w+hhYPXixLB2wjBH7lvzPVhbW2FLndNACVS1KLYO5v9gipg+WV1cK+MPqb92pnxWvy9lam8oUsm7KBuCONBjL+UFzB9Tp3nu4R/Tm8r9ZPPdhIRzeoIHMHBm3jabkvkOpyWUwbwTBGScQ3aHVaWOF17emX1pI1ZzqYZtE3QaZSV/Bjqy1YIAtlXkw7DOKk5HseGIkbQY6ggEDb+JMzY48XKtsrPBmsIhVBlVTfIzNULmSkJlxKudgEAAroXeeF+uahvLCKropWf63zDtbfjPJPIcNaV6L56RHbz040Y9hb4TE6y2EHbwHhB90f4AVxiu97NfH4bpdyaoIrmaTlJZb4Atg0PTvE113NSX8nx6UWSYSQ96Em7UR9IRVwUZdtFBv6NWL+haVMzI1GlmiF6q7jDlvdeNRJUITRC7wS8OZQAWNiTVuOVRLlPdlCKy41mY7o7vNFP4qJfIENVgf1n3OacAr478ewOTVhIgegShT0fQ0N3nXs0Q8a8XXBVcrSELr5kJHJSUD+V1k6Gr6LuPjQ4uBFaiw0hUkRpc7jHZV5IAXpwC78hNE7s3oBqJY/5fnPfipBl3YfRP+4OJjBDeAOUnp4O7GEJyM/BpKy8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EVyvhI2Y0X144044VhD7G1JSJmSc9LXF2kt/69CnXz7SnLvv0tmUAireOSmP?=
 =?us-ascii?Q?IA3lxAWgSqLRsuHD5lXWcU4HdFWfhR794nNdlGh7CQjJZYfsugk3uJVePraX?=
 =?us-ascii?Q?D49EIye4tUFUWIYxfZxs1AitpwE6LAa8CnrVj+1EI3Xdk7a6QUqxsmh48VVk?=
 =?us-ascii?Q?pW5aARAqPntv7E8IAVpO95WnfI78vHVyJtRuqbNxtWtqrhJY+cXGYwkrl6Ws?=
 =?us-ascii?Q?/ipsleyfLj1r+tfhYKrW9lzYe8WEsHhH1CXlBrNwb0dIbnXy609eNu6/xDmF?=
 =?us-ascii?Q?tpdEaR/maNEuYIy3Np/KscCsQ4qk1+DSgabAQVXEm4jFvez60xdHeMes17mP?=
 =?us-ascii?Q?Kz2F30pCtQlJ47xNkQKoSGdjXxXLHcFnUaa3ClX7W26iVFdEuvZH5yC4nlPM?=
 =?us-ascii?Q?BTdcbxquCIcHYwJKyuGM40wSw1SAWyNqPcstC+Jxs0Q04NWZnKLeiivNWcxz?=
 =?us-ascii?Q?G5j7M6c4f+JR73L3UqOnl0Rbjye5UFg3YA1BuLNl2S2XxHndnBHyMvhq1kGT?=
 =?us-ascii?Q?QsjEEpwt2qOFJq2eQoUgCOPh8E55DJ1y6JBv3Gr5WSMchCnUBQge3ZGfdD8h?=
 =?us-ascii?Q?qooAVWFPKcr5EddycsiFgOtWhVp8kpmulwma7DzPnKoOTRqCdtOXCbjS3n40?=
 =?us-ascii?Q?2Z4ZghtijUAYfds/vrT+0L5UX4rVz+nGhd6QX1I9an5nYM7JPlobqzd7cIJ7?=
 =?us-ascii?Q?8n5UVkOByZzxFwu8XGHirZ5BzTaWZEQLxEmC8Iv8ztEUv71NFNCdkNAmIjSb?=
 =?us-ascii?Q?C7IiZugKe04ROJyhgzGx2pZ9HRNzSHkiE+R00GiMMSVCQ1eGF9iVo1Zwn4YF?=
 =?us-ascii?Q?rX1wd9BrPVBqARVOiJdPNhFHLocNLjXC8cAynjEQkW289gV4RCuuOljnCou1?=
 =?us-ascii?Q?rmTonNuv1+9G4btJTywJSt8/sEI8F4pMvRsfqPY7h4BW4Xx5b3mcLKLUvwsU?=
 =?us-ascii?Q?/WgdysdJTuI6WXQienEju/XeGGjn1xjhi5oVAVuDFgC2/Ru1mt1RFszMvk+Y?=
 =?us-ascii?Q?APNI0Q2NESLVOi8s+raZ5CsnsfwNFJPirKeucrwFt8m6KM0Mte+nJpr5w069?=
 =?us-ascii?Q?1AkuHrKscDfLnYlX27Qty+gcK41PaxVI6G8FUBybc+wihE6Fo2UEsxvRPkLP?=
 =?us-ascii?Q?mQujIEZg/0x4r75GCbLOUNaQFPTXr8HYSOYNoIYyWKrjNyYWnHEcYekr9L8x?=
 =?us-ascii?Q?sqehV8wwx9+EFPasuF7tKl+QTYmztOG5rF4icP3+D8Ib8hdfZT6bhYJzlJDh?=
 =?us-ascii?Q?+PIQzaNB8ePI8f5nHuCfk+mlQrrXp3YvZtB0JcJzjHLZyB/xOiUgfQmkrOFC?=
 =?us-ascii?Q?V22Cy3vhbvwvAwJa0jAoCr0zfjcNyQEeIGnxS6aihk0qT+vS5/4B+A3d4k+Y?=
 =?us-ascii?Q?6aPpLpdfLKF1U3EWHzcIyxGLtq3UBw0FxpOUMJEIwQKTvMNcmdjpBAX9bEr2?=
 =?us-ascii?Q?8Xpk74M1EzDqOiQIVeLLCQxhAACy8xSyE3L21WuTDgsABw1ySSD4yhWRAXmZ?=
 =?us-ascii?Q?LegzRsvY3rUo0zBaoewo+o1mXkuBR+ZA2ruC4wMuroVXX9hl1aPHRo6WKuLE?=
 =?us-ascii?Q?vGvc0wJT+QfsSLVx9HAmDd4CszKhnvKSpae5zZqvoVy20HLC7ByMNpfziI1J?=
 =?us-ascii?Q?hX/3oojxfTfpWUeyuJpXbfsb3CK2J5/Oag5XABSXBv388x9tLUuLadPYpdn9?=
 =?us-ascii?Q?vz45gJttdk7V02S0scCjbwaOoKxhwUcTYE/6NZCgeDpjzqM8BsT2aref8q0+?=
 =?us-ascii?Q?0svBGlTRm8eRVIkNmugDyGjPbbtz61ggffqt+ng2OmjjOL4V6SxL?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a8b1c4-e66a-48f7-a803-08df4bd4bf2c
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:42.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3C0ZqxnYSZ9NHXx/Q6qEBXmJ0nVxfpJP+I4HdllwVVuEZx864bU/SEIKWvbSHfByXdzII230mFeCg3zd8rlAVz8twv1wtaN8ZLBY99Rp2xEwW7X8vnPUbmX0sJQI40wM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25161
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

commit 44f991bd6e01bb6a3f78da98eafa6d2a72819a2f upstream.

The RZ/G2L SCIFA driver uses dmaengine_prep_slave_sg() to enqueue DMA
transfers and implements a timeout mechanism on RX to handle cases where
a DMA transfer does not complete. The timeout is implemented using an
hrtimer.

In the hrtimer callback, dmaengine_tx_status() is called (along with
dmaengine_pause()) to retrieve the transfer residue and handle incomplete
DMA transfers.

Add support for device_{pause, resume}() callbacks.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-9-claudiu.beznea.uj@bp=
.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 49 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index bf0d7b6f5511..84d662ad798d 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -139,10 +139,12 @@ struct rz_dmac {
 #define CHANNEL_8_15_COMMON_BASE	0x0700
=20
 #define CHSTAT_ER			BIT(4)
+#define CHSTAT_SUS			BIT(3)
 #define CHSTAT_EN			BIT(0)
=20
 #define CHCTRL_CLRINTMSK		BIT(17)
 #define CHCTRL_CLRSUS			BIT(9)
+#define CHCTRL_SETSUS			BIT(8)
 #define CHCTRL_CLRTC			BIT(6)
 #define CHCTRL_CLREND			BIT(5)
 #define CHCTRL_CLRRQ			BIT(4)
@@ -804,11 +806,18 @@ static enum dma_status rz_dmac_tx_status(struct dma_c=
han *chan,
 	if (status =3D=3D DMA_COMPLETE || !txstate)
 		return status;
=20
-	scoped_guard(spinlock_irqsave, &channel->vc.lock)
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		u32 val;
+
 		residue =3D rz_dmac_chan_get_residue(channel, cookie);
=20
-	/* if there's no residue, the cookie is complete */
-	if (!residue)
+		val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
+		if (val & CHSTAT_SUS)
+			status =3D DMA_PAUSED;
+	}
+
+	/* if there's no residue and no paused, the cookie is complete */
+	if (!residue && status !=3D DMA_PAUSED)
 		return DMA_COMPLETE;
=20
 	dma_set_residue(txstate, residue);
@@ -816,6 +825,38 @@ static enum dma_status rz_dmac_tx_status(struct dma_ch=
an *chan,
 	return status;
 }
=20
+static int rz_dmac_device_pause(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	u32 val;
+
+	guard(spinlock_irqsave)(&channel->vc.lock);
+
+	val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
+	if (!(val & CHSTAT_EN))
+		return 0;
+
+	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
+	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+					(val & CHSTAT_SUS), 1, 1024,
+					false, channel, CHSTAT, 1);
+}
+
+static int rz_dmac_device_resume(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	u32 val;
+
+	guard(spinlock_irqsave)(&channel->vc.lock);
+
+	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
+
+	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
+	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+					!(val & CHSTAT_SUS), 1, 1024,
+					false, channel, CHSTAT, 1);
+}
+
 /*
  * -----------------------------------------------------------------------=
------
  * IRQ handling
@@ -1149,6 +1190,8 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
 	engine->device_terminate_all =3D rz_dmac_terminate_all;
 	engine->device_issue_pending =3D rz_dmac_issue_pending;
 	engine->device_synchronize =3D rz_dmac_device_synchronize;
+	engine->device_pause =3D rz_dmac_device_pause;
+	engine->device_resume =3D rz_dmac_device_resume;
=20
 	engine->copy_align =3D DMAENGINE_ALIGN_1_BYTE;
 	dma_set_max_seg_size(engine->dev, U32_MAX);
--=20
2.54.0

