Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2339CFD708D
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:56 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73447.1773746266268490576
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZUvGhdud;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-485392de558so33520335e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746264; x=1774351064; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qssqDcYM0UsKLcXiSnjbF0SeCNlrx24l3I/7cruQ0wU=;
        b=ZUvGhdud1n4QKN0OMGEZtL5DTC1XkcciAbwdq0RpdAA4Ln0r6oRIHHQdXbBpQcuj7P
         AJFSrq8ZvnKJIQHyFlwXWHh4N6TQUeSQD0wQwyu6HzqrXbIBkajxf/tYDx7zFQIraXVc
         lEZSFhJR7fMHq2upt0mHOLOGAtScCK95YQ9yHYs21pc/6EWvqwmyqYlKldZmtXfEI+1S
         4yz4138jUeWgGkxXtQrdDR0PJoFXFmwtDARpAwlQvA9p3M+ovrB8Q87QtLO1F2NxIsS+
         CLQU2jVx9izXekDLCMfmQOy8NEb/SmqYrOnz/UOdiFYBYeGFiyRQbVdCPnV+fikEMBEK
         RTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746264; x=1774351064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qssqDcYM0UsKLcXiSnjbF0SeCNlrx24l3I/7cruQ0wU=;
        b=VDIfgyPd0oUM1KiACX4u+r/pMyo8o1bjV5EsJQnAJ427Jx8c/CsrNOcqjeFS6wYrXZ
         nTxFKanPIBFulfhjJ5MYgwPRkupxx63UpXZNPUinQDIm4ty0NoYRgaWebyBZkwVO5pzE
         pwgXTRMa8j+NRs7fGW+RX9QFoCbJvTz+0tq+84n3PYLTnOisziFrqZc3Jk6/4Vxu43vJ
         lSQhpc0zqgfpyIhMX46aj65zWr5yVl+9C0mOQbrQwAxvxl1eJJU5z4Cfz4gZgKpqc/13
         U+XVevTraaJWUYt2DbO1qre9rfVPZZRD8Nz3+IWgH3mFOOFehZWnUpLTgZL0Tq7kDD8C
         NFiQ==
X-Gm-Message-State: AOJu0Yw1qTGy5GzFeQvP7EZq3fJko0Y73wdlt1Htj4FWoCplP5xfDvUW
	zul1lFnmiA9UeXzb4yJY9J2zPGEQzmS960oRonovr8Lp+0sWQ5h0gL2zqsIhOg==
X-Gm-Gg: ATEYQzyZDYdSEsdnPGBSpHr/X99YbHI2qJpnXWe1RElbzUhRI1bViPZDGXDrvRd6awt
	saaK6Odo4urw7RoJL0OE/mW2Q2QVQzrVCWkbOjvU8w3fI62P9aYy/RhH608gu5TmxwzYJ01mM5p
	Q0lZj+0l7SCcDVPu9wBgvhHmeTZbvN6i0/im+EgUHW8Nc/lxzhwxya+MG1hIdU9S2enwbIv5GFj
	qSuWyc3LBZy6xN9wHSksKTcA1P8JDxBxabeoYUWMq0GN7+Ry/NJrmjmnIgLVuu52Ga6CJnhE3KG
	htY+yNYS3eP7PBtDEXNQXywHDfNpZKUvhFZHx4LphXFnokZmumDSOC3708JjW4zf+MWAxynDJ/G
	q/xfpOLvPq+eoO5UJ4gfMZFhbETPb564CHpR5I3U2oRfW/Nd6nIGYye7iS55OaYKRC6BbPn2cyU
	ZjXs0KkV+YgzymQIx+9YFs1pSeo1petAllCId/02ar7a1ryGyJ
X-Received: by 2002:a05:600c:4f8b:b0:485:3e6c:aa84 with SMTP id 5b1f17b1804b1-4855670f7d3mr275302995e9.33.1773746264205;
        Tue, 17 Mar 2026 04:17:44 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:43 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 31/39] serial: sh-sci: Add RSCI_PORT_SCIF32 port ID
Date: Tue, 17 Mar 2026 11:16:56 +0000
Message-ID: <20260317111718.281633-32-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22464

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
index 680edd9d1771..54274112c3f5 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1186,7 +1186,7 @@ static int sci_handle_errors(struct uart_port *port)
 
 static bool sci_is_rsci_type(u8 type)
 {
-	return (type == RSCI_PORT_SCIF16);
+	return (type == RSCI_PORT_SCIF16 || type == RSCI_PORT_SCIF32);
 }
 
 static int sci_handle_fifo_overrun(struct uart_port *port)
-- 
2.43.0


