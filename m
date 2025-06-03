Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A1EC61CE7
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:20:17 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web10.6998.1748942411552910263
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:20:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=HQISbhc2;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-addcea380eeso339741066b.0
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942410; x=1749547210; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8WBLXCZfFL0TwaVgl43ELRZwAfpsDbWZIcAeYbq7rM=;
        b=HQISbhc2xDCTYpHU5P2GrxsbgqDWr53Nl1zfnAXdqpg8KB2EKXwmWu7C/XqtWmnfKb
         ujjuBAuRCEpXksUbVv6KCi3qrjw3HCDpkXJ2iKMoozfT7wEOsSohTrx9e7LKnoAEAyxL
         ubxjGbfhfh0OKNWgGyyKgv7s6SgMF95YuswiebIBRx46BQVYfY2zWpuOTq2oerPFkBZH
         g+gm+vsv3JI5+PRn4YIUpu5BikJmZaCFES3LbrNmGQQbdTgQQ0fMJU1O97SnXEfo9WQ9
         m/4yAjZjPR7CaaLrafBultYYYksRqwGjgCxbsL14rbAoS3YpQWAC5Y/IDIApLhXXqe7a
         qoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942410; x=1749547210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8WBLXCZfFL0TwaVgl43ELRZwAfpsDbWZIcAeYbq7rM=;
        b=xGs4T05wiZJFPl8oVgYkyTglgQgxeWh48iTzL8GPYc2lZ9x/xMulQer5QNHlleB5qD
         yHiwntEUYQbQTc+Un8+Ks+U9CtrwkoguurWyWep84vKeVjNtSfrxZGpSwjomQCniW9jy
         amAwOhK4odBe0oEotYFAdhdXl5C+fZZGcBz+naR4BwFYIIApuUtEIOL3ZGUgpJChOCTp
         6jWloWE97l8LE7bSX/04k0LIkWSUDIcjG5MEn62dnG1oxzuBxklT9yPyiSC+32NhVvrX
         I5FKkHIJUvMq3KxanJSDWDrNrWCDQ0B5mEQ1bFNMRo6geTY/pp6o2eKxWP9WjTEynmYn
         hUqA==
X-Forwarded-Encrypted: i=1; AJvYcCXu6YY/gPdHlGRsRyDTiPvlhDu2gFCFsPwVS4lO0TbLb1prfk4ow5i1R3rLc5AYZbZLu0PK2GgD@lists.cip-project.org
X-Gm-Message-State: AOJu0YzZ4IL0iIIxqg4ugxDHNx2mZ2vAg2qqUoXGqSQheQRlsJnlG5r2
	cIiQUMxmLextrp5eWGX28Ff3xvS4iOVS9pozRf0IltbhbbotFKefggcelz2TzHr76bM=
X-Gm-Gg: ASbGnctUxqQpuWJfJEu7OMVZgmAOqMsaGOHS+1iHekts7bApGoOZbQLjUkHZxtNULNe
	a7w+hsZ5JhtBGFYNt4ybRUx5hFcxERe0a5QL3eJ3RgmAIqMQuudggfmsT+NXHvpGRg1+EDJUhtt
	enD7FkWKe7HG7UfSgCb+XOHUg2SaYLPhvUHP7u1lA83x8RI4+awQshbcOlSMiqpQQtrfLjfBzr/
	FFTo73Snrfv5Jz29tGvgD20zvJIpemz+zcibsK/6LQs+YMQNh0NU1TBj93yIvEOegIfklx1p0Kv
	tSKfmO/++zm1dF16ty3ETC7ARsPqvmRxEzlI3wdnIlzULzH9Wmaw96aTOsc3vyrQL0Dl0CECRPv
	v6BruCQ==
X-Google-Smtp-Source: AGHT+IGlQscA6I6quuzf4HnBEyXBCAG0mS0rs62zy39/lfsnP38BmPjCPMgfwAx8HiP/SPTLXKZjIw==
X-Received: by 2002:a17:907:2d91:b0:ad6:4e8e:1883 with SMTP id a640c23a62f3a-adb49370accmr1111977566b.3.1748942409876;
        Tue, 03 Jun 2025 02:20:09 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb2e220548sm817017266b.109.2025.06.03.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:20:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 2/7] serial: sh-sci: Update the suspend/resume support
Date: Tue,  3 Jun 2025 12:20:00 +0300
Message-ID: <20250603092005.3917850-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:20:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18985

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 22a6984c5b5df8eab864d7f3e8b94d5a554d31ab upstream.

The Renesas RZ/G3S supports a power saving mode where power to most of the
SoC components is turned off. When returning from this power saving mode,
SoC components need to be re-configured.

