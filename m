Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EB8EDA6AE
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 16:54:50 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23260.1772556884440938222
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 08:54:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: SawK4wWtQra7NEeSOGS4wA==
X-CSE-MsgGUID: ZlhphN/zSw6Wh0G4flyyoQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Mar 2026 01:54:45 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.13])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 619C440031DC;
	Wed,  4 Mar 2026 01:54:44 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 03/11] property: Add functions to iterate named child
Date: Tue,  3 Mar 2026 18:53:43 +0200
Message-ID: <20260303165351.914437-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 16:54:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22063

From: Matti Vaittinen <mazziesaccount@gmail.com>

commit f24303631489d250f330373a59b3412103a93b67 upstream.

There are a few use-cases where child nodes with a specific name need to
be parsed. Code like:

fwnode_for_each_child_node()
	if (fwnode_name_eq())
		...

can be found from a various drivers/subsystems. Adding a macro for this
can simplify things a bit.

In a few cases the data from the found nodes is later added to an array,
which is allocated based on the number of found nodes. One example of
such use is the IIO subsystem's ADC channel nodes, where the relevant
nodes are named as channel[@N].

Add helpers for iterating and counting device's sub-nodes with certain
name instead of open-coding this in every user.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Link: https://patch.msgid.link/2767173b7b18e974c0bac244688214bd3863ff06.1742560649.git.mazziesaccount@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/base/property.c  | 27 +++++++++++++++++++++++++++
 include/linux/property.h | 20 ++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 837d77e3af2b..fb7e9c544dc5 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -907,6 +907,33 @@ unsigned int device_get_child_node_count(const struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_child_node_count);
 
+/**
+ * fwnode_get_named_child_node_count - number of child nodes with given name
+ * @fwnode: Node which child nodes are counted.
+ * @name: String to match child node name against.
+ *
+ * Scan child nodes and count all the nodes with a specific name. Potential
+ * 'number' -ending after the 'at sign' for scanned names is ignored.
+ * E.g.::
+ *   fwnode_get_named_child_node_count(fwnode, "channel");
+ * would match all the nodes::
+ *   channel { }, channel@0 {}, channel@0xabba {}...
+ *
+ * Return: the number of child nodes with a matching name for a given device.
+ */
+unsigned int fwnode_get_named_child_node_count(const struct fwnode_handle *fwnode,
+					       const char *name)
+{
+	struct fwnode_handle *child;
+	unsigned int count = 0;
+
+	fwnode_for_each_named_child_node(fwnode, child, name)
+		count++;
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_named_child_node_count);
+
 bool device_dma_supported(const struct device *dev)
 {
 	return fwnode_call_bool_op(dev_fwnode(dev), device_dma_supported);
diff --git a/include/linux/property.h b/include/linux/property.h
index 61fc20e5f81f..c335b206de41 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -164,6 +164,10 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
 	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
 	     child = fwnode_get_next_child_node(fwnode, child))
 
+#define fwnode_for_each_named_child_node(fwnode, child, name)		\
+	fwnode_for_each_child_node(fwnode, child)			\
+		if (!fwnode_name_eq(child, name)) { } else
+
 #define fwnode_for_each_available_child_node(fwnode, child)		       \
 	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
 	     child = fwnode_get_next_available_child_node(fwnode, child))
@@ -175,11 +179,19 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 	for (child = device_get_next_child_node(dev, NULL); child;	\
 	     child = device_get_next_child_node(dev, child))
 
+#define device_for_each_named_child_node(dev, child, name)		\
+	device_for_each_child_node(dev, child)				\
+		if (!fwnode_name_eq(child, name)) { } else
+
 #define device_for_each_child_node_scoped(dev, child)			\
 	for (struct fwnode_handle *child __free(fwnode_handle) =	\
 		device_get_next_child_node(dev, NULL);			\
 	     child; child = device_get_next_child_node(dev, child))
 
+#define device_for_each_named_child_node_scoped(dev, child, name)	\
+	device_for_each_child_node_scoped(dev, child)			\
+		if (!fwnode_name_eq(child, name)) { } else
+
 struct fwnode_handle *fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 						  const char *childname);
 struct fwnode_handle *device_get_named_child_node(const struct device *dev,
@@ -213,6 +225,14 @@ static inline bool device_property_read_bool(const struct device *dev,
 	return device_property_present(dev, propname);
 }
 
+unsigned int fwnode_get_named_child_node_count(const struct fwnode_handle *fwnode,
+					       const char *name);
+static inline unsigned int device_get_named_child_node_count(const struct device *dev,
+							     const char *name)
+{
+	return fwnode_get_named_child_node_count(dev_fwnode(dev), name);
+}
+
 static inline int device_property_read_u8(const struct device *dev,
 					  const char *propname, u8 *val)
 {
-- 
2.53.0


