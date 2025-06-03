Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64846C5B559
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:20:17 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web10.7000.1748942412967040205
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:20:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RshAoLtY;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad89333d603so1037036666b.2
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942411; x=1749547211; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6lN+tRlKq8+ZCqJDHZhyDz9gvLseGLsPyxTKaL0u3Y=;
        b=RshAoLtYzwZOay9PUtwpVuWdGMHE/itT6rdmbJxKR6EAG0MEP0U8LGQVyODfI179YR
         GyBWKmH1Lk/vj8cRcAcWTWVCuKABNSPx/j1YWOp6blsHOgJoVkTxRewQN7ViouvBnOHd
         hYbC+GaW9DOAX+huSf/MkPmOcGqjxyMutebtELK+MOF9LS31cAtvWrMm5Kc6pMQgI9oL
         M/3cEenfkt13kU4GGkj5yPyC/KlBjaum6VdpmhOqbZqOuwL7CLGa8OHd9J4HYb/eqFPE
         7JbURTTWspuMc6aF3FeiYZOaB1KDy3yYW2A+6ZOEv2WwcaPNWiww9p1qcFjrklITWN1s
         2OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942411; x=1749547211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6lN+tRlKq8+ZCqJDHZhyDz9gvLseGLsPyxTKaL0u3Y=;
        b=IJ1+zIQTj/swoU6aeTnEyxvM4rAztTa/3AFAr7Dlpyup02Wlrs+wJP+9AC/GruDUn/
         DP5jUkvbrR8UXNWGdI8kAxQnmBLeRcbKB47fgN7cTmqNAIX1GOA67VrGw+9aTWBA4WLX
         Blo4Xxj2fUg/8GtKTVqFWGVC5CS6v24RVm2DIwYdGPzHchUReIxHBbOlKzj4CiZ2HVU8
         OF3If1A7VCnQclpvFfctkUs9THq2yomUH3VN7wek1P3olfbUyJP6w4HZILGnihA3Myyx
         hJj+m85VAyUuNJy1MpKP/VVOktIsqXDs7hjWckdvKQB882oVsR9mF/IC6jPx8C53eYNJ
         cBxA==
X-Forwarded-Encrypted: i=1; AJvYcCXyTS8D8wljZw1zXtIl4bOGA9RJrE5mrZoDtf4VwG4lkEEG01drD4VU1brRyklL0tjyevKg07Ot@lists.cip-project.org
X-Gm-Message-State: AOJu0YyaejADfqkEku5SiUf1vuV4pZ4VBrOg39mz4aMtGs1rp1Nto4Fl
	sIT8StZuqRhoTA9NeKZR+CLJZEZh+dw03hNaWPp2aEx8Dy+FFWl6UhIlHktUwgZ+cts=
X-Gm-Gg: ASbGncvJtcz1gSSDn/tNaFx2Z0xKd3YxHFl4XlIowG6aKVEWKCgCB6Cxs3lQAcrYZtB
	SL7LVVI9eDHcmZv7d+3vPlwDmAXw959FpSy8gTmMic+/UAW1MP1Ygjq4pU70F8aXwwR6EVTGo6M
	rb8sYAmyi7Fj3pEOecm3GICmxPDLVw0jzyfopQdOI+oW/iil47KfLevIUrUuqbXTXoJr6XdRLh7
	HXnC86QysevbHy+gWJl53C3L2EN/lujAeLnnFzR/4EPV8/mgcDQtKO3nl+Y29J7TwFMeLURjJUH
	8Lvb2scFp+Hg5WJmVXN/nnLnSAaNZbKQW/Vbh6U8J/ekLqyo9d8xW+HmahF8N2ucQHXNKgbdpJe
	Xftubew==
X-Google-Smtp-Source: AGHT+IFCzwt2VLV0Bi39ddJlBsCF8nKkzE3N1Mvx0GZa+HlXWkLW5SWSpCBFPtkdS3LJXz8+iRTbtQ==
X-Received: by 2002:a17:907:3d16:b0:ace:d710:a8d1 with SMTP id a640c23a62f3a-adb32287d6amr1400025466b.24.1748942411264;
        Tue, 03 Jun 2025 02:20:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb2e220548sm817017266b.109.2025.06.03.02.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:20:10 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 3/7] serial: sh-sci: Save and restore more registers
Date: Tue,  3 Jun 2025 12:20:01 +0300
Message-ID: <20250603092005.3917850-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:20:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18986

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 81100b9a7b0515132996d62a7a676a77676cb6e3 upstream.

