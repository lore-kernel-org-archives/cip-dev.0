From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 19 Apr 2018 10:33:00 +0100
Subject: [cip-dev] [PATCH 5/6] i2c: rcar: refactor setup of a msg
In-Reply-To: <1524130381-4346-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1524130381-4346-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1524130381-4346-6-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We want to reuse this function later.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
(cherry picked from commit b9d0684c79c4b9d30ce0d47d3270493dd0e76e59)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reported-by: Zoran Stojsavljevic <zoran.stojsavljevic.de@gmail.com>
---
 drivers/i2c/busses/i2c-rcar.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 1c4566a..c57ba96 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -106,7 +106,8 @@ enum rcar_i2c_type {
 struct rcar_i2c_priv {
 	void __iomem *io;
 	struct i2c_adapter adap;
-	struct i2c_msg	*msg;
+	struct i2c_msg *msg;
+	int msgs_left;
 	struct clk *clk;
 
 	wait_queue_head_t wait;
@@ -255,6 +256,11 @@ static void rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 {
 	int read = !!rcar_i2c_is_recv(priv);
 
+	priv->pos = 0;
+	priv->flags = 0;
+	if (priv->msgs_left == 1)
+		rcar_i2c_flags_set(priv, ID_LAST_MSG);
+
 	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
 	rcar_i2c_write(priv, ICMSR, 0);
 	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
@@ -499,11 +505,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 		}
 
 		/* init each data */
-		priv->msg	= &msgs[i];
-		priv->pos	= 0;
-		priv->flags	= 0;
-		if (i == num - 1)
-			rcar_i2c_flags_set(priv, ID_LAST_MSG);
+		priv->msg = &msgs[i];
+		priv->msgs_left = num - i;
 
 		rcar_i2c_prepare_msg(priv);
 
-- 
2.7.4
