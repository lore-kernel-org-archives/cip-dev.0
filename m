From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:02:03 +0000
Subject: [cip-dev] [PATCH 07/15] serial: sh-sci: Add more Serial Port
	Control/Data Register documentation
In-Reply-To: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520247731-25239-8-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Improve documentation for the SCIFA/SCIFB Serial Port Control and Data
Registers:
  - State clearly that the RTS and CTS lines are active-low,
  - Document the bits related to the serial port's SCK, RXD, and TXD
    pins.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 4780c09f7a0926674c96c0a40dfeb7469f759c8e)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index fa560c0..1b699ea 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -104,12 +104,18 @@ enum {
 #define HSCIF_SRE	BIT(15)	/* Sampling Rate Register Enable */
 
 /* SCPCR (Serial Port Control Register), SCIFA/SCIFB only */
-#define SCPCR_RTSC	BIT(4)	/* Serial Port RTS Pin / Output Pin */
-#define SCPCR_CTSC	BIT(3)	/* Serial Port CTS Pin / Input Pin */
+#define SCPCR_RTSC	BIT(4)	/* Serial Port RTS# Pin / Output Pin */
+#define SCPCR_CTSC	BIT(3)	/* Serial Port CTS# Pin / Input Pin */
+#define SCPCR_SCKC	BIT(2)	/* Serial Port SCK Pin / Output Pin */
+#define SCPCR_RXDC	BIT(1)	/* Serial Port RXD Pin / Input Pin */
+#define SCPCR_TXDC	BIT(0)	/* Serial Port TXD Pin / Output Pin */
 
 /* SCPDR (Serial Port Data Register), SCIFA/SCIFB only */
-#define SCPDR_RTSD	BIT(4)	/* Serial Port RTS Output Pin Data */
-#define SCPDR_CTSD	BIT(3)	/* Serial Port CTS Input Pin Data */
+#define SCPDR_RTSD	BIT(4)	/* Serial Port RTS# Output Pin Data */
+#define SCPDR_CTSD	BIT(3)	/* Serial Port CTS# Input Pin Data */
+#define SCPDR_SCKD	BIT(2)	/* Serial Port SCK Output Pin Data */
+#define SCPDR_RXDD	BIT(1)	/* Serial Port RXD Input Pin Data */
+#define SCPDR_TXDD	BIT(0)	/* Serial Port TXD Output Pin Data */
 
 
 #define SCxSR_TEND(port)	(((port)->type == PORT_SCI) ? SCI_TEND   : SCIF_TEND)
-- 
2.7.4
