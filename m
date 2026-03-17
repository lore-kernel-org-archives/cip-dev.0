Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA21FD8740
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:56 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73602.1773746267856472251
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JBhFLpsS;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486b96760easo4148185e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746266; x=1774351066; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfis0D2rkuOGhoxqsVc3GEtfiYZuscc8qKOaCI9iw9Q=;
        b=JBhFLpsSkScYehCPLeky9Xsop7BrxhTT+UQCjujF+VUhSEaqd88LSn1VRK82ZvdQpS
         ThCk9nbngJAKjYLNWt8Wid0hCc14QSumfZFDMxErtThAI0Kug0sGE2Lz6jKp/3EUSO2S
         xJhitH0kwaIlonhpMnDOx2RgkYPd9sSs1SMOwQKgfZn7M3jE+WOqziCsRuyF9XIHPHDc
         nlhFKZ6NyYbkG2DpaeK3rtypFg2KxuXjGeTrVFjbcty6egJ/ucCHC4sSUfD82y22//OS
         iaVCaYkybplyiB3YAaP2ygpNjlsEj7R4hOi1aRyoTYFiaZe2wajE/QeVQANuuzpJEV9y
         jksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746266; x=1774351066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bfis0D2rkuOGhoxqsVc3GEtfiYZuscc8qKOaCI9iw9Q=;
        b=PM+8qBjGXUAXP93b0ELoMjcgutTBxAJGswCaDuTFvysfVpk3X1r4RTNK4cFLZ7JsX7
         C+12quuKRBaZLL7A2I02jzWAHZSBFIPoc4XwOrfi/kJI6WPcBzE3YCxVBVXSbFkstGRM
         k8r7J4PbgddNH33r4hr4BeaiUodfus0US/mnGds5V30yH/qf9tIKyr390X2KvewluV2J
         elKwrFRiEXfcs3CGO5L8ssXuN4JNKKst+ZIj/xteBhuX7MMkNTmi3bFXTNP1z2oiHZvV
         k3TTrCfRk2YLeLld6cwET+jROuW3nMb7I0DFxjL78DowcsL9H/CX7mqBLPykMSvgx3J1
         k9lQ==
X-Gm-Message-State: AOJu0YwSLc6oP/BcgL/UQEPLEIHK/ZOU9HqpQFZDZm/fNycMF4go9cgj
	pdCYCAmxhqD56i5twczpGG86vTGRWFWx1jUXVlGQtEyTqoOjdpJb7pTO9jxZ3A==
X-Gm-Gg: ATEYQzxL3V2QXQRq0RLEXTF1hIqKODLp0WoZ5f6Q/ndFOGccC8BhSmhh15M4acOATKY
	qf+rWMRxsfM80fD6wUrK98gdhZRdRXpmLSpDR+SYZfPhLxX6mGJo5p2aOGklvA0aF8r+k5HBWh6
	bwTMRU0JprD2iSaMDZetaXFvy5iWPeHqLivj3aa+bwmP2mX3Dr0fzd64qglXvbhIIi8F9kgeAHF
	hQKWbmXBEA0cgPFszxCIAWuZZ60zUlu91VEaLuvOJZykTuJqCwSu+W1blSirzGhoAew4dpvYQmJ
	3LufusrSMZwBJz86hJadX2W1gWAUnCvCjuWRT8HRBivr3IR/wh0/q+thyj1sY4ECzcCDebUNpPm
	Me+MT1fu0AdRXeYxU5GZMxLT/+x1imU2UsEp9UMqAXufwozhf8OAWahOlLRHBd0GifjKHIQCX2Y
	QEjCxt3sdl/lFx5f8aWNeZVRYDhIbRVWVzuDKglEBcU+hYmqBB
X-Received: by 2002:a05:600c:548f:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-4855670514dmr276341305e9.20.1773746265887;
        Tue, 17 Mar 2026 04:17:45 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:45 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 33/39] serial: sh-sci: Make sci_scbrr_calc() public
Date: Tue, 17 Mar 2026 11:16:58 +0000
Message-ID: <20260317111718.281633-34-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22466

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 5632bda5e848c4592eefa4451092beb4ce29ab76 ]

Make the function sci_scbrr_calc() public for code reuse to support RZ/G3E
RSCI IP.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-15-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Biju: Dropped double quotes around EXPORT_SYMBOL_NS_GPL ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci-common.h | 3 +++
 drivers/tty/serial/sh-sci.c        | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 5d30771278b4..976e394ab968 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -169,6 +169,9 @@ void sci_port_enable(struct sci_port *sci_port);
 int sci_startup(struct uart_port *port);
 void sci_shutdown(struct uart_port *port);
 
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks);
+
 #define min_sr(_port)		ffs((_port)->sampling_rate_mask)
 #define max_sr(_port)		fls((_port)->sampling_rate_mask)
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 13a1c6671cc9..decc6ccff256 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2581,9 +2581,8 @@ static int sci_brg_calc(struct sci_port *s, unsigned int bps,
 }
 
 /* calculate sample rate, BRR, and clock select */
-static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
-		   unsigned int *brr, unsigned int *srr,
-		   unsigned int *cks)
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks)
 {
 	unsigned long freq = s->clk_rates[SCI_FCK];
 	unsigned int sr, br, prediv, scrate, c;
@@ -2647,6 +2646,7 @@ static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 		min_err, *brr, *srr + 1, *cks);
 	return min_err;
 }
+EXPORT_SYMBOL_NS_GPL(sci_scbrr_calc, SH_SCI);
 
 static void sci_reset(struct uart_port *port)
 {
-- 
2.43.0


