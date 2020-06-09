Return-Path: <SRS0=HQu4=7W=lists.cip-project.org=bounce+64572+4781+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84351C433E2
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 04:10:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52554206D5
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 04:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Or+5kDh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52554206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4781+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rVSEYY4521723xtHxk9E849U; Mon, 08 Jun 2020 21:10:07 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web11.92.1591675802415002422
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 21:10:02 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 2D9B05FF88; Tue,  9 Jun 2020 12:09:59 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v3 08/14] PM / OPP: Parse 'opp-<prop>-<name>' bindings
Date: Tue,  9 Jun 2020 12:09:20 +0800
Message-Id: <20200609040926.8910-9-wens@csie.org>
In-Reply-To: <20200609040926.8910-1-wens@csie.org>
References: <20200609040926.8910-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dv0JKGKtdbh0aegZlx5VpblGx4520388AA=
Content-Type: multipart/mixed; boundary="E9TiWqfOhOhoZiTknDyz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591675807;
 bh=tnf+U9JoG1S9nktIV3mr6gmOg+al54wJujbs3Jzs3UM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Or+5kDh9EVnj4eOtz3ESleByQ5+VFZy1DV+Cgdyaiaio6+gEwpoaopWrZb+97WGLQ38
 vEVgAs1o2wcegqd8di7kWvbhhuxzZdcm+l8sU/QSQulMZXA2DxefxGRmf/1pG+qrvkgNS
 OUPsaCuUjMUQRyI9ns98G8KjdU0tf5RFpFU=

--E9TiWqfOhOhoZiTknDyz
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 01fb4d3c39d35b725441e8a9a26b3f3ad67793ed upstream.
commit fd8d8e63467c922be9ae4452cca2980d473477d9 upstream squashed in.

OPP bindings (for few properties) allow a platform to choose a
value/range among a set of available options. The options are present as
opp-<prop>-<name>, where the platform needs to supply the <name> string.

The OPP properties which allow such an option are: opp-microvolt and
opp-microamp.

Add support to the OPP-core to parse these bindings, by introducing
dev_pm_opp_{set|put}_prop_name() APIs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[wens: Squashed in Bartlomiej Zolnierkiewicz's <b.zolnierkie@samsung.com>
       upstream commit fd8d8e63467c922be9ae4452cca2980d473477d9 to fix a =
bug]
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 165 ++++++++++++++++++++++++++++++----
 drivers/base/power/opp/opp.h  |   2 +
 include/linux/pm_opp.h        |   9 ++
 3 files changed, 161 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index a73433c3cbe45..504a6d4e46723 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -562,6 +562,9 @@ static void _remove_device_opp(struct device_opp *dev=
_opp)
 	if (dev_opp->supported_hw)
 		return;
=20
+	if (dev_opp->prop_name)
+		return;
+
 	list_dev =3D list_first_entry(&dev_opp->dev_list, struct device_list_op=
p,
 				    node);
=20
@@ -794,35 +797,48 @@ unlock:
 }
=20
 /* TODO: Support multiple regulators */
-static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev=
)
+static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev=
,
+			      struct device_opp *dev_opp)
 {
 	u32 microvolt[3] =3D {0};
 	u32 val;
 	int count, ret;
+	struct property *prop =3D NULL;
+	char name[NAME_MAX];
+
+	/* Search for "opp-microvolt-<name>" */
+	if (dev_opp->prop_name) {
+		sprintf(name, "opp-microvolt-%s", dev_opp->prop_name);
+		prop =3D of_find_property(opp->np, name, NULL);
+	}
+
+	if (!prop) {
+		/* Search for "opp-microvolt" */
+		sprintf(name, "opp-microvolt");
+		prop =3D of_find_property(opp->np, name, NULL);
=20
-	/* Missing property isn't a problem, but an invalid entry is */
-	if (!of_find_property(opp->np, "opp-microvolt", NULL))
-		return 0;
+		/* Missing property isn't a problem, but an invalid entry is */
+		if (!prop)
+			return 0;
+	}
=20
-	count =3D of_property_count_u32_elems(opp->np, "opp-microvolt");
+	count =3D of_property_count_u32_elems(opp->np, name);
 	if (count < 0) {
-		dev_err(dev, "%s: Invalid opp-microvolt property (%d)\n",
-			__func__, count);
+		dev_err(dev, "%s: Invalid %s property (%d)\n",
+			__func__, name, count);
 		return count;
 	}
=20
 	/* There can be one or three elements here */
 	if (count !=3D 1 && count !=3D 3) {
-		dev_err(dev, "%s: Invalid number of elements in opp-microvolt property=
 (%d)\n",
-			__func__, count);
+		dev_err(dev, "%s: Invalid number of elements in %s property (%d)\n",
+			__func__, name, count);
 		return -EINVAL;
 	}
=20
-	ret =3D of_property_read_u32_array(opp->np, "opp-microvolt", microvolt,
-					 count);
+	ret =3D of_property_read_u32_array(opp->np, name, microvolt, count);
 	if (ret) {
-		dev_err(dev, "%s: error parsing opp-microvolt: %d\n", __func__,
-			ret);
+		dev_err(dev, "%s: error parsing %s: %d\n", __func__, name, ret);
 		return -EINVAL;
 	}
=20
@@ -836,7 +852,20 @@ static int opp_parse_supplies(struct dev_pm_opp *opp=
, struct device *dev)
 		opp->u_volt_max =3D microvolt[2];
 	}
