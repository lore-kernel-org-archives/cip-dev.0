Return-Path: <SRS0=wO3Z=AT=lists.cip-project.org=bounce+64572+4909+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E252C433E1
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2084207D0
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="qa8+/VTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2084207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4909+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3piUYY4521723x3JmLepPy9W; Wed, 08 Jul 2020 08:46:49 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web10.13563.1594223184560035164
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:25 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id B1A9660849; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 20/23] PM / OPP: Rename structures for clarity
Date: Wed,  8 Jul 2020 23:45:51 +0800
Message-Id: <20200708154554.26450-21-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zfdLa1asAAQ2OJm71PM6VXbnx4520388AA=
Content-Type: multipart/mixed; boundary="kS1u3eMUUsS48mDtPqwq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223209;
 bh=A/1SWBs9aWFdsRoNZLH70vAYA7zfCq/fqm/XrzhJK9w=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=qa8+/VTwyZPM8ssGCx9Sqfe+YpUGYJwOHyW+GC/NLs0ZOaaN9schXvutmzQsBf83w33
 0XM8E2a79XUa+Uf8/LRAebtwhACOQjc+WeO4CeOFdyxLjBY7+GLSkpNWKEKhG6DALDfzF
 m2c6TB4/1HukuNeWwZzPkGJdHqpnRpfRHJQ=

--kS1u3eMUUsS48mDtPqwq
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 2c2709dc6921c5d246b686521f932c73a20f428f upstream.

Stephen pointed out recently, that few structures always confuse him as
they aren't named properly. And this patch tries to address that:

Names are updated as:
- device_opp or dev_opp -> opp_table
- dev_opp_list -> opp_tables
- dev_opp_list_lock -> opp_table_lock
- device_list_opp -> opp_device (it was never a list, but a structure)
- list_dev -> opp_dev
- And similar changes in comments and function names as well.

This also fixes checkpatch warnings that were generated with this patch.

No functional changes.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[wens: adjusted message level to debug to match previous backported patch=
]
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c    | 752 ++++++++++++++++---------------
 drivers/base/power/opp/cpu.c     |  22 +-
 drivers/base/power/opp/debugfs.c |  85 ++--
 drivers/base/power/opp/opp.h     |  61 ++-
 4 files changed, 461 insertions(+), 459 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index ba574b814e30f..7fc3848df17f5 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -25,40 +25,40 @@
 #include "opp.h"
=20
 /*
- * The root of the list of all devices. All device_opp structures branch=
 off
- * from here, with each device_opp containing the list of opp it support=
s in
+ * The root of the list of all opp-tables. All opp_table structures bran=
ch off
+ * from here, with each opp_table containing the list of opps it support=
s in
  * various states of availability.
  */
-static LIST_HEAD(dev_opp_list);
+static LIST_HEAD(opp_tables);
 /* Lock to allow exclusive modification to the device and opp lists */
-DEFINE_MUTEX(dev_opp_list_lock);
+DEFINE_MUTEX(opp_table_lock);
=20
 #define opp_rcu_lockdep_assert()					\
 do {									\
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
-				!lockdep_is_held(&dev_opp_list_lock),	\
-			   "Missing rcu_read_lock() or "		\
-			   "dev_opp_list_lock protection");		\
+			 !lockdep_is_held(&opp_table_lock),		\
+			 "Missing rcu_read_lock() or "			\
+			 "opp_table_lock protection");			\
 } while (0)
=20
-static struct device_list_opp *_find_list_dev(const struct device *dev,
-					      struct device_opp *dev_opp)
+static struct opp_device *_find_opp_dev(const struct device *dev,
+					struct opp_table *opp_table)
 {
-	struct device_list_opp *list_dev;
+	struct opp_device *opp_dev;
=20
-	list_for_each_entry(list_dev, &dev_opp->dev_list, node)
-		if (list_dev->dev =3D=3D dev)
-			return list_dev;
+	list_for_each_entry(opp_dev, &opp_table->dev_list, node)
+		if (opp_dev->dev =3D=3D dev)
+			return opp_dev;
=20
 	return NULL;
 }
=20
-static struct device_opp *_managed_opp(const struct device_node *np)
+static struct opp_table *_managed_opp(const struct device_node *np)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
=20
-	list_for_each_entry_rcu(dev_opp, &dev_opp_list, node) {
-		if (dev_opp->np =3D=3D np) {
+	list_for_each_entry_rcu(opp_table, &opp_tables, node) {
+		if (opp_table->np =3D=3D np) {
 			/*
 			 * Multiple devices can point to the same OPP table and
 			 * so will have same node-pointer, np.
@@ -66,7 +66,7 @@ static struct device_opp *_managed_opp(const struct dev=
ice_node *np)
 			 * But the OPPs will be considered as shared only if the
 			 * OPP table contains a "opp-shared" property.
 			 */
-			return dev_opp->shared_opp ? dev_opp : NULL;
+			return opp_table->shared_opp ? opp_table : NULL;
 		}
 	}
=20
@@ -74,24 +74,24 @@ static struct device_opp *_managed_opp(const struct d=
evice_node *np)
 }
=20
 /**
- * _find_device_opp() - find device_opp struct using device pointer
- * @dev:	device pointer used to lookup device OPPs
+ * _find_opp_table() - find opp_table struct using device pointer
+ * @dev:	device pointer used to lookup OPP table
  *
- * Search list of device OPPs for one containing matching device. Does a=
 RCU
- * reader operation to grab the pointer needed.
+ * Search OPP table for one containing matching device. Does a RCU reade=
r
+ * operation to grab the pointer needed.
  *
- * Return: pointer to 'struct device_opp' if found, otherwise -ENODEV or
+ * Return: pointer to 'struct opp_table' if found, otherwise -ENODEV or
  * -EINVAL based on type of error.
  *
  * Locking: For readers, this function must be called under rcu_read_loc=
k().
- * device_opp is a RCU protected pointer, which means that device_opp is=
 valid
+ * opp_table is a RCU protected pointer, which means that opp_table is v=
alid
  * as long as we are under RCU lock.
  *
- * For Writers, this function must be called with dev_opp_list_lock held=
.
+ * For Writers, this function must be called with opp_table_lock held.
  */
-struct device_opp *_find_device_opp(struct device *dev)
+struct opp_table *_find_opp_table(struct device *dev)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
=20
 	opp_rcu_lockdep_assert();
=20
@@ -100,9 +100,9 @@ struct device_opp *_find_device_opp(struct device *de=
v)
 		return ERR_PTR(-EINVAL);
 	}
=20
-	list_for_each_entry_rcu(dev_opp, &dev_opp_list, node)
-		if (_find_list_dev(dev, dev_opp))
-			return dev_opp;
+	list_for_each_entry_rcu(opp_table, &opp_tables, node)
+		if (_find_opp_dev(dev, opp_table))
+			return opp_table;
=20
 	return ERR_PTR(-ENODEV);
 }
@@ -215,16 +215,16 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_is_turbo);
  */
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	unsigned long clock_latency_ns;
=20
 	rcu_read_lock();
=20
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp))
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table))
 		clock_latency_ns =3D 0;
 	else
-		clock_latency_ns =3D dev_opp->clock_latency_ns_max;
+		clock_latency_ns =3D opp_table->clock_latency_ns_max;
=20
 	rcu_read_unlock();
 	return clock_latency_ns;
@@ -241,7 +241,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
  */
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	struct dev_pm_opp *opp;
 	struct regulator *reg;
 	unsigned long latency_ns =3D 0;
@@ -250,13 +250,13 @@ unsigned long dev_pm_opp_get_max_volt_latency(struc=
t device *dev)
=20
 	rcu_read_lock();
=20
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
 		rcu_read_unlock();
 		return 0;
 	}
=20
-	reg =3D dev_opp->regulator;
+	reg =3D opp_table->regulator;
 	if (IS_ERR(reg)) {
 		/* Regulator may not be required for device */
 		if (reg)
@@ -266,7 +266,7 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct =
device *dev)
 		return 0;
 	}
=20
-	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
+	list_for_each_entry_rcu(opp, &opp_table->opp_list, node) {
 		if (!opp->available)
 			continue;
=20
@@ -279,7 +279,7 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct =
device *dev)
 	rcu_read_unlock();
=20
 	/*
-	 * The caller needs to ensure that dev_opp (and hence the regulator)
+	 * The caller needs to ensure that opp_table (and hence the regulator)
 	 * isn't freed, while we are executing this routine.
 	 */
 	ret =3D regulator_set_voltage_time(reg, min_uV, max_uV);
@@ -322,21 +322,21 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_transition_lat=
ency);
  */
 struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
=20
 	opp_rcu_lockdep_assert();
=20
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp) || !dev_opp->suspend_opp ||
-	    !dev_opp->suspend_opp->available)
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table) || !opp_table->suspend_opp ||
+	    !opp_table->suspend_opp->available)
 		return NULL;
=20
-	return dev_opp->suspend_opp;
+	return opp_table->suspend_opp;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp);
=20
 /**
- * dev_pm_opp_get_opp_count() - Get number of opps available in the opp =
list
+ * dev_pm_opp_get_opp_count() - Get number of opps available in the opp =
table
  * @dev:	device for which we do this operation
  *
  * Return: This function returns the number of available opps if there a=
re any,
@@ -346,21 +346,21 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp);
  */
 int dev_pm_opp_get_opp_count(struct device *dev)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	struct dev_pm_opp *temp_opp;
 	int count =3D 0;
=20
 	rcu_read_lock();
