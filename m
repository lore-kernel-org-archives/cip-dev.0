Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B8FFD9E0A
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:42:43 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78941.1772134961889401352
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:42:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LQAAVxTV;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439857ec679so1088073f8f.2
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134960; x=1772739760; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd/h7HN+yFiZhZj+v7XM5djUF+vpxZtrnQ+liLQrvyE=;
        b=LQAAVxTV65+dH/j1+nMPSM3LqbHnrxwbzSmmg4pWZIeJgB+ceZXZ7AjDmISLorMBDT
         zvcalic3qy35id62kF699eZqCg5kFYcfYNhnq/Cz9fvFuEV7pPK+jItVzX1FOHEh5fs8
         toM+Cjy5C6qzRsdHRbn3T5nQjyoQe8LVrGLRyuRCUSxv1tfa0GaUKQrZCiQeiywAXfHr
         tQ4Cxa0Vx/EQNzdnE2puFeLEmrcHdRmkiyMr+26ET5hM5EHO4xh9ObuyaBciPzdjnQbn
         CUdv4vb+kMmyIis+/cqbdI5iByRS0In3Skkn+0nd2QZ9FokxrF/yn8XYPhH3e3WPFPPB
         2TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134960; x=1772739760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hd/h7HN+yFiZhZj+v7XM5djUF+vpxZtrnQ+liLQrvyE=;
        b=iOEW5v9NQqi7tEb6mldlbnH7xWnHRDzO8MZ9qJRzBPakf7JmDGRbO4A7B79LWu+MlC
         z52WaVGoYB4IaCJdPDuC024pmMwzUOJT53ZCVXjKVzhVZ1PgN/xYPaeP8rpUSTts5C1K
         BYj2Mp7jaoW0iGsRTaksKhg9XDbACf0eSO0UVFV2T9WoMu9pz8p3MQzMUgUMmlc8SR8W
         jtxldscwNSsFFrvApqkLQ0JswJoVS5Lsciro45ylxu5IOsQs8cDzsPhzZ/fRkkcg6Not
         0R/HRQea9cZGdmKs5iOSswsLw1H7K2eKnFIXj43Xt2cxGWsIQMCUM7WlRknBSJZg+DT+
         Z8Vg==
X-Gm-Message-State: AOJu0Yxs7wKxp0cyAD21GgPmzWaJ20rtg8Lmc873VcAKDhhLTtJnaYD0
	mpFBk04pfhreIfFOuAoJuBYAJMq2dUy1woHFTTd8NRy+332oOzBFZMXRwsLTStLK
X-Gm-Gg: ATEYQzwf0fJ7JQTQl5jxAF8NzNyOgxfIUgIZ52+nECleorLiJDj1ckKgpJZII8zHaDF
	cdiCC0qe0iSPXQguYy1h+cxfXee41jGEuDbINalSqWQu5dogRLCDcKCLoc4Caq+82WEH/GJhCpN
	UQ56Ne3PgNZxkWq4fGNyfitH4muscMEROHJdOTlCq6KLrJ7F8hO/ULnDaoADZVUexiWXsBY9cZS
	WeL295uVRjx+hbdCzx3m5ON+CaQ5NInwo/3DJZzjoZao2CEYQm2VLxeiTiCuQbr6oTN12LggK35
	aZnAu5UDsAB5Wx0WG9M1uAGqY/PFITYySj/dY0Hyqt2NJDdi7ToZZjtOQ4CXIJDcxM0yq2VYHLD
	1SLIUf9XM9mOb5h85+Jcy4PWrolSEjVEnvhOslzasYAn97vu6dDkZtGJKH6w0NphIZAML7hoNPw
	2DEk6kodMLvKA2Aou3Mkby0riqS2azvc1a75JUb+9EwoBvc5Q=
X-Received: by 2002:a05:6000:2287:b0:431:a50:6e97 with SMTP id ffacd0b85a97d-4399de27bbcmr27521f8f.34.1772134959900;
        Thu, 26 Feb 2026 11:42:39 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c6100b8sm1854324f8f.2.2026.02.26.11.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:42:39 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/9] dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
Date: Thu, 26 Feb 2026 19:42:23 +0000
Message-ID: <20260226194237.449383-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
References: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:42:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22013

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 747213b08a1ab6a76e3e3b3e7a209cc1d402b5d0 ]

After audio full duplex testing, playing the recorded file contains a few
playback frames from the previous time. The rz_dmac_terminate_all() does
not reset all the hardware descriptors queued previously, leading to the
wrong descriptor being picked up during the next DMA transfer. Fix the
above issue by resetting all the descriptor headers for a channel in
rz_dmac_terminate_all() as rz_dmac_lmdesc_recycle() points to the proper
descriptor header filled by the rz_dmac_prepare_descs_for_slave_sg().

Cc: stable@kernel.org
Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20251113195052.564338-1-biju.das.jz@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 2d31c583508a..71c37d5e3227 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -533,11 +533,16 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
 	unsigned long flags;
+	unsigned int i;
 	LIST_HEAD(head);
 
 	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	for (i = 0; i < DMAC_NR_LMDESC; i++)
+		lmdesc[i].header = 0;
+
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
 	vchan_get_all_descriptors(&channel->vc, &head);
-- 
2.43.0


