Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFBCC5B552
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 10:23:50 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.13293.1749032627743823126
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 03:23:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=pXm7FQTE;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-adb5fd85996so649623066b.2
        for <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 03:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749032626; x=1749637426; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDPb+2YOWGmRSwpbGH6K+vVxKyytG2ua8aDaLPE5Asw=;
        b=pXm7FQTELCKHiyhb1pRReXdautcN8bSdAUTaMq8RygHeISwI5F2JvsCRuj72ANskCs
         m8TkJkztIQbNAl1eeAMJFTeyD6qJ9c0tJoqFfn6A6cKZ7eFYPbG4O1ARWttibwQgM4aO
         4aXSATDKTL8DsKRY95oyp15aUSHL9rMCcZbydGFMx8IOj6bJzMVzsl2o6q6P71VLMiab
         hC+5REYlLG2AWWnjNcT6zkIudEJDot60X1N3aIlsSp+cgTd1KvRu8uc+VgUxn0Ycpe6/
         HgWy26N2saE9Cb9twb90n/GMzMQKCgn4aMpTaUbUWjXEo18bjwG8VZqOT8ZqahGGDf90
         oQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032626; x=1749637426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDPb+2YOWGmRSwpbGH6K+vVxKyytG2ua8aDaLPE5Asw=;
        b=W8zeH3SMu6Rnz49WRngatTRoSP6NLMHUs5tzLeEdE7JBqRNWS+ucqMyJQ96iz3W4ZL
         4+ff0P0TbLzC22+uQwdYDl5Y0JIVhocccOPr4ryR1d/28kJMWvFtbFFvryNzw/HuUNUb
         NMpKv/BPBC/8ClepoLX6vjyEm/JiahVFTLGzIXSu9koDI+IZQXkr1fCEsKYLLMAmZvRi
         ZlBtd0ttRWAAF5gPBUCvVwRbGEXJHuBuqMAPw6wHZkD7/t8DHHVbsTvXv8btm0abVSo9
         Dczwm/hPFjZHcKd/EW8zwGI/7Uys00BptIiAnb8vyZclm7//n3qUvv/cO1uOIpGlCj9N
         LIzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMrvHaDtIId1Bk69QGg/Gce3UXcHecJ5gGxKP6wEQd9KDMeW6KuqnlL94lFoJ1pPoHIckpgK8Y@lists.cip-project.org
X-Gm-Message-State: AOJu0YzRt+bfmrTiJmhbLaeBIJJWFpqpnYh34xrvMgZorUA62mT0Nais
	0zPhvvyPVmvxHj6/y/JfZ+lWDU2zItPyydMSXJ03ey1Qo8wV3VlXhFf7IUAlN4hckG4wQ8dNrrN
	mWbxg
X-Gm-Gg: ASbGncvn3ONu1k85FHIp5gAOvnDinb4AQ5I+vXDdUdQPpsU6q5NhkKCyM+j5S8h+tVu
	bdCJ5zN/OcdKHrNvAgS0Z4fpxZtRWgY63aaZvGi0uv6lXA8jc9LpeLNci7rxS4nLxQQqGs3qvQt
	RqJMLn6fi3xJo/KtmRNIHi8Tjo7Oiv7eJ5jSrWocw5jppypcqGnrv4MS9kC5U1wnHsVnjWMbtUw
	J8piL3/aoF2JlgEkL9oMeuh67GejIA5RENHF4m34MHESW1+sNPqs0r/LUVbMPMuB3WiL4hdfBcQ
	y6hJCcYti+xSKWZpPJvD8YZtPm7kUKF9UG+Cc+2E7pPlkeWusVpfTdQm29imS8Rj7HZbZmjLI7c
	ei8Uqlw==
X-Google-Smtp-Source: AGHT+IF01tQGYgy/RtcLQ14juo0lemJ3WIz0uPKLMjGGRZP7KQT9dxaym3S43A9AoaBSXXIDcwByKw==
X-Received: by 2002:a17:906:c113:b0:ad2:2a5d:b1ab with SMTP id a640c23a62f3a-addf8ffaa74mr186976866b.59.1749032626126;
        Wed, 04 Jun 2025 03:23:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e760sm1087375166b.52.2025.06.04.03.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 03:23:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 2/8] serial: sh-sci: Update the suspend/resume support
Date: Wed,  4 Jun 2025 13:23:35 +0300
Message-ID: <20250604102341.2524186-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 10:23:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19003

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

Changes in v2:
- none

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