=20
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
-		count =3D PTR_ERR(dev_opp);
-		dev_dbg(dev, "%s: device OPP not found (%d)\n",
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		count =3D PTR_ERR(opp_table);
+		dev_dbg(dev, "%s: OPP table not found (%d)\n",
 			__func__, count);
 		goto out_unlock;
 	}
=20
-	list_for_each_entry_rcu(temp_opp, &dev_opp->opp_list, node) {
+	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available)
 			count++;
 	}
@@ -377,7 +377,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
  * @freq:		frequency to search for
  * @available:		true/false - match for available opp
  *
- * Return: Searches for exact match in the opp list and returns pointer =
to the
+ * Return: Searches for exact match in the opp table and returns pointer=
 to the
  * matching opp if found, else returns ERR_PTR in case of error and shou=
ld
  * be handled using IS_ERR. Error return values can be:
  * EINVAL:	for bad pointer
@@ -401,19 +401,20 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struc=
t device *dev,
 					      unsigned long freq,
 					      bool available)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	struct dev_pm_opp *temp_opp, *opp =3D ERR_PTR(-ERANGE);
=20
 	opp_rcu_lockdep_assert();
=20
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
-		int r =3D PTR_ERR(dev_opp);
-		dev_err(dev, "%s: device OPP not found (%d)\n", __func__, r);
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		int r =3D PTR_ERR(opp_table);
+
+		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
 		return ERR_PTR(r);
 	}
=20
-	list_for_each_entry_rcu(temp_opp, &dev_opp->opp_list, node) {
+	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available =3D=3D available &&
 				temp_opp->rate =3D=3D freq) {
 			opp =3D temp_opp;
@@ -449,7 +450,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	struct dev_pm_opp *temp_opp, *opp =3D ERR_PTR(-ERANGE);
=20
 	opp_rcu_lockdep_assert();
@@ -459,11 +460,11 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct=
 device *dev,
 		return ERR_PTR(-EINVAL);
 	}
=20
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp))
-		return ERR_CAST(dev_opp);
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return ERR_CAST(opp_table);
=20
-	list_for_each_entry_rcu(temp_opp, &dev_opp->opp_list, node) {
+	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available && temp_opp->rate >=3D *freq) {
 			opp =3D temp_opp;
 			*freq =3D opp->rate;
@@ -499,7 +500,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	struct dev_pm_opp *temp_opp, *opp =3D ERR_PTR(-ERANGE);
=20
 	opp_rcu_lockdep_assert();
@@ -509,11 +510,11 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struc=
t device *dev,
 		return ERR_PTR(-EINVAL);
 	}
=20
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp))
-		return ERR_CAST(dev_opp);
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return ERR_CAST(opp_table);
=20
-	list_for_each_entry_rcu(temp_opp, &dev_opp->opp_list, node) {
+	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available) {
 			/* go to the next node, before choosing prev */
 			if (temp_opp->rate > *freq)
@@ -530,24 +531,24 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struc=
t device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
=20
 /*
- * The caller needs to ensure that device_opp (and hence the clk) isn't =
freed,
+ * The caller needs to ensure that opp_table (and hence the clk) isn't f=
reed,
  * while clk returned here is used.
  */
 static struct clk *_get_opp_clk(struct device *dev)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	struct clk *clk;
=20
 	rcu_read_lock();
=20
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
-		clk =3D ERR_CAST(dev_opp);
+		clk =3D ERR_CAST(opp_table);
 		goto unlock;
 	}
=20
-	clk =3D dev_opp->clk;
+	clk =3D opp_table->clk;
 	if (IS_ERR(clk))
 		dev_err(dev, "%s: No clock available for the device\n",
 			__func__);
@@ -594,7 +595,7 @@ static int _set_opp_voltage(struct device *dev, struc=
t regulator *reg,
  */
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	struct dev_pm_opp *old_opp, *opp;
 	struct regulator *reg;
 	struct clk *clk;
@@ -628,11 +629,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigne=
d long target_freq)
=20
 	rcu_read_lock();
=20
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
 		rcu_read_unlock();
-		return PTR_ERR(dev_opp);
+		return PTR_ERR(opp_table);
 	}
=20
 	old_opp =3D dev_pm_opp_find_freq_ceil(dev, &old_freq);
@@ -658,7 +659,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned =
long target_freq)
 	u_volt_min =3D opp->u_volt_min;
 	u_volt_max =3D opp->u_volt_max;
=20
-	reg =3D dev_opp->regulator;
+	reg =3D opp_table->regulator;
=20
 	rcu_read_unlock();
=20
@@ -705,81 +706,81 @@ restore_voltage:
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
=20
-/* List-dev Helpers */
-static void _kfree_list_dev_rcu(struct rcu_head *head)
+/* OPP-dev Helpers */
+static void _kfree_opp_dev_rcu(struct rcu_head *head)
 {
-	struct device_list_opp *list_dev;
+	struct opp_device *opp_dev;
=20
-	list_dev =3D container_of(head, struct device_list_opp, rcu_head);
-	kfree_rcu(list_dev, rcu_head);
+	opp_dev =3D container_of(head, struct opp_device, rcu_head);
+	kfree_rcu(opp_dev, rcu_head);
 }
=20
-static void _remove_list_dev(struct device_list_opp *list_dev,
-			     struct device_opp *dev_opp)
+static void _remove_opp_dev(struct opp_device *opp_dev,
+			    struct opp_table *opp_table)
 {
-	opp_debug_unregister(list_dev, dev_opp);
-	list_del(&list_dev->node);
-	call_srcu(&dev_opp->srcu_head.srcu, &list_dev->rcu_head,
-		  _kfree_list_dev_rcu);
+	opp_debug_unregister(opp_dev, opp_table);
+	list_del(&opp_dev->node);
+	call_srcu(&opp_table->srcu_head.srcu, &opp_dev->rcu_head,
+		  _kfree_opp_dev_rcu);
 }
=20
-struct device_list_opp *_add_list_dev(const struct device *dev,
-				      struct device_opp *dev_opp)
+struct opp_device *_add_opp_dev(const struct device *dev,
+				struct opp_table *opp_table)
 {
-	struct device_list_opp *list_dev;
+	struct opp_device *opp_dev;
 	int ret;
=20
-	list_dev =3D kzalloc(sizeof(*list_dev), GFP_KERNEL);
-	if (!list_dev)
+	opp_dev =3D kzalloc(sizeof(*opp_dev), GFP_KERNEL);
+	if (!opp_dev)
 		return NULL;
=20
-	/* Initialize list-dev */
-	list_dev->dev =3D dev;
-	list_add_rcu(&list_dev->node, &dev_opp->dev_list);
+	/* Initialize opp-dev */
+	opp_dev->dev =3D dev;
+	list_add_rcu(&opp_dev->node, &opp_table->dev_list);
=20
-	/* Create debugfs entries for the dev_opp */
-	ret =3D opp_debug_register(list_dev, dev_opp);
+	/* Create debugfs entries for the opp_table */
+	ret =3D opp_debug_register(opp_dev, opp_table);
 	if (ret)
 		dev_err(dev, "%s: Failed to register opp debugfs (%d)\n",
 			__func__, ret);
=20
-	return list_dev;
+	return opp_dev;
 }
=20
 /**
- * _add_device_opp() - Find device OPP table or allocate a new one
+ * _add_opp_table() - Find OPP table or allocate a new one
  * @dev:	device for which we do this operation
  *
  * It tries to find an existing table first, if it couldn't find one, it
  * allocates a new OPP table and returns that.
  *
- * Return: valid device_opp pointer if success, else NULL.
+ * Return: valid opp_table pointer if success, else NULL.
  */
-static struct device_opp *_add_device_opp(struct device *dev)
+static struct opp_table *_add_opp_table(struct device *dev)
 {
-	struct device_opp *dev_opp;
-	struct device_list_opp *list_dev;
+	struct opp_table *opp_table;
+	struct opp_device *opp_dev;
 	struct device_node *np;
 	int ret;
=20
-	/* Check for existing list for 'dev' first */
-	dev_opp =3D _find_device_opp(dev);
-	if (!IS_ERR(dev_opp))
-		return dev_opp;
+	/* Check for existing table for 'dev' first */
+	opp_table =3D _find_opp_table(dev);
+	if (!IS_ERR(opp_table))
+		return opp_table;
=20
 	/*
-	 * Allocate a new device OPP table. In the infrequent case where a new
+	 * Allocate a new OPP table. In the infrequent case where a new
 	 * device is needed to be added, we pay this penalty.
 	 */
-	dev_opp =3D kzalloc(sizeof(*dev_opp), GFP_KERNEL);
-	if (!dev_opp)
+	opp_table =3D kzalloc(sizeof(*opp_table), GFP_KERNEL);
+	if (!opp_table)
 		return NULL;
=20
-	INIT_LIST_HEAD(&dev_opp->dev_list);
+	INIT_LIST_HEAD(&opp_table->dev_list);
=20
-	list_dev =3D _add_list_dev(dev, dev_opp);
-	if (!list_dev) {
-		kfree(dev_opp);
+	opp_dev =3D _add_opp_dev(dev, opp_table);
+	if (!opp_dev) {
+		kfree(opp_table);
 		return NULL;
 	}
=20
@@ -792,79 +793,80 @@ static struct device_opp *_add_device_opp(struct de=
vice *dev)
 		u32 val;
=20
 		if (!of_property_read_u32(np, "clock-latency", &val))
-			dev_opp->clock_latency_ns_max =3D val;
+			opp_table->clock_latency_ns_max =3D val;
 		of_property_read_u32(np, "voltage-tolerance",
-				     &dev_opp->voltage_tolerance_v1);
+				     &opp_table->voltage_tolerance_v1);
 		of_node_put(np);
 	}
