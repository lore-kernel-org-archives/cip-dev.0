Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36613FD709D
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:35 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73437.1773746254476299320
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iWg9RFHd;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48540355459so53954105e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746253; x=1774351053; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taPo/kpw/4OEs/O6/QOnzSeqjA9x9kj5MeUzRxWgzVk=;
        b=iWg9RFHd2dOrAxMm4bmKPvwuslzRwct8hZKirj0HO5UjnUhtPrTouZe4pepNx42IVw
         l3XaiWO2kzERj5uXzJQZgCpSo6mbqFFZYWt5biZoYz6uUHBQK0xd/n20R74SFBetf6To
         Vd0k/mwsC3W+dGn4FIFSKq/PoKFF3WDjXKYunvX7y7V0penBX597c7reRuA97zZsJXaC
         K23PJ0lXcKQOfiLLRWQYNNX5ggfvGhxyb3x6cRXLRJTDsvNloH6IY8E0k/Dz9OzsVifp
         E3JnqZEvYejzqsDMpEnTODxlB8BIptxkDhZ8Qpcv1tEa85c8eu26zmvaNh/ecLPUiINU
         A8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746253; x=1774351053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=taPo/kpw/4OEs/O6/QOnzSeqjA9x9kj5MeUzRxWgzVk=;
        b=T198/3O0INk/umFXZdXNTnuQf+sxNKVnxflxfXJ56F/h+hrXZFE3zJ3MZe1nWOxowg
         zs0u+g+h8cZW3lh7hCvNyh7zx6E4EwrJjLITkODZdyFXkE4Kvv5gqVAMoCrNT5NBJ5/0
         P8VstKUHLzIc0WP8/MxlJTUR6lN1V9StN4ROLCIHpJoASk0wX5xImVutpPcIPzD2SDV/
         8bmKQ4Ar6PM/o7NzIDMmLWYw4wk1F9C6Vv+xPnpqYtW2LafCyCCZaWCS1LU3dCvb0xM7
         jErNA14yqA8etP2K0cZRgD25XguwW2qnmQhnNYIKhtAD/M9pkb/xBqxzCxPPSuB2iaZh
         RNpA==
X-Gm-Message-State: AOJu0YxSJ+TFMBe8pqdve0mJPE6Av28uMOvaMUAWkodALIhUORZLmJtx
	8vMqV/FG4YJAuSzhU1Jvd7385PbkatS3utZlvZbzI4UkgsmeS19kRhDBhEbQmA==
X-Gm-Gg: ATEYQzxRPymxlZ09BRKu54DcglRRNkPPp/H3eRQYm/8TZRCezaSV+CrvSvYK6n7Ojok
	Rr6BHvyXxF3NmoLQdGuXgJmLlIop7VFTNtINnzaej0fwM52BGKFaDXM5w6rAaqYimDV/9DbNeKi
	pFn42OMEOoDke8pJDSQHr1+8g64t3X+pq8DnrXCiRG5blaHrG3AUf3bDuos0XI+owE1Cc0eWq73
	EhCSpL7bE7gKslf/pjQLuVDaD/ybvAHDBDzUZiUwzwhXxAxs2Y16OScGCqMJg1Zl7UxtrZLZoqz
	hqi9Gj7vSKHDhb8X4jaWQev0iS7dR5RGxp9/1uVeEatW7qczqbtzs8IqAXJ5440+Rsq71IcR4+J
	1zgUE2ozU/dFZ4SluJTNOKGWLaxbdA4reWg9W/k9kOwxkaXgsPDcsWhfYeaFjw6j8fcqnZuzRTe
	ad0nSBWsfBxkJX2TkKx1WG50kHs7e5eyfxEQ3ZcJol5XT1WhDO
X-Received: by 2002:a05:600c:1388:b0:485:3dfc:57d with SMTP id 5b1f17b1804b1-485567148d7mr286993605e9.30.1773746252383;
        Tue, 17 Mar 2026 04:17:32 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:31 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 16/39] tty: serial: sh-sci: fix RSCI FIFO overrun handling
Date: Tue, 17 Mar 2026 11:16:41 +0000
Message-ID: <20260317111718.281633-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22449

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

[ Upstream commit ef8fef45c74b5a0059488fda2df65fa133f7d7d0 ]

The receive error handling code is shared between RSCI and all other
SCIF port types, but the RSCI overrun_reg is specified as a memory
offset, while for other SCIF types it is an enum value used to index
into the sci_port_params->regs array, as mentioned above the
sci_serial_in() function.

