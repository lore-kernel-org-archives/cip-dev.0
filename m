From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:03 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 06/23] device connection: Prepare
	support for firmware described connections
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-7-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 80e04837a40f6f1c8e93437be3f772c967a41d2f upstream.

When the connections are defined in firmware, struct
device_connection will have the fwnode member pointing to
the device node (struct fwnode_handle) of the requested
device. The endpoint member for the device names will not be
used at all in that case.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Tested-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/base/devcon.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index d427e80..858b8d2 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -75,12 +75,36 @@ static struct bus_type *generic_match_buses[] = {
 	NULL,
 };
 
+static int device_fwnode_match(struct device *dev, void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode;
+}
+
+static void *device_connection_fwnode_match(struct device_connection *con)
+{
+	struct bus_type *bus;
+	struct device *dev;
+
+	for (bus = generic_match_buses[0]; bus; bus++) {
+		dev = bus_find_device(bus, NULL, (void *)con->fwnode,
+				      device_fwnode_match);
+		if (dev && !strncmp(dev_name(dev), con->id, strlen(con->id)))
+			return dev;
+
+		put_device(dev);
+	}
+	return NULL;
+}
+
 /* This tries to find the device from the most common bus types by name. */
 static void *generic_match(struct device_connection *con, int ep, void *data)
 {
 	struct bus_type *bus;
 	struct device *dev;
 
+	if (con->fwnode)
+		return device_connection_fwnode_match(con);
+
 	for (bus = generic_match_buses[0]; bus; bus++) {
 		dev = bus_find_device_by_name(bus, NULL, con->endpoint[ep]);
 		if (dev)
-- 
2.7.4
