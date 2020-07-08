Return-Path: <SRS0=didc=AT=lists.cip-project.org=bounce+64572+4892+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F677C433E0
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:30 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31F420720
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="fOLTPfBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31F420720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4892+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2mpHYY4521723xEgI7xnh7c3; Wed, 08 Jul 2020 08:46:27 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13601.1594223182727099817
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:23 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 47BFA60092; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 07/23] PM / OPP: Add dev_pm_opp_set_rate()
Date: Wed,  8 Jul 2020 23:45:38 +0800
Message-Id: <20200708154554.26450-8-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: o4cit29iehVGzEBhrSbvixYxx4520388AA=
Content-Type: multipart/mixed; boundary="vuuyKoCviCd5RaUs8Dvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223187;
 bh=g34fZObtNaiN1MAO5zwNmnsRfRhPFrbeCksOAqZ2Afo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=fOLTPfBdlx1gaMuPEI6zWcREP5lRcknA2q8XUcqt4g2fsS7SAAd+UOtCRvU0L/fyB1m
 zIr+WiHf0kK5x5EZQT5JgeJqDswBdcG3OUydexZFRlxXeKEViATUsuLgJnp1CDUwVtfE2
 L1HapscOJ2DcbP0Td/Jr5acQlreeJhgg4Jo=

--vuuyKoCviCd5RaUs8Dvy
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 6a0712f6f199e737aa5913d28ec4bd3a25de9660 upstream.

This adds a routine, dev_pm_opp_set_rate(), responsible for configuring
power-supply and clock source for an OPP.

The OPP is found by matching against the target_freq passed to the
routine. This shall replace similar code present in most of the OPP
users and help simplify them a lot.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 176 ++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h        |   6 ++
 2 files changed, 182 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index 4fd3a59060e30..91b4cc261d84a 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -529,6 +529,182 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struc=