The SCIFs on the Renesas RZ/G3S need to be re-configured as well when
returning from this power saving mode. The sh-sci code already configures
the SCIF clocks, power domain and registers by calling uart_resume_port()
in sci_resume(). On suspend path the SCIF UART ports are suspended
accordingly (by calling uart_suspend_port() in sci_suspend()). The only
missing setting is the reset signal. For this assert/de-assert the reset
signal on driver suspend/resume.

In case the no_console_suspend is specified by the user, the registers need
to be saved on suspend path and restore on resume path. To do this the
sci_console_save()/sci_console_restore() functions were added. There is no
need to cache/restore the status or FIFO registers. Only the control
registers. The registers that will be saved/restored on suspend/resume are
specified by the struct sci_suspend_regs data structure.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250207113313.545432-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 71 +++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 66f78f8c4909..f0ad251d352c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -104,6 +104,15 @@ struct plat_sci_reg {
 	u8 offset, size;
 };
 
+struct sci_suspend_regs {
+	u16 scsmr;
+	u16 scscr;
+	u16 scfcr;
+	u16 scsptr;
+	u8 scbrr;
+	u8 semr;
+};
+
 struct sci_port_params {
 	const struct plat_sci_reg regs[SCIx_NR_REGS];
 	unsigned int fifosize;
@@ -134,6 +143,8 @@ struct sci_port {
 	struct dma_chan			*chan_tx;
 	struct dma_chan			*chan_rx;
 
+	struct reset_control		*rstc;
+
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	struct dma_chan			*chan_tx_saved;
 	struct dma_chan			*chan_rx_saved;
@@ -153,6 +164,7 @@ struct sci_port {
 	int				rx_trigger;
 	struct timer_list		rx_fifo_timer;
 	int				rx_fifo_timeout;
+	struct sci_suspend_regs		suspend_regs;
 	u16				hscif_tot;
 
 	bool has_rtscts;
@@ -3374,6 +3386,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	}
 
 	sp = &sci_ports[id];
+	sp->rstc = rstc;
 	*dev_id = id;
 
 	p->type = SCI_OF_TYPE(data);
@@ -3546,13 +3559,57 @@ static int sci_probe(struct platform_device *dev)
 	return 0;
 }
 
+static void sci_console_save(struct sci_port *s)
+{
+	struct sci_suspend_regs *regs = &s->suspend_regs;
+	struct uart_port *port = &s->port;
+
+	if (sci_getreg(port, SCSMR)->size)
+		regs->scsmr = sci_serial_in(port, SCSMR);
+	if (sci_getreg(port, SCSCR)->size)
+		regs->scscr = sci_serial_in(port, SCSCR);
+	if (sci_getreg(port, SCFCR)->size)
+		regs->scfcr = sci_serial_in(port, SCFCR);
+	if (sci_getreg(port, SCSPTR)->size)
+		regs->scsptr = sci_serial_in(port, SCSPTR);
+	if (sci_getreg(port, SCBRR)->size)
+		regs->scbrr = sci_serial_in(port, SCBRR);
+	if (sci_getreg(port, SEMR)->size)
+		regs->semr = sci_serial_in(port, SEMR);
+}
+
+static void sci_console_restore(struct sci_port *s)
+{
+	struct sci_suspend_regs *regs = &s->suspend_regs;
+	struct uart_port *port = &s->port;
+
+	if (sci_getreg(port, SCSMR)->size)
+		sci_serial_out(port, SCSMR, regs->scsmr);
+	if (sci_getreg(port, SCSCR)->size)
+		sci_serial_out(port, SCSCR, regs->scscr);
+	if (sci_getreg(port, SCFCR)->size)
+		sci_serial_out(port, SCFCR, regs->scfcr);
+	if (sci_getreg(port, SCSPTR)->size)
+		sci_serial_out(port, SCSPTR, regs->scsptr);
+	if (sci_getreg(port, SCBRR)->size)
+		sci_serial_out(port, SCBRR, regs->scbrr);
+	if (sci_getreg(port, SEMR)->size)
+		sci_serial_out(port, SEMR, regs->semr);
+}
+
 static __maybe_unused int sci_suspend(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
 		uart_suspend_port(&sci_uart_driver, &sport->port);
 
+		if (!console_suspend_enabled && uart_console(&sport->port))
+			sci_console_save(sport);
+		else
+			return reset_control_assert(sport->rstc);
+	}
+
 	return 0;
 }
 
@@ -3560,8 +3617,18 @@ static __maybe_unused int sci_resume(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
+		if (!console_suspend_enabled && uart_console(&sport->port)) {
+			sci_console_restore(sport);
+		} else {
+			int ret = reset_control_deassert(sport->rstc);
+
+			if (ret)
+				return ret;
+		}
+
 		uart_resume_port(&sci_uart_driver, &sport->port);
+	}
 
 	return 0;
 }
-- 
2.43.0


