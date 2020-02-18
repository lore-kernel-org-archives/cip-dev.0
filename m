From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:04:58 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 01/23] device connection: Add fwnode
	member to struct device_connection
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-2-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 09aa11cfda9d8186046bcd1adcd6498b688114f4 upstream.

This will prepare the device connection API for connections
described in firmware.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 include/linux/device.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 19dd885..ceb69b9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -753,11 +753,17 @@ struct device_dma_parameters {
 
 /**
  * struct device_connection - Device Connection Descriptor
+ * @fwnode: The device node of the connected device
  * @endpoint: The names of the two devices connected together
  * @id: Unique identifier for the connection
  * @list: List head, private, for internal use only
+ *
+ * NOTE: @fwnode is not used together with @endpoint. @fwnode is used when
+ * platform firmware defines the connection. When the connection is registered
+ * with device_connection_add() @endpoint is used instead.
  */
 struct device_connection {
+	struct fwnode_handle	*fwnode;
 	const char		*endpoint[2];
 	const char		*id;
 	struct list_head	list;
-- 
2.7.4