t device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
=20
+/*
+ * The caller needs to ensure that device_opp (and hence the clk) isn't =
freed,
+ * while clk returned here is used.
+ */
+static struct clk *_get_opp_clk(struct device *dev)
+{
+	struct device_opp *dev_opp;
+	struct clk *clk;
+
+	rcu_read_lock();
+
+	dev_opp =3D _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
+		clk =3D ERR_CAST(dev_opp);
+		goto unlock;
+	}
+
+	clk =3D dev_opp->clk;
+	if (IS_ERR(clk))
+		dev_err(dev, "%s: No clock available for the device\n",
+			__func__);
+
+unlock:
+	rcu_read_unlock();
+	return clk;
+}
+
+static int _set_opp_voltage(struct device *dev, struct regulator *reg,
+			    unsigned long u_volt, unsigned long u_volt_min,
+			    unsigned long u_volt_max)
+{
+	int ret;
+
+	/* Regulator not available for device */
+	if (IS_ERR(reg)) {
+		dev_dbg(dev, "%s: regulator not available: %ld\n", __func__,
+			PTR_ERR(reg));
+		return 0;
+	}
+
+	dev_dbg(dev, "%s: voltages (mV): %lu %lu %lu\n", __func__, u_volt_min,
+		u_volt, u_volt_max);
+
+	ret =3D regulator_set_voltage_triplet(reg, u_volt_min, u_volt,
+					    u_volt_max);
+	if (ret)
+		dev_err(dev, "%s: failed to set voltage (%lu %lu %lu mV): %d\n",
+			__func__, u_volt_min, u_volt, u_volt_max, ret);
+
+	return ret;
+}
+
+/**
+ * dev_pm_opp_set_rate() - Configure new OPP based on frequency
+ * @dev:	 device for which we do this operation
+ * @target_freq: frequency to achieve
+ *
+ * This configures the power-supplies and clock source to the levels spe=
cified
+ * by the OPP corresponding to the target_freq.
+ *
+ * Locking: This function takes rcu_read_lock().
+ */
+int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
+{
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *old_opp, *opp;
+	struct regulator *reg;
+	struct clk *clk;
+	unsigned long freq, old_freq;
+	unsigned long u_volt, u_volt_min, u_volt_max;
+	unsigned long ou_volt, ou_volt_min, ou_volt_max;
+	int ret;
+
+	if (unlikely(!target_freq)) {
+		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
+			target_freq);
+		return -EINVAL;
+	}
+
+	clk =3D _get_opp_clk(dev);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	freq =3D clk_round_rate(clk, target_freq);
+	if ((long)freq <=3D 0)
+		freq =3D target_freq;
+
+	old_freq =3D clk_get_rate(clk);
+
+	/* Return early if nothing to do */
+	if (old_freq =3D=3D freq) {
+		dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do=
\n",
+			__func__, freq);
+		return 0;
+	}
+
+	rcu_read_lock();
+
+	dev_opp =3D _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
+		rcu_read_unlock();
+		return PTR_ERR(dev_opp);
+	}
+
+	old_opp =3D dev_pm_opp_find_freq_ceil(dev, &old_freq);
+	if (!IS_ERR(old_opp)) {
+		ou_volt =3D old_opp->u_volt;
+		ou_volt_min =3D old_opp->u_volt_min;
+		ou_volt_max =3D old_opp->u_volt_max;
+	} else {
+		dev_err(dev, "%s: failed to find current OPP for freq %lu (%ld)\n",
+			__func__, old_freq, PTR_ERR(old_opp));
+	}
+
+	opp =3D dev_pm_opp_find_freq_ceil(dev, &freq);
+	if (IS_ERR(opp)) {
+		ret =3D PTR_ERR(opp);
+		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
+			__func__, freq, ret);
+		rcu_read_unlock();
+		return ret;
+	}
+
+	u_volt =3D opp->u_volt;
+	u_volt_min =3D opp->u_volt_min;
+	u_volt_max =3D opp->u_volt_max;
+
+	reg =3D dev_opp->regulator;
+
+	rcu_read_unlock();
+
+	/* Scaling up? Scale voltage before frequency */
+	if (freq > old_freq) {
+		ret =3D _set_opp_voltage(dev, reg, u_volt, u_volt_min,
+				       u_volt_max);
+		if (ret)
+			goto restore_voltage;
+	}
+
+	/* Change frequency */
+
+	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n",
+		__func__, old_freq, freq);
+
+	ret =3D clk_set_rate(clk, freq);
+	if (ret) {
+		dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
+			ret);
+		goto restore_voltage;
+	}
+
+	/* Scaling down? Scale voltage after frequency */
+	if (freq < old_freq) {
+		ret =3D _set_opp_voltage(dev, reg, u_volt, u_volt_min,
+				       u_volt_max);
+		if (ret)
+			goto restore_freq;
+	}
+
+	return 0;
+
+restore_freq:
+	if (clk_set_rate(clk, old_freq))
+		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
+			__func__, old_freq);
+restore_voltage:
+	/* This shouldn't harm even if the voltages weren't updated earlier */
+	if (!IS_ERR(old_opp))
+		_set_opp_voltage(dev, reg, ou_volt, ou_volt_min, ou_volt_max);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
+
 /* List-dev Helpers */
 static void _kfree_list_dev_rcu(struct rcu_head *head)
 {
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 59da3d9e11ea3..cccaf4a29e9f0 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -64,6 +64,7 @@ int dev_pm_opp_set_prop_name(struct device *dev, const =
char *name);
 void dev_pm_opp_put_prop_name(struct device *dev);
 int dev_pm_opp_set_regulator(struct device *dev, const char *name);
 void dev_pm_opp_put_regulator(struct device *dev);
+int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *op=
p)
 {
@@ -172,6 +173,11 @@ static inline int dev_pm_opp_set_regulator(struct de=
vice *dev, const char *name)
=20
 static inline void dev_pm_opp_put_regulator(struct device *dev) {}
=20
+static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long =
target_freq)
+{
+	return -EINVAL;
+}
+
 #endif		/* CONFIG_PM_OPP */
=20
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
--=20
2.27.0


--vuuyKoCviCd5RaUs8Dvy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4892): https://lists.cip-project.org/g/cip-dev/message=
/4892
Mute This Topic: https://lists.cip-project.org/mt/75379084/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--vuuyKoCviCd5RaUs8Dvy--
