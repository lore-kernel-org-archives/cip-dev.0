Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B579FD8743
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:56 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73604.1773746268839001736
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=I5+jNCjL;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso48424565e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746267; x=1774351067; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sSgRsbEqM90OnvFSPO8jh7dFWfKT34QWwrkr5SmXeM=;
        b=I5+jNCjLRs29EeYcoyUIzWWqPdvUNt+oc2dlISccODQ/QMtB8KRpu0yJKTIimjWv32
         n/8EnsxmcAIjRBLfpwyh6yFMGApZVNsouJwlaSvLR9lwPuFPRj4+GkR5Rt0jSBUwya47
         48ULKI37PuXJ5KsrhBqnWKe5ixuz7Slo/RbXqNH28bdaN7xWJD1Sw5jrmhrKdfxl4Sy+
         nod6cKP29Kc6QvHsQG0YsBeopn01Nf+uhbkXX/ulbpzAhNFcilF00eZzOICb9HiZyhkp
         lkZzG62YDL3VEoUpo+50ZIN5Ltv/mty90J0CC6XlCiJE6qxYSpvrhmequsrzctbVWnmi
         J8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746267; x=1774351067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+sSgRsbEqM90OnvFSPO8jh7dFWfKT34QWwrkr5SmXeM=;
        b=o+SNWC3j9DMTbvCqhA7IizqcfELJG4mOOdQsnnYEs8t9DBWxwLVsHPzqihGIwm9YJg
         oKmMtv3DSmwu8XCXLd6P8Gm8XE6X47BeugQe6un2N7ilZS2h/D2JPR3Lgz+0V7mK+QkL
         6yhrEFGB0ICdfEk3bIfESRU6YSVlC8V5nywrDzIxwEpWO6ceBxey2tokKg5QYbGjRJJh
         DE6AIQ2DUGY1lxDVJ4YBUNeWwyyB9Xtrwt2fHwc9aCWu6vakKpuNw6kHmUhLpT9goec7
         XVHUVtJyLV4x4DwSq+sdc5bR6dw6BbIOmPAc5lRw8ZFce4lZslhl0J1XuvAt3Aee4k1l
         ZXWw==
X-Gm-Message-State: AOJu0YxbCR7IO7x6HIoSyOhiUJov36olD1EhCs/Hk1wtc8M97aVrgLzM
	GTRp/cFOGMu1a9kiKuOnUmLXBoBVj72iHQjeYMLFaJcyZ9PqvdKWJY2Hkzq2Rw==
X-Gm-Gg: ATEYQzxcMtUHDXQioY6m2vEmBT1iWbT46iYxdF3pc90OZVGnT3Zg3kqQjdUk6KVJBTV
	bMAgiF3Zl5n4Aob86G5L46UwA3Tljvw/8K3ytKUSInMIo5LeLkqmAKz/hSJ8AJpPg1LIKP92XSm
	WUaoIqYn8rcidh9R+mny8sX8KTaNQDb80J5yYREsNTV5OCcJSwRhERiK2fNwRvrfeNWWPWKPYkM
	vHq3grPNR/Ah0JI18Sh8JQawIfd2VEPXLz+6BAsUAAXcp93NFbqGAW392qzs6h7h6p1/raTZ/mF
	shR1k7Prd9JdeFS8oYP+nfLvqqDGRsCuwk9zjdcSCRUkTdr3umo4H/utwWX0BXvpJQ0hXuAKB69
	QAPYPOttSQKQEmYlEz9VgvJ5UIDsw9F3vB/3L3BUVtnLG6z3czBgfgAqDDYcpFikbWTMIV+Ely+
	K2Agby/NeT8PjK8rF3YnmPcJzkO2/V2PaDEhzjb7pNV6AMUTmFWz87xpsNQOE=
X-Received: by 2002:a05:600c:628c:b0:485:3aa1:a7f1 with SMTP id 5b1f17b1804b1-485566c6a59mr258055865e9.7.1773746266771;
        Tue, 17 Mar 2026 04:17:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:46 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 34/39] serial: sh-sci: Add finish_console_write() callback
Date: Tue, 17 Mar 2026 11:16:59 +0000
Message-ID: <20260317111718.281633-35-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22467

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
index decc6ccff256..bb38396b7764 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3439,7 +3439,10 @@ static void serial_console_write(struct console *co, const char *s,
 		cpu_relax();
 
 	/* restore the SCSCR */
-	sci_port->ops->write_reg(port, regs->control, ctrl);
+	if (sci_port->ops->finish_console_write)
+		sci_port->ops->finish_console_write(port, ctrl);
+	else
+		sci_port->ops->write_reg(port, regs->control, ctrl);
 
 	if (locked)
 		spin_unlock_irqrestore(&port->lock, flags);
-- 
2.43.0