=20
 	/* Set regulator to a non-NULL error value */
-	dev_opp->regulator =3D ERR_PTR(-ENXIO);
+	opp_table->regulator =3D ERR_PTR(-ENXIO);
=20
 	/* Find clk for the device */
-	dev_opp->clk =3D clk_get(dev, NULL);
-	if (IS_ERR(dev_opp->clk)) {
-		ret =3D PTR_ERR(dev_opp->clk);
+	opp_table->clk =3D clk_get(dev, NULL);
+	if (IS_ERR(opp_table->clk)) {
+		ret =3D PTR_ERR(opp_table->clk);
 		if (ret !=3D -EPROBE_DEFER)
 			dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__,
 				ret);
 	}
=20
-	srcu_init_notifier_head(&dev_opp->srcu_head);
-	INIT_LIST_HEAD(&dev_opp->opp_list);
+	srcu_init_notifier_head(&opp_table->srcu_head);
+	INIT_LIST_HEAD(&opp_table->opp_list);
=20
-	/* Secure the device list modification */
-	list_add_rcu(&dev_opp->node, &dev_opp_list);
-	return dev_opp;
+	/* Secure the device table modification */
+	list_add_rcu(&opp_table->node, &opp_tables);
+	return opp_table;
 }
=20
 /**
- * _kfree_device_rcu() - Free device_opp RCU handler
+ * _kfree_device_rcu() - Free opp_table RCU handler
  * @head:	RCU head
  */
 static void _kfree_device_rcu(struct rcu_head *head)
 {
-	struct device_opp *device_opp =3D container_of(head, struct device_opp,=
 rcu_head);
+	struct opp_table *opp_table =3D container_of(head, struct opp_table,
+						   rcu_head);
=20
-	kfree_rcu(device_opp, rcu_head);
+	kfree_rcu(opp_table, rcu_head);
 }
=20
 /**
- * _remove_device_opp() - Removes a device OPP table
- * @dev_opp: device OPP table to be removed.
+ * _remove_opp_table() - Removes a OPP table
+ * @opp_table: OPP table to be removed.
  *
- * Removes/frees device OPP table it it doesn't contain any OPPs.
+ * Removes/frees OPP table if it doesn't contain any OPPs.
  */
-static void _remove_device_opp(struct device_opp *dev_opp)
+static void _remove_opp_table(struct opp_table *opp_table)
 {
-	struct device_list_opp *list_dev;
+	struct opp_device *opp_dev;
=20
-	if (!list_empty(&dev_opp->opp_list))
+	if (!list_empty(&opp_table->opp_list))
 		return;
=20
-	if (dev_opp->supported_hw)
+	if (opp_table->supported_hw)
 		return;
=20
-	if (dev_opp->prop_name)
+	if (opp_table->prop_name)
 		return;
=20
-	if (!IS_ERR(dev_opp->regulator))
+	if (!IS_ERR(opp_table->regulator))
 		return;
=20
 	/* Release clk */
-	if (!IS_ERR(dev_opp->clk))
-		clk_put(dev_opp->clk);
+	if (!IS_ERR(opp_table->clk))
+		clk_put(opp_table->clk);
=20
-	list_dev =3D list_first_entry(&dev_opp->dev_list, struct device_list_op=
p,
-				    node);
+	opp_dev =3D list_first_entry(&opp_table->dev_list, struct opp_device,
+				   node);
=20
-	_remove_list_dev(list_dev, dev_opp);
+	_remove_opp_dev(opp_dev, opp_table);
=20
 	/* dev_list must be empty now */
-	WARN_ON(!list_empty(&dev_opp->dev_list));
+	WARN_ON(!list_empty(&opp_table->dev_list));
=20
-	list_del_rcu(&dev_opp->node);
-	call_srcu(&dev_opp->srcu_head.srcu, &dev_opp->rcu_head,
+	list_del_rcu(&opp_table->node);
+	call_srcu(&opp_table->srcu_head.srcu, &opp_table->rcu_head,
 		  _kfree_device_rcu);
 }
=20
@@ -881,17 +883,17 @@ static void _kfree_opp_rcu(struct rcu_head *head)
=20
 /**
  * _opp_remove()  - Remove an OPP from a table definition
- * @dev_opp:	points back to the device_opp struct this opp belongs to
+ * @opp_table:	points back to the opp_table struct this opp belongs to
  * @opp:	pointer to the OPP to remove
  * @notify:	OPP_EVENT_REMOVE notification should be sent or not
  *
- * This function removes an opp definition from the opp list.
+ * This function removes an opp definition from the opp table.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * It is assumed that the caller holds required mutex for an RCU updater
  * strategy.
  */
-static void _opp_remove(struct device_opp *dev_opp,
+static void _opp_remove(struct opp_table *opp_table,
 			struct dev_pm_opp *opp, bool notify)
 {
 	/*
@@ -899,22 +901,23 @@ static void _opp_remove(struct device_opp *dev_opp,
 	 * frequency/voltage list.
 	 */
 	if (notify)
-		srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_REMOVE, opp);
+		srcu_notifier_call_chain(&opp_table->srcu_head,
+					 OPP_EVENT_REMOVE, opp);
 	opp_debug_remove_one(opp);
 	list_del_rcu(&opp->node);
-	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
+	call_srcu(&opp_table->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
=20
-	_remove_device_opp(dev_opp);
+	_remove_opp_table(opp_table);
 }
=20
 /**
- * dev_pm_opp_remove()  - Remove an OPP from OPP list
+ * dev_pm_opp_remove()  - Remove an OPP from OPP table
  * @dev:	device for which we do this operation
  * @freq:	OPP to remove with matching 'freq'
  *
- * This function removes an opp from the opp list.
+ * This function removes an opp from the opp table.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex l=
ocks
  * to keep the integrity of the internal data structures. Callers should=
 ensure
  * that this function is *NOT* called under RCU protection or in context=
s where
@@ -923,17 +926,17 @@ static void _opp_remove(struct device_opp *dev_opp,
 void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 {
 	struct dev_pm_opp *opp;
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	bool found =3D false;
=20
-	/* Hold our list modification lock here */
-	mutex_lock(&dev_opp_list_lock);
+	/* Hold our table modification lock here */
+	mutex_lock(&opp_table_lock);
=20
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp))
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table))
 		goto unlock;
