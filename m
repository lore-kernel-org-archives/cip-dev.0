From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:04 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 07/23] device connection: Find device
	connections also from device graphs
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-8-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 637e9e52b185e5b10372366bd6db97f27cf3f202 upstream.

If connections between devices are described in OF graph or
ACPI device graph, we can find them by using the
fwnode_graph_*() functions.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Tested-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/base/devcon.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 858b8d2..04db9ae 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -7,10 +7,37 @@
  */
 
 #include <linux/device.h>
+#include <linux/property.h>
 
 static DEFINE_MUTEX(devcon_lock);
 static LIST_HEAD(devcon_list);
 
+typedef void *(*devcon_match_fn_t)(struct device_connection *con, int ep,
+				   void *data);
+
+static void *
+fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
+			  void *data, devcon_match_fn_t match)
+{
+	struct device_connection con = { .id = con_id };
+	struct fwnode_handle *ep;
+	void *ret;
+
+	fwnode_graph_for_each_endpoint(fwnode, ep) {
+		con.fwnode = fwnode_graph_get_remote_port_parent(ep);
+		if (!fwnode_device_is_available(con.fwnode))
+			continue;
+
+		ret = match(&con, -1, data);
+		fwnode_handle_put(con.fwnode);
+		if (ret) {
+			fwnode_handle_put(ep);
+			return ret;
+		}
+	}
+	return NULL;
+}
+
 /**
  * device_connection_find_match - Find physical connection to a device
  * @dev: Device with the connection
@@ -23,10 +50,9 @@ static LIST_HEAD(devcon_list);
  * caller is expecting to be returned.
  */
 void *device_connection_find_match(struct device *dev, const char *con_id,
-			       void *data,
-			       void *(*match)(struct device_connection *con,
-					      int ep, void *data))
+				   void *data, devcon_match_fn_t match)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	const char *devname = dev_name(dev);
 	struct device_connection *con;
 	void *ret = NULL;
@@ -35,6 +61,12 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
 	if (!match)
 		return NULL;
 
+	if (fwnode) {
+		ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
+		if (ret)
+			return ret;
+	}
+
 	mutex_lock(&devcon_lock);
 
 	list_for_each_entry(con, &devcon_list, list) {
-- 
2.7.4
