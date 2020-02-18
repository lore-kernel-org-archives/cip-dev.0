From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:02 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 05/23] usb: typec: Find the ports by
	also matching against the device node
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-6-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 6a0bbcf96b2273f110a14d11a5952527c5921191 upstream.

When the connections are defined in firmware, struct
device_connection will have the fwnode member pointing to
the device node (struct fwnode_handle) of the requested
device, and the endpoint will not be used at all in that
case.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/usb/typec/class.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 1916ee1..65e95b6 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include "bus.h"
@@ -204,15 +205,32 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	put_device(&adev->dev);
 }
 
-static int __typec_port_match(struct device *dev, const void *name)
+static int typec_port_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode;
+}
+
+static int typec_port_name_match(struct device *dev, const void *name)
 {
 	return !strcmp((const char *)name, dev_name(dev));
 }
 
 static void *typec_port_match(struct device_connection *con, int ep, void *data)
 {
-	return class_find_device(typec_class, NULL, con->endpoint[ep],
-				 __typec_port_match);
+	struct device *dev;
+
+	/*
+	 * FIXME: Check does the fwnode supports the requested SVID. If it does
+	 * we need to return ERR_PTR(-PROBE_DEFER) when there is no device.
+	 */
+	if (con->fwnode)
+		return class_find_device(typec_class, NULL, con->fwnode,
+					 typec_port_fwnode_match);
+
+	dev = class_find_device(typec_class, NULL, con->endpoint[ep],
+				typec_port_name_match);
+
+	return dev ? dev : ERR_PTR(-EPROBE_DEFER);
 }
 
 struct typec_altmode *
-- 
2.7.4
