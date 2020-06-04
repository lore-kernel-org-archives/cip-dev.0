Return-Path: <SRS0=AaRI=7R=lists.cip-project.org=bounce+64572+4686+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE924C433EA
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 04:18:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791F02072E
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 04:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="t4tPK+QE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791F02072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4686+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4F03YY4521723xImUkbk335c; Wed, 03 Jun 2020 21:18:08 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web12.7087.1591244286511785375
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 21:18:06 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id A96CE5FF28; Thu,  4 Jun 2020 12:18:02 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH RESEND 4.4.y-cip 07/15] PM / OPP: Parse 'opp-supported-hw' binding
Date: Thu,  4 Jun 2020 12:17:37 +0800
Message-Id: <20200604041745.28886-8-wens@csie.org>
In-Reply-To: <20200604041745.28886-1-wens@csie.org>
References: <20200604041745.28886-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Hywq38Kf9GEBzT8lD2kXEx4Yx4520388AA=
Content-Type: multipart/mixed; boundary="WphzJowWfMVBGnRGda39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591244288;
 bh=JD4Z90MsIeShfrHhmwQsbJqTYor4lkVqv58crWQXl1M=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=t4tPK+QETUoCiNKAAxopkf0NDc3l196hPO1ilIQSCF6rvQIao37o/tf5XN1CySY4zUJ
 flJoxUfOlp3aF06RMXCYHJvG1Uxk/TJvPKissMzBz25YiFNivXRE1jKwlBrWc3810W0f9
 LPzlr5jvNOYap/Or9rdNIDiuTMf/f3J72wo=

--WphzJowWfMVBGnRGda39
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 7de36b0aa51a5a59e28fb2da768fa3ab07de0674 upstream.

OPP bindings allow a platform to enable OPPs based on the version of the
hardware they are used for.

Add support to the OPP-core to parse these bindings, by introducing
dev_pm_opp_{set|put}_supported_hw() APIs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 148 ++++++++++++++++++++++++++++++++++
 drivers/base/power/opp/opp.h  |   5 ++
 include/linux/pm_opp.h        |  13 +++
 3 files changed, 166 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index 22d91d9b1b037..a73433c3cbe45 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -559,6 +559,9 @@ static void _remove_device_opp(struct device_opp *dev=
_opp)
 	if (!list_empty(&dev_opp->opp_list))
 		return;
=20
+	if (dev_opp->supported_hw)
+		return;
+
 	list_dev =3D list_first_entry(&dev_opp->dev_list, struct device_list_op=
p,
 				    node);
=20
@@ -839,6 +842,145 @@ static int opp_parse_supplies(struct dev_pm_opp *op=
p, struct device *dev)
 	return 0;
 }