For RSCI, the overrun_reg is CSR (0x48), causing the sci_getreg() call
inside the sci_handle_fifo_overrun() function to index outside the
bounds of the regs array, which currently has a size of 20, as specified
by SCI_NR_REGS.

Because of this, we end up accessing memory outside of RSCI's
rsci_port_params structure, which, when interpreted as a plat_sci_reg,
happens to have a non-zero size, causing the following WARN when
sci_serial_in() is called, as the accidental size does not match the
supported register sizes.

The existence of the overrun_reg needs to be checked because
SCIx_SH3_SCIF_REGTYPE has overrun_reg set to SCLSR, but SCLSR is not
present in the regs array.

Avoid calling sci_getreg() for port types which don't use standard
register handling.

Use the ops->read_reg() and ops->write_reg() functions to properly read
and write registers for RSCI, and change the type of the status variable
to accommodate the 32-bit CSR register.

sci_getreg() and sci_serial_in() are also called with overrun_reg in the
sci_mpxed_interrupt() interrupt handler, but that code path is not used
for RSCI, as it does not have a muxed interrupt.

------------[ cut here ]------------
Invalid register access
WARNING: CPU: 0 PID: 0 at drivers/tty/serial/sh-sci.c:522 sci_serial_in+0x38/0xac
Modules linked in: renesas_usbhs at24 rzt2h_adc industrialio_adc sha256 cfg80211 bluetooth ecdh_generic ecc rfkill fuse drm backlight ipv6
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc1+ #30 PREEMPT
Hardware name: Renesas RZ/T2H EVK Board based on r9a09g077m44 (DT)
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : sci_serial_in+0x38/0xac
lr : sci_serial_in+0x38/0xac
sp : ffff800080003e80
x29: ffff800080003e80 x28: ffff800082195b80 x27: 000000000000000d
x26: ffff8000821956d0 x25: 0000000000000000 x24: ffff800082195b80
x23: ffff000180e0d800 x22: 0000000000000010 x21: 0000000000000000
x20: 0000000000000010 x19: ffff000180e72000 x18: 000000000000000a
x17: ffff8002bcee7000 x16: ffff800080000000 x15: 0720072007200720
x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
x11: 0000000000000058 x10: 0000000000000018 x9 : ffff8000821a6a48
x8 : 0000000000057fa8 x7 : 0000000000000406 x6 : ffff8000821fea48
x5 : ffff00033ef88408 x4 : ffff8002bcee7000 x3 : ffff800082195b80
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff800082195b80
Call trace:
 sci_serial_in+0x38/0xac (P)
 sci_handle_fifo_overrun.isra.0+0x70/0x134
 sci_er_interrupt+0x50/0x39c
 __handle_irq_event_percpu+0x48/0x140
 handle_irq_event+0x44/0xb0
 handle_fasteoi_irq+0xf4/0x1a0
 handle_irq_desc+0x34/0x58
 generic_handle_domain_irq+0x1c/0x28
 gic_handle_irq+0x4c/0x140
 call_on_irq_stack+0x30/0x48
 do_interrupt_handler+0x80/0x84
 el1_interrupt+0x34/0x68
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x6c/0x70
 default_idle_call+0x28/0x58 (P)
 do_idle+0x1f8/0x250
 cpu_startup_entry+0x34/0x3c
 rest_init+0xd8/0xe0
 console_on_rootfs+0x0/0x6c
 __primary_switched+0x88/0x90
---[ end trace 0000000000000000 ]---

Cc: stable <stable@kernel.org>
Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20250923154707.1089900-1-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index db1950a7a750..69425071d1f2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1016,16 +1016,18 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	struct sci_port *s = to_sci_port(port);
 	const struct plat_sci_reg *reg;
 	int copied = 0;
-	u16 status;
+	u32 status;
 
-	reg = sci_getreg(port, s->params->overrun_reg);
-	if (!reg->size)
-		return 0;
+	if (s->type != SCI_PORT_RSCI) {
+		reg = sci_getreg(port, s->params->overrun_reg);
+		if (!reg->size)
+			return 0;
+	}
 
-	status = sci_serial_in(port, s->params->overrun_reg);
+	status = s->ops->read_reg(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
 		status &= ~s->params->overrun_mask;
-		sci_serial_out(port, s->params->overrun_reg, status);
+		s->ops->write_reg(port, s->params->overrun_reg, status);
 
 		port->icount.overrun++;
 
-- 
2.43.0


