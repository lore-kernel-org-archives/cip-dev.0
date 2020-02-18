From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:04:59 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 02/23] usb: typec: mux: Find the muxes
	by also matching against the device node
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-3-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 96a6d031ca9930938bd66d0052fc7ed2b56e3583 upstream.

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
 drivers/usb/typec/mux.c | 86 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index d990aa5..0c4e0b5 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -11,6 +11,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/slab.h>
 #include <linux/usb/typec_mux.h>
 
 static DEFINE_MUTEX(switch_lock);
@@ -23,15 +25,25 @@ static void *typec_switch_match(struct device_connection *con, int ep,
 {
 	struct typec_switch *sw;
 
-	list_for_each_entry(sw, &switch_list, entry)
-		if (!strcmp(con->endpoint[ep], dev_name(sw->dev)))
-			return sw;
+	if (!con->fwnode) {
+		list_for_each_entry(sw, &switch_list, entry)
+			if (!strcmp(con->endpoint[ep], dev_name(sw->dev)))
+				return sw;
+		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	/*
-	 * We only get called if a connection was found, tell the caller to
-	 * wait for the switch to show up.
+	 * With OF graph the mux node must have a boolean device property named
+	 * "orientation-switch".
 	 */
-	return ERR_PTR(-EPROBE_DEFER);
+	if (con->id && !fwnode_property_present(con->fwnode, con->id))
+		return NULL;
+
+	list_for_each_entry(sw, &switch_list, entry)
+		if (dev_fwnode(sw->dev) == con->fwnode)
+			return sw;
+
+	return con->id ? ERR_PTR(-EPROBE_DEFER) : NULL;
 }
 
 /**
@@ -112,17 +124,67 @@ EXPORT_SYMBOL_GPL(typec_switch_unregister);
 
 static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 {
+	const struct typec_altmode_desc *desc = data;
 	struct typec_mux *mux;
+	size_t nval;
+	bool match;
+	u16 *val;
+	int i;
 
-	list_for_each_entry(mux, &mux_list, entry)
-		if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
-			return mux;
+	if (!con->fwnode) {
+		list_for_each_entry(mux, &mux_list, entry)
+			if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
+				return mux;
+		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	/*
-	 * We only get called if a connection was found, tell the caller to
-	 * wait for the switch to show up.
+	 * Check has the identifier already been "consumed". If it
+	 * has, no need to do any extra connection identification.
 	 */
-	return ERR_PTR(-EPROBE_DEFER);
+	match = !con->id;
+	if (match)
+		goto find_mux;
+
+	/* Accessory Mode muxes */
+	if (!desc) {
+		match = fwnode_property_present(con->fwnode, "accessory");
+		if (match)
+			goto find_mux;
+		return NULL;
+	}
+
+	/* Alternate Mode muxes */
+	nval = fwnode_property_read_u16_array(con->fwnode, "svid", NULL, 0);
+	if (nval <= 0)
+		return NULL;
+
+	val = kcalloc(nval, sizeof(*val), GFP_KERNEL);
+	if (!val)
+		return ERR_PTR(-ENOMEM);
+
+	nval = fwnode_property_read_u16_array(con->fwnode, "svid", val, nval);
+	if (nval < 0) {
+		kfree(val);
+		return ERR_PTR(nval);
+	}
+
+	for (i = 0; i < nval; i++) {
+		match = val[i] == desc->svid;
+		if (match) {
+			kfree(val);
+			goto find_mux;
+		}
+	}
+	kfree(val);
+	return NULL;
+
+find_mux:
+	list_for_each_entry(mux, &mux_list, entry)
+		if (dev_fwnode(mux->dev) == con->fwnode)
+			return mux;
+
+	return match ? ERR_PTR(-EPROBE_DEFER) : NULL;
 }
 
 /**
-- 
2.7.4
