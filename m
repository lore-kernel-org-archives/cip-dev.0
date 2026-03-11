Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528A5104BED3
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:17 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17656.1773223512224097320
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=j83Iygoj;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b7a87fb5so6891429f8f.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223510; x=1773828310; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9sD3MKT9Y7H7XLFXHc1yfnHGesfkmdvXHS5Qb+Mtf4=;
        b=j83IygojOMlFQosncByWBGSUgq28/mg/wy+LY6gOTcxEbLKzIjhYieI7gQv1+DBgaq
         3HCh9anVhdxxxzRPPWlSU8AA66+METpXjgtVhfEbC36TM3APt2ebXC7G/A8385ypZFH6
         43eO9rCi981ssmTxP6/xZ7GopnfzK0n2Sc8EGbGXVGUFMGvSpNZ8N6bFuWIoOGpYueWt
         b+TrXIqvCa6bUO1B1l194PJjDnSvG1P8rv9QaSMmYgvevrEs4aibLPV1epi4r6iSB+18
         t2Id1CG929AYWKMJ3QRSYi5t9SxoH9wfKcZnWYRg6DnjCi0o/0ICxApWo5YBxQTSVbDB
         07SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223510; x=1773828310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9sD3MKT9Y7H7XLFXHc1yfnHGesfkmdvXHS5Qb+Mtf4=;
        b=Pm/TDAmxt1stGX1RsVHXBU8zt2e0Es4zeVZnvFcswn7d4zpJLdLHxk7HusCG7bjj/d
         UtnTZom104xGRcJKrwMoezyUOl2wJtUHvGfp8U9dBbkmLZClLaPI8TycMnTlK/JhdBJp
         lnYEtemYdEGbSt2F7kTGVGOrjp5Oa3RS+HuboZUicdZGS20bazOl3cGwpQkgCF/Jdc/O
         jf6Um+HbANEtyzKCddYRs3IRWIeBTMqL25XurfIQWg3B79Bo2CGl6fUmT2Pt0BkBJXAD
         5aVwQZoFCa/tZ0fyjsDvXQfGsqkiLp2IxNVuTS1Frzc6MB+NkEhzcx+ia+dTu855nP3x
         Ewcg==
X-Gm-Message-State: AOJu0YzuNN/UF8QGoQBuaAsFWzJfRm6qPNFSts8aEjUSrGouxO2JsCQD
	x35hX9XpOZz0tEsuUM9n9I7EptbLV5UcBnAiCz9K1MZzhnzodqVvIUBbJ1vayA==
X-Gm-Gg: ATEYQzxdKcccYjYnN0gAzCr46QQaQ3IIluIlOVoRhhLyyBnCUNyCGserh+pCPsB08hb
	ufQ358JHaRcPBeSXAEbahCWJ0WlUwyVjwi0ZvR8blXvwrOHFrWiEBjRk/2DzGQNeSjH8lNpxdII
	5BzxqHv7w5wn21aZIrfxsiaA8t769GL8xvpamjuVytSSYpTZobya4ID6dr3QCdfOWXH8l1zDUmr
	SQP5PIQHgc7VzadOQwELmySGJADM0NO+egLE02CNkXV67D46O/xufLPTKbyLiBwqMIU8VI/qJom
	qsdaYecc6zks8zStMBfkOEyozrOTsHJDIU4xVHojhiPjysmgWv0vaNFUcwJTr8YF8x/uqAPKniU
	bssEvbA094UR8HhOctqk5iSU8QFcgasIeUBllJXlxedQu89LDTGN5pL88KJ4IlMjrwtPTCYfotp
	hHJudJnuDaJU5d5yC7lUkZlfuVBH8Xi7I=
X-Received: by 2002:a05:6000:290f:b0:439:be3e:52fe with SMTP id ffacd0b85a97d-439f8209ab1mr3843663f8f.26.1773223510237;
        Wed, 11 Mar 2026 03:05:10 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:09 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 17/27] serial: sh-sci: Add sci_is_rsci_type()
Date: Wed, 11 Mar 2026 10:04:36 +0000
Message-ID: <20260311100458.162447-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22263

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


