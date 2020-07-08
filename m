Return-Path: <SRS0=5iZW=AT=lists.cip-project.org=bounce+64572+4886+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F94C433E1
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:25 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8991206DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BIEMVmkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8991206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4886+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XeeTYY4521723xqsiiokgnzy; Wed, 08 Jul 2020 08:46:22 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13599.1594223180608308549
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:21 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 1E4E55FD2A; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 03/23] PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
Date: Wed,  8 Jul 2020 23:45:34 +0800
Message-Id: <20200708154554.26450-4-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kzN4LgywFvnGsZ0B2ZZ5tZIex4520388AA=
Content-Type: multipart/mixed; boundary="KFCS2dRqGugZdFIip9NC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223182;
 bh=7lS8CSPl3JO8oxFPZH9pI1qQ4mPIAjkHn52qKsVZfYU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BIEMVmkn8HssdWNlAedT9qYJNeON2h8mE4HC0V5cMmPGcv4QTHOfUIVnKC8AIyek+/f
 CKBukWiMTxFf9+d7mX+Q+Nv22hbGnpNZiecEdHf8v3r3/OCLwJxIJLdRPsycnvgS6505v
 obMcBDS7kuJChGyLs4NZaQ6OvCCwKkfXvlk=

--KFCS2dRqGugZdFIip9NC
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 655c9df961751ce21466f6e97e8033932c27a675 upstream.

In few use cases (like: cpufreq), it is desired to get the maximum
voltage latency for changing OPPs. Add support for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 59 +++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h        |  6 ++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index 48ec88befffc9..09165fbef84ed 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -230,6 +230,65 @@ unsigned long dev_pm_opp_get_max_clock_latency(struc=
t device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
=20
+/**
+ * dev_pm_opp_get_max_volt_latency() - Get max voltage latency in nanose=
conds
+ * @dev: device for which we do this operation
+ *
+ * Return: This function returns the max voltage latency in nanoseconds.
+ *
+ * Locking: This function takes rcu_read_lock().
+ */
+unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
+{
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *opp;
+	struct regulator *reg;
+	unsigned long latency_ns =3D 0;
+	unsigned long min_uV =3D ~0, max_uV =3D 0;
+	int ret;
+
+	rcu_read_lock();
+
+	dev_opp =3D _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	reg =3D dev_opp->regulator;
+	if (IS_ERR_OR_NULL(reg)) {
+		/* Regulator may not be required for device */
+		if (reg)
+			dev_err(dev, "%s: Invalid regulator (%ld)\n", __func__,
+				PTR_ERR(reg));
+		rcu_read_unlock();
+		return 0;
+	}
+
+	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
+		if (!opp->available)
+			continue;
+
+		if (opp->u_volt_min < min_uV)
+			min_uV =3D opp->u_volt_min;
+		if (opp->u_volt_max > max_uV)
+			max_uV =3D opp->u_volt_max;
+	}
+
+	rcu_read_unlock();
+
+	/*
+	 * The caller needs to ensure that dev_opp (and hence the regulator)
+	 * isn't freed, while we are executing this routine.
+	 */
+	ret =3D regulator_set_voltage_time(reg, min_uV, max_uV);
+	if (ret > 0)
+		latency_ns =3D ret * 1000;
+
+	return latency_ns;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_volt_latency);
+
 /**
  * dev_pm_opp_get_suspend_opp() - Get suspend opp
  * @dev:	device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index c70a18ac9c8a7..5daa43058ac10 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -34,6 +34,7 @@ bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
=20
 int dev_pm_opp_get_opp_count(struct device *dev);
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
+unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
 struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev);
=20
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
@@ -88,6 +89,11 @@ static inline unsigned long dev_pm_opp_get_max_clock_l=
atency(struct device *dev)
 	return 0;
 }
=20
+static inline unsigned long dev_pm_opp_get_max_volt_latency(struct devic=
e *dev)
+{
+	return 0;
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct devic=
e *dev)
 {
 	return NULL;
--=20
2.27.0


--KFCS2dRqGugZdFIip9NC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4886): https://lists.cip-project.org/g/cip-dev/message=
/4886
Mute This Topic: https://lists.cip-project.org/mt/75379078/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--KFCS2dRqGugZdFIip9NC--