On (H)SCIF with a Baud Rate Generator for External Clock (BRG), there
are multiple ways to configure the requested serial speed.  If firmware
uses a different method than Linux, and if any debug info is printed
after the Bit Rate Register (SCBRR) is restored, but before termios is
reconfigured (which configures the alternative method), the system may
lock-up during resume.

Fix this by saving and restoring the contents of the BRG Frequency
Division (SCDL) and Clock Select (SCCKS) registers as well.

Also save and restore the HSCIF's Sampling Rate Register (HSSRR), which
configures the sampling point, and the SCIFA/SCIFB's Serial Port Control
and Data Registers (SCPCR/SCPDR), which configure the optional control
flow signals.

After this, all registers that are not saved/restored are either:
  - read-only,
  - write-only,
  - status registers containing flags with clear-after-set semantics,
  - FIFO Data Count Trigger registers, which do not matter much for
    the serial console.

Fixes: 22a6984c5b5df8ea ("serial: sh-sci: Update the suspend/resume support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/11c2eab45d48211e75d8b8202cce60400880fe55.1741114989.git.geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f0ad251d352c..3ea1d13fe5cb 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -105,10 +105,15 @@ struct plat_sci_reg {
 };
 
 struct sci_suspend_regs {
+	u16 scdl;
+	u16 sccks;
 	u16 scsmr;
 	u16 scscr;
 	u16 scfcr;
 	u16 scsptr;
+	u16 hssrr;
+	u16 scpcr;
+	u16 scpdr;
 	u8 scbrr;
 	u8 semr;
 };
@@ -3564,6 +3569,10 @@ static void sci_console_save(struct sci_port *s)
 	struct sci_suspend_regs *regs = &s->suspend_regs;
 	struct uart_port *port = &s->port;
 
+	if (sci_getreg(port, SCDL)->size)
+		regs->scdl = sci_serial_in(port, SCDL);
+	if (sci_getreg(port, SCCKS)->size)
+		regs->sccks = sci_serial_in(port, SCCKS);
 	if (sci_getreg(port, SCSMR)->size)
 		regs->scsmr = sci_serial_in(port, SCSMR);
 	if (sci_getreg(port, SCSCR)->size)
@@ -3574,6 +3583,12 @@ static void sci_console_save(struct sci_port *s)
 		regs->scsptr = sci_serial_in(port, SCSPTR);
 	if (sci_getreg(port, SCBRR)->size)
 		regs->scbrr = sci_serial_in(port, SCBRR);
+	if (sci_getreg(port, HSSRR)->size)
+		regs->hssrr = sci_serial_in(port, HSSRR);
+	if (sci_getreg(port, SCPCR)->size)
+		regs->scpcr = sci_serial_in(port, SCPCR);
+	if (sci_getreg(port, SCPDR)->size)
+		regs->scpdr = sci_serial_in(port, SCPDR);
 	if (sci_getreg(port, SEMR)->size)
 		regs->semr = sci_serial_in(port, SEMR);
 }
@@ -3583,6 +3598,10 @@ static void sci_console_restore(struct sci_port *s)
 	struct sci_suspend_regs *regs = &s->suspend_regs;
 	struct uart_port *port = &s->port;
 
+	if (sci_getreg(port, SCDL)->size)
+		sci_serial_out(port, SCDL, regs->scdl);
+	if (sci_getreg(port, SCCKS)->size)
+		sci_serial_out(port, SCCKS, regs->sccks);
 	if (sci_getreg(port, SCSMR)->size)
 		sci_serial_out(port, SCSMR, regs->scsmr);
 	if (sci_getreg(port, SCSCR)->size)
@@ -3593,6 +3612,12 @@ static void sci_console_restore(struct sci_port *s)
 		sci_serial_out(port, SCSPTR, regs->scsptr);
 	if (sci_getreg(port, SCBRR)->size)
 		sci_serial_out(port, SCBRR, regs->scbrr);
+	if (sci_getreg(port, HSSRR)->size)
+		sci_serial_out(port, HSSRR, regs->hssrr);
+	if (sci_getreg(port, SCPCR)->size)
+		sci_serial_out(port, SCPCR, regs->scpcr);
+	if (sci_getreg(port, SCPDR)->size)
+		sci_serial_out(port, SCPDR, regs->scpdr);
 	if (sci_getreg(port, SEMR)->size)
 		sci_serial_out(port, SEMR, regs->semr);
 }
-- 
2.43.0


