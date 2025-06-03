Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474EAC61CE8
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:17 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.7094.1748942348848575599
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=XlISdJCf;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adb5cb6d8f1so349696966b.3
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942347; x=1749547147; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezLNa9knF5WYbbZSPZYz1O2o6AK6WE9pz7hjlxykhiU=;
        b=XlISdJCfEXYH00cZy1clghDeKHLlrnbIYNPnJo6gk/u43AY7/PAPKs5vPBnbTR9fWq
         cbb9ooiAaHWIqtjNqXrffAkhk1BleQuH6rOD8n8pPWl2bmM7vBKPYJkAn406xMOhvrti
         C3Q5gN9ygofgH1fgF0peJ4b/w5WjCujzmvhrnWoiIv4J1DNLxTK/Jg16IY4vQrKqMncM
         OKj2f3l5SHKZRahJ6TdN6MscESLbvjwvUzsmgelpn77B3OMe3LpNLHmcvIQXdwqlxjy/
         9/DWs05ZAp6aJ0GFVJTLuIIF25Kc/j7s3yLUQQY30I9c324gFebzj1TUngZk65MGcCuw
         UGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942347; x=1749547147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezLNa9knF5WYbbZSPZYz1O2o6AK6WE9pz7hjlxykhiU=;
        b=GPTzVnXvJhld0pPjZx/cLLW3eGc35Qvgl1t3D0zO41oeqgzYBze6c8X4sx5NN6VEDM
         bdHA8ManRWYUTZXXQoQg+kIDRgiB5BbZp6H1Qwn5bM/2WxEywQx5DV8LE40VsYv5zp40
         KWljNB3Xmz7TsY+NR+fDhqQTJi2SdrXqko0XhDhDNbDUnDMIjzvnXYIrACgwUtJzRvFx
         ATSJaZzxTuI2leSO4VOf0SrTiDxW9BhxyEpH7APs//jjKc9tnpqG+PS3gd4RloPKMBsm
         e87b/4E7dvIU19f8tRwrCjjFm0NmDptlZbyV4o7CuJHKgIM2vJEr6XMtz+euW2x7eLSv
         PF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJTkzN8LLYbNveU20xYlYXDRWxUwCYjLdBeit33PWcYav44eeIr0w/dTbO0NI65xf6AIYUOgac@lists.cip-project.org
X-Gm-Message-State: AOJu0YwRXWSpOD9us7NOp8ycUQkP3t/KytEw9NDf0x9eLTyB6AcgsPBE
	SsmAh/rULf61MpR/PdmrQvuRnB1FRt03+m7J7fJuMsffA7ql8ecGF/o8tiFGsbmVq1M=
X-Gm-Gg: ASbGncuN9vgK70DUNFbTG7GOuPOWD6XG5KSZCoXBSy85yaAzESGpQy2o7b5L8Jc/zkh
	XDwqWC0ZzVyOPBbNVfTrsYk7gZj/fpA+OWF5I8BslD2s0Zc3CZOG6r8l1yz9DXv9btNv6yxZdks
	wGVz7dhP1ptMt+aDXwiu8kZnsPDycgfZ6nWB/wVfxFdoUObeWCrv7LeNQ/Sz8SI1TZVM6MEt4gN
	+5+tWqtb/6pXk8W/sUXor4mqS+bD5IXuWGMNqLs1PNJuzC9vMkl1oZWYWLgGjSFjPWmFCz+sqVz
	pPu2e07NcXrhBfAMyr8xmnVD3PIBA3A9eb/JkHm54cmhEFYGOIJl+EPFeo9JFgxC8EdqEBcWWr8
	DZ4QN+e4xrwnXSM61
X-Google-Smtp-Source: AGHT+IHQpDnS6P862Hp+XVbbYMFVjpn3m1KZOegBb25gpcPO64W0+dM3/gHuzHZBnc5nruYnsF/xbw==
X-Received: by 2002:a17:907:9494:b0:ad8:8efe:31fb with SMTP id a640c23a62f3a-adb36c28fd7mr1474090066b.54.1748942347164;
        Tue, 03 Jun 2025 02:19:07 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fecd2sm918093866b.36.2025.06.03.02.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:06 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 2/8] serial: sh-sci: Update the suspend/resume support
Date: Tue,  3 Jun 2025 12:18:57 +0300
Message-ID: <20250603091903.3917202-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18967

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
index 76c9b439e412..98742edd93f5 100644
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
@@ -3375,6 +3387,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	}
 
 	sp = &sci_ports[id];
+	sp->rstc = rstc;
 	*dev_id = id;
 
 	p->type = SCI_OF_TYPE(data);
@@ -3523,13 +3536,57 @@ static int sci_probe(struct platform_device *dev)
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
 
@@ -3537,8 +3594,18 @@ static __maybe_unused int sci_resume(struct device *dev)
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


