Return-Path: <SRS0=ZTnn=AT=lists.cip-project.org=bounce+64572+4905+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83197C433DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:48 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B97206DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="k1kCXXYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B97206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4905+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ier5YY4521723xX7Zxj2EdCS; Wed, 08 Jul 2020 08:46:46 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13611.1594223184681079847
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:25 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 8274160337; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 15/23] cpufreq: dt: No need to fetch voltage-tolerance
Date: Wed,  8 Jul 2020 23:45:46 +0800
Message-Id: <20200708154554.26450-16-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: HMNeEDJDBJnEKCtATeKVltasx4520388AA=
Content-Type: multipart/mixed; boundary="Fml3xCWQGwRajPCOgENm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223206;
 bh=Y5fsNAzNQPBcZbfjvAT7QVBETcPwjJ9KWYfVIsS5LcM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=k1kCXXYaJ5EywKg1HYNCmAliXC6Nra/15VfkWZMK5L8qzsUnn5Pox4LeRzN45Mb24Ho
 Alv7teQ0RNbJRPVQxw0X3UdayW/hhkoRzYPHVjWLezmzBs1fMAct/c9AXKiVWNBLJ+NBu
 LwzTbZKAc/eRjIsA6p67wv6rPtaJVy2FGVE=

--Fml3xCWQGwRajPCOgENm
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit df2c8ec28e73d47392b8cb24828c15c54819da41 upstream.

Its already done by core and we don't need to get it anymore.  And so,
we don't need to get of node in cpufreq_init() anymore, move that to
find_supply_name() instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/cpufreq-dt.c | 46 ++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 150a172c7d0a7..bbafd7b63d1a2 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -33,7 +33,6 @@ struct private_data {
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct thermal_cooling_device *cdev;
-	unsigned int voltage_tolerance; /* in percentage */
 	const char *reg_name;
 };
=20
@@ -55,24 +54,38 @@ static int set_target(struct cpufreq_policy *policy, =
unsigned int index)
  * An earlier version of opp-v1 bindings used to name the regulator
  * "cpu0-supply", we still need to handle that for backwards compatibili=
ty.
  */
-static const char *find_supply_name(struct device *dev, struct device_no=
de *np)
+static const char *find_supply_name(struct device *dev)
 {
+	struct device_node *np;
 	struct property *pp;
 	int cpu =3D dev->id;
+	const char *name =3D NULL;
+
+	np =3D of_node_get(dev->of_node);
+
+	/* This must be valid for sure */
+	if (WARN_ON(!np))
+		return NULL;
=20
 	/* Try "cpu0" for older DTs */
 	if (!cpu) {
 		pp =3D of_find_property(np, "cpu0-supply", NULL);
-		if (pp)
-			return "cpu0";
+		if (pp) {
+			name =3D "cpu0";
+			goto node_put;
+		}
 	}
=20
 	pp =3D of_find_property(np, "cpu-supply", NULL);
-	if (pp)
-		return "cpu";
+	if (pp) {
+		name =3D "cpu";
+		goto node_put;
+	}
=20
 	dev_dbg(dev, "no regulator for cpu%d\n", cpu);
-	return NULL;
+node_put:
+	of_node_put(np);
+	return name;
 }
=20
 static int allocate_resources(int cpu, struct device **cdev,
@@ -147,7 +160,6 @@ try_again:
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
-	struct device_node *np;
 	struct private_data *priv;
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
@@ -164,13 +176,6 @@ static int cpufreq_init(struct cpufreq_policy *polic=
y)
 		return ret;
 	}
=20
-	np =3D of_node_get(cpu_dev->of_node);
-	if (!np) {
-		dev_err(cpu_dev, "failed to find cpu%d node\n", policy->cpu);
-		ret =3D -ENOENT;
-		goto out_put_reg_clk;
-	}
-
 	/* Get OPP-sharing information from "operating-points-v2" bindings */
 	ret =3D dev_pm_opp_of_get_sharing_cpus(cpu_dev, policy->cpus);
 	if (ret) {
@@ -181,20 +186,20 @@ static int cpufreq_init(struct cpufreq_policy *poli=
cy)
 		if (ret =3D=3D -ENOENT)
 			opp_v1 =3D true;
 		else
-			goto out_node_put;
+			goto out_put_reg_clk;
 	}
=20
 	/*
 	 * OPP layer will be taking care of regulators now, but it needs to kno=
w
 	 * the name of the regulator first.
 	 */
-	name =3D find_supply_name(cpu_dev, np);
+	name =3D find_supply_name(cpu_dev);
 	if (name) {
 		ret =3D dev_pm_opp_set_regulator(cpu_dev, name);
 		if (ret) {
 			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
 				policy->cpu, ret);
-			goto out_node_put;
+			goto out_put_reg_clk;
 		}
 	}
=20
@@ -244,7 +249,6 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
 	}
=20
 	priv->reg_name =3D name;
-	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance)=
;
=20
 	ret =3D dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
@@ -286,8 +290,6 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
=20
 	policy->cpuinfo.transition_latency =3D transition_latency;
=20
-	of_node_put(np);
-
 	return 0;
=20
 out_free_cpufreq_table:
@@ -298,8 +300,6 @@ out_free_opp:
 	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	if (name)
 		dev_pm_opp_put_regulator(cpu_dev);
-out_node_put:
-	of_node_put(np);
 out_put_reg_clk:
 	clk_put(cpu_clk);
 	if (!IS_ERR(cpu_reg))
--=20
2.27.0


--Fml3xCWQGwRajPCOgENm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4905): https://lists.cip-project.org/g/cip-dev/message=
/4905
Mute This Topic: https://lists.cip-project.org/mt/75379097/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Fml3xCWQGwRajPCOgENm--
