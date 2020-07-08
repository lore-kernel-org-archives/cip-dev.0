Return-Path: <SRS0=nyqc=AT=lists.cip-project.org=bounce+64572+4901+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA08C433DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C1D20720
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="b7pZI0vN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C1D20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4901+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RYOrYY4521723xIB0f3KRtGt; Wed, 08 Jul 2020 08:46:39 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13608.1594223184414778447
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:24 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 8DF79603D5; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 16/23] cpufreq: dt: No need to allocate resources anymore
Date: Wed,  8 Jul 2020 23:45:47 +0800
Message-Id: <20200708154554.26450-17-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8OHeoa6oeRkjDbpLWuOoR5gBx4520388AA=
Content-Type: multipart/mixed; boundary="WvJGljl7DD1SPQCSQvHi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223199;
 bh=outJvhRtEiveRGoybyFrOhS2XELDXOgvgnqXc4YJHRU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=b7pZI0vNmYWzsLv1n+wijfqsX3kgVngeNznJTYMvJaNzQMf3GAAeDvCTnPrcVQM79tH
 5uBQbdF3PHY+XQBTTawAE9d/8L5jMoBvKFWgDr3MlVHwswrOuLXbjQS53mwpvr2K4FjUI
 8TGi62J+Djt9ci4gQYMaRzvUjmxw6VUNPp8=

--WvJGljl7DD1SPQCSQvHi
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit dd02a3d920083b6cb0ee4f0eaf2c599b740bf5fe upstream.

OPP layer manages it now and cpufreq-dt driver doesn't need it. But, we
still need to check for availability of resources for deferred probing.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/cpufreq-dt.c | 112 ++++++++++++++---------------------
 1 file changed, 45 insertions(+), 67 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index bbafd7b63d1a2..f951f911786e0 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -31,7 +31,6 @@
=20
 struct private_data {
 	struct device *cpu_dev;
-	struct regulator *cpu_reg;
 	struct thermal_cooling_device *cdev;
 	const char *reg_name;
 };
@@ -88,73 +87,59 @@ node_put:
 	return name;
 }
=20
-static int allocate_resources(int cpu, struct device **cdev,
-			      struct regulator **creg, struct clk **cclk)
+static int resources_available(void)
 {
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
 	int ret =3D 0;
-	char *reg_cpu0 =3D "cpu0", *reg_cpu =3D "cpu", *reg;
+	const char *name;
=20
-	cpu_dev =3D get_cpu_device(cpu);
+	cpu_dev =3D get_cpu_device(0);
 	if (!cpu_dev) {
-		pr_err("failed to get cpu%d device\n", cpu);
+		pr_err("failed to get cpu0 device\n");
 		return -ENODEV;
 	}
=20
-	/* Try "cpu0" for older DTs */
-	if (!cpu)
-		reg =3D reg_cpu0;
-	else
-		reg =3D reg_cpu;
-
-try_again:
-	cpu_reg =3D regulator_get_optional(cpu_dev, reg);
-	ret =3D PTR_ERR_OR_ZERO(cpu_reg);
+	cpu_clk =3D clk_get(cpu_dev, NULL);
+	ret =3D PTR_ERR_OR_ZERO(cpu_clk);
 	if (ret) {
 		/*
-		 * If cpu's regulator supply node is present, but regulator is
-		 * not yet registered, we should try defering probe.
+		 * If cpu's clk node is present, but clock is not yet
+		 * registered, we should try defering probe.
 		 */
-		if (ret =3D=3D -EPROBE_DEFER) {
-			dev_dbg(cpu_dev, "cpu%d regulator not ready, retry\n",
-				cpu);
-			return ret;
-		}
-
-		/* Try with "cpu-supply" */
-		if (reg =3D=3D reg_cpu0) {
-			reg =3D reg_cpu;
-			goto try_again;
-		}
+		if (ret =3D=3D -EPROBE_DEFER)
+			dev_dbg(cpu_dev, "clock not ready, retry\n");
+		else
+			dev_err(cpu_dev, "failed to get clock: %d\n", ret);
=20
-		dev_dbg(cpu_dev, "no regulator for cpu%d: %d\n", cpu, ret);
+		return ret;
 	}
=20
-	cpu_clk =3D clk_get(cpu_dev, NULL);
-	ret =3D PTR_ERR_OR_ZERO(cpu_clk);
-	if (ret) {
-		/* put regulator */
-		if (!IS_ERR(cpu_reg))
-			regulator_put(cpu_reg);
+	clk_put(cpu_clk);
+
+	name =3D find_supply_name(cpu_dev);
+	/* Platform doesn't require regulator */
+	if (!name)
+		return 0;
=20
+	cpu_reg =3D regulator_get_optional(cpu_dev, name);
+	ret =3D PTR_ERR_OR_ZERO(cpu_reg);
+	if (ret) {
 		/*
-		 * If cpu's clk node is present, but clock is not yet
-		 * registered, we should try defering probe.
+		 * If cpu's regulator supply node is present, but regulator is
+		 * not yet registered, we should try defering probe.
 		 */
 		if (ret =3D=3D -EPROBE_DEFER)
-			dev_dbg(cpu_dev, "cpu%d clock not ready, retry\n", cpu);
+			dev_dbg(cpu_dev, "cpu0 regulator not ready, retry\n");
 		else
-			dev_err(cpu_dev, "failed to get cpu%d clock: %d\n", cpu,
-				ret);
-	} else {
-		*cdev =3D cpu_dev;
-		*creg =3D cpu_reg;
-		*cclk =3D cpu_clk;
+			dev_dbg(cpu_dev, "no regulator for cpu0: %d\n", ret);
+
+		return ret;
 	}
=20
-	return ret;
+	regulator_put(cpu_reg);
+	return 0;
 }
=20
 static int cpufreq_init(struct cpufreq_policy *policy)
@@ -162,7 +147,6 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
 	struct cpufreq_frequency_table *freq_table;
 	struct private_data *priv;
 	struct device *cpu_dev;
-	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
 	struct dev_pm_opp *suspend_opp;
 	unsigned int transition_latency;
@@ -170,9 +154,16 @@ static int cpufreq_init(struct cpufreq_policy *polic=
y)
 	const char *name;
 	int ret;
=20
-	ret =3D allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
-	if (ret) {
-		pr_err("%s: Failed to allocate resources: %d\n", __func__, ret);
+	cpu_dev =3D get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu%d device\n", policy->cpu);
+		return -ENODEV;
+	}
+
+	cpu_clk =3D clk_get(cpu_dev, NULL);
+	if (IS_ERR(cpu_clk)) {
+		ret =3D PTR_ERR(cpu_clk);
+		dev_err(cpu_dev, "%s: failed to get clk: %d\n", __func__, ret);
 		return ret;
 	}
=20
@@ -186,7 +177,7 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
 		if (ret =3D=3D -ENOENT)
 			opp_v1 =3D true;
 		else
-			goto out_put_reg_clk;
+			goto out_put_clk;
 	}