=20
+/**
+ * dev_pm_opp_set_supported_hw() - Set supported platforms
+ * @dev: Device for which supported-hw has to be set.
+ * @versions: Array of hierarchy of versions to match.
+ * @count: Number of elements in the array.
+ *
+ * This is required only for the V2 bindings, and it enables a platform =
to
+ * specify the hierarchy of versions it supports. OPP layer will then en=
able
+ * OPPs, which are available for those versions, based on its 'opp-suppo=
rted-hw'
+ * property.
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
+int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
+				unsigned int count)
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
+	/* Do we already have a version hierarchy associated with dev_opp? */
+	if (dev_opp->supported_hw) {
+		dev_err(dev, "%s: Already have supported hardware list\n",
+			__func__);
+		ret =3D -EBUSY;
+		goto err;
+	}
+
+	dev_opp->supported_hw =3D kmemdup(versions, count * sizeof(*versions),
+					GFP_KERNEL);
+	if (!dev_opp->supported_hw) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	dev_opp->supported_hw_count =3D count;
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
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_supported_hw);
+
+/**
+ * dev_pm_opp_put_supported_hw() - Releases resources blocked for suppor=
ted hw
+ * @dev: Device for which supported-hw has to be set.
+ *
+ * This is required only for the V2 bindings, and is called for a matchi=
ng
+ * dev_pm_opp_set_supported_hw(). Until this is called, the device_opp s=
tructure
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
+void dev_pm_opp_put_supported_hw(struct device *dev)
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
+	if (!dev_opp->supported_hw) {
+		dev_err(dev, "%s: Doesn't have supported hardware list\n",
+			__func__);
+		goto unlock;
+	}
+
+	kfree(dev_opp->supported_hw);
+	dev_opp->supported_hw =3D NULL;
+	dev_opp->supported_hw_count =3D 0;
+
+	/* Try freeing device_opp if this was the last blocking resource */
+	_remove_device_opp(dev_opp);
+
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
+
+static bool _opp_is_supported(struct device *dev, struct device_opp *dev=
_opp,
+			      struct device_node *np)
+{
+	unsigned int count =3D dev_opp->supported_hw_count;
+	u32 version;
+	int ret;
+
+	if (!dev_opp->supported_hw)
+		return true;
+
+	while (count--) {
+		ret =3D of_property_read_u32_index(np, "opp-supported-hw", count,
+						 &version);
+		if (ret) {
+			dev_warn(dev, "%s: failed to read opp-supported-hw property at index =
%d: %d\n",
+				 __func__, count, ret);
+			return false;
+		}
+
+		/* Both of these are bitwise masks of the versions */
+		if (!(version & dev_opp->supported_hw[count]))
+			return false;
+	}
+
+	return true;
+}
+
 /**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @dev:	device for which we do this operation
@@ -885,6 +1027,12 @@ static int _opp_add_static_v2(struct device *dev, s=
truct device_node *np)
 		goto free_opp;
 	}
=20
+	/* Check if the OPP supports hardware's hierarchy of versions or not */
+	if (!_opp_is_supported(dev, dev_opp, np)) {
+		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
+		goto free_opp;
+	}
+
 	/*
 	 * Rate is defined as an unsigned long in clk API, and so casting
 	 * explicitly to its type. Must be fixed once rate is 64 bit
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index b8880c7f8be1c..70f4564a6ab9d 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -129,6 +129,8 @@ struct device_list_opp {
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @shared_opp: OPP is shared between multiple devices.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
+ * @supported_hw: Array of version number to support.
+ * @supported_hw_count: Number of elements in supported_hw array.
  * @dentry:	debugfs dentry pointer of the real device directory (not lin=
ks).
  * @dentry_name: Name of the real dentry.
  *
@@ -153,6 +155,9 @@ struct device_opp {
 	bool shared_opp;
 	struct dev_pm_opp *suspend_opp;
=20
+	unsigned int *supported_hw;
+	unsigned int supported_hw_count;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	char dentry_name[NAME_MAX];
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 9a2e50337af9f..3a85110242f00 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -55,6 +55,9 @@ int dev_pm_opp_enable(struct device *dev, unsigned long=
 freq);
 int dev_pm_opp_disable(struct device *dev, unsigned long freq);
=20
 struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev);
+int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
+				unsigned int count);
+void dev_pm_opp_put_supported_hw(struct device *dev);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *op=
p)
 {
@@ -129,6 +132,16 @@ static inline struct srcu_notifier_head *dev_pm_opp_=
get_notifier(
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline int dev_pm_opp_set_supported_hw(struct device *dev,
+					      const u32 *versions,
+					      unsigned int count)
+{
+	return -EINVAL;
+}
+
+static inline void dev_pm_opp_put_supported_hw(struct device *dev) {}
+
 #endif		/* CONFIG_PM_OPP */
=20
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
--=20
2.27.0.rc0


--WphzJowWfMVBGnRGda39
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4686): https://lists.cip-project.org/g/cip-dev/message=
/4686
Mute This Topic: https://lists.cip-project.org/mt/74665639/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--WphzJowWfMVBGnRGda39--
