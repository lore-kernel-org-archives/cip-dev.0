Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7746FC3ABCF
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:44 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web11.10298.1746783219944424549
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Qn1xMNx9;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fbfdf7d353so2482652a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783218; x=1747388018; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMAMadtzjKgiF0MBv+JBrLukjBSCSQCM+MZ+5hAN9S8=;
        b=Qn1xMNx9JE0LSY1Pj5AELoRV49d5qtf6x9vbg6OMtSWilBotphE1oHEklthMgitFTr
         0aE6YAxoGWvKu99mA6tc5uocwOh9WRrvGxGbe7dwxiXBmJ9/UANSZ6oio0FpiA+SMw9K
         iw5/HlOZu1HDFmAcjI4mxBdW0CGw+d10P00UM2OChf5IeZKNg6dIBo4v7qXP8VDu1eTN
         Ow3eJ/c93nh5VNKAIsjwxGlhLelG5PuFnZ4dX9Q6LJB3jTxUDDsi3WZXx+g2cdOqfP/8
         W7ceO9gNH1MyGZnu5M0QzXBPGIPohcM87u3y8WlX46yTNariVhGnUGT+2x5LCeBO7Job
         jUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783218; x=1747388018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMAMadtzjKgiF0MBv+JBrLukjBSCSQCM+MZ+5hAN9S8=;
        b=a75o9nTu+rnkHSkR6EIEiejUC6fB/IMCK3cDh85viHkUf0PtXpaH/EclcHFbyMhQRs
         /lr3kwfWbXTTkKX9Tr6eB69FigzgO2e61KyLs75DRZRPd72kcS8+oT7DPbzQbRtFR5f5
         S3bWVklkWDr+qRCJoCVc+MinLV1vgQho5tIjhbCHcvl2MmT93R08tM/CPiOzm4nW6rDN
         Xc1A/dWXTgF4RazxvTBKn9kAb8/2skH/XShWp8iMF7nz/nZLa6S/OLiJrVTplYjCgy/v
         PWQ2IloYcng0t0R3oGO6UkuVNlj0uIt8iuhsiQyzdFE737xvjRMNsndh8hlbQfkMwZDo
         nmmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlu1ny0rxQDW3WZtbk8WImvz0lhaiHVPmMhuN1JZ68YfJKDca9w/g/j6yj2QAmil2SEbvv0cCq@lists.cip-project.org
X-Gm-Message-State: AOJu0YydIGYVhu9Yg0YBspTLsfYN9ZdzPFgXAOwIHEYtkblR9qR236xx
	fZgA8tb9C43pNJMo5JHP/0l5pWNW2Ixm406l/pZvoRiTsCmKMCL48YnKROm2to8yc/KyLvQLozM
	S
X-Gm-Gg: ASbGncsnBOyB3fR2AXSHe2NGh5mUmdpFuUd9C5y2CTjSs9VtKpUcD9ZBziZumjfgcBF
	gZ6UKpYB8B6U224/FbfJzNCF0YV9LUye40Wsn1TYoejQ8jP8lG8z7uy13Act5Um+pNTNp5SX3GL
	yOL8JgxnHwXH9tLY9wt3XC7p4Ml45/keE+vfqz2RBwiJaUQeLbos+QNseVaNj6qnPZ4YmZPKpal
	mNwWb/Bc52x4R1gc2U6lGt8rKa6uu1ktQK+71D/wmrn3dUjsjkYJDhyDXyi/6SQ5oJI7MtkvN3Y
	Mntw2UrXGVVstlsmLsfnB2+gOWe+HWrSY6FeSMD0MNxjWmT7/pkTVixN0l4KFjGmK43hqp83giW
	GyrOI
X-Google-Smtp-Source: AGHT+IHe/8Bxu6+rfzDcvHneuGUeRjRgU/SI6GBT4T5573XP36ve4trsJdm8LTQzNMkhooZjMZ386A==
X-Received: by 2002:a05:6402:13d4:b0:5f3:7f49:a4b6 with SMTP id 4fb4d7f45d1cf-5fca080a80amr1786013a12.23.1746783218313;
        Fri, 09 May 2025 02:33:38 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:37 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 14/34] ASoC: renesas: rz-ssi: Terminate all the DMA transactions
Date: Fri,  9 May 2025 12:32:58 +0300
Message-ID: <20250509093318.4014916-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18831

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 541011dc2d7c4c82523706f726f422a5e23cc86f upstream.

The stop trigger invokes rz_ssi_stop() and rz_ssi_stream_quit().
- The purpose of rz_ssi_stop() is to disable TX/RX, terminate DMA
  transactions, and set the controller to idle.
- The purpose of rz_ssi_stream_quit() is to reset the substream-specific
  software data by setting strm->running and strm->substream appropriately.

The function rz_ssi_is_stream_running() checks if both strm->substream and
strm->running are valid and returns true if so. Its implementation is as
follows:

static inline bool rz_ssi_is_stream_running(struct rz_ssi_stream *strm)
{
    return strm->substream && strm->running;
}

When the controller is configured in full-duplex mode (with both playback
and capture active), the rz_ssi_stop() function does not modify the
controller settings when called for the first substream in the full-duplex
setup. Instead, it simply sets strm->running = 0 and returns if the
companion substream is still running. The following code illustrates this:

static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
{
    strm->running = 0;

    if (rz_ssi_is_stream_running(&ssi->playback) ||
        rz_ssi_is_stream_running(&ssi->capture))
        return 0;

    // ...
}

The controller settings, along with the DMA termination (for the last
stopped substream), are only applied when the last substream in the
full-duplex setup is stopped.

While applying the controller settings only when the last substream stops
is not problematic, terminating the DMA operations for only one substream
causes failures when starting and stopping full-duplex operations multiple
times in a loop.

To address this issue, call dmaengine_terminate_async() for both substreams
involved in the full-duplex setup when the last substream in the setup is
stopped.

Fixes: 4f8cd05a4305 ("ASoC: sh: rz-ssi: Add full duplex support")
Cc: stable@vger.kernel.org
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20241210170953.2936724-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 542522422e56..a8e7b76b5b2a 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -417,8 +417,12 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
 
 	/* Cancel all remaining DMA transactions */
-	if (rz_ssi_is_dma_enabled(ssi))
-		dmaengine_terminate_async(strm->dma_ch);
+	if (rz_ssi_is_dma_enabled(ssi)) {
+		if (ssi->playback.dma_ch)
+			dmaengine_terminate_async(ssi->playback.dma_ch);
+		if (ssi->capture.dma_ch)
+			dmaengine_terminate_async(ssi->capture.dma_ch);
+	}
 
 	rz_ssi_set_idle(ssi);
 
-- 
2.43.0