=20
 	/*
@@ -199,7 +190,7 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
 		if (ret) {
 			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
 				policy->cpu, ret);
-			goto out_put_reg_clk;
+			goto out_put_clk;
 		}
 	}
=20
@@ -257,9 +248,7 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
 	}
=20
 	priv->cpu_dev =3D cpu_dev;
-	priv->cpu_reg =3D cpu_reg;
 	policy->driver_data =3D priv;
-
 	policy->clk =3D cpu_clk;
=20
 	rcu_read_lock();
@@ -300,10 +289,8 @@ out_free_opp:
 	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	if (name)
 		dev_pm_opp_put_regulator(cpu_dev);
-out_put_reg_clk:
+out_put_clk:
 	clk_put(cpu_clk);
-	if (!IS_ERR(cpu_reg))
-		regulator_put(cpu_reg);
=20
 	return ret;
 }
@@ -319,8 +306,6 @@ static int cpufreq_exit(struct cpufreq_policy *policy=
)
 		dev_pm_opp_put_regulator(priv->cpu_dev);
=20
 	clk_put(policy->clk);
-	if (!IS_ERR(priv->cpu_reg))
-		regulator_put(priv->cpu_reg);
 	kfree(priv);
=20
 	return 0;
@@ -373,9 +358,6 @@ static struct cpufreq_driver dt_cpufreq_driver =3D {
=20
 static int dt_cpufreq_probe(struct platform_device *pdev)
 {
-	struct device *cpu_dev;
-	struct regulator *cpu_reg;
-	struct clk *cpu_clk;
 	int ret;
=20
 	/*
@@ -385,19 +367,15 @@ static int dt_cpufreq_probe(struct platform_device =
*pdev)
 	 *
 	 * FIXME: Is checking this only for CPU0 sufficient ?
 	 */
-	ret =3D allocate_resources(0, &cpu_dev, &cpu_reg, &cpu_clk);
+	ret =3D resources_available();
 	if (ret)
 		return ret;
=20
-	clk_put(cpu_clk);
-	if (!IS_ERR(cpu_reg))
-		regulator_put(cpu_reg);
-
 	dt_cpufreq_driver.driver_data =3D dev_get_platdata(&pdev->dev);
=20
 	ret =3D cpufreq_register_driver(&dt_cpufreq_driver);
 	if (ret)
-		dev_err(cpu_dev, "failed register driver: %d\n", ret);
+		dev_err(&pdev->dev, "failed register driver: %d\n", ret);
=20
 	return ret;
 }
--=20
2.27.0


--WvJGljl7DD1SPQCSQvHi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4901): https://lists.cip-project.org/g/cip-dev/message=
/4901
Mute This Topic: https://lists.cip-project.org/mt/75379093/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--WvJGljl7DD1SPQCSQvHi--
