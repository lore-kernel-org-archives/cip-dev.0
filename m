Return-Path: <SRS0=GWB9=7R=lists.cip-project.org=bounce+64572+4675+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C16C433E3
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 04:18:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BE0207D0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 04:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="GcZcjM83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BE0207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4675+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aLVAYY4521723xBe417z1H72; Wed, 03 Jun 2020 21:18:06 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web10.7307.1591244284259956780
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 21:18:04 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 6B4DD5F87E; Thu,  4 Jun 2020 12:18:02 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH RESEND 4.4.y-cip 01/15] PM / OPP: Add debugfs support
Date: Thu,  4 Jun 2020 12:17:31 +0800
Message-Id: <20200604041745.28886-2-wens@csie.org>
In-Reply-To: <20200604041745.28886-1-wens@csie.org>
References: <20200604041745.28886-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FMQpzGmtCF2qjCrf8QBvsnPcx4520388AA=
Content-Type: multipart/mixed; boundary="LtF0UnIETTq2ndQAM6uB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591244286;
 bh=d5PKJEfsGGDZw3k46Ax9waaChnpBcGZQ9evoI1MZpdA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=GcZcjM83wg0xIsL/62TJ9gbP6/woQ4fjyK1dpz2qWKO4MgMoC5PbxU+xp+w4v7cUtUk
 nXETe+vGbvdnw1kpOcbB2cJ4EgLAi25bGFYlWPqo/tSTo0b25V3MEXz/ux7wMXt9mRhry
 85P+NBa1aof3LWAxIgxE8zxmcyscg5ALiuQ=

--LtF0UnIETTq2ndQAM6uB
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit deaa51465105a7eda19a627b10372f4f7c51a4df upstream.

This patch adds debugfs support to OPP layer to export OPPs and their
properties for all the devices.

This creates a top level directory: /sys/kernel/debug/opp and then
device specific directories (based on device names) inside it. For
example: 'cpu0', 'cpu1', etc..

If multiple devices share the OPP table, then the real directory is
created only for the first device. For all others, links are created to
the real directory.

Inside the device specific directory, a separate directory is created
for each OPP. And within that files per opp property.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/Makefile  |   1 +
 drivers/base/power/opp/core.c    |  21 ++-
 drivers/base/power/opp/debugfs.c | 219 +++++++++++++++++++++++++++++++
 drivers/base/power/opp/opp.h     |  42 ++++++
 4 files changed, 281 insertions(+), 2 deletions(-)
 create mode 100644 drivers/base/power/opp/debugfs.c

diff --git a/drivers/base/power/opp/Makefile b/drivers/base/power/opp/Mak=
efile
index 33c1e18c41a4d..19837ef04d8ef 100644
--- a/drivers/base/power/opp/Makefile
+++ b/drivers/base/power/opp/Makefile
@@ -1,2 +1,3 @@
 ccflags-$(CONFIG_DEBUG_DRIVER)	:=3D -DDEBUG
 obj-y				+=3D core.o cpu.o