=20
-	list_for_each_entry(opp, &dev_opp->opp_list, node) {
+	list_for_each_entry(opp, &opp_table->opp_list, node) {
 		if (opp->rate =3D=3D freq) {
 			found =3D true;
 			break;
@@ -946,14 +949,14 @@ void dev_pm_opp_remove(struct device *dev, unsigned=
 long freq)
 		goto unlock;
 	}
=20
-	_opp_remove(dev_opp, opp, true);
+	_opp_remove(opp_table, opp, true);
 unlock:
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
=20
 static struct dev_pm_opp *_allocate_opp(struct device *dev,
-					struct device_opp **dev_opp)
+					struct opp_table **opp_table)
 {
 	struct dev_pm_opp *opp;
=20
@@ -964,8 +967,8 @@ static struct dev_pm_opp *_allocate_opp(struct device=
 *dev,
=20
 	INIT_LIST_HEAD(&opp->node);
=20
-	*dev_opp =3D _add_device_opp(dev);
-	if (!*dev_opp) {
+	*opp_table =3D _add_opp_table(dev);
+	if (!*opp_table) {
 		kfree(opp);
 		return NULL;
 	}
@@ -974,9 +977,9 @@ static struct dev_pm_opp *_allocate_opp(struct device=
 *dev,
 }
=20
 static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
-					 struct device_opp *dev_opp)
+					 struct opp_table *opp_table)
 {
-	struct regulator *reg =3D dev_opp->regulator;
+	struct regulator *reg =3D opp_table->regulator;
=20
 	if (!IS_ERR(reg) &&
 	    !regulator_is_supported_voltage(reg, opp->u_volt_min,
@@ -990,21 +993,21 @@ static bool _opp_supported_by_regulators(struct dev=
_pm_opp *opp,
 }
=20
 static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
-		    struct device_opp *dev_opp)
+		    struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp;
-	struct list_head *head =3D &dev_opp->opp_list;
+	struct list_head *head =3D &opp_table->opp_list;
 	int ret;
=20
 	/*
 	 * Insert new OPP in order of increasing frequency and discard if
 	 * already present.
 	 *
-	 * Need to use &dev_opp->opp_list in the condition part of the 'for'
+	 * Need to use &opp_table->opp_list in the condition part of the 'for'
 	 * loop, don't replace it with head otherwise it will become an infinit=
e
 	 * loop.
 	 */
-	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
+	list_for_each_entry_rcu(opp, &opp_table->opp_list, node) {
 		if (new_opp->rate > opp->rate) {
 			head =3D &opp->node;
 			continue;
@@ -1022,15 +1025,15 @@ static int _opp_add(struct device *dev, struct de=
v_pm_opp *new_opp,
 			0 : -EEXIST;
 	}
=20
-	new_opp->dev_opp =3D dev_opp;
+	new_opp->opp_table =3D opp_table;
 	list_add_rcu(&new_opp->node, head);
=20
-	ret =3D opp_debug_create_one(new_opp, dev_opp);
+	ret =3D opp_debug_create_one(new_opp, opp_table);
 	if (ret)
 		dev_err(dev, "%s: Failed to register opp to debugfs (%d)\n",
 			__func__, ret);
=20
-	if (!_opp_supported_by_regulators(new_opp, dev_opp)) {
+	if (!_opp_supported_by_regulators(new_opp, opp_table)) {
 		new_opp->available =3D false;
 		dev_warn(dev, "%s: OPP not supported by regulators (%lu)\n",
 			 __func__, new_opp->rate);
@@ -1046,14 +1049,14 @@ static int _opp_add(struct device *dev, struct de=
v_pm_opp *new_opp,
  * @u_volt:	Voltage in uVolts for this OPP
  * @dynamic:	Dynamically added OPPs.
  *
- * This function adds an opp definition to the opp list and returns stat=
us.
+ * This function adds an opp definition to the opp table and returns sta=
tus.
  * The opp is made available by default and it can be controlled using
  * dev_pm_opp_enable/disable functions and may be removed by dev_pm_opp_=
remove.
  *
  * NOTE: "dynamic" parameter impacts OPPs added by the dev_pm_opp_of_add=
_table
  * and freed by dev_pm_opp_of_remove_table.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex l=
ocks
  * to keep the integrity of the internal data structures. Callers should=
 ensure
  * that this function is *NOT* called under RCU protection or in context=
s where
@@ -1069,15 +1072,15 @@ static int _opp_add(struct device *dev, struct de=
v_pm_opp *new_opp,
 static int _opp_add_v1(struct device *dev, unsigned long freq, long u_vo=
lt,
 		       bool dynamic)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	struct dev_pm_opp *new_opp;
 	unsigned long tol;
 	int ret;
=20
-	/* Hold our list modification lock here */
-	mutex_lock(&dev_opp_list_lock);
+	/* Hold our table modification lock here */
+	mutex_lock(&opp_table_lock);
=20
-	new_opp =3D _allocate_opp(dev, &dev_opp);
+	new_opp =3D _allocate_opp(dev, &opp_table);
 	if (!new_opp) {
 		ret =3D -ENOMEM;
 		goto unlock;
@@ -1085,36 +1088,36 @@ static int _opp_add_v1(struct device *dev, unsign=
ed long freq, long u_volt,
=20
 	/* populate the opp table */
 	new_opp->rate =3D freq;
-	tol =3D u_volt * dev_opp->voltage_tolerance_v1 / 100;
+	tol =3D u_volt * opp_table->voltage_tolerance_v1 / 100;
 	new_opp->u_volt =3D u_volt;
 	new_opp->u_volt_min =3D u_volt - tol;
 	new_opp->u_volt_max =3D u_volt + tol;
 	new_opp->available =3D true;
 	new_opp->dynamic =3D dynamic;
=20
-	ret =3D _opp_add(dev, new_opp, dev_opp);
+	ret =3D _opp_add(dev, new_opp, opp_table);
 	if (ret)
 		goto free_opp;
=20
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
=20
 	/*
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
 	 */
-	srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_ADD, new_opp);
+	srcu_notifier_call_chain(&opp_table->srcu_head, OPP_EVENT_ADD, new_opp)=
;
 	return 0;
=20
 free_opp:
-	_opp_remove(dev_opp, new_opp, false);
+	_opp_remove(opp_table, new_opp, false);
 unlock:
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
 	return ret;
 }
=20
 /* TODO: Support multiple regulators */
 static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev=
,
-			      struct device_opp *dev_opp)
+			      struct opp_table *opp_table)
 {
 	u32 microvolt[3] =3D {0};
 	u32 val;
@@ -1123,9 +1126,9 @@ static int opp_parse_supplies(struct dev_pm_opp *op=
p, struct device *dev,
 	char name[NAME_MAX];
=20
 	/* Search for "opp-microvolt-<name>" */
-	if (dev_opp->prop_name) {
+	if (opp_table->prop_name) {
 		snprintf(name, sizeof(name), "opp-microvolt-%s",
-			 dev_opp->prop_name);
+			 opp_table->prop_name);
 		prop =3D of_find_property(opp->np, name, NULL);
 	}
=20
@@ -1171,9 +1174,9 @@ static int opp_parse_supplies(struct dev_pm_opp *op=
p, struct device *dev,
=20
 	/* Search for "opp-microamp-<name>" */
 	prop =3D NULL;
-	if (dev_opp->prop_name) {
+	if (opp_table->prop_name) {
 		snprintf(name, sizeof(name), "opp-microamp-%s",
-			 dev_opp->prop_name);
+			 opp_table->prop_name);
 		prop =3D of_find_property(opp->np, name, NULL);
 	}
=20
@@ -1200,7 +1203,7 @@ static int opp_parse_supplies(struct dev_pm_opp *op=
p, struct device *dev,
  * OPPs, which are available for those versions, based on its 'opp-suppo=
rted-hw'
  * property.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex l=
ocks
  * to keep the integrity of the internal data structures. Callers should=
 ensure
  * that this function is *NOT* called under RCU protection or in context=
s where
@@ -1209,44 +1212,44 @@ static int opp_parse_supplies(struct dev_pm_opp *=
opp, struct device *dev,
 int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
 				unsigned int count)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	int ret =3D 0;
=20
-	/* Hold our list modification lock here */
-	mutex_lock(&dev_opp_list_lock);
+	/* Hold our table modification lock here */
+	mutex_lock(&opp_table_lock);
=20
-	dev_opp =3D _add_device_opp(dev);
-	if (!dev_opp) {
+	opp_table =3D _add_opp_table(dev);
+	if (!opp_table) {
 		ret =3D -ENOMEM;
 		goto unlock;
 	}
=20
-	/* Make sure there are no concurrent readers while updating dev_opp */
-	WARN_ON(!list_empty(&dev_opp->opp_list));
+	/* Make sure there are no concurrent readers while updating opp_table *=
/
+	WARN_ON(!list_empty(&opp_table->opp_list));
=20
-	/* Do we already have a version hierarchy associated with dev_opp? */
-	if (dev_opp->supported_hw) {
+	/* Do we already have a version hierarchy associated with opp_table? */
+	if (opp_table->supported_hw) {
 		dev_err(dev, "%s: Already have supported hardware list\n",
 			__func__);
 		ret =3D -EBUSY;
 		goto err;
 	}
=20
-	dev_opp->supported_hw =3D kmemdup(versions, count * sizeof(*versions),
+	opp_table->supported_hw =3D kmemdup(versions, count * sizeof(*versions)=
,
 					GFP_KERNEL);
-	if (!dev_opp->supported_hw) {
+	if (!opp_table->supported_hw) {
 		ret =3D -ENOMEM;
 		goto err;
 	}
=20
-	dev_opp->supported_hw_count =3D count;
-	mutex_unlock(&dev_opp_list_lock);
+	opp_table->supported_hw_count =3D count;
+	mutex_unlock(&opp_table_lock);
 	return 0;
=20
 err:
-	_remove_device_opp(dev_opp);
+	_remove_opp_table(opp_table);
 unlock:
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
=20
 	return ret;
 }
@@ -1257,10 +1260,10 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_supported_hw);
  * @dev: Device for which supported-hw has to be put.
  *
  * This is required only for the V2 bindings, and is called for a matchi=
ng
- * dev_pm_opp_set_supported_hw(). Until this is called, the device_opp s=
tructure
+ * dev_pm_opp_set_supported_hw(). Until this is called, the opp_table st=
ructure
  * will not be freed.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex l=
ocks
  * to keep the integrity of the internal data structures. Callers should=
 ensure
  * that this function is *NOT* called under RCU protection or in context=
s where
@@ -1268,36 +1271,37 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_supported_hw);
  */
 void dev_pm_opp_put_supported_hw(struct device *dev)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
=20
-	/* Hold our list modification lock here */
-	mutex_lock(&dev_opp_list_lock);
+	/* Hold our table modification lock here */
+	mutex_lock(&opp_table_lock);
=20
-	/* Check for existing list for 'dev' first */
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
-		dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR(dev_opp));
+	/* Check for existing table for 'dev' first */
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "Failed to find opp_table: %ld\n",
+			PTR_ERR(opp_table));
 		goto unlock;
 	}
=20
-	/* Make sure there are no concurrent readers while updating dev_opp */
-	WARN_ON(!list_empty(&dev_opp->opp_list));
+	/* Make sure there are no concurrent readers while updating opp_table *=
/
+	WARN_ON(!list_empty(&opp_table->opp_list));
=20
-	if (!dev_opp->supported_hw) {
+	if (!opp_table->supported_hw) {
 		dev_err(dev, "%s: Doesn't have supported hardware list\n",
 			__func__);
 		goto unlock;
 	}
=20
-	kfree(dev_opp->supported_hw);
-	dev_opp->supported_hw =3D NULL;
-	dev_opp->supported_hw_count =3D 0;
+	kfree(opp_table->supported_hw);
+	opp_table->supported_hw =3D NULL;
+	opp_table->supported_hw_count =3D 0;
=20
-	/* Try freeing device_opp if this was the last blocking resource */
-	_remove_device_opp(dev_opp);
+	/* Try freeing opp_table if this was the last blocking resource */
+	_remove_opp_table(opp_table);
=20
 unlock:
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
=20
@@ -1311,7 +1315,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
  * which the extension will apply are opp-microvolt and opp-microamp. OP=
P core
  * should postfix the property name with -<name> while looking for them.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex l=
ocks
  * to keep the integrity of the internal data structures. Callers should=
 ensure
  * that this function is *NOT* called under RCU protection or in context=
s where
@@ -1319,42 +1323,42 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
  */
 int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	int ret =3D 0;
=20
-	/* Hold our list modification lock here */
-	mutex_lock(&dev_opp_list_lock);
+	/* Hold our table modification lock here */
+	mutex_lock(&opp_table_lock);
=20
-	dev_opp =3D _add_device_opp(dev);
-	if (!dev_opp) {
+	opp_table =3D _add_opp_table(dev);
+	if (!opp_table) {
 		ret =3D -ENOMEM;
 		goto unlock;
 	}
=20
-	/* Make sure there are no concurrent readers while updating dev_opp */
-	WARN_ON(!list_empty(&dev_opp->opp_list));
+	/* Make sure there are no concurrent readers while updating opp_table *=
/
+	WARN_ON(!list_empty(&opp_table->opp_list));
=20
-	/* Do we already have a prop-name associated with dev_opp? */
-	if (dev_opp->prop_name) {
+	/* Do we already have a prop-name associated with opp_table? */
+	if (opp_table->prop_name) {
 		dev_err(dev, "%s: Already have prop-name %s\n", __func__,
-			dev_opp->prop_name);
+			opp_table->prop_name);
 		ret =3D -EBUSY;
 		goto err;
 	}
=20
-	dev_opp->prop_name =3D kstrdup(name, GFP_KERNEL);
-	if (!dev_opp->prop_name) {
+	opp_table->prop_name =3D kstrdup(name, GFP_KERNEL);
+	if (!opp_table->prop_name) {
 		ret =3D -ENOMEM;
 		goto err;
 	}
=20
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
 	return 0;
=20
 err:
-	_remove_device_opp(dev_opp);
+	_remove_opp_table(opp_table);
 unlock:
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
=20
 	return ret;
 }
@@ -1365,10 +1369,10 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
  * @dev: Device for which the prop-name has to be put.
  *
  * This is required only for the V2 bindings, and is called for a matchi=
ng
- * dev_pm_opp_set_prop_name(). Until this is called, the device_opp stru=
cture
+ * dev_pm_opp_set_prop_name(). Until this is called, the opp_table struc=
ture
  * will not be freed.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex l=
ocks
  * to keep the integrity of the internal data structures. Callers should=
 ensure
  * that this function is *NOT* called under RCU protection or in context=
s where
@@ -1376,34 +1380,35 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
  */
 void dev_pm_opp_put_prop_name(struct device *dev)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
=20
-	/* Hold our list modification lock here */
-	mutex_lock(&dev_opp_list_lock);
+	/* Hold our table modification lock here */
+	mutex_lock(&opp_table_lock);
=20
-	/* Check for existing list for 'dev' first */
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
-		dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR(dev_opp));
+	/* Check for existing table for 'dev' first */
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "Failed to find opp_table: %ld\n",
+			PTR_ERR(opp_table));
 		goto unlock;
 	}
=20
-	/* Make sure there are no concurrent readers while updating dev_opp */
-	WARN_ON(!list_empty(&dev_opp->opp_list));
+	/* Make sure there are no concurrent readers while updating opp_table *=
/
+	WARN_ON(!list_empty(&opp_table->opp_list));
=20
-	if (!dev_opp->prop_name) {
+	if (!opp_table->prop_name) {
 		dev_err(dev, "%s: Doesn't have a prop-name\n", __func__);
 		goto unlock;
 	}
=20
-	kfree(dev_opp->prop_name);
-	dev_opp->prop_name =3D NULL;
+	kfree(opp_table->prop_name);
+	opp_table->prop_name =3D NULL;
=20
-	/* Try freeing device_opp if this was the last blocking resource */
-	_remove_device_opp(dev_opp);
+	/* Try freeing opp_table if this was the last blocking resource */
+	_remove_opp_table(opp_table);
=20
 unlock:
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
=20
@@ -1417,7 +1422,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
  *
  * This must be called before any OPPs are initialized for the device.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex l=
ocks
  * to keep the integrity of the internal data structures. Callers should=
 ensure
  * that this function is *NOT* called under RCU protection or in context=
s where
@@ -1425,26 +1430,26 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
  */
 int dev_pm_opp_set_regulator(struct device *dev, const char *name)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	struct regulator *reg;
 	int ret;
=20
-	mutex_lock(&dev_opp_list_lock);
+	mutex_lock(&opp_table_lock);
=20
-	dev_opp =3D _add_device_opp(dev);
-	if (!dev_opp) {
+	opp_table =3D _add_opp_table(dev);
+	if (!opp_table) {
 		ret =3D -ENOMEM;
 		goto unlock;
 	}
=20
 	/* This should be called before OPPs are initialized */
-	if (WARN_ON(!list_empty(&dev_opp->opp_list))) {
+	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
 		ret =3D -EBUSY;
 		goto err;
 	}
=20
 	/* Already have a regulator set */
-	if (WARN_ON(!IS_ERR(dev_opp->regulator))) {
+	if (WARN_ON(!IS_ERR(opp_table->regulator))) {
 		ret =3D -EBUSY;
 		goto err;
 	}
@@ -1458,15 +1463,15 @@ int dev_pm_opp_set_regulator(struct device *dev, =
const char *name)
 		goto err;
 	}
=20
-	dev_opp->regulator =3D reg;
+	opp_table->regulator =3D reg;
=20
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
 	return 0;
=20
 err:
-	_remove_device_opp(dev_opp);
+	_remove_opp_table(opp_table);
 unlock:
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
=20
 	return ret;
 }
@@ -1476,7 +1481,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulator);
  * dev_pm_opp_put_regulator() - Releases resources blocked for regulator
  * @dev: Device for which regulator was set.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex l=
ocks
  * to keep the integrity of the internal data structures. Callers should=
 ensure
  * that this function is *NOT* called under RCU protection or in context=
s where
@@ -1484,44 +1489,45 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulator);
  */
 void dev_pm_opp_put_regulator(struct device *dev)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
=20
-	mutex_lock(&dev_opp_list_lock);
+	mutex_lock(&opp_table_lock);
=20
-	/* Check for existing list for 'dev' first */
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
-		dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR(dev_opp));
+	/* Check for existing table for 'dev' first */
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "Failed to find opp_table: %ld\n",
+			PTR_ERR(opp_table));
 		goto unlock;
 	}
=20
-	if (IS_ERR(dev_opp->regulator)) {
+	if (IS_ERR(opp_table->regulator)) {
 		dev_err(dev, "%s: Doesn't have regulator set\n", __func__);
 		goto unlock;
 	}
=20
-	/* Make sure there are no concurrent readers while updating dev_opp */
-	WARN_ON(!list_empty(&dev_opp->opp_list));
+	/* Make sure there are no concurrent readers while updating opp_table *=
/
+	WARN_ON(!list_empty(&opp_table->opp_list));
=20
-	regulator_put(dev_opp->regulator);
-	dev_opp->regulator =3D ERR_PTR(-ENXIO);
+	regulator_put(opp_table->regulator);
+	opp_table->regulator =3D ERR_PTR(-ENXIO);
=20
-	/* Try freeing device_opp if this was the last blocking resource */
-	_remove_device_opp(dev_opp);
+	/* Try freeing opp_table if this was the last blocking resource */
+	_remove_opp_table(opp_table);
=20
 unlock:
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulator);
=20
-static bool _opp_is_supported(struct device *dev, struct device_opp *dev=
_opp,
+static bool _opp_is_supported(struct device *dev, struct opp_table *opp_=
table,
 			      struct device_node *np)
 {
-	unsigned int count =3D dev_opp->supported_hw_count;
+	unsigned int count =3D opp_table->supported_hw_count;
 	u32 version;
 	int ret;
=20
-	if (!dev_opp->supported_hw)
+	if (!opp_table->supported_hw)
 		return true;
=20
 	while (count--) {
@@ -1534,7 +1540,7 @@ static bool _opp_is_supported(struct device *dev, s=
truct device_opp *dev_opp,
 		}
=20
 		/* Both of these are bitwise masks of the versions */
-		if (!(version & dev_opp->supported_hw[count]))
+		if (!(version & opp_table->supported_hw[count]))
 			return false;
 	}
=20
@@ -1546,11 +1552,11 @@ static bool _opp_is_supported(struct device *dev,=
 struct device_opp *dev_opp,
  * @dev:	device for which we do this operation
  * @np:		device node
  *
- * This function adds an opp definition to the opp list and returns stat=
us. The
+ * This function adds an opp definition to the opp table and returns sta=
tus. The
  * opp can be controlled using dev_pm_opp_enable/disable functions and m=
ay be
  * removed by dev_pm_opp_remove.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex l=
ocks
  * to keep the integrity of the internal data structures. Callers should=
 ensure
  * that this function is *NOT* called under RCU protection or in context=
s where
@@ -1566,16 +1572,16 @@ static bool _opp_is_supported(struct device *dev,=
 struct device_opp *dev_opp,
  */
 static int _opp_add_static_v2(struct device *dev, struct device_node *np=
)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	struct dev_pm_opp *new_opp;
 	u64 rate;
 	u32 val;
 	int ret;
=20
-	/* Hold our list modification lock here */
-	mutex_lock(&dev_opp_list_lock);
+	/* Hold our table modification lock here */
+	mutex_lock(&opp_table_lock);
=20
-	new_opp =3D _allocate_opp(dev, &dev_opp);
+	new_opp =3D _allocate_opp(dev, &opp_table);
 	if (!new_opp) {
 		ret =3D -ENOMEM;
 		goto unlock;
@@ -1588,7 +1594,7 @@ static int _opp_add_static_v2(struct device *dev, s=
truct device_node *np)
 	}
=20
 	/* Check if the OPP supports hardware's hierarchy of versions or not */
-	if (!_opp_is_supported(dev, dev_opp, np)) {
+	if (!_opp_is_supported(dev, opp_table, np)) {
 		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
 		goto free_opp;
 	}
@@ -1608,30 +1614,30 @@ static int _opp_add_static_v2(struct device *dev,=
 struct device_node *np)
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns =3D val;
=20
-	ret =3D opp_parse_supplies(new_opp, dev, dev_opp);
+	ret =3D opp_parse_supplies(new_opp, dev, opp_table);
 	if (ret)
 		goto free_opp;
=20
-	ret =3D _opp_add(dev, new_opp, dev_opp);
+	ret =3D _opp_add(dev, new_opp, opp_table);
 	if (ret)
 		goto free_opp;
=20
 	/* OPP to select on device suspend */
 	if (of_property_read_bool(np, "opp-suspend")) {
-		if (dev_opp->suspend_opp) {
+		if (opp_table->suspend_opp) {
 			dev_warn(dev, "%s: Multiple suspend OPPs found (%lu %lu)\n",
-				 __func__, dev_opp->suspend_opp->rate,
+				 __func__, opp_table->suspend_opp->rate,
 				 new_opp->rate);
 		} else {
 			new_opp->suspend =3D true;
-			dev_opp->suspend_opp =3D new_opp;
+			opp_table->suspend_opp =3D new_opp;
 		}
 	}
=20
-	if (new_opp->clock_latency_ns > dev_opp->clock_latency_ns_max)
-		dev_opp->clock_latency_ns_max =3D new_opp->clock_latency_ns;
+	if (new_opp->clock_latency_ns > opp_table->clock_latency_ns_max)
+		opp_table->clock_latency_ns_max =3D new_opp->clock_latency_ns;
=20
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
=20
 	pr_debug("%s: turbo:%d rate:%lu uv:%lu uvmin:%lu uvmax:%lu latency:%lu\=
n",
 		 __func__, new_opp->turbo, new_opp->rate, new_opp->u_volt,
@@ -1642,13 +1648,13 @@ static int _opp_add_static_v2(struct device *dev,=
 struct device_node *np)
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
 	 */
-	srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_ADD, new_opp);
+	srcu_notifier_call_chain(&opp_table->srcu_head, OPP_EVENT_ADD, new_opp)=
;
 	return 0;
=20
 free_opp:
-	_opp_remove(dev_opp, new_opp, false);
+	_opp_remove(opp_table, new_opp, false);
 unlock:
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
 	return ret;
 }
=20
@@ -1658,11 +1664,11 @@ unlock:
  * @freq:	Frequency in Hz for this OPP
  * @u_volt:	Voltage in uVolts for this OPP
  *
- * This function adds an opp definition to the opp list and returns stat=
us.
+ * This function adds an opp definition to the opp table and returns sta=
tus.
  * The opp is made available by default and it can be controlled using
  * dev_pm_opp_enable/disable functions.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex l=
ocks
  * to keep the integrity of the internal data structures. Callers should=
 ensure
  * that this function is *NOT* called under RCU protection or in context=
s where
@@ -1694,7 +1700,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_add);
  * copy operation, returns 0 if no modification was done OR modification=
 was
  * successful.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex l=
ocks to
  * keep the integrity of the internal data structures. Callers should en=
sure
  * that this function is *NOT* called under RCU protection or in context=
s where
@@ -1703,7 +1709,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_add);
 static int _opp_set_availability(struct device *dev, unsigned long freq,
 				 bool availability_req)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	struct dev_pm_opp *new_opp, *tmp_opp, *opp =3D ERR_PTR(-ENODEV);
 	int r =3D 0;
=20
@@ -1712,18 +1718,18 @@ static int _opp_set_availability(struct device *d=
ev, unsigned long freq,
 	if (!new_opp)
 		return -ENOMEM;
=20
-	mutex_lock(&dev_opp_list_lock);
+	mutex_lock(&opp_table_lock);
=20
-	/* Find the device_opp */
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
-		r =3D PTR_ERR(dev_opp);
+	/* Find the opp_table */
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		r =3D PTR_ERR(opp_table);
 		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
 		goto unlock;
 	}
=20
 	/* Do we have the frequency? */
-	list_for_each_entry(tmp_opp, &dev_opp->opp_list, node) {
+	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
 		if (tmp_opp->rate =3D=3D freq) {
 			opp =3D tmp_opp;
 			break;
@@ -1744,21 +1750,21 @@ static int _opp_set_availability(struct device *d=
ev, unsigned long freq,
 	new_opp->available =3D availability_req;
=20
 	list_replace_rcu(&opp->node, &new_opp->node);
-	mutex_unlock(&dev_opp_list_lock);
-	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
+	mutex_unlock(&opp_table_lock);
+	call_srcu(&opp_table->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
=20
 	/* Notify the change of the OPP availability */
 	if (availability_req)
-		srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_ENABLE,
-					 new_opp);
+		srcu_notifier_call_chain(&opp_table->srcu_head,
+					 OPP_EVENT_ENABLE, new_opp);
 	else
-		srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_DISABLE,
-					 new_opp);
+		srcu_notifier_call_chain(&opp_table->srcu_head,
+					 OPP_EVENT_DISABLE, new_opp);
=20
 	return 0;
=20
 unlock:
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
 	kfree(new_opp);
 	return r;
 }
@@ -1772,7 +1778,7 @@ unlock:
  * corresponding error value. It is meant to be used for users an OPP av=
ailable
  * after being temporarily made unavailable with dev_pm_opp_disable.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function indirectly uses RCU and mutex locks to keep the
  * integrity of the internal data structures. Callers should ensure that
  * this function is *NOT* called under RCU protection or in contexts whe=
re
@@ -1798,7 +1804,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_enable);
  * control by users to make this OPP not available until the circumstanc=
es are
  * right to make it available again (with a call to dev_pm_opp_enable).
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function indirectly uses RCU and mutex locks to keep the
  * integrity of the internal data structures. Callers should ensure that
  * this function is *NOT* called under RCU protection or in contexts whe=
re
@@ -1816,26 +1822,26 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
=20
 /**
  * dev_pm_opp_get_notifier() - find notifier_head of the device with opp
- * @dev:	device pointer used to lookup device OPPs.
+ * @dev:	device pointer used to lookup OPP table.
  *
  * Return: pointer to  notifier head if found, otherwise -ENODEV or
  * -EINVAL based on type of error casted as pointer. value must be check=
ed
  *  with IS_ERR to determine valid pointer or error result.
  *
- * Locking: This function must be called under rcu_read_lock(). dev_opp =
is a RCU
- * protected pointer. The reason for the same is that the opp pointer wh=
ich is
- * returned will remain valid for use with opp_get_{voltage, freq} only =
while
+ * Locking: This function must be called under rcu_read_lock(). opp_tabl=
e is a
+ * RCU protected pointer. The reason for the same is that the opp pointe=
r which
+ * is returned will remain valid for use with opp_get_{voltage, freq} on=
ly while
  * under the locked area. The pointer returned must be used prior to unl=
ocking
  * with rcu_read_unlock() to maintain the integrity of the pointer.
  */
 struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev)
 {
-	struct device_opp *dev_opp =3D _find_device_opp(dev);
+	struct opp_table *opp_table =3D _find_opp_table(dev);
=20
-	if (IS_ERR(dev_opp))
-		return ERR_CAST(dev_opp); /* matching type */
+	if (IS_ERR(opp_table))
+		return ERR_CAST(opp_table); /* matching type */
=20
-	return &dev_opp->srcu_head;
+	return &opp_table->srcu_head;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
=20
@@ -1843,11 +1849,11 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
 /**
  * dev_pm_opp_of_remove_table() - Free OPP table entries created from st=
atic DT
  *				  entries
- * @dev:	device pointer used to lookup device OPPs.
+ * @dev:	device pointer used to lookup OPP table.
  *
  * Free OPPs created using static entries present in DT.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function indirectly uses RCU updater strategy with mutex l=
ocks
  * to keep the integrity of the internal data structures. Callers should=
 ensure
  * that this function is *NOT* called under RCU protection or in context=
s where
@@ -1855,38 +1861,38 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
  */
 void dev_pm_opp_of_remove_table(struct device *dev)
 {
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	struct dev_pm_opp *opp, *tmp;
=20
-	/* Hold our list modification lock here */
-	mutex_lock(&dev_opp_list_lock);
+	/* Hold our table modification lock here */
+	mutex_lock(&opp_table_lock);
=20
-	/* Check for existing list for 'dev' */
-	dev_opp =3D _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
-		int error =3D PTR_ERR(dev_opp);
+	/* Check for existing table for 'dev' */
+	opp_table =3D _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		int error =3D PTR_ERR(opp_table);
=20
 		if (error !=3D -ENODEV)
-			WARN(1, "%s: dev_opp: %d\n",
+			WARN(1, "%s: opp_table: %d\n",
 			     IS_ERR_OR_NULL(dev) ?
 					"Invalid device" : dev_name(dev),
 			     error);
 		goto unlock;
 	}
=20
-	/* Find if dev_opp manages a single device */
-	if (list_is_singular(&dev_opp->dev_list)) {
+	/* Find if opp_table manages a single device */
+	if (list_is_singular(&opp_table->dev_list)) {
 		/* Free static OPPs */
-		list_for_each_entry_safe(opp, tmp, &dev_opp->opp_list, node) {
+		list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
 			if (!opp->dynamic)
-				_opp_remove(dev_opp, opp, true);
+				_opp_remove(opp_table, opp, true);
 		}
 	} else {
-		_remove_list_dev(_find_list_dev(dev, dev_opp), dev_opp);
+		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
 	}
=20
 unlock:
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
=20
@@ -1907,22 +1913,22 @@ struct device_node *_of_get_opp_desc_node(struct =
device *dev)
 static int _of_add_opp_table_v2(struct device *dev, struct device_node *=
opp_np)
 {
 	struct device_node *np;
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	int ret =3D 0, count =3D 0;
=20
-	mutex_lock(&dev_opp_list_lock);
+	mutex_lock(&opp_table_lock);
=20
-	dev_opp =3D _managed_opp(opp_np);
-	if (dev_opp) {
+	opp_table =3D _managed_opp(opp_np);
+	if (opp_table) {
 		/* OPPs are already managed */
-		if (!_add_list_dev(dev, dev_opp))
+		if (!_add_opp_dev(dev, opp_table))
 			ret =3D -ENOMEM;
-		mutex_unlock(&dev_opp_list_lock);
+		mutex_unlock(&opp_table_lock);
 		return ret;
 	}
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
=20
-	/* We have opp-list node now, iterate over it and add OPPs */
+	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
 		count++;
=20
@@ -1939,19 +1945,19 @@ static int _of_add_opp_table_v2(struct device *de=
v, struct device_node *opp_np)
 	if (WARN_ON(!count))
 		return -ENOENT;
=20
-	mutex_lock(&dev_opp_list_lock);
+	mutex_lock(&opp_table_lock);
=20
-	dev_opp =3D _find_device_opp(dev);
-	if (WARN_ON(IS_ERR(dev_opp))) {
-		ret =3D PTR_ERR(dev_opp);
-		mutex_unlock(&dev_opp_list_lock);
+	opp_table =3D _find_opp_table(dev);
+	if (WARN_ON(IS_ERR(opp_table))) {
+		ret =3D PTR_ERR(opp_table);
+		mutex_unlock(&opp_table_lock);
 		goto free_table;
 	}
=20
-	dev_opp->np =3D opp_np;
-	dev_opp->shared_opp =3D of_property_read_bool(opp_np, "opp-shared");
+	opp_table->np =3D opp_np;
+	opp_table->shared_opp =3D of_property_read_bool(opp_np, "opp-shared");
=20
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
=20
 	return 0;
=20
@@ -1980,7 +1986,7 @@ static int _of_add_opp_table_v1(struct device *dev)
 	 */
 	nr =3D prop->length / sizeof(u32);
 	if (nr % 2) {
-		dev_err(dev, "%s: Invalid OPP list\n", __func__);
+		dev_err(dev, "%s: Invalid OPP table\n", __func__);
 		return -EINVAL;
 	}
=20
@@ -2000,11 +2006,11 @@ static int _of_add_opp_table_v1(struct device *de=
v)
=20
 /**
  * dev_pm_opp_of_add_table() - Initialize opp table from device tree
- * @dev:	device pointer used to lookup device OPPs.
+ * @dev:	device pointer used to lookup OPP table.
  *
  * Register the initial OPP table with the OPP library for given device.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function indirectly uses RCU updater strategy with mutex l=
ocks
  * to keep the integrity of the internal data structures. Callers should=
 ensure
  * that this function is *NOT* called under RCU protection or in context=
s where
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index a0db8b3575f38..6e27a3544e494 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -31,7 +31,7 @@
  * @table:	Cpufreq table returned back to caller
  *
  * Generate a cpufreq table for a provided device- this assumes that the
- * opp list is already initialized and ready for usage.
+ * opp table is already initialized and ready for usage.
  *
  * This function allocates required memory for the cpufreq table. It is
  * expected that the caller does the required maintenance such as freein=
g
@@ -44,7 +44,7 @@
  * WARNING: It is  important for the callers to ensure refreshing their =
copy of
  * the table if any of the mentioned functions have been invoked in the =
interim.
  *
- * Locking: The internal device_opp and opp structures are RCU protected=
.
+ * Locking: The internal opp_table and opp structures are RCU protected.
  * Since we just use the regular accessor functions to access the intern=
al data
  * structures, we use RCU read lock inside this function. As a result, u=
sers of
  * this function DONOT need to use explicit locks for invoking.
@@ -122,15 +122,15 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 /* Required only for V1 bindings, as v2 can manage it from DT itself */
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cp=
umask)
 {
-	struct device_list_opp *list_dev;
-	struct device_opp *dev_opp;
+	struct opp_device *opp_dev;
+	struct opp_table *opp_table;
 	struct device *dev;
 	int cpu, ret =3D 0;
=20
-	mutex_lock(&dev_opp_list_lock);
+	mutex_lock(&opp_table_lock);
=20
-	dev_opp =3D _find_device_opp(cpu_dev);
-	if (IS_ERR(dev_opp)) {
+	opp_table =3D _find_opp_table(cpu_dev);
+	if (IS_ERR(opp_table)) {
 		ret =3D -EINVAL;
 		goto unlock;
 	}
@@ -146,15 +146,15 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_=
dev, cpumask_var_t cpumask)
 			continue;
 		}
=20
-		list_dev =3D _add_list_dev(dev, dev_opp);
-		if (!list_dev) {
-			dev_err(dev, "%s: failed to add list-dev for cpu%d device\n",
+		opp_dev =3D _add_opp_dev(dev, opp_table);
+		if (!opp_dev) {
+			dev_err(dev, "%s: failed to add opp-dev for cpu%d device\n",
 				__func__, cpu);
 			continue;
 		}
 	}
 unlock:
-	mutex_unlock(&dev_opp_list_lock);
+	mutex_unlock(&opp_table_lock);
=20
 	return ret;
 }
diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/de=
bugfs.c
index ddfe4773e922a..ef1ae6b520427 100644
--- a/drivers/base/power/opp/debugfs.c
+++ b/drivers/base/power/opp/debugfs.c
@@ -34,9 +34,9 @@ void opp_debug_remove_one(struct dev_pm_opp *opp)
 	debugfs_remove_recursive(opp->dentry);
 }
=20
-int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_=
opp)
+int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_t=
able)
 {
-	struct dentry *pdentry =3D dev_opp->dentry;
+	struct dentry *pdentry =3D opp_table->dentry;
 	struct dentry *d;
 	char name[25];	/* 20 chars for 64 bit value + 5 (opp:\0) */
=20
@@ -83,52 +83,52 @@ int opp_debug_create_one(struct dev_pm_opp *opp, stru=
ct device_opp *dev_opp)
 	return 0;
 }
=20
-static int device_opp_debug_create_dir(struct device_list_opp *list_dev,
-				       struct device_opp *dev_opp)
+static int opp_list_debug_create_dir(struct opp_device *opp_dev,
+				     struct opp_table *opp_table)
 {
-	const struct device *dev =3D list_dev->dev;
+	const struct device *dev =3D opp_dev->dev;
 	struct dentry *d;
=20
-	opp_set_dev_name(dev, dev_opp->dentry_name);
+	opp_set_dev_name(dev, opp_table->dentry_name);
=20
 	/* Create device specific directory */
-	d =3D debugfs_create_dir(dev_opp->dentry_name, rootdir);
+	d =3D debugfs_create_dir(opp_table->dentry_name, rootdir);
 	if (!d) {
 		dev_err(dev, "%s: Failed to create debugfs dir\n", __func__);
 		return -ENOMEM;
 	}
=20
-	list_dev->dentry =3D d;
-	dev_opp->dentry =3D d;
+	opp_dev->dentry =3D d;
+	opp_table->dentry =3D d;
=20
 	return 0;
 }
=20
-static int device_opp_debug_create_link(struct device_list_opp *list_dev=
,
-					struct device_opp *dev_opp)
+static int opp_list_debug_create_link(struct opp_device *opp_dev,
+				      struct opp_table *opp_table)
 {
-	const struct device *dev =3D list_dev->dev;
+	const struct device *dev =3D opp_dev->dev;
 	char name[NAME_MAX];
 	struct dentry *d;
=20
-	opp_set_dev_name(list_dev->dev, name);
+	opp_set_dev_name(opp_dev->dev, name);
=20
 	/* Create device specific directory link */
-	d =3D debugfs_create_symlink(name, rootdir, dev_opp->dentry_name);
+	d =3D debugfs_create_symlink(name, rootdir, opp_table->dentry_name);
 	if (!d) {
 		dev_err(dev, "%s: Failed to create link\n", __func__);
 		return -ENOMEM;
 	}
=20
-	list_dev->dentry =3D d;
+	opp_dev->dentry =3D d;
=20
 	return 0;
 }
=20
 /**
  * opp_debug_register - add a device opp node to the debugfs 'opp' direc=
tory
- * @list_dev: list-dev pointer for device
- * @dev_opp: the device-opp being added
+ * @opp_dev: opp-dev pointer for device
+ * @opp_table: the device-opp being added
  *
  * Dynamically adds device specific directory in debugfs 'opp' directory=
. If the
  * device-opp is shared with other devices, then links will be created f=
or all
@@ -136,73 +136,72 @@ static int device_opp_debug_create_link(struct devi=
ce_list_opp *list_dev,
  *
  * Return: 0 on success, otherwise negative error.
  */
-int opp_debug_register(struct device_list_opp *list_dev,
-		       struct device_opp *dev_opp)
+int opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp=
_table)
 {
 	if (!rootdir) {
 		pr_debug("%s: Uninitialized rootdir\n", __func__);
 		return -EINVAL;
 	}
=20
-	if (dev_opp->dentry)
-		return device_opp_debug_create_link(list_dev, dev_opp);
+	if (opp_table->dentry)
+		return opp_list_debug_create_link(opp_dev, opp_table);
=20
-	return device_opp_debug_create_dir(list_dev, dev_opp);
+	return opp_list_debug_create_dir(opp_dev, opp_table);
 }
=20
-static void opp_migrate_dentry(struct device_list_opp *list_dev,
-			       struct device_opp *dev_opp)
+static void opp_migrate_dentry(struct opp_device *opp_dev,
+			       struct opp_table *opp_table)
 {
-	struct device_list_opp *new_dev;
+	struct opp_device *new_dev;
 	const struct device *dev;
 	struct dentry *dentry;
=20
-	/* Look for next list-dev */
-	list_for_each_entry(new_dev, &dev_opp->dev_list, node)
-		if (new_dev !=3D list_dev)
+	/* Look for next opp-dev */
+	list_for_each_entry(new_dev, &opp_table->dev_list, node)
+		if (new_dev !=3D opp_dev)
 			break;
=20
 	/* new_dev is guaranteed to be valid here */
 	dev =3D new_dev->dev;
 	debugfs_remove_recursive(new_dev->dentry);
=20
-	opp_set_dev_name(dev, dev_opp->dentry_name);
+	opp_set_dev_name(dev, opp_table->dentry_name);
=20
-	dentry =3D debugfs_rename(rootdir, list_dev->dentry, rootdir,
-				dev_opp->dentry_name);
+	dentry =3D debugfs_rename(rootdir, opp_dev->dentry, rootdir,
+				opp_table->dentry_name);
 	if (!dentry) {
 		dev_err(dev, "%s: Failed to rename link from: %s to %s\n",
-			__func__, dev_name(list_dev->dev), dev_name(dev));
+			__func__, dev_name(opp_dev->dev), dev_name(dev));
 		return;
 	}
=20
 	new_dev->dentry =3D dentry;
-	dev_opp->dentry =3D dentry;
+	opp_table->dentry =3D dentry;
 }
=20
 /**
  * opp_debug_unregister - remove a device opp node from debugfs opp dire=
ctory
- * @list_dev: list-dev pointer for device
- * @dev_opp: the device-opp being removed
+ * @opp_dev: opp-dev pointer for device
+ * @opp_table: the device-opp being removed
  *
  * Dynamically removes device specific directory from debugfs 'opp' dire=
ctory.
  */
-void opp_debug_unregister(struct device_list_opp *list_dev,
-			  struct device_opp *dev_opp)
+void opp_debug_unregister(struct opp_device *opp_dev,
+			  struct opp_table *opp_table)
 {
-	if (list_dev->dentry =3D=3D dev_opp->dentry) {
+	if (opp_dev->dentry =3D=3D opp_table->dentry) {
 		/* Move the real dentry object under another device */
-		if (!list_is_singular(&dev_opp->dev_list)) {
-			opp_migrate_dentry(list_dev, dev_opp);
+		if (!list_is_singular(&opp_table->dev_list)) {
+			opp_migrate_dentry(opp_dev, opp_table);
 			goto out;
 		}
-		dev_opp->dentry =3D NULL;
+		opp_table->dentry =3D NULL;
 	}
=20
-	debugfs_remove_recursive(list_dev->dentry);
+	debugfs_remove_recursive(opp_dev->dentry);
=20
 out:
-	list_dev->dentry =3D NULL;
+	opp_dev->dentry =3D NULL;
 }
=20
 static int __init opp_debug_init(void)
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 4f1bdfc7da03b..f67f806fcf3ae 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -26,12 +26,12 @@ struct clk;
 struct regulator;
=20
 /* Lock to allow exclusive modification to the device and opp lists */
-extern struct mutex dev_opp_list_lock;
+extern struct mutex opp_table_lock;
=20
 /*
  * Internal data structure organization with the OPP layer library is as
  * follows:
- * dev_opp_list (root)
+ * opp_tables (root)
  *	|- device 1 (represents voltage domain 1)
  *	|	|- opp 1 (availability, freq, voltage)
  *	|	|- opp 2 ..
@@ -40,18 +40,18 @@ extern struct mutex dev_opp_list_lock;
  *	|- device 2 (represents the next voltage domain)
  *	...
  *	`- device m (represents mth voltage domain)
- * device 1, 2.. are represented by dev_opp structure while each opp
+ * device 1, 2.. are represented by opp_table structure while each opp
  * is represented by the opp structure.
  */
=20
 /**
  * struct dev_pm_opp - Generic OPP description structure
- * @node:	opp list node. The nodes are maintained throughout the lifetim=
e
+ * @node:	opp table node. The nodes are maintained throughout the lifeti=
me
  *		of boot. It is expected only an optimal set of OPPs are
  *		added to the library by the SoC framework.
- *		RCU usage: opp list is traversed with RCU locks. node
+ *		RCU usage: opp table is traversed with RCU locks. node
  *		modification is possible realtime, hence the modifications
- *		are protected by the dev_opp_list_lock for integrity.
+ *		are protected by the opp_table_lock for integrity.
  *		IMPORTANT: the opp nodes should be maintained in increasing
  *		order.
  * @available:	true/false - marks if this OPP as available or not
@@ -65,7 +65,7 @@ extern struct mutex dev_opp_list_lock;
  * @u_amp:	Maximum current drawn by the device in microamperes
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP'=
s
  *		frequency from any other OPP's frequency.
- * @dev_opp:	points back to the device_opp struct this opp belongs to
+ * @opp_table:	points back to the opp_table struct this opp belongs to
  * @rcu_head:	RCU callback head used for deferred freeing
  * @np:		OPP's device node.
  * @dentry:	debugfs dentry pointer (per opp)
@@ -87,7 +87,7 @@ struct dev_pm_opp {
 	unsigned long u_amp;
 	unsigned long clock_latency_ns;
=20
-	struct device_opp *dev_opp;
+	struct opp_table *opp_table;
 	struct rcu_head rcu_head;
=20
 	struct device_node *np;
@@ -98,16 +98,16 @@ struct dev_pm_opp {
 };
=20
 /**
- * struct device_list_opp - devices managed by 'struct device_opp'
+ * struct opp_device - devices managed by 'struct opp_table'
  * @node:	list node
  * @dev:	device to which the struct object belongs
  * @rcu_head:	RCU callback head used for deferred freeing
  * @dentry:	debugfs dentry pointer (per device)
  *
- * This is an internal data structure maintaining the list of devices th=
at are
- * managed by 'struct device_opp'.
+ * This is an internal data structure maintaining the devices that are m=
anaged
+ * by 'struct opp_table'.
  */
-struct device_list_opp {
+struct opp_device {
 	struct list_head node;
 	const struct device *dev;
 	struct rcu_head rcu_head;
@@ -118,16 +118,16 @@ struct device_list_opp {
 };
=20
 /**
- * struct device_opp - Device opp structure
- * @node:	list node - contains the devices with OPPs that
+ * struct opp_table - Device opp structure
+ * @node:	table node - contains the devices with OPPs that
  *		have been registered. Nodes once added are not modified in this
- *		list.
- *		RCU usage: nodes are not modified in the list of device_opp,
- *		however addition is possible and is secured by dev_opp_list_lock
+ *		table.
+ *		RCU usage: nodes are not modified in the table of opp_table,
+ *		however addition is possible and is secured by opp_table_lock
  * @srcu_head:	notifier head to notify the OPP availability changes.
  * @rcu_head:	RCU callback head used for deferred freeing
  * @dev_list:	list of devices that share these OPPs
- * @opp_list:	list of opps
+ * @opp_list:	table of opps
  * @np:		struct device_node pointer for opp's DT node.
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @shared_opp: OPP is shared between multiple devices.
@@ -150,7 +150,7 @@ struct device_list_opp {
  * need to wait for the grace period of both of them before freeing any
  * resources. And so we have used kfree_rcu() from within call_srcu() ha=
ndlers.
  */
-struct device_opp {
+struct opp_table {
 	struct list_head node;
=20
 	struct srcu_notifier_head srcu_head;
@@ -180,30 +180,27 @@ struct device_opp {
 };
=20
 /* Routines internal to opp core */
-struct device_opp *_find_device_opp(struct device *dev);
-struct device_list_opp *_add_list_dev(const struct device *dev,
-				      struct device_opp *dev_opp);
+struct opp_table *_find_opp_table(struct device *dev);
+struct opp_device *_add_opp_dev(const struct device *dev, struct opp_tab=
le *opp_table);
 struct device_node *_of_get_opp_desc_node(struct device *dev);
=20
 #ifdef CONFIG_DEBUG_FS
 void opp_debug_remove_one(struct dev_pm_opp *opp);
-int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_=
opp);
-int opp_debug_register(struct device_list_opp *list_dev,
-		       struct device_opp *dev_opp);
-void opp_debug_unregister(struct device_list_opp *list_dev,
-			  struct device_opp *dev_opp);
+int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_t=
able);
+int opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp=
_table);
+void opp_debug_unregister(struct opp_device *opp_dev, struct opp_table *=
opp_table);
 #else
 static inline void opp_debug_remove_one(struct dev_pm_opp *opp) {}
=20
 static inline int opp_debug_create_one(struct dev_pm_opp *opp,
-				       struct device_opp *dev_opp)
+				       struct opp_table *opp_table)
 { return 0; }
-static inline int opp_debug_register(struct device_list_opp *list_dev,
-				     struct device_opp *dev_opp)
+static inline int opp_debug_register(struct opp_device *opp_dev,
+				     struct opp_table *opp_table)
 { return 0; }
=20
-static inline void opp_debug_unregister(struct device_list_opp *list_dev=
,
-					struct device_opp *dev_opp)
+static inline void opp_debug_unregister(struct opp_device *opp_dev,
+					struct opp_table *opp_table)
 { }
 #endif		/* DEBUG_FS */
=20
--=20
2.27.0


--kS1u3eMUUsS48mDtPqwq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4909): https://lists.cip-project.org/g/cip-dev/message=
/4909
Mute This Topic: https://lists.cip-project.org/mt/75379101/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--kS1u3eMUUsS48mDtPqwq--
