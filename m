Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A18AEF3718
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:08 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15644.1773066358772601599
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:25:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EuH+1dRB;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso3893496f8f.1
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066357; x=1773671157; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zl910sHQHOTfuYq5bq6vuj5uk6To4gAtDKD02Ve5AVY=;
        b=EuH+1dRBGa3cUbql7H7MQwzifD4g0WTcmsRaj4HUONpAb7Hf52K82JbLCknf/HUcWK
         6hLKuzoEm0nOEUO8k6W6dQNXCZZQrb3/1gG0y06TbTGBEcbKcOLcpisWUNbT9vCIse0u
         FX8jW/+799RC5rqHCrHM5LvwO8ewNq9R9sDI8Ec1+68mlfubop7yXpHPZB/3AsoipiOA
         Vzf1QHUuZq/OKBalubI5YH+WvVVjlZDXlWg1hYv8H5ySkglh7Bu058et6UvTAGwoqRta
         weTXlLU9gAugTIl16ofPzFkSOlTo54wFvwQYXgUt9gPXfv/M4LgbTjCeXWi1sd0W1Peo
         tnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066357; x=1773671157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zl910sHQHOTfuYq5bq6vuj5uk6To4gAtDKD02Ve5AVY=;
        b=VTWgsMGzgj+f+Vae49oZNrsS7Gwv5Yw/vhhEeL7X0c0eH6ytZkTpJM+Gpw7YVO16XU
         cnVHbxvcMkU5QwCWkmi7WTLKNMelU8px8IcZdrSGQ2TbzGf7AvxbNNAjJNNaOqkTXAoh
         W+hMM6V6wQFt+21OBYBMM/L32yx9nutmDBYqRUZY2ztM4wjZwts1CJWX/q1Wci4Px+TH
         VBh6Fa69gkbFA4zh/PVsFwsBDTObUwec0D9WEZjWEZ/GISwq6Y0pSEEJNI3wk40zXG0Z
         n6PoRoryrinOGW1yp59Rp3q4seO6Uk3XObQeahP2npLmWnmiCXjk5s40YHzIHIaYNev+
         PkZA==
X-Gm-Message-State: AOJu0YywBJwrCagAWEiaDrLCR2PGKCAGvEd5aj8ujfb7cJkM3reAu9m7
	Fkpux4K9V3noVeQCOvy7Mp0JBvpQttrNfdtzcwQMacLyK+H8e6CuJD5F79Zm8w==
X-Gm-Gg: ATEYQzxlMjfsm6Uq/0lvY/fZq3K6F+VoWYPxP9Watf3yxnPDOi8uBf+i9JEMzFjXijn
	zc08XxNH+KKitGEgXR8lNT+/MySgM1xERLWrxo0aDH6bHpgs9ldNEMsobeyM1ZypJlDc4izOczm
	LyMKKW9XzjWTzL6HDqkwtJSl+0QVCwAShWfVcklg9atYPjwWRsISXqpGXr6QbB3XUsB7j6Jt9Mz
	5BpX5kZCeuGwLEEtbbXoZ06kxpOF/pnXqYSUjAjPTypBdrmGmHSuVG0+Cc7Yf8hTG/NoqIvzCTn
	uusEXF5Pz10iNo49BvN2EfRdu+obNZVjHzacUiit82vDSPVez08ZFe/zTe0RKWds3frpo8mxoUl
	fiDv4LONq65mxGjIhWtueJ0/6yfxMtOrOhmhm8O0lotJTBxp+Vka5VK/QDqKguMJy+pFRU+nq52
	qIWBpIQpasUp7gYwgct5yYXDP0R9YJpC8=
X-Received: by 2002:a5d:64e7:0:b0:439:bcdb:95a8 with SMTP id ffacd0b85a97d-439da10ed50mr18155748f8f.0.1773066356850;
        Mon, 09 Mar 2026 07:25:56 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:25:56 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 10/29] serial: rsci: Add set_rtrg() callback
Date: Mon,  9 Mar 2026 14:25:10 +0000
Message-ID: <20260309142549.987737-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22178

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit b346e5d7dbf6696176417923c49838a1beb1d785 ]

The rtrg variable is populated in sci_init_single() for RZ/T2H. Add
set_rtrg() callback for setting the rtrg value.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-4-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index aacd20bcd1c1..4d2572d63180 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -151,6 +151,22 @@ static void rsci_start_rx(struct uart_port *port)
 	rsci_serial_out(port, CCR0, ctrl);
 }
 
+static int rsci_scif_set_rtrg(struct uart_port *port, int rx_trig)
+{
+	u32 fcr = rsci_serial_in(port, FCR);
+
+	if (rx_trig >= port->fifosize)
+		rx_trig = port->fifosize - 1;
+	else if (rx_trig < 1)
+		rx_trig = 0;
+
+	fcr &= ~FCR_RTRG4_0;
+	fcr |= field_prep(FCR_RTRG4_0, rx_trig);
+	rsci_serial_out(port, FCR, fcr);
+
+	return rx_trig;
+}
+
 static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 			     const struct ktermios *old)
 {
@@ -454,6 +470,7 @@ static const struct sci_port_ops rsci_port_ops = {
 	.poll_put_char		= rsci_poll_put_char,
 	.prepare_console_write	= rsci_prepare_console_write,
 	.suspend_regs_size	= rsci_suspend_regs_size,
+	.set_rtrg		= rsci_scif_set_rtrg,
 	.shutdown_complete	= rsci_shutdown_complete,
 };
 
-- 
2.43.0


