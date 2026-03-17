Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501DCFD7085
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:33 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73431.1773746246207632641
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LCnOORNM;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso47721565e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746244; x=1774351044; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwsvH0kYjkP++5twEFjyX9+HaysIGJPePPn24qddbBw=;
        b=LCnOORNMy/jlsulrTW5gZ0A7YXp2L8IpToVsvxvYgDXeVrJhs6YRJz6u0ZXDg3qi0K
         tcD2SYoyOEw3ETZV8ZjeZ/92CeJvCxPnY9FWCpn7pFpw20VqbVizUkDECf5oX+gy7CXa
         LtLn0cL5v27iGpiYlSVs8VQScB6jzpTTqve8Kwr8wGnkV06krS/DsnXS8jzjW2tI2vwa
         In2Az9ZwAMAOvuT8qlX2Dr3dxacgUjnG3iSqm5U4n9wIlBNAPZu8F7Mnp11ZDDtqRJ0K
         W+x/b8moovwZbYUGydiubSOzNoCELl+0bPaDGR8SajjO8Jd/6v/atOYgRD2N0myllxes
         QSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746244; x=1774351044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YwsvH0kYjkP++5twEFjyX9+HaysIGJPePPn24qddbBw=;
        b=hTuEsydmZ6OEnlSRfTSHn2Fxk+sCvPrcPNPl+IjGlqniIfYiVg9ih1RmKmlEb3aAzs
         wOjUjaq58BtNk08IKoiqQeShvGJNMZszneEgDg3BmAx2Ltaf50V8w7aTAdNRo1fl6q9O
         +/NQRCCymDpPIKlEwjz+wPg5fng12Q7wzDTQB2x7evKkP8p0l8caVfKQNIPnHLexUBH+
         JQqakVvujyOKTGN/fEWfFjSqMkeqWyZAus82jhFQ5zqioOaPAvZWeYyzWYg423G/ZEFg
         JArdh4I3bjHNHhNiG7IVoSCma+lYSL2VI0ZCogGoO8rkrtfCbzq2b1/mlPRlQXNsxV7o
         uYAw==
X-Gm-Message-State: AOJu0YyoCCOMz8g9Bep4mIzpTra1zKtyb/9urnXfYBazHtWtHHFjxDvp
	49UT5/aGcCDExdhzoHAmiyMbaDgrIq0LW6gjeutsFSs8Olzzc2ZErGxo0+8tbw==
X-Gm-Gg: ATEYQzyT7UJOZzLcMsHN+qlgL7soncgkvAZ73mtZ0tFKW6tmD/2NDihpN2zSX/vdiLu
	/U0Xz3W5GvYcDLqa81jsdioAPhP0jh37oPvBThNr2+L4ZzpwqJt3WPhQrR1WDssCBcNkisasaWu
	LgzftIRY9k9XiTJJWIHAW8O0bJQ0e7GX6lzButEL6mhqo8m2oOoqpT03P9rsour701zmiAk3OQH
	Y0gbguNTetl7bN7CFgp+letO8VI6Xd9Ewk2jf5U2cbpRR/OizwULgajFjLyIlLsVTxgR5EimQLc
	8hYQUGeiT2ZKyWDFzw4D9MvWIQaYtC5laSl+Jg/jbtEegYSN7So9jN8GnMtz6qzw3zPMI1P2g7l
	QvI4rMKhYCP+W8SEkdaMcutjpUv6FxFJsk/U/s/exyg3jmDSRSY0xgX9Wu9YqT27YsfMGDyilQ7
	Dd5v7BLrZ4fA7/pA9+owAGCXvwuJ30k2zZzqp5xR6KgBIk8N8f
X-Received: by 2002:a05:600c:1d0f:b0:485:309c:2984 with SMTP id 5b1f17b1804b1-485566d2dfbmr280806765e9.13.1773746244194;
        Tue, 17 Mar 2026 04:17:24 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:23 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 06/39] serial: sh-sci: simplify locking when re-issuing RXDMA fails
Date: Tue, 17 Mar 2026 11:16:31 +0000
Message-ID: <20260317111718.281633-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22439

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit ae1b6b4c0a0c93a53cb897e54c84079a017cd9d0 ]

Avoid a superfluous unlock/lock-pair by simply moving the printout to
the end of bailing out.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20240506114016.30498-10-wsa+renesas@sang-engineering.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Biju: Retained spin_unlock_irq{save,restore} ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6db637c8aa18..06f6e1c7cf5c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1421,14 +1421,12 @@ static void sci_dma_rx_complete(void *arg)
 	return;
 
 fail:
-	spin_unlock_irqrestore(&port->lock, flags);
-	dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
 	/* Switch to PIO */
-	spin_lock_irqsave(&port->lock, flags);
 	dmaengine_terminate_async(chan);
 	sci_dma_rx_chan_invalidate(s);
 	sci_dma_rx_reenable_irq(s);
 	spin_unlock_irqrestore(&port->lock, flags);
+	dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
 }
 
 static void sci_dma_tx_release(struct sci_port *s)
-- 
2.43.0


