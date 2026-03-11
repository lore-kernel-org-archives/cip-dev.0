Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EC8104BFFF
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:17 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17653.1773223508912017065
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=a++vRqGc;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b9b1900bso7500066f8f.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223507; x=1773828307; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r10tF+XTPVxbSD1F73y5amsr5PMa6uXEY/oAsK61DpA=;
        b=a++vRqGcU3L5BzqtKxt8iZa7pIAqz7/Ix6klYUWK0sA58pFguz9uKTKI2iMoVZOaVo
         Vv6M3LD7hrrxgiju8uLc3QN8febGhbJ30Uv7m98a9R6yRUj0/uAQZQDQNLSxwQwmvKPN
         jBQ4Jpr98bpjEBWurNPjdEZTRgTkhgDyaT8wqcd85T1/Vjo4yMvk9Wa2mmoiHNWN431j
         CvaAn0vdQ1XfgSIBMWVydQeLnzWVxcOsL9IKFD2KOxFbfdqELwd8ROb0vp7OUG6lj16f
         O8D5z9O8m94z7sM63+TeTKeN8FP0AhkVuEScOf8tdIFHCYeNXT/rXp+K7dqP2iUiiqds
         VbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223507; x=1773828307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r10tF+XTPVxbSD1F73y5amsr5PMa6uXEY/oAsK61DpA=;
        b=W5sPZBRao/OhVOBvg6OZvUrfyursgOqKFrNYum5yc1TSGu3Jgzn7jtRp669cIT+Ox3
         qPaUdd6MurzdGGBFM2TxpIwZ9jvQMMbgO060TFANP6DatyETzb51AbXOdHLsaEEuj0QA
         83CQVI9Suk88tB6jTrjUFLuUPGMUiEhRIFkKe6hHO5IpAiy9CkZKq3OucsCrTRSG/JiQ
         JpDn6nM2mlvYxOwMCCfT/dNqcTIFeM2AXz0x1kzx4qpmr98mq2jxupI7jet+7sl5MTYu
         RTOvXZMaYTXBjAIagnW4L3TkLmpGkhXvWOLuzfltzrIRkR3qRfI09csK6pfXgh+F9S4o
         EoFw==
X-Gm-Message-State: AOJu0Yxhe8Ypg4RsQKLI9m5CQnJo/VJiNhqAJW9yoNexyVkH44L/qiPH
	GKkt6hk0CXKCgEgWBZ0eC8mKlflU2rsaCoS1djHJaR87T4MKheOTtnWdG6GOAQ==
X-Gm-Gg: ATEYQzwnnwNIbgJz4+hfhwfO4bs6sqmFO5wYfQidK6A0m1jnrKOPtZ9GX1UN4JcOY+U
	m5Jz6TagO7+7Iz/I/zCqn3GSFNxNh4DgVz9kjsGJrrCJb4gLw4365yQvX5AWBh91y8b+S6KjkmY
	Xf/C3qQY1HXGxS00RJ362TKqvO3uPeYh9ZQbX/PXhJpy+SfQpvOGpp9eDh0uEia+7FITAqUz4YP
	dXl0WB+G0HAJ690iDjIRCSZAA8ckHCwkxWK8DuyEhl4ZN9FQhPLGrpx8rHQDfrRZn8uUao4cE6E
	F72Z6S2MPUTtsYN0Qm7HHvddz2oLsvktX7a3ba9iCKrueW9d7bIiQ+cQNgY44b6zmvFrKZv2gRJ
	3iRgbLZjACCAVDabSBvSw8RxcaZ1PtwAwJLdykeKsYYAUV5XlnfznKzZXl36IwNnFWDqLfbESWm
	DrndctwoYHapY0jsQGHHTa33insC0jwbQ=
X-Received: by 2002:a05:6000:2082:b0:439:ad90:389e with SMTP id ffacd0b85a97d-439f821b643mr3578401f8f.36.1773223506951;
        Wed, 11 Mar 2026 03:05:06 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:06 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 12/27] serial: rsci: Drop rsci_clear_SCxSR()
Date: Wed, 11 Mar 2026 10:04:31 +0000
Message-ID: <20260311100458.162447-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22258

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 450bd399c8797d2783c73aa6c83f382ac8d5f630 ]

Drop rsci_clear_SCxSR by reusing rsci_clear_CFC() as the contents of
both functions are the same.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-6-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 63b37c7e461c..ca593665b551 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -137,10 +137,6 @@ static void rsci_clear_DRxC(struct uart_port *port)
 	rsci_serial_out(port, FFCLR, FFCLR_DRC);
 }
 
-static void rsci_clear_SCxSR(struct uart_port *port, unsigned int mask)
-{
-	rsci_serial_out(port, CFCLR, mask);
-}
 
 static void rsci_start_rx(struct uart_port *port)
 {
@@ -390,7 +386,7 @@ static void rsci_poll_put_char(struct uart_port *port, unsigned char c)
 	}
 	rsci_serial_out(port, TDR, c);
 done:
-	rsci_clear_SCxSR(port, CFCLR_TDREC);
+	rsci_clear_CFC(port, CFCLR_TDREC);
 }
 
 static void rsci_prepare_console_write(struct uart_port *port, u32 ctrl)
@@ -463,7 +459,7 @@ static const struct uart_ops rsci_uart_ops = {
 static const struct sci_port_ops rsci_port_ops = {
 	.read_reg		= rsci_serial_in,
 	.write_reg		= rsci_serial_out,
-	.clear_SCxSR		= rsci_clear_SCxSR,
+	.clear_SCxSR		= rsci_clear_CFC,
 	.transmit_chars		= rsci_transmit_chars,
 	.receive_chars		= rsci_receive_chars,
 	.poll_put_char		= rsci_poll_put_char,
-- 
2.43.0


