Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17734FD4601
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:34:03 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78748.1772134435837293744
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:33:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e5NrRnz9;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483703e4b08so10971185e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134434; x=1772739234; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+1o3nhp8nCH5TquVySGC8xvK5df2MjN6IrToqFmLe0=;
        b=e5NrRnz9MImz70Xk2NtzMj2oN6lsV86O45nNAj+L023R9qwNxBA09teVKGhUGD7as5
         dItSrxT+O3b9qIknNrcYI3wT34mjUo+/VS/lszW0WW2IB/hsb2FjxIiyywMZxYkg+2fh
         8i+K/cyHw9WGBqTlAtskLX2jBNjWkA33bAsidoz6dObKHbKug53L9+ABM9p4apCQOjx9
         H08B11h9hVUKlAjwi2N8tsflzfp5rf+GyGLjGC6kgLeTS6Llh4mbmh7RTs8PUEZ50M0r
         OUoqeuRLYe/kmDxMHG1CTCFYtY3n+O1sXdEIzhL+WcoJozsA5gtH8TbizgxFWgYpbhOr
         phYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134434; x=1772739234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3+1o3nhp8nCH5TquVySGC8xvK5df2MjN6IrToqFmLe0=;
        b=wD3PncWVVyb2FxezfLzKRZCGGA3dxrvTB41J0SRACGMYtPkFzeLVLqK8pARSK3c4wI
         JexQYbFUJIgvkdbm7WrxmZJD5bcI1XDMFl7pInIF5BxQuyLHwqrW1O6wCq9cpbR8UcUD
         N5NUCM2M0fP8aE4UCZIv5SQ1/Aqt7nlPaRg/IlKU2lElY1/NkTs07cDLaaHvz0Ed34Mp
         HbxHvt/2WqVRvyWdcPmkA/7t4vP6sKaaEi2CrmgPUFUiA4NQ6FBx7Wa1EoMnVm60OOGR
         sk90kd3StmDljHLkU1AgasE03Rx5ssgC2kW/a5eVa67ksMLRmo1HS62c4zNU0fhaAIo2
         GoSw==
X-Gm-Message-State: AOJu0YzdzSYW7kyjMaXB6AuDZiI73oNR+sM0YyrgSStS0Qu8vXGLBbPX
	K3JZ1jGi05b2OHz9o0waitj3YeDHK6edVeAK2M4vZAbVOfp9jwnlTu3V0jcgRerj
X-Gm-Gg: ATEYQzzYrT9c65cA1BCTxBG3rTdrMO/kYzktmPCnIbJBsKXeAKT+o1W8K3Bc2Qb1SUG
	oq8GwAgLk16b5uumfCVdCa/DyvApfmFAC5LmLYnllzJLAvatQpIs9ZU2uChW6KUfpNVeLrbHuG8
	iDY0RbRRJ7nwYeMwF/miDfZroHSIdHbOpQPt6L+fUtdSmdWEyr37XR20zS2d/lDnuU3wnj7Mw6h
	2LfwCat/OsylWfxI9N94Kv+2lLdOVIkisCSWBJy26QKmxYAmCHADXbxp5nYFnmjFfrISgoWAhYI
	LWz1+3l+iDXB0gZVDrROhma7rZkchIguhrZxk2etydi2f+y1juIO6Wx2AIo2v7XJcj+FLvi6MmV
	wbHhHApvOJuniVhebKa80Xw5cuvKLrl7yBJi1LYFRu4gYZExEpZFXnVgQx8Z+0tqS2aZHKnZCy+
	ZNPVsxw+ul905AGYANKmBEtZCG3FdlQOW26JKSRMI5KcRB3bs=
X-Received: by 2002:a05:600c:1e8f:b0:47e:e051:79ee with SMTP id 5b1f17b1804b1-483c33c28f9mr69098555e9.3.1772134433829;
        Thu, 26 Feb 2026 11:33:53 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm167721555e9.14.2026.02.26.11.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:33:53 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 6/8] ASoC: renesas: rz-ssi: Move DMA configuration
Date: Thu, 26 Feb 2026 19:33:30 +0000
Message-ID: <20260226193348.449329-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
References: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:34:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22008

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
index f57f8e85e4d2..570313c50232 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -791,14 +791,6 @@ static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
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
@@ -846,24 +838,27 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
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


