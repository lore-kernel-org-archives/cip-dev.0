From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 19 Apr 2018 10:32:58 +0100
Subject: [cip-dev] [PATCH 3/6] i2c: rcar: remove unused IOERROR state
In-Reply-To: <1524130381-4346-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1524130381-4346-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1524130381-4346-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
(cherry picked from commit 90f779e565bdc18dd4f79d81cf11f43a7266010b)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reported-by: Zoran Stojsavljevic <zoran.stojsavljevic.de@gmail.com>
---
 drivers/i2c/busses/i2c-rcar.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index fd76b15..30daad1 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -94,7 +94,6 @@
 #define RCAR_IRQ_ACK_RECV	(~(MAT | MDR) & 0xFF)
 
 #define ID_LAST_MSG	(1 << 0)
-#define ID_IOERROR	(1 << 1)
 #define ID_DONE		(1 << 2)
 #define ID_ARBLOST	(1 << 3)
 #define ID_NACK		(1 << 4)
@@ -541,11 +540,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 			break;
 		}
 
-		if (rcar_i2c_flags_has(priv, ID_IOERROR)) {
-			ret = -EIO;
-			break;
-		}
-
 		ret = i + 1; /* The number of transfer */
 	}
 out:
-- 
2.7.4
