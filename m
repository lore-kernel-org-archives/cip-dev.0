Return-Path: <SRS0=YUhq=AT=lists.cip-project.org=bounce+64572+4887+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968D5C433E0
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:27 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63989206DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="k/VI1399"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63989206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4887+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OD4HYY4521723xjwfK1Xom5m; Wed, 08 Jul 2020 08:46:25 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web10.13558.1594223180607576294
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:21 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 135595FC7F; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 01/23] PM / OPP: get/put regulators from OPP core
Date: Wed,  8 Jul 2020 23:45:32 +0800
Message-Id: <20200708154554.26450-2-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fyVyWVSf3rZWzsOrT6WZqMKYx4520388AA=
Content-Type: multipart/mixed; boundary="GTj5aL8ZtaOaIq4a45rZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223185;
 bh=0KO7h8btuhkUe7eA1M5nJODumQLKJtN/4jVLGHJL7ws=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=k/VI1399QKmjwWvi3lw7wtUeNapxPHkYcRFJnLikG5ffgqXFcePFBo9ARTKarZ6lSV6
 k+6fB+Hjx1fxFFYpN3Vmg5EqfLqusViWT4OHUB3mYc2bGdn8jJqimZVut7R0wdoQ/IV2H
 k0qC5L7+uPRBtaF8aBhJa77y0XxE9HrJznw=

--GTj5aL8ZtaOaIq4a45rZ
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 9f8ea969d5cfdd4353d2adb004e8e2286b984369 upstream.

This allows the OPP core to request/free the regulator resource,
attached to a device OPP. The regulator device is fetched using the name
provided by the driver, while calling: dev_pm_opp_set_regulator().

This will work for both OPP-v1 and v2 bindings.

This is a preliminary step for moving the OPP switching logic into the
OPP core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 111 ++++++++++++++++++++++++++++++++++
 drivers/base/power/opp/opp.h  |   4 ++
 include/linux/pm_opp.h        |   9 +++
 3 files changed, 124 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index 1e0a2ddf73323..efdfcee48cac7 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -19,6 +19,7 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/export.h>
+#include <linux/regulator/consumer.h>
=20
 #include "opp.h"
=20
@@ -565,6 +566,9 @@ static void _remove_device_opp(struct device_opp *dev=
_opp)
 	if (dev_opp->prop_name)
 		return;
=20
+	if (!IS_ERR_OR_NULL(dev_opp->regulator))
+		return;
+
 	list_dev =3D list_first_entry(&dev_opp->dev_list, struct device_list_op=
p,
 				    node);