+obj-$(CONFIG_DEBUG_FS)		+=3D debugfs.o
diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index e822dc706d676..22d91d9b1b037 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -463,6 +463,7 @@ static void _kfree_list_dev_rcu(struct rcu_head *head=
)
 static void _remove_list_dev(struct device_list_opp *list_dev,
 			     struct device_opp *dev_opp)
 {
+	opp_debug_unregister(list_dev, dev_opp);
 	list_del(&list_dev->node);
 	call_srcu(&dev_opp->srcu_head.srcu, &list_dev->rcu_head,
 		  _kfree_list_dev_rcu);
@@ -472,6 +473,7 @@ struct device_list_opp *_add_list_dev(const struct de=
vice *dev,
 				      struct device_opp *dev_opp)
 {
 	struct device_list_opp *list_dev;
+	int ret;
=20
 	list_dev =3D kzalloc(sizeof(*list_dev), GFP_KERNEL);
 	if (!list_dev)
@@ -481,6 +483,12 @@ struct device_list_opp *_add_list_dev(const struct d=
evice *dev,
 	list_dev->dev =3D dev;
 	list_add_rcu(&list_dev->node, &dev_opp->dev_list);
=20
+	/* Create debugfs entries for the dev_opp */
+	ret =3D opp_debug_register(list_dev, dev_opp);
+	if (ret)
+		dev_err(dev, "%s: Failed to register opp debugfs (%d)\n",
+			__func__, ret);
+
 	return list_dev;
 }
=20
@@ -596,6 +604,7 @@ static void _opp_remove(struct device_opp *dev_opp,
 	 */
 	if (notify)
 		srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_REMOVE, opp);
+	opp_debug_remove_one(opp);
 	list_del_rcu(&opp->node);
 	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
=20
@@ -673,6 +682,7 @@ static int _opp_add(struct device *dev, struct dev_pm=
_opp *new_opp,
 {
 	struct dev_pm_opp *opp;
 	struct list_head *head =3D &dev_opp->opp_list;
+	int ret;
=20
 	/*
 	 * Insert new OPP in order of increasing frequency and discard if
@@ -703,6 +713,11 @@ static int _opp_add(struct device *dev, struct dev_p=
m_opp *new_opp,
 	new_opp->dev_opp =3D dev_opp;
 	list_add_rcu(&new_opp->node, head);
=20
+	ret =3D opp_debug_create_one(new_opp, dev_opp);
+	if (ret)
+		dev_err(dev, "%s: Failed to register opp to debugfs (%d)\n",
+			__func__, ret);
+
 	return 0;
 }
=20
@@ -895,12 +910,14 @@ static int _opp_add_static_v2(struct device *dev, s=
truct device_node *np)
=20
 	/* OPP to select on device suspend */
 	if (of_property_read_bool(np, "opp-suspend")) {
-		if (dev_opp->suspend_opp)
+		if (dev_opp->suspend_opp) {
 			dev_warn(dev, "%s: Multiple suspend OPPs found (%lu %lu)\n",
 				 __func__, dev_opp->suspend_opp->rate,
 				 new_opp->rate);
-		else
+		} else {
+			new_opp->suspend =3D true;
 			dev_opp->suspend_opp =3D new_opp;
+		}
 	}
=20
 	if (new_opp->clock_latency_ns > dev_opp->clock_latency_ns_max)
diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/de=
bugfs.c
new file mode 100644
index 0000000000000..ddfe4773e922a
--- /dev/null
+++ b/drivers/base/power/opp/debugfs.c
@@ -0,0 +1,219 @@
+/*
+ * Generic OPP debugfs interface
+ *
+ * Copyright (C) 2015-2016 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/limits.h>
+
+#include "opp.h"
+
+static struct dentry *rootdir;
+
+static void opp_set_dev_name(const struct device *dev, char *name)
+{
+	if (dev->parent)
+		snprintf(name, NAME_MAX, "%s-%s", dev_name(dev->parent),
+			 dev_name(dev));
+	else
+		snprintf(name, NAME_MAX, "%s", dev_name(dev));
+}
+
+void opp_debug_remove_one(struct dev_pm_opp *opp)
+{
+	debugfs_remove_recursive(opp->dentry);
+}
+
+int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_=
opp)
+{
+	struct dentry *pdentry =3D dev_opp->dentry;
+	struct dentry *d;
+	char name[25];	/* 20 chars for 64 bit value + 5 (opp:\0) */
+
+	/* Rate is unique to each OPP, use it to give opp-name */
+	snprintf(name, sizeof(name), "opp:%lu", opp->rate);
+
+	/* Create per-opp directory */
+	d =3D debugfs_create_dir(name, pdentry);
+	if (!d)
+		return -ENOMEM;
+
+	if (!debugfs_create_bool("available", S_IRUGO, d, &opp->available))
+		return -ENOMEM;
+
+	if (!debugfs_create_bool("dynamic", S_IRUGO, d, &opp->dynamic))
+		return -ENOMEM;
+
+	if (!debugfs_create_bool("turbo", S_IRUGO, d, &opp->turbo))
+		return -ENOMEM;
+
+	if (!debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("u_volt_target", S_IRUGO, d, &opp->u_volt))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("u_volt_min", S_IRUGO, d, &opp->u_volt_min))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("u_volt_max", S_IRUGO, d, &opp->u_volt_max))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("u_amp", S_IRUGO, d, &opp->u_amp))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("clock_latency_ns", S_IRUGO, d,
+				  &opp->clock_latency_ns))
+		return -ENOMEM;
+
+	opp->dentry =3D d;
+	return 0;
+}
+
+static int device_opp_debug_create_dir(struct device_list_opp *list_dev,
+				       struct device_opp *dev_opp)
+{
+	const struct device *dev =3D list_dev->dev;
+	struct dentry *d;
+
+	opp_set_dev_name(dev, dev_opp->dentry_name);
+
+	/* Create device specific directory */
+	d =3D debugfs_create_dir(dev_opp->dentry_name, rootdir);
+	if (!d) {
+		dev_err(dev, "%s: Failed to create debugfs dir\n", __func__);
+		return -ENOMEM;
+	}
+
+	list_dev->dentry =3D d;
+	dev_opp->dentry =3D d;
+
+	return 0;
+}
+
+static int device_opp_debug_create_link(struct device_list_opp *list_dev=
,
+					struct device_opp *dev_opp)
+{
+	const struct device *dev =3D list_dev->dev;
+	char name[NAME_MAX];
+	struct dentry *d;
+
+	opp_set_dev_name(list_dev->dev, name);
+
+	/* Create device specific directory link */
+	d =3D debugfs_create_symlink(name, rootdir, dev_opp->dentry_name);
+	if (!d) {
+		dev_err(dev, "%s: Failed to create link\n", __func__);
+		return -ENOMEM;
+	}
+
+	list_dev->dentry =3D d;
+
+	return 0;
+}
+
+/**
+ * opp_debug_register - add a device opp node to the debugfs 'opp' direc=
tory
+ * @list_dev: list-dev pointer for device
+ * @dev_opp: the device-opp being added
+ *
+ * Dynamically adds device specific directory in debugfs 'opp' directory=
. If the
+ * device-opp is shared with other devices, then links will be created f=
or all
+ * devices except the first.
+ *
+ * Return: 0 on success, otherwise negative error.
+ */
+int opp_debug_register(struct device_list_opp *list_dev,
+		       struct device_opp *dev_opp)
+{
+	if (!rootdir) {
+		pr_debug("%s: Uninitialized rootdir\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_opp->dentry)
+		return device_opp_debug_create_link(list_dev, dev_opp);
+
+	return device_opp_debug_create_dir(list_dev, dev_opp);
+}
+
+static void opp_migrate_dentry(struct device_list_opp *list_dev,
+			       struct device_opp *dev_opp)
+{
+	struct device_list_opp *new_dev;
+	const struct device *dev;
+	struct dentry *dentry;
+
+	/* Look for next list-dev */
+	list_for_each_entry(new_dev, &dev_opp->dev_list, node)
+		if (new_dev !=3D list_dev)
+			break;
+
+	/* new_dev is guaranteed to be valid here */
+	dev =3D new_dev->dev;
+	debugfs_remove_recursive(new_dev->dentry);
+
+	opp_set_dev_name(dev, dev_opp->dentry_name);
+
+	dentry =3D debugfs_rename(rootdir, list_dev->dentry, rootdir,
+				dev_opp->dentry_name);
+	if (!dentry) {
+		dev_err(dev, "%s: Failed to rename link from: %s to %s\n",
+			__func__, dev_name(list_dev->dev), dev_name(dev));
+		return;
+	}
+
+	new_dev->dentry =3D dentry;
+	dev_opp->dentry =3D dentry;
+}
+
+/**
+ * opp_debug_unregister - remove a device opp node from debugfs opp dire=
ctory
+ * @list_dev: list-dev pointer for device
+ * @dev_opp: the device-opp being removed
+ *
+ * Dynamically removes device specific directory from debugfs 'opp' dire=
ctory.
+ */
+void opp_debug_unregister(struct device_list_opp *list_dev,
+			  struct device_opp *dev_opp)
+{
+	if (list_dev->dentry =3D=3D dev_opp->dentry) {
+		/* Move the real dentry object under another device */
+		if (!list_is_singular(&dev_opp->dev_list)) {
+			opp_migrate_dentry(list_dev, dev_opp);
+			goto out;
+		}
+		dev_opp->dentry =3D NULL;
+	}
+
+	debugfs_remove_recursive(list_dev->dentry);
+
+out:
+	list_dev->dentry =3D NULL;
+}
+
+static int __init opp_debug_init(void)
+{
+	/* Create /sys/kernel/debug/opp directory */
+	rootdir =3D debugfs_create_dir("opp", NULL);
+	if (!rootdir) {
+		pr_err("%s: Failed to create root directory\n", __func__);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+core_initcall(opp_debug_init);
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 7366b2aa89978..a6bd8d2c2b47f 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/limits.h>
 #include <linux/pm_opp.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -53,6 +54,7 @@ extern struct mutex dev_opp_list_lock;
  * @dynamic:	not-created from static DT entries.
  * @available:	true/false - marks if this OPP as available or not
  * @turbo:	true if turbo (boost) OPP
+ * @suspend:	true if suspend OPP
  * @rate:	Frequency in hertz
  * @u_volt:	Target voltage in microvolts corresponding to this OPP
  * @u_volt_min:	Minimum voltage in microvolts corresponding to this OPP
@@ -63,6 +65,7 @@ extern struct mutex dev_opp_list_lock;
  * @dev_opp:	points back to the device_opp struct this opp belongs to
  * @rcu_head:	RCU callback head used for deferred freeing
  * @np:		OPP's device node.
+ * @dentry:	debugfs dentry pointer (per opp)
  *
  * This structure stores the OPP information for a given device.
  */
@@ -72,6 +75,7 @@ struct dev_pm_opp {
 	bool available;
 	bool dynamic;
 	bool turbo;
+	bool suspend;
 	unsigned long rate;
=20
 	unsigned long u_volt;
@@ -84,6 +88,10 @@ struct dev_pm_opp {
 	struct rcu_head rcu_head;
=20
 	struct device_node *np;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dentry;
+#endif
 };
=20
 /**
@@ -91,6 +99,7 @@ struct dev_pm_opp {
  * @node:	list node
  * @dev:	device to which the struct object belongs
  * @rcu_head:	RCU callback head used for deferred freeing
+ * @dentry:	debugfs dentry pointer (per device)
  *
  * This is an internal data structure maintaining the list of devices th=
at are
  * managed by 'struct device_opp'.
@@ -99,6 +108,10 @@ struct device_list_opp {
 	struct list_head node;
 	const struct device *dev;
 	struct rcu_head rcu_head;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dentry;
+#endif
 };
=20
 /**
@@ -114,6 +127,8 @@ struct device_list_opp {
  * @opp_list:	list of opps
  * @np:		struct device_node pointer for opp's DT node.
  * @shared_opp: OPP is shared between multiple devices.
+ * @dentry:	debugfs dentry pointer of the real device directory (not lin=
ks).
+ * @dentry_name: Name of the real dentry.
  *
  * This is an internal data structure maintaining the link to opps attac=
hed to
  * a device. This structure is not meant to be shared to users as it is
@@ -135,6 +150,11 @@ struct device_opp {
 	unsigned long clock_latency_ns_max;
 	bool shared_opp;
 	struct dev_pm_opp *suspend_opp;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dentry;
+	char dentry_name[NAME_MAX];
+#endif
 };
=20
 /* Routines internal to opp core */
@@ -143,4 +163,26 @@ struct device_list_opp *_add_list_dev(const struct d=
evice *dev,
 				      struct device_opp *dev_opp);
 struct device_node *_of_get_opp_desc_node(struct device *dev);
=20
+#ifdef CONFIG_DEBUG_FS
+void opp_debug_remove_one(struct dev_pm_opp *opp);
+int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_=
opp);
+int opp_debug_register(struct device_list_opp *list_dev,
+		       struct device_opp *dev_opp);
+void opp_debug_unregister(struct device_list_opp *list_dev,
+			  struct device_opp *dev_opp);
+#else
+static inline void opp_debug_remove_one(struct dev_pm_opp *opp) {}
+
+static inline int opp_debug_create_one(struct dev_pm_opp *opp,
+				       struct device_opp *dev_opp)
+{ return 0; }
+static inline int opp_debug_register(struct device_list_opp *list_dev,
+				     struct device_opp *dev_opp)
+{ return 0; }
+
+static inline void opp_debug_unregister(struct device_list_opp *list_dev=
,
+					struct device_opp *dev_opp)
+{ }
+#endif		/* DEBUG_FS */
+
 #endif		/* __DRIVER_OPP_H__ */
--=20
2.27.0.rc0


--LtF0UnIETTq2ndQAM6uB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4675): https://lists.cip-project.org/g/cip-dev/message=
/4675
Mute This Topic: https://lists.cip-project.org/mt/74665628/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--LtF0UnIETTq2ndQAM6uB--