=20
-	if (!of_property_read_u32(opp->np, "opp-microamp", &val))
+	/* Search for "opp-microamp-<name>" */
+	prop =3D NULL;
+	if (dev_opp->prop_name) {
+		sprintf(name, "opp-microamp-%s", dev_opp->prop_name);
+		prop =3D of_find_property(opp->np, name, NULL);
+	}
+
+	if (!prop) {
+		/* Search for "opp-microamp" */
+		sprintf(name, "opp-microamp");
+		prop =3D of_find_property(opp->np, name, NULL);
+	}
+
+	if (prop && !of_property_read_u32(opp->np, name, &val))
 		opp->u_amp =3D val;
=20
 	return 0;
@@ -954,6 +983,112 @@ unlock:
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
=20
+/**
+ * dev_pm_opp_set_prop_name() - Set prop-extn name
+ * @dev: Device for which the regulator has to be set.
+ * @name: name to postfix to properties.
+ *
+ * This is required only for the V2 bindings, and it enables a platform =
to
+ * specify the extn to be used for certain property names. The propertie=
s to
+ * which the extension will apply are opp-microvolt and opp-microamp. OP=
P core
+ * should postfix the property name with -<name> while looking for them.
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
+int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
+{
+	struct device_opp *dev_opp;
+	int ret =3D 0;
+
+	/* Hold our list modification lock here */
+	mutex_lock(&dev_opp_list_lock);
+
+	dev_opp =3D _add_device_opp(dev);
+	if (!dev_opp) {
+		ret =3D -ENOMEM;
+		goto unlock;
+	}
+
+	/* Make sure there are no concurrent readers while updating dev_opp */
+	WARN_ON(!list_empty(&dev_opp->opp_list));
+
+	/* Do we already have a prop-name associated with dev_opp? */
+	if (dev_opp->prop_name) {
+		dev_err(dev, "%s: Already have prop-name %s\n", __func__,
+			dev_opp->prop_name);
+		ret =3D -EBUSY;
+		goto err;
+	}
+
+	dev_opp->prop_name =3D kstrdup(name, GFP_KERNEL);
+	if (!dev_opp->prop_name) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
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
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
+
+/**
+ * dev_pm_opp_put_prop_name() - Releases resources blocked for prop-name
+ * @dev: Device for which the regulator has to be set.
+ *
+ * This is required only for the V2 bindings, and is called for a matchi=
ng
+ * dev_pm_opp_set_prop_name(). Until this is called, the device_opp stru=
cture
+ * will not be freed.
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
+void dev_pm_opp_put_prop_name(struct device *dev)
+{
+	struct device_opp *dev_opp;
+
+	/* Hold our list modification lock here */
+	mutex_lock(&dev_opp_list_lock);
+
+	/* Check for existing list for 'dev' first */
+	dev_opp =3D _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR(dev_opp));
+		goto unlock;
+	}
+
+	/* Make sure there are no concurrent readers while updating dev_opp */
+	WARN_ON(!list_empty(&dev_opp->opp_list));
+
+	if (!dev_opp->prop_name) {
+		dev_err(dev, "%s: Doesn't have a prop-name\n", __func__);
+		goto unlock;
+	}
+
+	kfree(dev_opp->prop_name);
+	dev_opp->prop_name =3D NULL;
+
+	/* Try freeing device_opp if this was the last blocking resource */
+	_remove_device_opp(dev_opp);
+
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
+
 static bool _opp_is_supported(struct device *dev, struct device_opp *dev=
_opp,
 			      struct device_node *np)
 {
@@ -1048,7 +1183,7 @@ static int _opp_add_static_v2(struct device *dev, s=
truct device_node *np)
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns =3D val;
=20
-	ret =3D opp_parse_supplies(new_opp, dev);
+	ret =3D opp_parse_supplies(new_opp, dev, dev_opp);
 	if (ret)
 		goto free_opp;
=20
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 70f4564a6ab9d..690638ef36ee5 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -131,6 +131,7 @@ struct device_list_opp {
  * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
+ * @prop_name: A name to postfix to many DT properties, while parsing th=
em.
  * @dentry:	debugfs dentry pointer of the real device directory (not lin=
ks).
  * @dentry_name: Name of the real dentry.
  *
@@ -157,6 +158,7 @@ struct device_opp {
=20
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
+	const char *prop_name;
=20
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 3a85110242f00..95403d2ccaf56 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -58,6 +58,8 @@ struct srcu_notifier_head *dev_pm_opp_get_notifier(stru=
ct device *dev);
 int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
 				unsigned int count);
 void dev_pm_opp_put_supported_hw(struct device *dev);
+int dev_pm_opp_set_prop_name(struct device *dev, const char *name);
+void dev_pm_opp_put_prop_name(struct device *dev);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *op=
p)
 {
@@ -142,6 +144,13 @@ static inline int dev_pm_opp_set_supported_hw(struct=
 device *dev,
=20
 static inline void dev_pm_opp_put_supported_hw(struct device *dev) {}
=20
+static inline int dev_pm_opp_set_prop_name(struct device *dev, const cha=
r *name)
+{
+	return -EINVAL;
+}
+
+static inline void dev_pm_opp_put_prop_name(struct device *dev) {}
+
 #endif		/* CONFIG_PM_OPP */
=20
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
--=20
2.27.0.rc0


--E9TiWqfOhOhoZiTknDyz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4781): https://lists.cip-project.org/g/cip-dev/message=
/4781
Mute This Topic: https://lists.cip-project.org/mt/74768068/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--E9TiWqfOhOhoZiTknDyz--
