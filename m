From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:16 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 19/23] usb: typec: fix an IS_ERR() vs
	NULL bug in hd3ss3220_probe()
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-20-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit c8dd192be821039d7023e0a5869d2cdf3acdef7e upstream.

The device_get_named_child_node() function doesn't return error
pointers, it returns NULL on error.

Fixes: 1c48c759ef4b ("usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20191011185055.GA20972 at mwanda
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/usb/typec/hd3ss3220.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index 0b28ca9..ac4bd17 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -173,8 +173,8 @@ static int hd3ss3220_probe(struct i2c_client *client,
 	hd3ss3220_set_source_pref(hd3ss3220,
 				  HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_DEFAULT);
 	connector = device_get_named_child_node(hd3ss3220->dev, "connector");
-	if (IS_ERR(connector))
-		return PTR_ERR(connector);
+	if (!connector)
+		return -ENODEV;
 
 	hd3ss3220->role_sw = fwnode_usb_role_switch_get(connector);
 	fwnode_handle_put(connector);
-- 
2.7.4
