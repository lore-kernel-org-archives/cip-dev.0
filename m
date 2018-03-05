From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:02:02 +0000
Subject: [cip-dev] [PATCH 06/15] serial: sh-sci: Add more Serial Port
	Register documentation
In-Reply-To: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520247731-25239-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Improve documentation for the (H)SCIF Serial Port Register:
  - Make it clear the RTS and CTS lines are active-low,
  - Document the bits related to the serial port's clock pin.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit ef5e90e8ccb7b715c0a1509339f730b2bf9698a2)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index bf69bbd..fa560c0 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -91,10 +91,12 @@ enum {
 #define SCLSR_ORER	BIT(0)	/* Overrun Error */
 
 /* SCSPTR (Serial Port Register), optional */
-#define SCSPTR_RTSIO	BIT(7)	/* Serial Port RTS Pin Input/Output */
-#define SCSPTR_RTSDT	BIT(6)	/* Serial Port RTS Pin Data */
-#define SCSPTR_CTSIO	BIT(5)	/* Serial Port CTS Pin Input/Output */
-#define SCSPTR_CTSDT	BIT(4)	/* Serial Port CTS Pin Data */
+#define SCSPTR_RTSIO	BIT(7)	/* Serial Port RTS# Pin Input/Output */
+#define SCSPTR_RTSDT	BIT(6)	/* Serial Port RTS# Pin Data */
+#define SCSPTR_CTSIO	BIT(5)	/* Serial Port CTS# Pin Input/Output */
+#define SCSPTR_CTSDT	BIT(4)	/* Serial Port CTS# Pin Data */
+#define SCSPTR_SCKIO	BIT(3)	/* Serial Port Clock Pin Input/Output */
+#define SCSPTR_SCKDT	BIT(2)	/* Serial Port Clock Pin Data */
 #define SCSPTR_SPB2IO	BIT(1)	/* Serial Port Break Input/Output */
 #define SCSPTR_SPB2DT	BIT(0)	/* Serial Port Break Data */
 
-- 
2.7.4
