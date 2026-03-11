Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69EA104BEDD
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:17 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17658.1773223515095390508
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mqVQY80d;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4327790c4e9so10904837f8f.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223513; x=1773828313; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCcL1pudzdrE+W73uff5IKcpUv6dzBTQDOLJqd9RxI4=;
        b=mqVQY80dqh7nts3c9z/p9eV+exveEeQhemFFP6X/Ue648iNG2FvaFL6bkrLGHbuP6k
         IGc4qjkfzQR+TSxgUophcf4PpRbb3gyIFUnoE0d5T2HMEoBOJ0LsVbsSxsdy6nxVmSnU
         ff95zYWDZe9BWhghT16NyoeNz6lvhpQ0axgs38i9DKr78jBjlNisLD/6wk3q5dLlTrgA
         VMWeZaE4/kgncNWoxTlDOOCdIAF5ZAW030on136ToPb0bfFWBMk1BPBT+uyXnNgXdRBd
         gq52hVHnXqc06WIM8segsF2e+4yusqRFLIhc+JcpghTkqLcq4Fhm6P7E50N8uR5L98rq
         0cSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223513; x=1773828313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wCcL1pudzdrE+W73uff5IKcpUv6dzBTQDOLJqd9RxI4=;
        b=bnrTWLFt78sxS+rcgLfb+PuX4ani4eSHr/vHHcLZq3peP2tGMDauIOejCPFyUNK5gR
         OVR96wI3kGLuKDyobeZMCRNHcyiTzz0ifLrNdrqCue7Rncr/xIlaPDe0huHWU7/LoDOx
         q6eDbAHukBwFmx3Gyq3LhKA2XKwAJ+yFORBBHWs1pUiiJHLr96dt8IVPlf9dLiaQLPi6
         Hee7neABI5VlF3gIYlokdHhmYVtm+CS0Ojguftlv3SLuhGZfQW7zun4dtfoSmu2z4ZPQ
         3IL3btqHhJTEXFsgpmVVviA1GPwOmlv59gWAzOAornbTH49lLoN+dR89PEHxmhQnbrQR
         DcpA==
X-Gm-Message-State: AOJu0YyTI7WR3NYHm6mVuIf8l0YAdFzUqmd4c/or3TzXaEZ4jDvmKxL/
	Ck0uq5htQB0Cs50PdjIjKqSN7mEMbJzBrTHMExWITSpd6zfJxmwPyPflY88x3g==
X-Gm-Gg: ATEYQzzMXuqqYYZqIzC8oll9o35gBDjcwPqirsRYY/4P7bCAU7tNrOEAet+wBW+E4pl
	HTxUqIH1l8Cgqvy5oI5ebt3GuEgRqXKwiU4QxXrk37LegO3hmSMOGPn8xz6FsKJpzifd5oPSJ6B
	vTfekQGJ+2ULTSqrgAUZB9iY2Zs3b3usZzGG7Bchkrlo55H/D9epJ4stmyQwOTSgDKs3pPhtNmL
	tz9ioY95BVELlTpWoL56o+HdoImF+VhDCNVnmbuW0H/aNw2u5jDBLVWTD87+bSN5Le5VMN8elgA
	Q/xHIefTw7zoTCHIJpDZg+PwpDbE/Z+udXPzYz5t3NJwU1pkWs3Uf39e0bDACmOHVzS1Gru5CW/
	Q5C7c8pwRzhTDsw1YFNB8X93a9d5NdZ1e4ouUaM0AzwiJ+y+6WVedHfFnO+Y21weBau8/u5z8bF
	oSp7BFdOVwTHKk5pTEGacqIjDmUXIHSo4=
X-Received: by 2002:a5d:5848:0:b0:439:b1be:819f with SMTP id ffacd0b85a97d-439f81df05dmr4291282f8f.2.1773223512767;
        Wed, 11 Mar 2026 03:05:12 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:12 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 21/27] serial: sh-sci: Make sci_scbrr_calc() public
Date: Wed, 11 Mar 2026 10:04:40 +0000
Message-ID: <20260311100458.162447-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22267

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
index 6e9cd8044b89..781fc371a62c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2574,9 +2574,8 @@ static int sci_brg_calc(struct sci_port *s, unsigned int bps,
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
@@ -2640,6 +2639,7 @@ static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 		min_err, *brr, *srr + 1, *cks);
 	return min_err;
 }
+EXPORT_SYMBOL_NS_GPL(sci_scbrr_calc, SH_SCI);
 
 static void sci_reset(struct uart_port *port)
 {
-- 
2.43.0


