From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:06 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 09/23] device connection: Find
	connections also by checking the references
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-10-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit fde777791eb83f6c5845b81af89de6be60a2b2ce upstream.

We can also use this API to find named references that the
device nodes have by using fwnode_property_get_reference_args()
function.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/base/devcon.c     | 26 ++++++++++++++++++++++++++
 drivers/usb/roles/class.c |  2 +-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 04db9ae..f7035fc 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -38,6 +38,28 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 	return NULL;
 }
 
+static void *
+fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
+		    void *data, devcon_match_fn_t match)
+{
+	struct device_connection con = { };
+	void *ret;
+	int i;
+
+	for (i = 0; ; i++) {
+		con.fwnode = fwnode_find_reference(fwnode, con_id, i);
+		if (IS_ERR(con.fwnode))
+			break;
+
+		ret = match(&con, -1, data);
+		fwnode_handle_put(con.fwnode);
+		if (ret)
+			return ret;
+	}
+
+	return NULL;
+}
+
 /**
  * device_connection_find_match - Find physical connection to a device
  * @dev: Device with the connection
@@ -65,6 +87,10 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
 		ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
 		if (ret)
 			return ret;
+
+		ret = fwnode_devcon_match(fwnode, con_id, data, match);
+		if (ret)
+			return ret;
 	}
 
 	mutex_lock(&devcon_lock);
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 44a4af2..6b3c087 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -101,7 +101,7 @@ static void *usb_role_switch_match(struct device_connection *con, int ep,
 	struct device *dev;
 
 	if (con->fwnode) {
-		if (!fwnode_property_present(con->fwnode, con->id))
+		if (con->id && !fwnode_property_present(con->fwnode, con->id))
 			return NULL;
 
 		dev = class_find_device(role_class, NULL, con->fwnode,
-- 
2.7.4
