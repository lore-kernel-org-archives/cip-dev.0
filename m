Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7F5F417EE
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:09 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15547.1773066364308929949
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=b1Yvrl2z;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so7450605e9.1
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066362; x=1773671162; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71EhgwrCZRDI9Hd+515xK7NjNGjwsFpZO4UCsol8jVI=;
        b=b1Yvrl2z8AAQ91ws2HGpaj0ucMfLtvP6KUDHMZgqZxExtO2OVDNWFnaF7ZNY2cElfg
         2sN+mGCyjmeC28pmHXRKMIMFz1S2kw3VfArnf8FOpLmnVHHLynjSkpJACmcdlZf7Grbi
         mvdLTOZlBvU4Sr7DfgzGbdMF0lOn5150aAyoJnlilH7e/3aqWCw4YGvFaI+udzqOYye+
         9PPl+akx7DfiUeAzXA9Wf2nCDiDBk1HKaQeYGCPzhFnCMThN4b53DZjrR6FhZqohpihy
         VykS7pjrNh8mJxx4hFmrzhIapMMPr9R3Xg7mNVAuhuEcALoaVstWpKQGMnl5Tglw0l2y
         fy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066362; x=1773671162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71EhgwrCZRDI9Hd+515xK7NjNGjwsFpZO4UCsol8jVI=;
        b=hiSfRyoEjoH3ZxQwbURNCVb89zfxvVFonixyEYPirH5M749ad9tPRpSpd995GL2OrH
         tr8875R7guSr2dkiKG+QjtlO06l35riXj3VB9KLqmeHKjTqexNQ7ARymAXuN9VcHivaa
         aRPGO/kJZrWnN8yAYf3UK5Gpc+NN/q0f3kbGbs8LbQLcqFpaLxww/Hlc+TGtxLAqKtxu
         qxRWq5zpNC6b0rF3IYTkBykWNVULCY85sorO1YV9xVBEGBc+AFuNtOmi1DGJ14g1ecQo
         sBo0zHO6Chc+1ieVr/GWrVX40YTq/YnMNKI1a+D6wB3Sn2hH2O8XnKafRyDBa6UBAuxR
         Vd8A==
X-Gm-Message-State: AOJu0YzayQac1Nfm/li8zr1trxLnM2e6v6tF/kUr0OIc8ekVVjP8OnA7
	nHBloNOKtvvVf8zcupG9PJyKY4mt9jWEcxaEKjDyyvBYAhdn39cjluhgFG3cIA==
X-Gm-Gg: ATEYQzzjJYxm7loPHvDQrKE+B3AMWeqvXJchI9i7wH2DwM6ZPQA/BZcUu9VAwGvDLgs
	SxddRsYNfed8fx4/KtYqn+HUAfORbGAVm5ryuL+eHmdL/bikiVDdfeYhdWEQhhX2mQwrLAgwpMR
	EmOPblBhHYhbcbbfJ8s40+BpxWB+4sjNcMGKAcEZ9FZh6W5AaUvYCsSY6M/EDPpiK1d926QZ70K
	EIJUwckKqdH35PJfM7HF3Cf8QSReWAmf2afIz4BW9NK0lRtkOry5GwrhrG29lpDQuzcuJQfq+zb
	/3SngDz0vOBE42Io8Ft+J/aoTLGLYr4fZJonZ/1UkE313FM115rZN28gMH3JmytXTxyg+dY6IZO
	XhvdI+6GWKpW1uP3eGzhlfN3TiCt2uPbb5dOnjpH1Xl/LzDRnA1FWbhYIHAgDMfOK8+IFOjJIRB
	FXpleuYj/5O+k85Mq06mw3UfFuBN8VKEg=
X-Received: by 2002:a05:600c:4fc3:b0:485:3692:e906 with SMTP id 5b1f17b1804b1-4853692eacemr90302375e9.13.1773066361993;
        Mon, 09 Mar 2026 07:26:01 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:26:01 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 19/29] serial: sh-sci: Add RSCI_PORT_SCIF32 port ID
Date: Mon,  9 Mar 2026 14:25:19 +0000
Message-ID: <20260309142549.987737-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22187

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


