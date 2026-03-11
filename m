Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BAA104BED9
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:17 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17657.1773223513623713371
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=U9L54bke;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439bcec8613so7783655f8f.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223511; x=1773828311; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71EhgwrCZRDI9Hd+515xK7NjNGjwsFpZO4UCsol8jVI=;
        b=U9L54bkelPRlGcIsmrC3tUuCtm/afnUFNmK4UXooQrI0va42B2n5nfG1sAu4ryaa+5
         IHE83IJ1nr772lxX4enyvSzTMNNWNHTqBkdUENT+WJZR4hdutzfmI8C8ZzfWyRHIbCXb
         M1sfmaZeAF6GtLLtTsPQfk6aHxjTCl8PX74kAaj6wXPvPkJ71/E6Vq9GNP196IaRT/Z6
         G2biMRviNCah5uY5NgDK8+rNzVQ5zeqNQzluPf81LZQHAs29+pnKyknadjmMsUsSJk8B
         0ILJI+p3+QmNfA8CM3nURT7MVOAQ9aI6X9RWWnGn1FZuqERNbHYJsMa4oUs5YK80sNdx
         U6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223511; x=1773828311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71EhgwrCZRDI9Hd+515xK7NjNGjwsFpZO4UCsol8jVI=;
        b=IgGNZ3PN7/RrzWSIUeXg/WJ9TDmE/gOkQRK5rBv0cKUqdxBOov1XjKdyUYCz6Sfcmx
         ByREuV2YHB16NU51ZCxr5BjFaLtwedC4CmmSabiBInzhYkhnJdqxSK2JkJBrwkfQqkxn
         TOg85+GnaAtlA0iw26yzHSOZC0hS7yBrM27lW4Wj/L+leA/bKP9IvAe1uS98Cx+U84sZ
         A6ro8AL1ZvWO2t6Fn1wvzVGRiNSeAac9f3s/ESfUa+mQx/kQUzljcwflVj95qczVplCj
         NFzj7SkG5GK9qvDevIpPs+hR4AZEfGoIUctsJRQ8BD5/MwgTN4Af6taq5I6zj3OxFiAm
         //hA==
X-Gm-Message-State: AOJu0Yyq2Z5gvF5eX4YcxnIMzdEpxolQU6KVFa4Y+63RcR70iQ7ir4Th
	R2193iC0MWPHC0DrR1cS4H7on7UGlsnDnVkm43L2Xiv5edWiKgHX9XkwRbormg==
X-Gm-Gg: ATEYQzxfGskumn8fbsphj1OT6UtGg6U0N+JsZVizkqiWDwl/cOBd8uOjF4cY0qAjWvC
	HuLBlvhkC+3lkaChI3NK1/bmoYtnHvCU5IoRt3DjvYSAuWAWEG4RZRhWDv3VVBKvbP4wur5ANh9
	hsPhk0Ml+iElcrx+F9V92gSKrlAnG9uwva9SE4DFa5TRQNEN8R5fschA3QYRpslJldPnfIMg8ht
	G4IKQdVaEx0U/Miq4KmVG5hk9wMI2nuUyhfagQ/1tl1j6EPcL0v2o4ez5c4NRhZArQEAyuwOOgX
	WHAucfDiSRS3fJ8SDpe2NniLZ1VpL1QYR09HKApbob+UK9rorui+rkOK1ydT/DUGQgWxo0zVKs3
	AdOYVbHGgnULE2psTmg5/DpI6Xv7r5JKuixeOtIJLksyEC2Y1VwtW54Nj4+SPgqdfgXtRnt+Jdx
	Ob8vtYFoniBmmsoxMFUKd+cyGTgyclofE=
X-Received: by 2002:a05:6000:2882:b0:439:a95c:ef03 with SMTP id ffacd0b85a97d-439f821bedfmr3811862f8f.37.1773223511399;
        Wed, 11 Mar 2026 03:05:11 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:11 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 19/27] serial: sh-sci: Add RSCI_PORT_SCIF32 port ID
Date: Wed, 11 Mar 2026 10:04:38 +0000
Message-ID: <20260311100458.162447-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22265

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 4cb2bd1bf41a0d6dbe1fc4bf8d8f83f40b914572 ]

The RZ/G3E RSCI IP has 32-stage FIFO compared to 16-stage FIFO on RZ/T2H.
Add RSCI_PORT_SCIF32 port ID to differentiate it from RZ/T2H RSCI and
update sci_is_rsci_type() and sci_is_fifo_type()

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-13-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci-common.h | 1 +
 drivers/tty/serial/sh-sci.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 1b9480c7f4cb..abcd5bcc7c36 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -8,6 +8,7 @@
 /* Private port IDs */
 enum SCI_PORT_TYPE {
 	RSCI_PORT_SCIF16 = BIT(7) | 0,
+	RSCI_PORT_SCIF32 = BIT(7) | 1,
 };
 
 enum SCI_CLKS {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 69cd9aa60922..0a38fd760c4f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1184,7 +1184,7 @@ static int sci_handle_errors(struct uart_port *port)
 
 static bool sci_is_rsci_type(u8 type)
 {
-	return (type == RSCI_PORT_SCIF16);
+	return (type == RSCI_PORT_SCIF16 || type == RSCI_PORT_SCIF32);
 }
 
 static int sci_handle_fifo_overrun(struct uart_port *port)
-- 
2.43.0


