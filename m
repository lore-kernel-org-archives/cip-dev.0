Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4328EDA6AF
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 16:54:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23263.1772556888088808628
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 08:54:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: /kl1m8mTRROHRhJLXcmOSg==
X-CSE-MsgGUID: HwN2mijUSeufaIoupyLTIw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Mar 2026 01:54:47 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.13])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1D3BB40031DC;
	Wed,  4 Mar 2026 01:54:45 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 04/11] iio: adc: add helpers for parsing ADC nodes
Date: Tue,  3 Mar 2026 18:53:44 +0200
Message-ID: <20260303165351.914437-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 16:54:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22064

From: Matti Vaittinen <mazziesaccount@gmail.com>

commit f3a8f870fa9c84b34aad4c72c8d0a1213ba13a36 upstream.

There are ADC ICs which may have some of the AIN pins usable for other
functions. These ICs may have some of the AIN pins wired so that they
should not be used for ADC.

A common way of marking pins that can be used as ADC inputs is to add
corresponding channel@N nodes in the device tree as described in the ADC
	      binding yaml.

Add couple of helper functions which can be used to retrieve the channel
information from the device node.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Link: https://patch.msgid.link/f1d8b3e15237947738912c0d297b3e1e21d8b03e.1742560649.git.mazziesaccount@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[cosmin.tanislav:
 - unquote EXPORT_SYMBOL_NS_GPL() argument]
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/iio/adc/Kconfig            |  3 ++
 drivers/iio/adc/Makefile           |  2 +
 drivers/iio/adc/industrialio-adc.c | 82 ++++++++++++++++++++++++++++++
 include/linux/iio/adc-helpers.h    | 27 ++++++++++
 4 files changed, 114 insertions(+)
 create mode 100644 drivers/iio/adc/industrialio-adc.c
 create mode 100644 include/linux/iio/adc-helpers.h

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 216f3c9ce183..154d58ad9268 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -6,6 +6,9 @@
 
 menu "Analog to digital converters"
 
+config IIO_ADC_HELPER
+	tristate
+
 config AB8500_GPADC
 	bool "ST-Ericsson AB8500 GPADC driver"
 	depends on AB8500_CORE && REGULATOR_AB8500
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7b91cd98c0e0..339a7ae9cf62 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -3,6 +3,8 @@
 # Makefile for IIO ADC drivers
 #
 
+obj-$(CONFIG_IIO_ADC_HELPER) += industrialio-adc.o
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
diff --git a/drivers/iio/adc/industrialio-adc.c b/drivers/iio/adc/industrialio-adc.c
new file mode 100644
index 000000000000..c05153db88e0
--- /dev/null
+++ b/drivers/iio/adc/industrialio-adc.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Helpers for parsing common ADC information from a firmware node.
+ *
+ * Copyright (c) 2025 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/types.h>
+
+#include <linux/iio/adc-helpers.h>
+#include <linux/iio/iio.h>
+
+/**
+ * devm_iio_adc_device_alloc_chaninfo_se - allocate and fill iio_chan_spec for ADC
+ *
+ * Scan the device node for single-ended ADC channel information. Channel ID is
+ * expected to be found from the "reg" property. Allocate and populate the
+ * iio_chan_spec structure corresponding to channels that are found. The memory
+ * for iio_chan_spec structure will be freed upon device detach.
+ *
+ * @dev:		Pointer to the ADC device.
+ * @template:		Template iio_chan_spec from which the fields of all
+ *			found and allocated channels are initialized.
+ * @max_chan_id:	Maximum value of a channel ID. Use negative value if no
+ *			checking is required.
+ * @cs:			Location where pointer to allocated iio_chan_spec
+ *			should be stored.
+ *
+ * Return:	Number of found channels on success. Negative value to indicate
+ *		failure. Specifically, -ENOENT if no channel nodes were found.
+ */
+int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
+					  const struct iio_chan_spec *template,
+					  int max_chan_id,
+					  struct iio_chan_spec **cs)
+{
+	struct iio_chan_spec *chan_array, *chan;
+	int num_chan, ret;
+
+	num_chan = iio_adc_device_num_channels(dev);
+	if (num_chan < 0)
+		return num_chan;
+
+	if (!num_chan)
+		return -ENOENT;
+
+	chan_array = devm_kcalloc(dev, num_chan, sizeof(*chan_array),
+				  GFP_KERNEL);
+	if (!chan_array)
+		return -ENOMEM;
+
+	chan = &chan_array[0];
+
+	device_for_each_named_child_node_scoped(dev, child, "channel") {
+		u32 ch;
+
+		ret = fwnode_property_read_u32(child, "reg", &ch);
+		if (ret)
+			return ret;
+
+		if (max_chan_id >= 0 && ch > max_chan_id)
+			return -ERANGE;
+
+		*chan = *template;
+		chan->channel = ch;
+		chan++;
+	}
+
+	*cs = chan_array;
+
+	return num_chan;
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_adc_device_alloc_chaninfo_se, IIO_DRIVER);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("IIO ADC fwnode parsing helpers");
diff --git a/include/linux/iio/adc-helpers.h b/include/linux/iio/adc-helpers.h
new file mode 100644
index 000000000000..56b092a2a4c4
--- /dev/null
+++ b/include/linux/iio/adc-helpers.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * The industrial I/O ADC firmware property parsing helpers
+ *
+ * Copyright (c) 2025 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#ifndef _INDUSTRIAL_IO_ADC_HELPERS_H_
+#define _INDUSTRIAL_IO_ADC_HELPERS_H_
+
+#include <linux/property.h>
+
+struct device;
+struct iio_chan_spec;
+
+static inline int iio_adc_device_num_channels(struct device *dev)
+{
+	return device_get_named_child_node_count(dev, "channel");
+}
+
+int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
+					  const struct iio_chan_spec *template,
+					  int max_chan_id,
+					  struct iio_chan_spec **cs);
+
+#endif /* _INDUSTRIAL_IO_ADC_HELPERS_H_ */
-- 
2.53.0


