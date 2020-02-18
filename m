From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:01 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 04/23] usb: roles: Find the muxes by
	also matching against the device node
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-5-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit ec69e9533c4879c81eb7122771792864eb49af35 upstream.

When the connections are defined in firmware, struct
device_connection will have the fwnode member pointing to
the device node (struct fwnode_handle) of the requested
device, and the endpoint will not be used at all in that
case.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Tested-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/usb/roles/class.c | 21 ++++++++++++++++++---
 include/linux/usb/role.h  |  2 ++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 1dd492e..44a4af2 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/usb/role.h>
+#include <linux/property.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -84,7 +85,12 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
 
-static int __switch_match(struct device *dev, const void *name)
+static int switch_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode;
+}
+
+static int switch_name_match(struct device *dev, const void *name)
 {
 	return !strcmp((const char *)name, dev_name(dev));
 }
@@ -94,8 +100,16 @@ static void *usb_role_switch_match(struct device_connection *con, int ep,
 {
 	struct device *dev;
 
-	dev = class_find_device(role_class, NULL, con->endpoint[ep],
-				__switch_match);
+	if (con->fwnode) {
+		if (!fwnode_property_present(con->fwnode, con->id))
+			return NULL;
+
+		dev = class_find_device(role_class, NULL, con->fwnode,
+					switch_fwnode_match);
+	} else {
+		dev = class_find_device(role_class, NULL, con->endpoint[ep],
+					switch_name_match);
+	}
 
 	return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 }
@@ -266,6 +280,7 @@ usb_role_switch_register(struct device *parent,
 	sw->get = desc->get;
 
 	sw->dev.parent = parent;
+	sw->dev.fwnode = desc->fwnode;
 	sw->dev.class = role_class;
 	sw->dev.type = &usb_role_dev_type;
 	dev_set_name(&sw->dev, "%s-role-switch", dev_name(parent));
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index edc51be..c05ffa6 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -18,6 +18,7 @@ typedef enum usb_role (*usb_role_switch_get_t)(struct device *dev);
 
 /**
  * struct usb_role_switch_desc - USB Role Switch Descriptor
+ * @fwnode: The device node to be associated with the role switch
  * @usb2_port: Optional reference to the host controller port device (USB2)
  * @usb3_port: Optional reference to the host controller port device (USB3)
  * @udc: Optional reference to the peripheral controller device
@@ -32,6 +33,7 @@ typedef enum usb_role (*usb_role_switch_get_t)(struct device *dev);
  * usb_role_switch_register() before registering the switch.
  */
 struct usb_role_switch_desc {
+	struct fwnode_handle *fwnode;
 	struct device *usb2_port;
 	struct device *usb3_port;
 	struct device *udc;
-- 
2.7.4
