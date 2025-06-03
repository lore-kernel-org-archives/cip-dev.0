Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1EEC5AE59
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:57 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web10.6979.1748942387273452798
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=m5h+piPV;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60462000956so9160015a12.0
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942386; x=1749547186; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhTTBFXuZ0psyEJ76glufVgmlB9G1xyg1vLzkzG7kKQ=;
        b=m5h+piPVAftRlPUpw26Sl2K0KKnizrv5wSCiv7mwL/U0yEQPVqtKulrHltsv1kTFkr
         gtHj8f6dhsJhv1U/OwSc13dQuDUKgjdqAbCVZyi5ithxUxAMH80e0v7dtF5T7HxL4i5/
         JePjqcCt0FofqsDsOQEQZIgjuz5k5LmwrbG9WeBSppDUYC+gtwW4qecUdBtjbxN85G1G
         RSMAe8DFKaEYxJAzA7gl/kgyBeaweSt5yXVMkbxpC/hRLxGPMPQuIQWiyovYUMjTcCb/
         H1bysBK1Hu1/zJbRDzkjyQUm8p3CCBMikJAuYINe0jzRTMrMnAN10pqmx9MS4HQX/Mfc
         M2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942386; x=1749547186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhTTBFXuZ0psyEJ76glufVgmlB9G1xyg1vLzkzG7kKQ=;
        b=Qw8kJ0RSzV5PqLJZiaqVhXBCr3jdXyM+afVXuYl5lA24ojEJBySp11pOb0yrJcsf0y
         iIYDvRtz6XMf6nrbhRZ9lczEroJKT7pNm4JCmZrY34h42b48xcP8rOZaHVYZmLypDdas
         nlbp63trCtQrYZeWLmlYgi9s5xx1bvljwFcsYS/9owA89xthzJAGPDn/rjNYwYDPEFBH
         UUZvOrZHyQcwSlY3ktxwAijDMkD4n4DCRkT1UCX/AbmALsN2rOCnExW9BA/m0rGj2Seg
         zsp1YnCHQovLx1AbHNIE+NyW7KxoBWuY3ZEtMbQNt3eSt3Wr1MdRcXVPUcgRebY9JZuT
         u+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWINypRzEeRipEcvg0LZnXvp/PRKJKzlQUkGp9Iqm+TXGl7V1vZ/8Ni3a2H6SMv3dvRqL1HxD7b@lists.cip-project.org
X-Gm-Message-State: AOJu0YwaQxdUNG1eqBsnuB8rfy7mVUTXRi+0AJjwWLUcq9D9g5WEBKli
	lgNrzC+AZyW7ZjhPTvw1EeSu5PtFfdSv64hqA+oxzOpR6dqFjCAChT7RyRNlCGCGmf0=
X-Gm-Gg: ASbGncu6DX7q/s7ITCdqAzn1VyhvdzZBiguZp/SULD6hF5ylWalna1MF2nfD0GY4eGj
	p7oqVFVOf5IjkeuJA8NQ9Ex/Y3Ey2fFztbo9FlAT6F5Z8F4fAPJzuDERU7XTUT5am9zeMKLbovM
	VQ1xLqUGbml2Op83qgR+2pwSyuDO/Vxdefu8WhBy+mEYeGiJsGEsn92fmRUX/I5XBcfCCtobXUB
	xlpaDar9BD9hjEMNqAO0RGLdSZ7vdg6hgQf18YJW6KCH2Oo9KFWfZdkSEhNYLGhTY2e3JSKG33W
	lvZYxNyKxVxQujN0W6cEzrq0wxX+VGWxfXjOxPCJmo0YouC6sOHuF6BzuiU/zRToRwHfapplfx9
	iihE97A==
X-Google-Smtp-Source: AGHT+IEcaYWQO32iEeaYklFwqN5EKOEucBJy7gNxCnPQn7mREsuZ1I5fzReeXyoeL7pj5ScJ4DdTGg==
X-Received: by 2002:a05:6402:2349:b0:604:efcc:bf64 with SMTP id 4fb4d7f45d1cf-6057c60312bmr13932862a12.19.1748942385652;
        Tue, 03 Jun 2025 02:19:45 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c5c5casm7301944a12.25.2025.06.03.02.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 3/8] serial: sh-sci: Save and restore more registers
Date: Tue,  3 Jun 2025 12:19:35 +0300
Message-ID: <20250603091940.3917581-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18977

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


