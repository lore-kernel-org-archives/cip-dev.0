Return-Path: <SRS0=T05D=AT=lists.cip-project.org=bounce+64572+4895+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FA2C433DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9374020720
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="XujaouZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9374020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4895+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ayf6YY4521723xwz0JdcvVDn; Wed, 08 Jul 2020 08:46:32 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web11.13702.1594223182827967476
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:23 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 62F2C60243; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 11/23] cpufreq: dt: Pass regulator name to the OPP core
Date: Wed,  8 Jul 2020 23:45:42 +0800
Message-Id: <20200708154554.26450-12-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: b7YRPMs02zUM60CsQOQZN9Obx4520388AA=
Content-Type: multipart/mixed; boundary="sZS6oHmehVVbqr2YOAX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223192;
 bh=jiQc2G0LQUgk04nRn9Z6jPchXLkyfFTnATjjyeWeqNk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=XujaouZYIkll62SJTKQamLO4tJu40moIgltNXzGA+mbUsAilpz6WWdFD3QdOqDC/F4M
 CO+UIfKNkmep4hUPM9fcSOksaZbA/u3D8brTPJ5AkTMGCPLHgTMitQdbGN5sdnnVUlBW9
 rF3esNVRGnTmksxUK2ZmYaibhLMcXNxoGgQ=

--sZS6oHmehVVbqr2YOAX6
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 050794aaebbb9f2c2c50b340b6998273e7c64189 upstream.

OPP core can handle the regulators by itself, and but it needs to know
the name of the regulator to fetch. Add support for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/cpufreq-dt.c | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 4c9f8a828f6f1..2af75f8088bbb 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -34,6 +34,7 @@ struct private_data {
 	struct regulator *cpu_reg;
 	struct thermal_cooling_device *cdev;
 	unsigned int voltage_tolerance; /* in percentage */
+	const char *reg_name;
 };
=20
 static struct freq_attr *cpufreq_dt_attr[] =3D {
@@ -119,6 +120,30 @@ static int set_target(struct cpufreq_policy *policy,=
 unsigned int index)
 	return ret;
 }
=20
+/*
+ * An earlier version of opp-v1 bindings used to name the regulator
+ * "cpu0-supply", we still need to handle that for backwards compatibili=
ty.
+ */
+static const char *find_supply_name(struct device *dev, struct device_no=
de *np)
+{
+	struct property *pp;
+	int cpu =3D dev->id;
+
+	/* Try "cpu0" for older DTs */
+	if (!cpu) {
+		pp =3D of_find_property(np, "cpu0-supply", NULL);
+		if (pp)
+			return "cpu0";
+	}
+
+	pp =3D of_find_property(np, "cpu-supply", NULL);
+	if (pp)
+		return "cpu";
+
+	dev_dbg(dev, "no regulator for cpu%d\n", cpu);
+	return NULL;
+}
+
 static int allocate_resources(int cpu, struct device **cdev,
 			      struct regulator **creg, struct clk **cclk)
 {
@@ -200,6 +225,7 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
 	unsigned long min_uV =3D ~0, max_uV =3D 0;
 	unsigned int transition_latency;
 	bool opp_v1 =3D false;
+	const char *name;
 	int ret;
=20
 	ret =3D allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
@@ -228,6 +254,20 @@ static int cpufreq_init(struct cpufreq_policy *polic=
y)
 			goto out_node_put;
 	}
=20
+	/*
+	 * OPP layer will be taking care of regulators now, but it needs to kno=
w
+	 * the name of the regulator first.
+	 */
+	name =3D find_supply_name(cpu_dev, np);
+	if (name) {
+		ret =3D dev_pm_opp_set_regulator(cpu_dev, name);
+		if (ret) {
+			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
+				policy->cpu, ret);
+			goto out_node_put;
+		}
+	}
+
 	/*
 	 * Initialize OPP tables for all policy->cpus. They will be shared by
 	 * all CPUs which have marked their CPUs shared with OPP bindings.
@@ -273,6 +313,7 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
 		goto out_free_opp;
 	}
=20
+	priv->reg_name =3D name;
 	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance)=
;
=20
 	transition_latency =3D dev_pm_opp_get_max_clock_latency(cpu_dev);
@@ -366,6 +407,8 @@ out_free_priv:
 	kfree(priv);
 out_free_opp:
 	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
+	if (name)
+		dev_pm_opp_put_regulator(cpu_dev);
 out_node_put:
 	of_node_put(np);
 out_put_reg_clk:
@@ -383,6 +426,9 @@ static int cpufreq_exit(struct cpufreq_policy *policy=
)
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
+	if (priv->reg_name)
+		dev_pm_opp_put_regulator(priv->cpu_dev);
+
 	clk_put(policy->clk);
 	if (!IS_ERR(priv->cpu_reg))
 		regulator_put(priv->cpu_reg);
--=20
2.27.0


--sZS6oHmehVVbqr2YOAX6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4895): https://lists.cip-project.org/g/cip-dev/message=
/4895
Mute This Topic: https://lists.cip-project.org/mt/75379087/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--sZS6oHmehVVbqr2YOAX6--
