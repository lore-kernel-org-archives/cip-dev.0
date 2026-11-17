Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16035.1794916169077848179
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:49:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8064762472;
	Tue, 17 Nov 2026 11:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3E91F000C4;
	Tue, 17 Nov 2026 11:49:27 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 03/34] i3c: renesas: Check that the transfer is valid before accessing it
Date: Tue, 17 Nov 2026 13:48:49 +0200
Message-ID: <20261117114921.1485204-4-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:49:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24914
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 5f1a76ecfe90544a28d657306c9b3caa66ba0e63 upstream.

The Renesas I3C driver uses an asynchronous model to transfer data. It
prepares a struct renesas_i3c_xfer, enqueues it, and waits for completion=
.
The interrupt handler dequeues the transfer, updates/uses it, and signals
the waiting thread.

If the completion times out, the waiting thread dequeues the transfer and
free it. If an interrupt fires after that, the handler may access freed
memory, leading to crashes.

Check that the transfer is still valid before accessing it in the
interrupt handler. With it clear any status flags and disable all
the interrupts to avoid triggering the same interrupts again.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C c=
ontroller")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260713130545.568657-2-claudiu.beznea+ren=
esas@tuxon.dev
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 52 +++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index 9c438b162250..ffe3f0d9d5ce 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -434,6 +434,21 @@ static void renesas_i3c_enqueue_xfer(struct renesas_=
i3c *i3c, struct renesas_i3c
 	}
 }
=20
+static void renesas_i3c_irqs_mask_and_clear_locked(struct renesas_i3c *i=
3c)
+{
+	/* Disable all the interrupts. */
+	renesas_writel(i3c->regs, BIE, 0);
+	renesas_writel(i3c->regs, NTIE, 0);
+
+	/* Clear normal transfer status flags. */
+	renesas_writel(i3c->regs, NTST, 0);
+
+	/* Clear bus status flags. */
+	renesas_writel(i3c->regs, BST, 0);
+	/* Read back registers to confirm writes have fully propagated. */
+	renesas_readl(i3c->regs, BST);
+}
+
 static void renesas_i3c_wait_xfer(struct renesas_i3c *i3c, struct renesa=
s_i3c_xfer *xfer)
 {
 	unsigned long time_left;
@@ -1015,6 +1030,11 @@ static irqreturn_t renesas_i3c_tx_isr(int irq, voi=
d *data)
=20
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer =3D i3c->xferqueue.cur;
+		if (!xfer) {
+			renesas_i3c_irqs_mask_and_clear_locked(i3c);
+			return IRQ_HANDLED;
+		}
+
 		cmd =3D xfer->cmds;
=20
 		if (xfer->is_i2c_xfer) {
@@ -1055,6 +1075,11 @@ static irqreturn_t renesas_i3c_resp_isr(int irq, v=
oid *data)
=20
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer =3D i3c->xferqueue.cur;
+		if (!xfer) {
+			renesas_i3c_irqs_mask_and_clear_locked(i3c);
+			return IRQ_HANDLED;
+		}
+
 		cmd =3D xfer->cmds;
=20
 		/* Clear the Respone Queue Full status flag*/
@@ -1139,6 +1164,11 @@ static irqreturn_t renesas_i3c_tend_isr(int irq, v=
oid *data)
=20
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer =3D i3c->xferqueue.cur;
+		if (!xfer) {
+			renesas_i3c_irqs_mask_and_clear_locked(i3c);
+			return IRQ_HANDLED;
+		}
+
 		cmd =3D xfer->cmds;
=20
 		if (xfer->is_i2c_xfer) {
@@ -1185,6 +1215,11 @@ static irqreturn_t renesas_i3c_rx_isr(int irq, voi=
d *data)
=20
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer =3D i3c->xferqueue.cur;
+		if (!xfer) {
+			renesas_i3c_irqs_mask_and_clear_locked(i3c);
+			return IRQ_HANDLED;
+		}
+
 		cmd =3D xfer->cmds;
=20
 		if (xfer->is_i2c_xfer) {
@@ -1235,15 +1270,13 @@ static irqreturn_t renesas_i3c_stop_isr(int irq, =
void *data)
 	struct renesas_i3c_xfer *xfer;
=20
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
-		xfer =3D i3c->xferqueue.cur;
-
-		/* read back registers to confirm writes have fully propagated */
-		renesas_writel(i3c->regs, BST, 0);
-		renesas_readl(i3c->regs, BST);
-		renesas_writel(i3c->regs, BIE, 0);
-		renesas_clear_bit(i3c->regs, NTST, NTST_TDBEF0 | NTST_RDBFF0);
+		renesas_i3c_irqs_mask_and_clear_locked(i3c);
 		renesas_clear_bit(i3c->regs, SCSTRCTL, SCSTRCTL_RWE);
=20
+		xfer =3D i3c->xferqueue.cur;
+		if (!xfer)
+			return IRQ_HANDLED;
+
 		xfer->ret =3D 0;
 		complete(&xfer->comp);
 	}
@@ -1260,6 +1293,11 @@ static irqreturn_t renesas_i3c_start_isr(int irq, =
void *data)
=20
 	scoped_guard(spinlock, &i3c->xferqueue.lock) {
 		xfer =3D i3c->xferqueue.cur;
+		if (!xfer) {
+			renesas_i3c_irqs_mask_and_clear_locked(i3c);
+			return IRQ_HANDLED;
+		}
+
 		cmd =3D xfer->cmds;
=20
 		if (xfer->is_i2c_xfer) {
--=20
2.43.0

