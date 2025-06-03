Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233F8C61CE5
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:17 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.7095.1748942349931500801
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ehbthPMY;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6049431b409so9667146a12.3
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942348; x=1749547148; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXmYsTM6p2s/Yz7WC81zIsDl6rRB5BIdyJIAqO6iiDw=;
        b=ehbthPMYtQtIV7CS1zwESlyv7CuwycGvAq5wf7RA4TQPe++FSkMmY/FajNcALijHyC
         TRVTwSqy63wsELwGSARUo77pCTOmI8J/rl3ZZgdQDPUv1egSfO4tml9Kuvo48+UFTbhk
         +pNv119nKweHPEAIVStB7feH0UlH963kfAQUtNSCrKLgJU/sT7pdCGhsd74HTIlPagE/
         nw2q5OM/AvYTDn+4CwdcK2YsZKtEOyaI8xk+jKWlrk8uCQeHp/oYXNPBv+QdIB0i+PPo
         qrHeIb6k8VZnugkhGfTO6tufx63SGGO3A0atzjUr4Q87K+3shpzMy2F+sK5v0/FceY8a
         EWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942348; x=1749547148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXmYsTM6p2s/Yz7WC81zIsDl6rRB5BIdyJIAqO6iiDw=;
        b=q/Ktx4gSd8g+ivcFySz/Zx0Jdpew4kc9oRFubbYD3/N0iDPQxWuh1+JYWzo0Ekclxg
         MEyS9clH0I7pTCiWMgMGleBrTljpvtyVN41iOy0yNkOdsRaRqkStTrRciMgSC05LgJcb
         quqVkgiK9YxzNyn+EaAdvJfZF4pyHRcWa1mpGjYCRcN5MLLs/4b7SgVGAoE5e9or0ua1
         dLmMuRIgQ7qNlxO7/DpMvblFXjrq0rBUCrdMWRbyGF9Rr6pNdBn84ndTAi7RkLPhbWg6
         O49SXxknmC40eICRc5mlLjKrZ13k7HMGahqsJxnOv80tksnnpEmjd4GptajXWhquGkFg
         hXtg==
X-Forwarded-Encrypted: i=1; AJvYcCUXw78jxlAvD+T8WnXUlRtUNRJhvnvEFJTANFk7J5S33hmvJaectAsSSQHSXTVGIWHx+UNpmDB3@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz3csjkRlddhg6OWamKktTd8jSdHuY6XMkKGYD+wsW2L0xnGgGC
	dW8iV0VLT566KEX3LIL4bh329bA8sdZ2S2mCu8BMvoX30Oh+Fxl3SSQM+4ZOFWij3lY=
X-Gm-Gg: ASbGncsNv/qjzFJSWQ4H51yPd0KLI38c9lRwuxsxZCr2s7btu2aNo1wfRv1tCAiRnc1
	snC8KurHANZEWlpIFzZtnit16of/ZMbHIZNlLfEVxAZtYyV/g7JSoZ0eqS1zRufhT+aaVArlS4e
	NUMvY+H3V1rE7nLUgh/GloQky/O84MUD2I91n1bPHKLU9QPCaIS9IMhtSsOjkuzXnHMnwcPOV4u
	O3KYI5IAs5jgeY5LN1A5CRkzW9OYS2LDvTz5MzPNO1NuaM/JAXbTJkkPpk/UbGv3rlesdqV+NeH
	h6rF8ydXbooTYpkASD1UKypRJEfrfy8rdEXyAOYSf7/1avEO3I3Gn3u2RRCJyzaeoifADpUfAaf
	cCuZaguQVUp4z74Ud
X-Google-Smtp-Source: AGHT+IETIWG08C4nZWAyLNHuRPUqZwHyv/jiv8DbbD9y4e6JBB1W7qrJthMpNySVRRzDWP0zMhm3Uw==
X-Received: by 2002:a17:907:a08a:b0:ad2:43b6:dd75 with SMTP id a640c23a62f3a-adb49370c27mr1144976166b.10.1748942348208;
        Tue, 03 Jun 2025 02:19:08 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fecd2sm918093866b.36.2025.06.03.02.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:07 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 3/8] serial: sh-sci: Save and restore more registers
Date: Tue,  3 Jun 2025 12:18:58 +0300
Message-ID: <20250603091903.3917202-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18968

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
index 98742edd93f5..a3f7ee98afad 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -106,10 +106,15 @@ struct plat_sci_reg {
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
@@ -3541,6 +3546,10 @@ static void sci_console_save(struct sci_port *s)
 	struct sci_suspend_regs *regs = &s->suspend_regs;
 	struct uart_port *port = &s->port;
 
+	if (sci_getreg(port, SCDL)->size)
+		regs->scdl = sci_serial_in(port, SCDL);
+	if (sci_getreg(port, SCCKS)->size)
+		regs->sccks = sci_serial_in(port, SCCKS);
 	if (sci_getreg(port, SCSMR)->size)
 		regs->scsmr = sci_serial_in(port, SCSMR);
 	if (sci_getreg(port, SCSCR)->size)
@@ -3551,6 +3560,12 @@ static void sci_console_save(struct sci_port *s)
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
@@ -3560,6 +3575,10 @@ static void sci_console_restore(struct sci_port *s)
 	struct sci_suspend_regs *regs = &s->suspend_regs;
 	struct uart_port *port = &s->port;
 
+	if (sci_getreg(port, SCDL)->size)
+		sci_serial_out(port, SCDL, regs->scdl);
+	if (sci_getreg(port, SCCKS)->size)
+		sci_serial_out(port, SCCKS, regs->sccks);
 	if (sci_getreg(port, SCSMR)->size)
 		sci_serial_out(port, SCSMR, regs->scsmr);
 	if (sci_getreg(port, SCSCR)->size)
@@ -3570,6 +3589,12 @@ static void sci_console_restore(struct sci_port *s)
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


