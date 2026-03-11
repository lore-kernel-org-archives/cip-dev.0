Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA128104BEC7
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:16 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17324.1773223507477687739
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cM+L7QKI;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c4bde55cso5548654f8f.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223505; x=1773828305; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GevEwx4C+PGrgB6iya0kBmOzN9F/xjvMzwaTLK0sKyo=;
        b=cM+L7QKIeCIr7V9DjULkpoA6MYhpZMwolTkD8SMqlB+Kb08Q38laa1bAs1HhJWTkJR
         chtlclFjSe0wWtH9buK+fQ8vRTfn9Ukz9g5zmGzDCYQuGnSETan3qrpweyKTxr2VmRZp
         7RdinTQLE4Q/OsAUlvCnj6Nuozfr0Pp0eYQir45DPS47vnqzLD57KUAKy23VLR0I59rz
         nU/GzmqVd6BhW94JSw8XOaW8fHXLDng53MKm6FIDO8QQINgHJhIFpKj3UGkBa45pc4HG
         y3TnkgADX9ZwzhQEjuizarxjAy5cpm0h6a2caujpo9nat4jyFXTE9+dC77V3RH7y9Jvr
         b7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223505; x=1773828305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GevEwx4C+PGrgB6iya0kBmOzN9F/xjvMzwaTLK0sKyo=;
        b=XTiRfk6NQl43HZ6qI4/dIIeV8OIiTF9g4oLaC/4I7TImaCMEafzaBn8OfHhWe0hImw
         CBUYT0+3zAkSLMFdrBKAjiCGnWqbCJsmfdE4fQPCEkGjSJbjQ1ZOGAsDKw/7LW68xTf8
         SJQy03tevJfE26qd20iNwnAjnF9onUaYZ5Q7ZtCHBQeplpooHCJXK3J2quMO/1Lhhb11
         Yj9H2xS/VIPMieUageVdPAzBKnyC92rfO/TvOL7EilDiW66q/z2DQewMclBgYS+CmDFg
         mKohoiSVEbAzH+5zV60t18k0VfXKRpjHwnJuTBcvBVb+CvAQ/SmR7V8jyCYnLoAVUmNl
         H9Xg==
X-Gm-Message-State: AOJu0Yzv+tZ89Ulhm0W7vXPyPM+FOctd4TwSQUl/+mPTlcv+92NADekY
	gUCnKmeyqv9pD+9Ctyb6fFsT/QetKDdW/t3KfFlQB7ukjBtH49Ky7g2L+wTEPw==
X-Gm-Gg: ATEYQzwTPSKxRJ6JFZ3dra+HzLNfCOzugKanxUeX+EAsA8vUfvCojZnGBlZ37YvvUZP
	F3qYHKlMWtskAmL8JEXtYQ7eBo3gwyJKhazegHvh4xrHgep6B48IE3PNBeY1d719vhoH4HbP5Eh
	ZKg5aYklkYZf8Ag0Hb+W53eq+MPSQ/srLvbtjx9rLYF76A+im9QCBPBK9QiIoHjl5YOn1wGVcGc
	yiW4bJttK26fSfmOp3D3dekCLkZ3gimAf/YOmSAhxhK/2/XRZy+oKvl/mpsZlgZVWXGU7igfEgB
	YYFQGSItWqunl4vHLQwH7R046S7g2+RDkBA/kJommAgQr03gYamSQLzIrC+LRD77tD/7Yu9WiB8
	JRdc8pF7rVEaQhmNldRZznS7+WXsT3c4TYcPKTuQ/mygkrDr10W1z4BeLMrwVVR3wvTbhceqic4
	VpeI7lz43aCXJpYV5GAUpFCWIDKflmTGY=
X-Received: by 2002:a05:6000:1846:b0:437:6625:d0d7 with SMTP id ffacd0b85a97d-439f8438f5dmr3757954f8f.42.1773223505263;
        Wed, 11 Mar 2026 03:05:05 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:04 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 10/27] serial: rsci: Add set_rtrg() callback
Date: Wed, 11 Mar 2026 10:04:29 +0000
Message-ID: <20260311100458.162447-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22256

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit b346e5d7dbf6696176417923c49838a1beb1d785 ]

The rtrg variable is populated in sci_init_single() for RZ/T2H. Add
set_rtrg() callback for setting the rtrg value.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-4-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Biju: Suashed commit c14afba60a61bc80403a571a67db956aa9800dbb as
        field_prep() not present in 6.12.cip ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index aacd20bcd1c1..63b37c7e461c 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -151,6 +151,21 @@ static void rsci_start_rx(struct uart_port *port)
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
+	FIELD_MODIFY(FCR_RTRG4_0, &fcr, rx_trig);
+	rsci_serial_out(port, FCR, fcr);
+
+	return rx_trig;
+}
+
 static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 			     const struct ktermios *old)
 {
@@ -454,6 +469,7 @@ static const struct sci_port_ops rsci_port_ops = {
 	.poll_put_char		= rsci_poll_put_char,
 	.prepare_console_write	= rsci_prepare_console_write,
 	.suspend_regs_size	= rsci_suspend_regs_size,
+	.set_rtrg		= rsci_scif_set_rtrg,
 	.shutdown_complete	= rsci_shutdown_complete,
 };
 
-- 
2.43.0


