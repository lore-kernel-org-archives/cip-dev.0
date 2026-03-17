Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4031CFD708D
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:45 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73593.1773746259818544875
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fwmVNyHi;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853c3c2fe7so32998615e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746258; x=1774351058; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xudq0nRrmC7PYNpjzSkoD4OB31w+4aWwSR0L56N1kH0=;
        b=fwmVNyHimThk8MHlg8n+vEX6CIMYiTn+0VJ0ZbleXbioR4/AxeI9ivtvsgbgdB4xbe
         QnLuHIMB7h2kcBFbCSohrnkn7BYY+hVw4nNTuyx9bH1DHrehCjs2BoV9YeyyYbHGMZGV
         kVnHQ+O1ioCMmiI6K9Ke2dRf6oruvHtRnTtf3fKwW+2UjkPNrRZwR9GuN92iUIqefycM
         5V8SLt2ZZGMWVQklNhNedbzRWJkMuMqTTxaOASL/s2kPDUIDhcaD7sWJymaVUge5FvPV
         TnOUEQD1KprLiSNki4L3GGwnqD2o9+hQa0y5Y0ExoIgZW4R5ISNYFmpv/kSl9M92tc02
         djQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746258; x=1774351058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xudq0nRrmC7PYNpjzSkoD4OB31w+4aWwSR0L56N1kH0=;
        b=cL/A4ZW1R1DnlWIPrGLEEwqERniCnLkQcklf25BmXYwPPhXArnAUhRdkeV41lyInHP
         5UhNzTBeCQzugyW3HFPB59HCRb5VjvtksdFrfK9WpeAuBNg62p0FtPWFz6eD23Kws0zp
         6G+xK9BYAzpMiFZ8oRq0MVq6LEDOQvpK6CSHawgSQACMtnSeDXdaNZKpJCF18njl5t5C
         pO+JX7SQFRsfoktssaP3c8IpGJCI05mhVTIYwIS6W0JcFalIsJHDmS0ZbxA6L3OJ1DtE
         jcMtOcCVP6aLPUbsgfgYWb8Hu19MPgmMYq/VCUNsfPDq8zA8sB2GB/QqHF0FW9CLdaYb
         Kfnw==
X-Gm-Message-State: AOJu0YxbN/CU8CkpqACMKL2CRjiAHuQyu8VPI6QCYq6EvubXR3NkHEWG
	rfJgJ0faqh2JUE+aQ2s9sky7xj08l1yyWf8KmKcxhmIm9bjI7SEsLG2lWbdaXw==
X-Gm-Gg: ATEYQzyi616jmT/08jCrDTM+QHJNwcLmrhAG6RgPIkDxmFUcrTjSj9mwMXKYIF+jhCM
	qbjFXVaeJ14TGKMB+P7nVwst4daj4sXLIAajUkiKErxGyCRooPtH60q0A1YbV8WEcGAIC2wyD2X
	bimhi3ylPGVD+0pHFmvaSdBZpa+cTsxI/h9+/8a2rxQNSKPP2/iLr2irEUNEw3Ek6YOoTp6Z1hg
	KNKMSq6xCPZ38LzijV1bmX9f6KVsp2DMxlPdmHqoJ2W4drt2/QYRtv1shAvOclWCM7kLQEFHCN+
	y144gqi9u3oP1ndJNIyjQ57YGbpKWZgVhFnz0vpC9v7WB9n4hLR1yPhJfhIXMncNBNtWKLvpH+z
	ZgZvBt28wkCUzKUvU347APtBqeZnqqNpe96bHpfhaLf7DDWqfNzkvB61u5cC8VZODDaAyXzNE8Z
	Lg1kSWa9kxRLV5BfCYlahFc6T5HL4xkJ46mp1hdVd4ogczXL6k
X-Received: by 2002:a05:600c:3552:b0:485:3a59:99ca with SMTP id 5b1f17b1804b1-485566fab0bmr275918505e9.16.1773746257647;
        Tue, 17 Mar 2026 04:17:37 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:37 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 22/39] serial: rsci: Add set_rtrg() callback
Date: Tue, 17 Mar 2026 11:16:47 +0000
Message-ID: <20260317111718.281633-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22455

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstram commit b346e5d7dbf6696176417923c49838a1beb1d785 ]

The rtrg variable is populated in sci_init_single() for RZ/T2H. Add
set_rtrg() callback for setting the rtrg value.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-4-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Biju: Squashed with commit c14afba60a61bc80403a571a67db956aa9800dbb
  as 6.1 do not have field_prep() ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index af6dd4b54787..3869ecb0315b 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -151,6 +151,21 @@ static void rsci_start_rx(struct uart_port *port)
 	rsci_serial_out(port, CCR0, ctrl);
 }
 
+static int rsci_scif_set_rtrg(struct uart_port *port, int rx_trig)
+{
+	u32 fcr = rsci_serial_in(port, FCR);
+
+	if (rx_trig >= port->fifosize)
+		rx_trig = port->fifosize - 1;
+	else if (rx_trig < 1)
+		rx_trig = 0;
+
+	FIELD_MODIFY(FCR_RTRG4_0, &fcr, rx_trig);
+	rsci_serial_out(port, FCR, fcr);
+
+	return rx_trig;
+}
+
 static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 			     const struct ktermios *old)
 {
@@ -457,6 +472,7 @@ static const struct sci_port_ops rsci_port_ops = {
 	.poll_put_char		= rsci_poll_put_char,
 	.prepare_console_write	= rsci_prepare_console_write,
 	.suspend_regs_size	= rsci_suspend_regs_size,
+	.set_rtrg		= rsci_scif_set_rtrg,
 	.shutdown_complete	= rsci_shutdown_complete,
 };
 
-- 
2.43.0


