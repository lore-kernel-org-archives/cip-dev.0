Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D522FD4600
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:33:53 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78742.1772134432485865328
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:33:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SD5BGY0k;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48370174e18so7129985e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134430; x=1772739230; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UU81Grlm4Ky78MldwQwddwIAvI4dBZk52QEZL8qnhGI=;
        b=SD5BGY0kIHOI+oU798FNYLnWy1WkRvMGWJ1Z1rlSXJ3N/UjyfPYpAUdkwSeUw4lQo8
         9VEjVXfrAa/FMMTVoEsQCOTbSM4m4rQ1j+G6Gjm7q7dNStVgDhVnogFLAXJhWhSaC5YO
         Seo83ycIZ83mu+UgAUzsgD1vtysuamDdyPScLE7IsLn8DoTyqZyXa9qBrLpSmqwMXgHL
         3qIJi/sU+pYM8p17eh+B0AQm3NI1EuOLrQdIZZm4esxjU19us+NxB1xvsEmMPJ3vLRKN
         JhGGUPSy2HJr6qEHegQWhjkiCS3pe7W+6jZxfFq/ADWvkZu1pwKKFusOMTT1P9/UHnhm
         +krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134430; x=1772739230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UU81Grlm4Ky78MldwQwddwIAvI4dBZk52QEZL8qnhGI=;
        b=tto/DiPs+EMrRMT7fC858LsrqepAjtIMIFZA2y+hh6Ls4pKoNaw7eRegd5GvgWsv4Q
         QiyDsLiHiHm14OG1//l1tA1mk8c7Z8eSB7lbPLVJnDGhoC+GuLln9jlRyh4Rkl1Aywri
         02GjR1zGZ3mrshRi9lpdKuv9KKb47aVao6rHCsHJ56Ve16Ih5gblM5gtwGcctzmS5+rf
         d/Mp/biBrPPTixBDTOhmijN05UoXL9KTlL0T4qlb3/L+PiJyLB0tCczXgQ8REulTA9pm
         q8VpLJtZS6GEPHp9u7ox/nrhFAZ7RV4xNCjO8Fi/bzOLr1ZPrkk1hQbIMjIDRE2IEChi
         YdAw==
X-Gm-Message-State: AOJu0Yy4v/iUORaY4BD8t8WCOuWgSOk5qrz2bz7VW5Z2/YscvV7TxO2s
	frbT59JqQKejVD7OnLvNAFeVniJxEhn3GfCSiQWd0/3wA4zo0tpE/w36bLnqt5j2
X-Gm-Gg: ATEYQzyDdfCwr6jZRm2fvMwQzNU+00wT7urSUhRTUsq3WVow7UcLyKamZ4IKnLVA+h7
	4mEXpLo3CnSFPSLt4WetiONQVrsgtG+6XF5TGEPl8DkuXy++W83eSYX2ohfhpCiMK+kOTKdw2h5
	MG+3Ox4hk6j8tqncTANbwx2KJp3HK177fYE/rFCDJfgtYKbs/gAdbT6XllBC1V5gwNh9N0vVvJG
	oAH+AyqFEqGtWWKOYIQRWSqqOrSYhg3lqFE2PGkyM+xou/J0Gqr1sISnDCF28Asmtbf5XVt4S1Q
	deMBATKvXEVfpt4VUd4cnthB0kiAWykhJEgJ/dmCgipug66/pH53L4Xo42p0P4l3OOKpmcKd429
	rj+CY1R5cX5ihvvYqDdsaWrMw0SjGkm2QTj9TJzy117ugIM4bnSm6jKZWBY8JEHYDJZ/iZ07CCQ
	DOhicfDBckKSkMk1MGx/819/jLwpI1uRqaHu2DZZxD5Hp35Mc=
X-Received: by 2002:a05:600c:34c1:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-483c9b9435cmr18215e9.5.1772134430467;
        Thu, 26 Feb 2026 11:33:50 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm167721555e9.14.2026.02.26.11.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:33:50 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 2/8] ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
