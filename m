From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:05 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 08/23] device property: Introduce
	fwnode_find_reference()
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-9-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 83b34afb6b79c69f5478a7249451cab858af97d6 upstream.

In most cases the references that the drivers look for don't
have any arguments. This introduces a wrapper function for
fwnode_property_get_reference_args() that looks for
references by using only the name and index.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/base/property.c  | 24 ++++++++++++++++++++++++
 include/linux/property.h |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 240ab52..52be8c8 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -946,6 +946,30 @@ static struct property_set *pset_copy_set(const struct property_set *pset)
 }
 
 /**
+ * fwnode_find_reference - Find named reference to a fwnode_handle
+ * @fwnode: Firmware node where to look for the reference
+ * @name: The name of the reference
+ * @index: Index of the reference
+ *
+ * @index can be used when the named reference holds a table of references.
+ *
+ * Returns pointer to the reference fwnode, or ERR_PTR. Caller is responsible to
+ * call fwnode_handle_put() on the returned fwnode pointer.
+ */
+struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
+					    const char *name,
+					    unsigned int index)
+{
+	struct fwnode_reference_args args;
+	int ret;
+
+	ret = fwnode_property_get_reference_args(fwnode, name, NULL, 0, index,
+						 &args);
+	return ret ? ERR_PTR(ret) : args.fwnode;
+}
+EXPORT_SYMBOL_GPL(fwnode_find_reference);
+
+/**
  * device_remove_properties - Remove properties from a device object.
  * @dev: Device whose properties to remove.
  *
diff --git a/include/linux/property.h b/include/linux/property.h
index 1a12364..216dcfe 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -78,6 +78,10 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       unsigned int nargs, unsigned int index,
 				       struct fwnode_reference_args *args);
 
+struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
+					    const char *name,
+					    unsigned int index);
+
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
-- 
2.7.4
