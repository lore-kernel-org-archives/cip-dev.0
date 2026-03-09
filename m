Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E671F3C27F
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:08 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15555.1773066365686690423
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jwpOZG7/;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b78b638eso8921733f8f.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066364; x=1773671164; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoHx5kizIrPJZtvBZQ8WOU3JBd4pGBNBlOoEZxd/18c=;
        b=jwpOZG7/7R7ehoB3FCJTD0TwFH65WM+FW2gFJeavHbkr8HVhPpipdq7Ozp+XEmDOlh
         Xhc7UD/yae4HVQPmn5OBro0bT7q8i54v4bA1x5B6OTLtpcyzac9MWk4PUPgVMXVc4ooV
         EYdID5LPgI3pBi6CCf3bz7ocDjuL/YxFh+NYRFudqE8NcXFGj7/XuhNLtVTS38njMhE7
         UXUwdp7j7eI6pRQYVkolgPo+6KO+nHIOxWv07ReN8p6NgsERBma95qXhMsqGDxD/sTUe
         K+dpBuEyKRXOozjlvdcR4AqOI9ANQK2zsEZdvcgBUhXjlXtWk8AFybUruki+d7VEcqkT
         VETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066364; x=1773671164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RoHx5kizIrPJZtvBZQ8WOU3JBd4pGBNBlOoEZxd/18c=;
        b=RgqBwySjmeIM1ijBkwpQJLKyNbAHcWQA7bWzcOBnYtPPNzb4hUog8yo9DctP+y5H+Z
         RDVD4qfCWpAK9IVXWFf57akhXIEqonDfrUWAYOj5ioDcLye9RROQAm3KeAlI8UltQ1IM
         Ljc0RjyLfxsjtoWnbYjPlZmozLvCzhyAsN8nBxlB88lHvTa1UiYG86Z7Nz5RUDjw9NTp
         3oMmUNbKbhghU1/4zEWrbud5+x99vfxNt8PVoz604Rfr9qUY0rUiRv/cBX6sjhnN6VHS
         07K+ISMkMVEMgMHNfGzILRO70o4zd4tsn+PlAhCqyEV8/C8l50I1JGXWRrYy9UZLcS0/
         b0bg==
X-Gm-Message-State: AOJu0YxRzFXssD2Jno5lypAGS1HMqs6/fSH039hTEEaVyhUcad4sijnF
	pV81qGkA65aou4mgnd2DfnYkJEmxdi/+iMrDS/6gnTuFTF8q0QrZkeJVOTAc4g==
X-Gm-Gg: ATEYQzxVrcJQ3L3892/fAs5uLkr4k8Sybvq2OyY79JYPcm3hZUebBoS0pvNtkk0Paqv
	JlRqi8iBs3s5EbX9zwIb1GE9T+AywFV/GYuPyN3Tz7ANaLhQlIFcmroqL7eKJqU2x0cgsKtlDog
	l0tGqLUHcIpJCvBHRW8ASPjsfyx4tOWhSN6z7P+BoKVirKSeicgFMAxLUulAWlDQmmOWuR3w3B0
	bNCOJtu74KIRLOWdYKim1zwdrsXJV0XD72CMe2i7vQXMk9ysK1JXCvCnAhTkIUPlLRnVU0+pstH
	zSMrcteEXKrYIBgYzSJ3sd9FXKPs8/BpKFNad8PvOJCBU4dChnp7SAYIQflRi67G0T0HRVVGNf3
	0Ld+iYpQI9CkGqkd20Sqd7nhZuzzq7vaKVjwNhj/esAmxKuR0ppF7LWAtOJ4poKCaleL0ulFBk1
	Iw8k3o0zeBM85CLVs09fk7cpH5Sp46pQZh175qiJrHCg==
X-Received: by 2002:a05:6000:1acf:b0:435:add0:3d68 with SMTP id ffacd0b85a97d-439da8a7f38mr20258220f8f.58.1773066363702;
        Mon, 09 Mar 2026 07:26:03 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:26:03 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 22/29] serial: sh-sci: Add finish_console_write() callback
Date: Mon,  9 Mar 2026 14:25:22 +0000
Message-ID: <20260309142549.987737-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22190

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit bbcd508c84d4884c620f4f4bb7d382539466b9a3 ]

Add finish_console_write() callback as RZ/G3E RSCI IP needs special
handling compared to other SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-16-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci-common.h | 1 +
 drivers/tty/serial/sh-sci.c        | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 976e394ab968..f363a659c46a 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -93,6 +93,7 @@ struct sci_port_ops {
 	void (*shutdown_complete)(struct uart_port *port);
 
 	void (*prepare_console_write)(struct uart_port *port, u32 ctrl);
+	void (*finish_console_write)(struct uart_port *port, u32 ctrl);
 	void (*console_save)(struct uart_port *port);
 	void (*console_restore)(struct uart_port *port);
 	size_t (*suspend_regs_size)(void);
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 781fc371a62c..588027a8068f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3432,7 +3432,10 @@ static void serial_console_write(struct console *co, const char *s,
 		cpu_relax();
 
 	/* restore the SCSCR */
-	sci_port->ops->write_reg(port, regs->control, ctrl);
+	if (sci_port->ops->finish_console_write)
+		sci_port->ops->finish_console_write(port, ctrl);
+	else
+		sci_port->ops->write_reg(port, regs->control, ctrl);
 
 	if (locked)
 		uart_port_unlock_irqrestore(port, flags);
-- 
2.43.0


