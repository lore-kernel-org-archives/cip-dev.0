Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4B6FD7091
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:34 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73579.1773746245925517153
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=N1IsqFi5;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4853fd7b59aso34687365e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746244; x=1774351044; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FolEl5fjwqCfV2oJioEsRcHorVguRMKLt74vUdS+RSQ=;
        b=N1IsqFi59IQbwnG1VaSWGXfP/gydKMfCssKurM/VrzfTJIbdET3dKL8C8ck0G3wlRi
         Y5fogci7s6tlRFGQFKD9eHevDL4OIeR3SFMpknw38LdLS8oVash16arqOI6vP/2+I+ej
         OTtEpWQbqTtcQGGPWd6Ax2zPBOnNUPtsM7L2ja7DRckRqix4ivgrqll+hbWTB6nR/0SZ
         baSVsXog2MM4Z/YNOlEpQrr1WcjYL6COdaJuGU1gHjZ/b+HhHYc5YcxT7sqZRORxRuDr
         pZ+IqETly7Y6Ri+Wgb9roGMdwHAkCzZ5FTKgVRB2VRmREbn9vOpScPqAVAzvlI3HNxat
         O+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746244; x=1774351044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FolEl5fjwqCfV2oJioEsRcHorVguRMKLt74vUdS+RSQ=;
        b=BGjXmcZ3npk/xLGStsF/cf85a/66vdlFzQ7b8kZ/FLtSyMu9KA5qC9P80kKdBCeNTo
         2v0Ii7Ow71cfY758kELPNwvrwIBRZcKVDQ3go7qzLG2WBDYbiYbrLFZzGqhKc5SmYMHW
         RNA7w3yjdYqhtj8hGTa68VCg3VpmCPNnOM7235VML9S1+GyjJ3arywsebtu7ycvDz07J
         M0rUc+In88n0nksF2TBsJevKUFgsVISxICJmAUleY4A5YTX5FhjbS9YLrBifMaaglgrH
         fFj5HTjszp+Dicb1ClML5Dpjl+oCo7a8+VRc/cpoqayIFrgbjeDcJGB/31n2Bls7c8XD
         D7SQ==
X-Gm-Message-State: AOJu0YwR2VFwCd4ah7BQAjvDvOwdiQ8Mu9T6gNoMOngD40L4mW7Mo66W
	andITJstKjpthr6J6hT6Z46f/73If3FPVKUxRK8+BQhqOHZofGksZZLFn2IE+Q==
X-Gm-Gg: ATEYQzyopJH+OL9O5A9kCgx8MtBd7qIbbL1jdWhl7oTjY91o5otzeN1H5FcGicGOT5K
	uu3+LVWsRZ733eR4GZM9DDOmF2/O0IGSwccJaghyTQ3hP8TKRouOrKpZPaTJlgUKq63jtblpOXG
	3n+VDzQaYTGdiFW/XR9fezNWQ/VywAWicTAFty9rGhTNik6ckNObJoqVJUdM9LKaNo3+7lt5wLV
	V8RRPyaSj/xlohUgIEHn7dR8+Qlr01bqboON3UOekNwWKMRLETLz2w9Wei909ZxIBogMONUVdJu
	GUhc2bAnRl9id5Ru6Vw2Nw1YCfjs/nX+FM/OUjhbvl1mAI1Ltb50TbnwlgYrjy7P71aWzCM8ui6
	B0mSU9Rp+U0dCAHZ2gNz/6xo9XOmurY7nJCBBlh2dInjakNRyw6BmhBFkvbD2ZlWlyY0qVbPzsQ
	QVjM5NveKo03WNamzEGBCmtm62JxNEaJoY04xDzCt0XFtTbxdh
X-Received: by 2002:a05:600c:1e8c:b0:485:41c4:e2e5 with SMTP id 5b1f17b1804b1-485567090cdmr258359335e9.27.1773746243514;
        Tue, 17 Mar 2026 04:17:23 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:23 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 05/39] serial: sh-sci: let timeout timer only run when DMA is scheduled
Date: Tue, 17 Mar 2026 11:16:30 +0000
Message-ID: <20260317111718.281633-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22438

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 0c9c1ea583f1b9887d248dc26f6921c4ae826b96 ]

The hrtimer for RXDMA timeout was unconditionally restarted in the RXDMA
complete handler ignoring the fact that setting up DMA may fail and PIO
is used instead. Explicitly stop the timer when DMA is completed and
only restart it when setting up DMA was successful. This makes the
intention of the timer much clearer, the driver easier to understand and
simplifies assumptions about the timer. The latter avoids race
conditions if these assumptions were not met or confused.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20240506114016.30498-9-wsa+renesas@sang-engineering.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f29268bcec35..6db637c8aa18 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1385,14 +1385,14 @@ static void sci_dma_rx_complete(void *arg)
 	dev_dbg(port->dev, "%s(%d) active cookie %d\n", __func__, port->line,
 		s->active_rx);
 
+	hrtimer_cancel(&s->rx_timer);
+
 	spin_lock_irqsave(&port->lock, flags);
 
 	active = sci_dma_rx_find_active(s);
 	if (active >= 0)
 		count = sci_dma_rx_push(s, s->rx_buf[active], s->buf_len_rx);
 
-	start_hrtimer_us(&s->rx_timer, s->rx_timeout);
-
 	if (count)
 		tty_flip_buffer_push(&port->state->port);
 
@@ -1415,6 +1415,9 @@ static void sci_dma_rx_complete(void *arg)
 	spin_unlock_irqrestore(&port->lock, flags);
 	dev_dbg(port->dev, "%s: cookie %d #%d, new active cookie %d\n",
 		__func__, s->cookie_rx[active], active, s->active_rx);
+
+	start_hrtimer_us(&s->rx_timer, s->rx_timeout);
+
 	return;
 
 fail:
-- 
2.43.0


