Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C57C61CE7
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:47 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web11.7109.1748942386184423588
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GzycymcD;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6046ecc3e43so9017100a12.3
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942384; x=1749547184; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHat6ae1pR1RpZFXbJmKeE4+DPjRRH7PGHjXM2hMygA=;
        b=GzycymcD2M8GO5DU7u1ks/llGYRaHxRK6fJtkKZcnjkOElUdDRky3+nJ+6YNLQOVsA
         0dYH9Ha46SaIMZ+sXg9VZwucP0IChJYz6GZlNYxbMoF15RH/GoqK06OLBwlvkLsyuCMA
         xbpgnXD+jlmmsbt4DO8JIbIn/MWzgcMS3jmuCzKt8mTaYT8dY581L+8woF/iHFe6VHPl
         SITNGGbWrt1pld8zPzD3Ejo3cJCt58h03n8/UhYztw6j0bRZVkqassdTrUkicUMO3C3A
         k4awFiMh0YhAmWAUfbkG3uMvOfJ8KGjhWnzjiYc32dsXj8Gz69idKlGtgMtvsGYh2T3p
         bHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942384; x=1749547184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHat6ae1pR1RpZFXbJmKeE4+DPjRRH7PGHjXM2hMygA=;
        b=nKl4Zmg9OC4YdxsiTqS01X/khSPvcMGboQ3sL6psP8D8cAstWnwFhpZDc9HfZbOICi
         6PyA91AhcVgvGR42F0urPr0y6NqLEpQ6760hRvxvXMznzm58k7dSgHT8Nl968K+j1/FQ
         yd4VaaBSu7E4KGztGWZ0hNhgKR1EGAKyqrHvIkLctWj45PCoswdkETtzjR3gOGAlFYig
         V9xe9L2bfRu3Nshik8VXjvkAAyTdgUGS8pGSHPRUxoK9i1BU/2PUooAvhkB/LUphNQKN
         XcioKn9jEZoD4aKsl2Dc2lr0bhRodC174LfMBdvt6BfWLOD6YtoquihDwVeWtxKI1uSo
         OE8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtMtJlIQwOuZJog/tIKr3I7gbnW4jLewNt1izR9pWdNIS0bfrhFcmvyFnxyYc7LqI5c98SLU9D@lists.cip-project.org
X-Gm-Message-State: AOJu0YxWNgaaQ+g8KbnGrLrxu6TDbRAGcRBC6CL3DFypyu/e0I71Wcco
	Ha/iyww+Tlr87+UEJVMVSK9Xv45I8+mfIZe5uaIlOXcQ8zIu80au2ko/xrm6CwpIb65DqP+LTS+
	QYZWg
X-Gm-Gg: ASbGncux1ivupmL0JqpLuZhh7PEs7pn/0D7NIOkOdMb2Z0JVhyAYoVK3d5C/zlGB/Jt
	b+QEveAvk3QuGc9S4sKqQHBvN+EFTeX5CAebwC3sPOP/kmBgtSobcUgItds5heI4yPoZcsXMWsK
	9lKYIbWfJwWcFmTeKxFKSoWnOmkay0eGgO1lpy30ecUsn36hY0lAQtPgZmppEa6HqKnHyKxp3r5
	tfeTBv4qXKEwYk2FK/Xi201RcUDz/AfPsDFPtxYONSHXMpI0oK7JmweNzueo+Ko2Le9dUR3Oug+
	7cEKRD2n9br/Sti4EDst8gFEfZ/u3tO5YHTOITofidO86NI+W+ExIUxppfJ2SH5JMwt36L17RjH
	chiV2tG3+92wrkLyd
X-Google-Smtp-Source: AGHT+IG5V5ZNI/u0YhERCLwaumrni7Xh+TzK2IGNUDor/sj4YREPgJYWjxyEzN5kh7wKFapO8D9Q1A==
X-Received: by 2002:a05:6402:d0b:b0:602:c310:896 with SMTP id 4fb4d7f45d1cf-6056e14e8b4mr14001899a12.20.1748942384574;
        Tue, 03 Jun 2025 02:19:44 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c5c5casm7301944a12.25.2025.06.03.02.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 2/8] serial: sh-sci: Update the suspend/resume support
Date: Tue,  3 Jun 2025 12:19:34 +0300
Message-ID: <20250603091940.3917581-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18976

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
index 3f5c319215d2..fad62f1a5ad8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -105,6 +105,15 @@ struct plat_sci_reg {
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
@@ -135,6 +144,8 @@ struct sci_port {
 	struct dma_chan			*chan_tx;
 	struct dma_chan			*chan_rx;
 
+	struct reset_control		*rstc;
+
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	struct dma_chan			*chan_tx_saved;
 	struct dma_chan			*chan_rx_saved;
@@ -154,6 +165,7 @@ struct sci_port {
 	int				rx_trigger;
 	struct timer_list		rx_fifo_timer;
 	int				rx_fifo_timeout;
+	struct sci_suspend_regs		suspend_regs;
 	u16				hscif_tot;
 
 	bool has_rtscts;
@@ -3373,6 +3385,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	}
 
 	sp = &sci_ports[id];
+	sp->rstc = rstc;
 	*dev_id = id;
 
 	p->type = SCI_OF_TYPE(data);
@@ -3545,13 +3558,57 @@ static int sci_probe(struct platform_device *dev)
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
 
@@ -3559,8 +3616,18 @@ static __maybe_unused int sci_resume(struct device *dev)
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


