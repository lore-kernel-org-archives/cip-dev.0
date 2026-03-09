Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E1FF417E5
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:08 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15651.1773066362902345558
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TIrKSJAS;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-485409ab264so3074185e9.1
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066361; x=1773671161; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9sD3MKT9Y7H7XLFXHc1yfnHGesfkmdvXHS5Qb+Mtf4=;
        b=TIrKSJASzJCvVT0+86umB18lS9jGOayDiV71bVtLT/E2EsU9sAaAgqifXi9+zgZe4q
         8DZJzYz8NKSB/4dVKJtDhPOWYXEply4jr645Ks3st3r/LX0iVSTyOZd9rI+kj3r1zZ+W
         AWMuWflQUxGvc0gOX1awwBM7TuAstEcyMnpPr/jJmW8N3a3STawSLMoY2wlwkrtpaeA+
         BuSTU7XQjDagbdn+DnO+xXc8FioAe+bbcsRhx+Jk5i7Pw/eiVhZ+JkqbLlOQowg5e3TA
         NvXsieQdbtGz4Cn6NPPHtrzeX1quBIU95ta/7jkreLe+iWvzCWF7jg1Vwhd9SK9cMS6N
         Yn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066361; x=1773671161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9sD3MKT9Y7H7XLFXHc1yfnHGesfkmdvXHS5Qb+Mtf4=;
        b=KNEHVIs7Ly+w7twKD1voFgGVf72QXo/Q9GGLIIYfKr6/9qAFx6H1cGKGU1TjCSU1SX
         J0t3gqaWsV/HoayTpIgbYlu6EMM9jXXKJNNKuFdsODaPIT5x6FXIP/6GZF35QCZdmJj3
         Egiz4gczy277Jc0FmkJnMuv4i/tm5QpVVDAaELYMp6f2CIr6a8/lEgw8VEouA30jZ5vL
         5HjDm7DYASIS4ClHg7FhKlFOJVeHJzKjN8pEYv6DfKh2b8yNyV2CDXYJGO1iPPTlxISL
         3VlqlMXECo6BDwEf4On+g6E6k2npa5/yvyTCzJ0cwPoZjgQFD2hstCJhIibW8+PISKND
         4I6g==
X-Gm-Message-State: AOJu0YwNR6fpZ3H37Bcngvq5QdR9+pqKBygn+a6ldiwJSlJWK7mjceud
	Q1RUVNgMMrN+7enVIDqSMQ3g6mmFIGsppnISYuGc+0CFD3h8k36w4pes4zOgrQ==
X-Gm-Gg: ATEYQzyN7OUhI33akBzrz88k6+GR8sAI+BWPW9NpGMcDo428pQyrCAUJJBNlgN25yJS
	ENsCiTBQoqnwm4jMssoTb4E2Xn1jmAmJnG4VgifwKOAWr0gBtOaDQrv63qPBfaYMUykr0/FqxKo
	sZWHQ2GiZDbjFsoETXOqvhnUBOTKrLukIW2EydBJ9xR4NK1aJTWHuKHiebAWWGMuNCMpB2zfmpK
	Uk9VjXGH7KUzB1vH6eq4uaNzhMO0vREGoER/E2Vd2fHkrllmeilxTS+yoHGP0+l6aMdEBSBiRjX
	fQXDjD1LB1bmYDPMU2+cGZLhJJvxJgqKsBZUGcq5GQs9inuwrtFfzIqOgQfAMEYNLCi9doQShkB
	y88ffDHfGxudCwzNIB11VnFGVLgcjAat6lF+c8q13oYsPpLP+fmitmLhhJEMfs0SxVdNuk/1TxF
	pyvx9DGmzhKYA0Rp8K6cMzdt+31F/ZB0n9cjTCSLfhiA==
X-Received: by 2002:a05:600c:58d0:b0:485:3ddb:8180 with SMTP id 5b1f17b1804b1-4853ddbab95mr23891165e9.11.1773066360868;
        Mon, 09 Mar 2026 07:26:00 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:26:00 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 17/29] serial: sh-sci: Add sci_is_rsci_type()
Date: Mon,  9 Mar 2026 14:25:17 +0000
Message-ID: <20260309142549.987737-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22185

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 7d8b226bf95cd2b49f15da4f4d40e05932c0d4cc ]

Add sci_is_rsci_type() for RSCI port type. This will simplify the code
when the support added for RSCI_PORT_SCIF32 private PORT type.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-11-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index cc6765463003..0be3d5c45388 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1182,6 +1182,11 @@ static int sci_handle_errors(struct uart_port *port)
 	return copied;
 }
 
+static bool sci_is_rsci_type(u8 type)
+{
+	return (type == SCI_PORT_RSCI);
+}
+
 static int sci_handle_fifo_overrun(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
@@ -1190,7 +1195,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	int copied = 0;
 	u32 status;
 
-	if (s->type != SCI_PORT_RSCI) {
+	if (!sci_is_rsci_type(s->type)) {
 		reg = sci_getreg(port, s->params->overrun_reg);
 		if (!reg->size)
 			return 0;
@@ -1198,7 +1203,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 
 	status = s->ops->read_reg(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
-		if (s->type == SCI_PORT_RSCI) {
+		if (sci_is_rsci_type(s->type)) {
 			/*
 			 * All of the CFCLR_*C clearing bits match the corresponding
 			 * CSR_*status bits. So, reuse the overrun mask for clearing.
@@ -2016,7 +2021,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 	unsigned long flags;
 	u32 ctrl;
 
-	if (s->type != PORT_SCI && s->type != SCI_PORT_RSCI)
+	if (s->type != PORT_SCI && !sci_is_rsci_type(s->type))
 		return sci_tx_interrupt(irq, ptr);
 
 	uart_port_lock_irqsave(port, &flags);
@@ -3290,7 +3295,7 @@ static int sci_init_single(struct platform_device *dev,
 	 * The fourth interrupt on SCI and RSCI port is transmit end interrupt, so
 	 * shuffle the interrupts.
 	 */
-	if (p->type == PORT_SCI || p->type == SCI_PORT_RSCI)
+	if (p->type == PORT_SCI || sci_is_rsci_type(p->type))
 		swap(sci_port->irqs[SCIx_BRI_IRQ], sci_port->irqs[SCIx_TEI_IRQ]);
 
 	/* The SCI generates several interrupts. They can be muxed together or
-- 
2.43.0


