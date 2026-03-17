Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1B0FD709F
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:45 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73591.1773746257504820427
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YqXcfL9K;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso48422765e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746255; x=1774351055; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiWlpnDPnz/KD+OMk36yNBnSCxa1UrXNpQ60mRlKq14=;
        b=YqXcfL9KmTI28D2exRTWEuuCOJ924KwdjmSWzjK6guJMZdTmGkyZuD2LVeXyVxJzxh
         WR0KUXlW35CjCR2S5wO3TODOhTtZEXlx3W29pU4kFx+XFMc1CXkaOo38M40Pi1SwCMup
         HYlAwIkn6Cqk+tuQ3aY+rgEcIZS2k6Wr9MUCiXZPZvK786qBabpUmAYjBgWbO7Zxb2gm
         0rJ49njfTWIRteAtUM9f95cfBqhpS1LqNN951J7PCqUMDb2xhbszeO27OdfDfypZarSR
         kQob+Cfg/ZAYwsKOEKkSqjCcna8BJaWyuMUWUF78t0b4S8FPetZ5omAvspaCC39chOgX
         0bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746255; x=1774351055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iiWlpnDPnz/KD+OMk36yNBnSCxa1UrXNpQ60mRlKq14=;
        b=NMXisd4vdE2PkJA6rr1Hey/HuyO8jVWw8l2WeZivJiE9tEbVEY0F5/V7eOQ+TbosCf
         hn5HhNq9lm4K3tJ2Sz7JRf5WcuIMXfm3utbzIfIIkYP9ufagMd1fknLoLheeaJ5YuSfZ
         v92OpqLZ37RtpwPhq5DsS9Hgzl6feShHuG+RHvms3tUb1cO5zxjCPXkD9hxi+aa+NqKO
         h9AHXYqGzOGKlhfm5zZZAuoyeIPLaAzP+XTRRSSVk/bb2HgZ/BenBFNlF4B0zj/DBvYM
         tqRF/CSuHd8JA8opa0GxFPG0q3psNtjuydpQRB75q+b7hjFB+F46crDY4uLUJsYgB7xP
         OR+Q==
X-Gm-Message-State: AOJu0Yz0zMChpzjkQ4pvtf26n0eTMfHEbwQU9YDCkcVNnJHw1346n7kI
	8dv1HjsnAcRLa4zYzlm7DjFfRn8Ja6D2FjpRNhogVe9snaKVMiiqJSps64rcPA==
X-Gm-Gg: ATEYQzxskv0FCfBUkzluKd/TyaifP5lbRa1ToJWybafI31oczDYpjZeQcF0P8V8N4E8
	QHHsUWJVrjOM6vo/weTxgiq1OzfiCMBjA1qUVzQvNMQAnwzSQdPidSylzggDw4ZNOammL8UZv7B
	k9bpVa/FWo9Rdvx9kaibFTre6CcPb+6jcjdgCPxiDEt5viImSYci0AbxiZ+uDnGDkSGWm19/gE8
	BuOogXLKaKzmVXRQRTYyi2gFTs6GFh+Tru0IKkfBz4lNB96+7AtkVklZfBmc4x+kRBtOcfP5CJQ
	EVlhI1vikF7IN+HFiN9u/LDaUhbBpQe7sENPXUehgkxFC7yE1/2fZG6cLcKQXiEAjWxHOqYljgx
	MfE4YW1vV8tKS9GNDhsnRIHslAicsSzwsSjLMLpA3vSdJTLgfTQPnrdvzVFxKjPkUa3ox6Of7Ns
	gznouankL7m7phYRXajmpMagMQdTS7Cg7ywZrXadPU7BB3vWXo
X-Received: by 2002:a05:600c:4fc6:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-485566cfccfmr267533505e9.10.1773746255095;
        Tue, 17 Mar 2026 04:17:35 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:34 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 19/39] serial: sh-sci: Fix deadlock during RSCI FIFO overrun error
Date: Tue, 17 Mar 2026 11:16:44 +0000
Message-ID: <20260317111718.281633-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22452

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 75a9f4c54770f062f4b3813a83667452b326dda3 ]

On RSCI IP, a deadlock occurs during a FIFO overrun error, as it uses a
different register to clear the FIFO overrun error status.

Cc: stable@kernel.org
Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251114101350.106699-3-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b64bd8a155c7..398f6518ff28 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1200,8 +1200,16 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 
 	status = s->ops->read_reg(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
-		status &= ~s->params->overrun_mask;
-		s->ops->write_reg(port, s->params->overrun_reg, status);
+		if (s->type == SCI_PORT_RSCI) {
+			/*
+			 * All of the CFCLR_*C clearing bits match the corresponding
+			 * CSR_*status bits. So, reuse the overrun mask for clearing.
+			 */
+			s->ops->clear_SCxSR(port, s->params->overrun_mask);
+		} else {
+			status &= ~s->params->overrun_mask;
+			s->ops->write_reg(port, s->params->overrun_reg, status);
+		}
 
 		port->icount.overrun++;
 
-- 
2.43.0