Date: Thu, 26 Feb 2026 19:33:26 +0000
Message-ID: <20260226193348.449329-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
References: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:33:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22004

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 52a525011cb8e293799a085436f026f2958403f9 ]

The full duplex audio starts with half duplex mode and then switch to
full duplex mode (another FIFO reset) when both playback/capture
streams available leading to random audio left/right channel swap
issue. Fix this channel swap issue by detecting the full duplex
condition by populating struct dup variable in startup() callback
and synchronize starting both the play and capture at the same time
in rz_ssi_start().

Cc: stable@kernel.org
Fixes: 4f8cd05a4305 ("ASoC: sh: rz-ssi: Add full duplex support")
Co-developed-by: Tony Tang <tony.tang.ks@renesas.com>
Signed-off-by: Tony Tang <tony.tang.ks@renesas.com>
Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114073709.4376-2-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 51 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 19247a641a6d..2cf8b21567b1 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -134,6 +134,12 @@ struct rz_ssi_priv {
 	bool bckp_rise;	/* Bit clock polarity (SSICR.BCKP) */
 	bool dma_rt;
 
+	struct {
+		bool tx_active;
+		bool rx_active;
+		bool one_stream_triggered;
+	} dup;
+
 	/* Full duplex communication support */
 	struct {
 		unsigned int rate;
@@ -349,13 +355,12 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	bool is_full_duplex;
 	u32 ssicr, ssifcr;
 
-	is_full_duplex = rz_ssi_is_stream_running(&ssi->playback) ||
-		rz_ssi_is_stream_running(&ssi->capture);
+	is_full_duplex = ssi->dup.tx_active && ssi->dup.rx_active;
 	ssicr = rz_ssi_reg_readl(ssi, SSICR);
 	ssifcr = rz_ssi_reg_readl(ssi, SSIFCR);
 	if (!is_full_duplex) {
 		ssifcr &= ~0xF;
-	} else {
+	} else if (ssi->dup.one_stream_triggered) {
 		rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
 		rz_ssi_set_idle(ssi);
 		ssifcr &= ~SSIFCR_FIFO_RST;
@@ -391,12 +396,16 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 			      SSISR_RUIRQ), 0);
 
 	strm->running = 1;
-	if (is_full_duplex)
-		ssicr |= SSICR_TEN | SSICR_REN;
-	else
+	if (!is_full_duplex) {
 		ssicr |= is_play ? SSICR_TEN : SSICR_REN;
-
-	rz_ssi_reg_writel(ssi, SSICR, ssicr);
+		rz_ssi_reg_writel(ssi, SSICR, ssicr);
+	} else if (ssi->dup.one_stream_triggered) {
+		ssicr |= SSICR_TEN | SSICR_REN;
+		rz_ssi_reg_writel(ssi, SSICR, ssicr);
+		ssi->dup.one_stream_triggered = false;
+	} else {
+		ssi->dup.one_stream_triggered = true;
+	}
 
 	return 0;
 }
@@ -932,6 +941,30 @@ static int rz_ssi_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static int rz_ssi_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ssi->dup.tx_active = true;
+	else
+		ssi->dup.rx_active = true;
+
+	return 0;
+}
+
+static void rz_ssi_shutdown(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ssi->dup.tx_active = false;
+	else
+		ssi->dup.rx_active = false;
+}
+
 static bool rz_ssi_is_valid_hw_params(struct rz_ssi_priv *ssi, unsigned int rate,
 				      unsigned int channels,
 				      unsigned int sample_width,
@@ -1002,6 +1035,8 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dai_ops rz_ssi_dai_ops = {
+	.startup	= rz_ssi_startup,
+	.shutdown	= rz_ssi_shutdown,
 	.trigger	= rz_ssi_dai_trigger,
 	.set_fmt	= rz_ssi_dai_set_fmt,
 	.hw_params	= rz_ssi_dai_hw_params,
-- 
2.43.0


