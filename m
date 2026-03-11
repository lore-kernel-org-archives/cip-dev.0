Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9CF104C002
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:18 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17661.1773223516636844549
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H6Cwbj6m;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b7c2788dso7433444f8f.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223515; x=1773828315; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoHx5kizIrPJZtvBZQ8WOU3JBd4pGBNBlOoEZxd/18c=;
        b=H6Cwbj6mJKSSZ42RX1hZwPPDYg/WiXIPFbHVnQJDNEg84TJIXDOzL/ihrowDqa3gez
         j++1tmu+X4vetGb8sdFtmAD9+PsfYM441/G7heFVvpxXeTHqNiXt67qJ8Lb6EqP+tI5p
         FOrqyGPil7lTO8QSay78LzRhhoTLB+3TNLPWzO1KO5hVH7+Pni0ETh2DedhdQAn8P15V
         JfXbqtMrLoO2WYfvEpYjL4slf0vNNA5RtbF9MfB3QCf3tQcmKAqXhDJKjXJoU6HmI0+D
         NPaQIcXh+9Obe6ivBU2VILAPp8TCBIdf/e1ecAsTVj57b0wjOq0I22dMm70My/1wyIoN
         Zk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223515; x=1773828315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RoHx5kizIrPJZtvBZQ8WOU3JBd4pGBNBlOoEZxd/18c=;
        b=bXS9XHbBDAWSAzSjyDorvdbQl5edWIkNkt0YUWRG0HfUw5BOEs5KO5S27NkD5cozFM
         zvym6SISxCIq34y+1RYsAnuB8CH0Az8QQiOw6LiVDjAxJNOerE0Z+OdtdnrI+LLkufKw
         qNE3i7NOYY3VCQ4Sfagdt5xnMJB/lfa9uOpTeJzjEFjv/oOoDtDNnUlMMMfdPEAfssp4
         HsbS2tb9C3aFMc426RUurFfCIlpuj8J3jrBHuqJOLvg+IKXpFaHkGFXK/WBHuB1Y4QtP
         bWHqOeH17T2x48rdHQXga+31sOw/gAx2Usb7y6G5xJEge2fvWDKz1FUv3EdLH0mfNPK8
         Hf9Q==
X-Gm-Message-State: AOJu0YwM87ZGduZd0bju0VAA9A8hdJhwWAAb8sV/r22Sud+W12nHvuzq
	iQFzADuuY0krgHg1vYCSL9aUhssK2PPAzpZ2oKkHQmIN7mTvEuNSpAbUFnD8fg==
X-Gm-Gg: ATEYQzym3n/MXfb+Yku4Bs73UMmf2QC7etmeI70Q0jgZsnQfYRaFzr6FhStOc+hfE/p
	5o156D9dU90QPSHj4lt+NB9tBRoA0WoS3EtTW2H8J3EemJWpiwfHqWZxNMLwLFTuOG7bf3oqxzD
	p3gJkoh1GqyCV+x/msiVGMqAUO6OroA0GIwJe5sjdPT0ySj5Gn54vGafX1Ngp5BHZBFP9vof23n
	297TeKe/SOaZLIZeb3hC1G/KSUo/rZtV/0L5FcDl2xsiUzA9EBxU1BdQObTZe4u6dEB5vQtG0Jh
	IBOa1pjMfK9RAM8N6So7+gKDjpSL5UlsfhQTbgCjXSaM7qQr658msyCcvVAWxY7u1x/y5y+aajd
	MZAmA0WGhyj6esd5OFMfsZfENLv0aeR/gHxLlQh11OWrxtQ7HCpTVnVbiEXNZfvx6ZlnWiUWCcB
	glVYKUWbg24yeIb/CBce2m93FD059q8v1x1KOkHLNllA==
X-Received: by 2002:a5d:5f55:0:b0:439:c5cf:fc6d with SMTP id ffacd0b85a97d-439f81bd4b9mr3825288f8f.4.1773223513280;
        Wed, 11 Mar 2026 03:05:13 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:13 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 22/27] serial: sh-sci: Add finish_console_write() callback
Date: Wed, 11 Mar 2026 10:04:41 +0000
Message-ID: <20260311100458.162447-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22269

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