=20
@@ -1091,6 +1095,113 @@ unlock:
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
=20
+/**
+ * dev_pm_opp_set_regulator() - Set regulator name for the device
+ * @dev: Device for which regulator name is being set.
+ * @name: Name of the regulator.
+ *
+ * In order to support OPP switching, OPP layer needs to know the name o=
f the
+ * device's regulator, as the core would be required to switch voltages =
as well.
+ *
+ * This must be called before any OPPs are initialized for the device.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Hence this function internally uses RCU updater strategy with mutex l=
ocks
+ * to keep the integrity of the internal data structures. Callers should=
 ensure
+ * that this function is *NOT* called under RCU protection or in context=
s where
+ * mutex cannot be locked.
+ */
+int dev_pm_opp_set_regulator(struct device *dev, const char *name)
+{
+	struct device_opp *dev_opp;
+	struct regulator *reg;
+	int ret;
+
+	mutex_lock(&dev_opp_list_lock);
+
+	dev_opp =3D _add_device_opp(dev);
+	if (!dev_opp) {
+		ret =3D -ENOMEM;
+		goto unlock;
+	}
+
+	/* This should be called before OPPs are initialized */
+	if (WARN_ON(!list_empty(&dev_opp->opp_list))) {
+		ret =3D -EBUSY;
+		goto err;
+	}
+
+	/* Already have a regulator set */
+	if (WARN_ON(!IS_ERR_OR_NULL(dev_opp->regulator))) {
+		ret =3D -EBUSY;
+		goto err;
+	}
+	/* Allocate the regulator */
+	reg =3D regulator_get_optional(dev, name);
+	if (IS_ERR(reg)) {
+		ret =3D PTR_ERR(reg);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(dev, "%s: no regulator (%s) found: %d\n",
+				__func__, name, ret);
+		goto err;
+	}
+
+	dev_opp->regulator =3D reg;
+
+	mutex_unlock(&dev_opp_list_lock);
+	return 0;
+
+err:
+	_remove_device_opp(dev_opp);
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulator);
+
+/**
+ * dev_pm_opp_put_regulator() - Releases resources blocked for regulator
+ * @dev: Device for which regulator was set.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Hence this function internally uses RCU updater strategy with mutex l=
ocks
+ * to keep the integrity of the internal data structures. Callers should=
 ensure
+ * that this function is *NOT* called under RCU protection or in context=
s where
+ * mutex cannot be locked.
+ */
+void dev_pm_opp_put_regulator(struct device *dev)
+{
+	struct device_opp *dev_opp;
+
+	mutex_lock(&dev_opp_list_lock);
+
+	/* Check for existing list for 'dev' first */
+	dev_opp =3D _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR(dev_opp));
+		goto unlock;
+	}
+
+	if (IS_ERR_OR_NULL(dev_opp->regulator)) {
+		dev_err(dev, "%s: Doesn't have regulator set\n", __func__);
+		goto unlock;
+	}
+
+	/* Make sure there are no concurrent readers while updating dev_opp */
+	WARN_ON(!list_empty(&dev_opp->opp_list));
+
+	regulator_put(dev_opp->regulator);
+	dev_opp->regulator =3D ERR_PTR(-EINVAL);
+
+	/* Try freeing device_opp if this was the last blocking resource */
+	_remove_device_opp(dev_opp);
+
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulator);
+
 static bool _opp_is_supported(struct device *dev, struct device_opp *dev=
_opp,
 			      struct device_node *np)
 {
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 690638ef36ee5..416293b7da237 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -22,6 +22,8 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
=20
+struct regulator;
+
 /* Lock to allow exclusive modification to the device and opp lists */
 extern struct mutex dev_opp_list_lock;
=20
@@ -132,6 +134,7 @@ struct device_list_opp {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing th=
em.
+ * @regulator: Supply regulator
  * @dentry:	debugfs dentry pointer of the real device directory (not lin=
ks).
  * @dentry_name: Name of the real dentry.
  *
@@ -159,6 +162,7 @@ struct device_opp {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
+	struct regulator *regulator;
=20
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 95403d2ccaf56..c70a18ac9c8a7 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -60,6 +60,8 @@ int dev_pm_opp_set_supported_hw(struct device *dev, con=
st u32 *versions,
 void dev_pm_opp_put_supported_hw(struct device *dev);
 int dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct device *dev);
+int dev_pm_opp_set_regulator(struct device *dev, const char *name);
+void dev_pm_opp_put_regulator(struct device *dev);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *op=
p)
 {
@@ -151,6 +153,13 @@ static inline int dev_pm_opp_set_prop_name(struct de=
vice *dev, const char *name)
=20
 static inline void dev_pm_opp_put_prop_name(struct device *dev) {}
=20
+static inline int dev_pm_opp_set_regulator(struct device *dev, const cha=
r *name)
+{
+	return -EINVAL;
+}
+
+static inline void dev_pm_opp_put_regulator(struct device *dev) {}
+
 #endif		/* CONFIG_PM_OPP */
=20
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
--=20
2.27.0


--GTj5aL8ZtaOaIq4a45rZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4887): https://lists.cip-project.org/g/cip-dev/message=
/4887
Mute This Topic: https://lists.cip-project.org/mt/75379079/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--GTj5aL8ZtaOaIq4a45rZ--
