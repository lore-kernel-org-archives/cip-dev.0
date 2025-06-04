Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50474C5B555
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 10:23:51 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.13294.1749032629116279737
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 03:23:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=NNxAMygp;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad891bb0957so1170157266b.3
        for <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749032627; x=1749637427; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxNPRJAqSaNHqNZ9aXGPxspxDR8Rwg64Sl1Naujb4S8=;
        b=NNxAMygpN1NdHgfaw3EAY8EKSr08pq3lhKEgNel3FKFtBwiz0nSWtzTcYtJUmlg4pq
         0DY/MhppAoebSX0OTh4WG4EsvY3uE9rTvRxc3KpI970nJsFpDg7/+3aiqko8Ss+U8Sia
         N11GJ1Oko0fuwmMJGeZg0FVxiAEFqABs4zLAnT7LJMtZj71p5tgU3sWHvhO6IJBxNd69
         eUTP1aYfLsx5jk4ztv7ayeVDCNbwxcwVWutgJ7rJzcYcTQWytBDlIK+wsVp7iVMj+3Bl
         qtarQHm1mEwWS+4OBAJrolHppNgfBG5IBVmL1uIlyYeULYInI+XxbRAFDVNvrNZk6b0I
         7h8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032627; x=1749637427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxNPRJAqSaNHqNZ9aXGPxspxDR8Rwg64Sl1Naujb4S8=;
        b=FMIgo1TVXEAvYzNI+0+30p/DP8SYJFagNsFh0EEsn3/9U4Kyp7ChUAAJwVQVqag0tm
         CSxXLQ1I8aGDRS1bkEAusyaUOloL//ArqEf64k18zRMqDdv7SJ0YOebnlhAAy2VKFojS
         7DGW+d0T1i6jFN9VBMSXtQo5Pfot0V9lFlpTVQZ+yWfdwcGeIuetg2Td9jph8EdfFLm9
         uHicK1YAWLJ5/jU8QaL7/FIF7W5rDlq9FNytC+eJFs2nBEe7nZ+IrYArbotRFfgWKMTb
         rCOd5rcILWJg4DhM/JDBFxdwnUgWWKo8oJPcIKszYwEIeeUKIeRPWzVO9mE484/7T4fS
         uI7w==
X-Forwarded-Encrypted: i=1; AJvYcCUcHW/0Z7hiXAO1qCwYcpFPgfNU3Uf12aTMnKZY+YFBxlx9vlQm4fPHCTsi3nbLJ7NBBsypdtTT@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw7p7xjcyPRvwfDL9Go5Ti6ZeoRooEE5im7nu8z1VwEPODQOBIZ
	xrNKyrbSLUioLjX762EI3P/MfOmp6UqjLOlL1zgaeOAKofRkwgZWYZgwqAa7TeKtv8HWJmwaZh1
	/whvO
X-Gm-Gg: ASbGncsZV1XcvP2Gcbo4tDwTajK+NMmh/mgYqnyXJLHls2ErkXQ8fQR1tNRBTJFhb55
	6Lf1rmQWso+oW32ezM3vydJQDSHN2Asp/L9MKy6pfLxuRIo1dGJRiQOZ7fWW1LrdyyIQMTHm22L
	n7mV7GUjpZC2SakT3o0r3Zb1tovW6WUvt5bmAc1O1WVzg28+OZfM/+HMKqmItjFlkTEUAdlnpMx
	JdiMInfIPj0VhiN7Mbl0mvukQ05XyTQYBnbUwueZimBNeplKynpqXEGEs56AR+k77Gq+8Fd/NPy
	QiN/ySyBKHmovTdQbW0APBfIxU4QRpNLIW4Ut9TfFsulWHiIlx0GHCTZqQzurLAZR17TzoDXMUG
	fawe3C1nf+gP9t5Rz
X-Google-Smtp-Source: AGHT+IHX+Ut/h9Wys+eIwCMwYlo2tPhvF5Z4OqwaUlMepLVNjPzuH74LUYTgzwLS8SGpBt9qXnlw0A==
X-Received: by 2002:a17:906:dc8b:b0:ad8:87a1:4da8 with SMTP id a640c23a62f3a-addf8ceb568mr180504466b.14.1749032627458;
        Wed, 04 Jun 2025 03:23:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e760sm1087375166b.52.2025.06.04.03.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 03:23:46 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 3/8] serial: sh-sci: Save and restore more registers
Date: Wed,  4 Jun 2025 13:23:36 +0300
Message-ID: <20250604102341.2524186-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 10:23:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19004

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

Changes in v2:
- none

 drivers/tty/serial/sh-sci.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index fad62f1a5ad8..f914cd5df01c 100644
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
@@ -3563,6 +3568,10 @@ static void sci_console_save(struct sci_port *s)
 	struct sci_suspend_regs *regs = &s->suspend_regs;
 	struct uart_port *port = &s->port;
 
+	if (sci_getreg(port, SCDL)->size)
+		regs->scdl = sci_serial_in(port, SCDL);
+	if (sci_getreg(port, SCCKS)->size)
+		regs->sccks = sci_serial_in(port, SCCKS);
 	if (sci_getreg(port, SCSMR)->size)
 		regs->scsmr = sci_serial_in(port, SCSMR);
 	if (sci_getreg(port, SCSCR)->size)
@@ -3573,6 +3582,12 @@ static void sci_console_save(struct sci_port *s)
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
@@ -3582,6 +3597,10 @@ static void sci_console_restore(struct sci_port *s)
 	struct sci_suspend_regs *regs = &s->suspend_regs;
 	struct uart_port *port = &s->port;
 
+	if (sci_getreg(port, SCDL)->size)
+		sci_serial_out(port, SCDL, regs->scdl);
+	if (sci_getreg(port, SCCKS)->size)
+		sci_serial_out(port, SCCKS, regs->sccks);
 	if (sci_getreg(port, SCSMR)->size)
 		sci_serial_out(port, SCSMR, regs->scsmr);
 	if (sci_getreg(port, SCSCR)->size)
@@ -3592,6 +3611,12 @@ static void sci_console_restore(struct sci_port *s)
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


