From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 20:52:29 +0200
Subject: [cip-dev] [PATCH 2/8] iio: core: implement
	iio_device_{claim|release}_direct_mode()
In-Reply-To: <cover.1504119155.git.jan.kiszka@siemens.com>
References: <cover.1504119155.git.jan.kiszka@siemens.com>
Message-ID: <f65f45d276ccb2179f31a379cfcd27e4845eccea.1504119155.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Alison Schofield <amsfield22@gmail.com>

commit 08a33805518e7845486f88287e8aace6f8439391 upstream.

It is often the case that the driver wants to be sure a device stays
in direct mode while it is executing a task or series of tasks.  To
accomplish this today, the driver performs this sequence: 1) take the
device state lock, 2) verify it is not in a buffered mode, 3) execute
some tasks, and 4) release that lock.

This patch introduces a pair of helper functions that simplify these
steps and make it more semantically expressive.

iio_device_claim_direct_mode()
        If the device is not in any buffered mode it is guaranteed
        to stay that way until iio_release_direct_mode() is called.

iio_device_release_direct_mode()
        Release the claim. Device is no longer guaranteed to stay
        in direct mode.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-core.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 131b434af994..dc0701f0ab03 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/anon_inodes.h>
 #include <linux/debugfs.h>
+#include <linux/mutex.h>
 #include <linux/iio/iio.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
@@ -1363,6 +1364,44 @@ void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(devm_iio_device_unregister);
 
+/**
+ * iio_device_claim_direct_mode - Keep device in direct mode
+ * @indio_dev:	the iio_dev associated with the device
+ *
+ * If the device is in direct mode it is guaranteed to stay
+ * that way until iio_device_release_direct_mode() is called.
+ *
+ * Use with iio_device_release_direct_mode()
+ *
+ * Returns: 0 on success, -EBUSY on failure
+ */
+int iio_device_claim_direct_mode(struct iio_dev *indio_dev)
+{
+	mutex_lock(&indio_dev->mlock);
+
+	if (iio_buffer_enabled(indio_dev)) {
+		mutex_unlock(&indio_dev->mlock);
+		return -EBUSY;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
+
+/**
+ * iio_device_release_direct_mode - releases claim on direct mode
+ * @indio_dev:	the iio_dev associated with the device
+ *
+ * Release the claim. Device is no longer guaranteed to stay
+ * in direct mode.
+ *
+ * Use with iio_device_claim_direct_mode()
+ */
+void iio_device_release_direct_mode(struct iio_dev *indio_dev)
+{
+	mutex_unlock(&indio_dev->mlock);
+}
+EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
+
 subsys_initcall(iio_init);
 module_exit(iio_exit);
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 19c94c9acc81..b6edc8dcbe61 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -527,6 +527,8 @@ void iio_device_unregister(struct iio_dev *indio_dev);
 int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev);
 void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
+int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
+void iio_device_release_direct_mode(struct iio_dev *indio_dev);
 
 extern struct bus_type iio_bus_type;
 
-- 
2.12.3
