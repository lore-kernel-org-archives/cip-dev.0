From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:02:07 +0000
Subject: [cip-dev] [PATCH 11/15] serial: sh-sci: Add DT support for
	dedicated RTS/CTS
In-Reply-To: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520247731-25239-12-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add support for indicating the availability of dedicated lines for
RTS/CTS hardware flow control, using the standard "uart-has-rtscts" DT
property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 861a70abb483645d4474a6bc006471c2db59a78d)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4e53fa4..b09db16 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2728,6 +2728,9 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 	p->regtype = info->regtype;
 	p->scscr = SCSCR_RE | SCSCR_TE;
 
+	if (of_find_property(np, "uart-has-rtscts", NULL))
+		p->capabilities |= SCIx_HAVE_RTSCTS;
+
 	return p;
 }
 
-- 
2.7.4
