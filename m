Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11256F3383D
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:46 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73599.1773746265018075930
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GCRALM0N;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so59233975e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746263; x=1774351063; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZCY6lDtwPTB8TNI7FyU9aF+Cv/PSZ8t/2VT/pZSHCM=;
        b=GCRALM0NO4dXU5fi42YFHgme9C9BKZReQVUj+krBmeDh6/NjSgjllPtGeb5qJPeoZG
         W9sV98d793CUd/BnUS4xy+WrzqlIAzdIjbW/bULmfzQ8kfA9hYQK/EqyDF+8j3ChaReT
         Ouat2DS7sMKfVP03duLf/zHv+cFy76XWEoxYFK1ZERWE+jgqeA5s5DJ7ZbB2SR8byb6L
         tsVKfBDBvB3AOaKtcpAmgjEigdwzhrobLGrymSZZiWwmAKTkq92O2nAS9SMy7BsqxmIc
         UQaXLh0qafkzplAMQktsr5DQ+pZrYsxJT8lJ5qOaBrGK8bQmHKa6NMHU+FtEoT49+pU/
         dPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746263; x=1774351063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kZCY6lDtwPTB8TNI7FyU9aF+Cv/PSZ8t/2VT/pZSHCM=;
        b=g5EqF3jUvBJjRBLgB963U19Sb9F0pEARFU3TT/E3npUFXSzDb8xpz+JQIK6n8opix1
         rq+nVZMnMRPzpDMjzY9IUkfg+dB/jK/E/K8LJVF3VkF8SUWcis1OuFCVE55YRxIkVLpq
         6N4k8MsLU8KoPCGo4QdKx0DYi2FqmjuSt+GwPOrTd/mz/wty2Zp2NONliKmtJAJR2Xzc
         2CJUXfZJMRtBfBvgfL3T81we+D4Qd0NYL38LMOzSjmeZ7BVhuc9zk9aFBkOviM3nz7H6
         dc8VtnUCeQpoqd2hJa+j6+h5/hVbH0Gh4jR19rRZoWQXFuCnxF9J/34AW6mcMN1gFNHG
         zD+g==
X-Gm-Message-State: AOJu0YxJfIdIHwPMQB8COlfkJBxqG/Qp1qOpBKlcufj/OhYcnipoFCB2
	TMjW4eu6ByFfHDWYRI4uUUn99HuBAi5YSOHJZ0XhvhUj61tasJuaJL4nb4/kpQ==
X-Gm-Gg: ATEYQzzwqSNTzuaOhznHSAiEbtV3rNJ1j4gAGYDY8r/Pweyr4z5lfrHzqZZWt4DR8wP
	xYBaUKNZg1sJsrCe0pfOWtFHX5kbwIwsyoNfEPY8DFwRIdi5Xdk+rG0oV9nZpFqgDhQIV0Oa3ON
	yqNJf91QdAw/JghTRtmu3oeomkgNdonhBckEarqK1PAu+PP4iroHEExDObbHagxEBF5gJsysWPh
	p/wMZ49bJ36Psq8u53xvDcml6BtwcOj7aIX6ZRIxK8YsF46cpBLhcottjXSykd4ABOOLr9FN0A+
	uKjm+3bnplOC8Ts8ctZpH1NFhSx07408f6rwhDjv6C7TmFxf/CtYlH0T2yqFBHGIiDjrM70CkEt
	p8bW8U17eQhzALlUhy5dnW7+giruBbqWu9s/+Nrq3sH0o5yhei3rrZz3OfK3xI6CESgAwl4Ex+l
	Ju+nCjRckgrHI3JSZE8dgDfgCGkQ8pH7WAWsbKF18qtIrwfPxh
X-Received: by 2002:a05:600c:3b14:b0:485:4526:ee06 with SMTP id 5b1f17b1804b1-485566d70efmr289262865e9.11.1773746262954;
        Tue, 17 Mar 2026 04:17:42 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:42 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 29/39] serial: sh-sci: Add sci_is_rsci_type()
Date: Tue, 17 Mar 2026 11:16:54 +0000
Message-ID: <20260317111718.281633-30-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22461

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
index ec7b487ec44e..a85e9aaf792f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1184,6 +1184,11 @@ static int sci_handle_errors(struct uart_port *port)
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
@@ -1192,7 +1197,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	int copied = 0;
 	u32 status;
 
-	if (s->type != SCI_PORT_RSCI) {
+	if (!sci_is_rsci_type(s->type)) {
 		reg = sci_getreg(port, s->params->overrun_reg);
 		if (!reg->size)
 			return 0;
@@ -1200,7 +1205,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 
 	status = s->ops->read_reg(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
-		if (s->type == SCI_PORT_RSCI) {
+		if (sci_is_rsci_type(s->type)) {
 			/*
 			 * All of the CFCLR_*C clearing bits match the corresponding
 			 * CSR_*status bits. So, reuse the overrun mask for clearing.
@@ -2023,7 +2028,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 	unsigned long flags;
 	u32 ctrl;
 
-	if (s->type != PORT_SCI && s->type != SCI_PORT_RSCI)
+	if (s->type != PORT_SCI && !sci_is_rsci_type(s->type))
 		return sci_tx_interrupt(irq, ptr);
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -3297,7 +3302,7 @@ static int sci_init_single(struct platform_device *dev,
 	 * The fourth interrupt on SCI and RSCI port is transmit end interrupt, so
 	 * shuffle the interrupts.
 	 */
-	if (p->type == PORT_SCI || p->type == SCI_PORT_RSCI)
+	if (p->type == PORT_SCI || sci_is_rsci_type(p->type))
 		swap(sci_port->irqs[SCIx_BRI_IRQ], sci_port->irqs[SCIx_TEI_IRQ]);
 
 	/* The SCI generates several interrupts. They can be muxed together or
-- 
2.43.0


