Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BDBFC5921
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:28:53 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78614.1772134131934871286
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:28:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=R4r1WNDq;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48370174e18so7108845e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134130; x=1772738930; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9yqmtTL9UB2lNZFbHEEY0/icaSl6b5zOJUQ8TA/J0U=;
        b=R4r1WNDqzqbHtDdx13qYkVb7zrjGusfMrJ1tJ2y1SYHL1ep+MoyRA5HDhYoiQGjMUM
         aVdy7aJJKOab30piLl02EWiaXJOPQmbmEJ/u8Qqa8lPjkpHy4h1TPyOMyV8DNa6CKp4o
         qsI3ewDWhexI5rXEAkPkoSRkTKA09U4HxNKgo2nEQiq/xpTl1Gli81tyGG3QnJ15rhPT
         4RFbSV9zdRiP22sz9zHT9g/cO8KiW4ycqlf9aJopzwrRIQGWfbGPazZujmUmOmoasUqR
         BMy/Y5AAuMzKL/RmQXEio0NaZY82oN67s5FnDVxHiDZMiQEPsUCss71DGrQvvPXdDq8a
         zDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134130; x=1772738930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y9yqmtTL9UB2lNZFbHEEY0/icaSl6b5zOJUQ8TA/J0U=;
        b=bQfHqRFaO4r+vXPCILh1Rb/uVlAk2OIuT2ThBrQXbSpmmWZkAhrHtNdfmlO1DC0z5R
         ZQh1+AXZFId3IeRXgnN2PGN9ZPmY/RD5uHYb2Xujdi0DduUaJ/hLWC+n6psA7UlS4SS5
         3HIgedbmrAUx/DToHxmse5pG1dfk8+HpZY375PROKuug4K+vXAmQ3bQG8AgH07CjPxD/
         FRGtymJ/H9oBwlSzH5TwmJdKELqiE/ASaxO+UJ4CiK8vGA9XxJiEd637kUOTp7144yeA
         I+4ZoUKgAk8gJZv7kFp3ivRoI2bfAuKv7o4afjjylh1Hs1f9t6jVEagYsnhukPE6pxSE
         tslw==
X-Gm-Message-State: AOJu0Ywkvc1op2ZlLIdqxktrG1H5J2jaZz/2HxHsD4oR8E80sqghMz1H
	Th0K3qC8SrAyNnsdXpBW28bB1DYYd9ItU36n0OaWQtbFFHQROUl1p3dsYk237Pyk
X-Gm-Gg: ATEYQzyu+PSdIEmu7jqbhkTNSZBAtynEpz39Ou3qQOYxAZtz2+iR+FFez0pFJGJT4hu
	1LCyKKxTjX4eARuT8v+SUJlE8ZLgrJVXxbd0xDT0fjpMwF6v4bRclgpfgHpyHfes2zrAgPrSkZy
	BaBPufogbSp2Fr0MGERW1ygoc++mUY2UiSRYZG/ePehIBCA5cxY4+bS1dua1OWl3Zfzqqf0BfOK
	kJeDcagQ6f1qw38TNI2RGxkpD2yUr/83ga3A33+i2VC7vOzn9nUGR4h2s1zYbtPqWPrgndZox/p
	FxnKhlEgosa4k7wi/cY2qg/m8FAYBu0It/9bqiBTwA108KiUQPj+WJIqsHvzHsYG8QaQnjBoEgX
	SwhvcsBDiDG/atTSQKZEl1PyGmEsF8g3QCAmgZgDa55MVuYUXTALkku4FluCdNkAMes8wN4xWwQ
	BsR5uu9RTtwYLsLje6Qz187XV2LJBnWZYAE2xxb9JgcDtAd20=
X-Received: by 2002:a05:600c:34c3:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-483c21bd28emr97088145e9.35.1772134130008;
        Thu, 26 Feb 2026 11:28:50 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776dfsm76701365e9.1.2026.02.26.11.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:28:49 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 3/5] ASoC: renesas: rz-ssi: Move DMA configuration
Date: Thu, 26 Feb 2026 19:28:40 +0000
Message-ID: <20260226192846.449277-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
References: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:28:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21999

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit b541cb0a27dfa7504a8008320502f869c75f8bfc ]

Move DMA configuration from rz_ssi_dma_request() to rz_ssi_dai_trigger()
for supporting sample widths higher than 16.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114075856.4751-4-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 7ffe26c17433..8c326bd4ba7d 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -782,14 +782,6 @@ static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
 	if (!rz_ssi_is_dma_enabled(ssi))
 		goto no_dma;
 
-	if (ssi->playback.dma_ch &&
-	    (rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch, true) < 0))
-		goto no_dma;
-
-	if (ssi->capture.dma_ch &&
-	    (rz_ssi_dma_slave_config(ssi, ssi->capture.dma_ch, false) < 0))
-		goto no_dma;
-
 	return 0;
 
 no_dma:
@@ -837,24 +829,27 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (cmd == SNDRV_PCM_TRIGGER_START)
 			rz_ssi_stream_init(strm, substream);
 
-		if (ssi->dma_rt) {
-			bool is_playback;
+		if (rz_ssi_is_dma_enabled(ssi)) {
+			bool is_playback = rz_ssi_stream_is_play(substream);
+
+			if (ssi->dma_rt)
+				ret = rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch,
+							      is_playback);
+			else
+				ret = rz_ssi_dma_slave_config(ssi, strm->dma_ch,
+							      is_playback);
 
-			is_playback = rz_ssi_stream_is_play(substream);
-			ret = rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch,
-						      is_playback);
 			/* Fallback to pio */
 			if (ret < 0) {
 				ssi->playback.transfer = rz_ssi_pio_send;
 				ssi->capture.transfer = rz_ssi_pio_recv;
 				rz_ssi_release_dma_channels(ssi);
+			} else {
+				/* For DMA, queue up multiple DMA descriptors */
+				num_transfer = 4;
 			}
 		}
 
-		/* For DMA, queue up multiple DMA descriptors */
-		if (rz_ssi_is_dma_enabled(ssi))
-			num_transfer = 4;
-
 		for (i = 0; i < num_transfer; i++) {
 			ret = strm->transfer(ssi, strm);
 			if (ret)
-- 
2.43.0


