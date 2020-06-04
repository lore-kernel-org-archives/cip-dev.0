Return-Path: <SRS0=5HsL=7R=lists.cip-project.org=bounce+64572+4718+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D75C433F1
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C501D2075B
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PBBAY9jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C501D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4718+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uxTqYY4521723xoftnE6SGXP; Thu, 04 Jun 2020 04:55:37 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web11.6515.1591240766312853893
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 20:19:26 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 44D2360141; Thu,  4 Jun 2020 11:19:20 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: Andrzej Hajda <a.hajda@samsung.com>,
	cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [cip-dev] [4.4.y-cip 14/15] cpufreq-dt: fix handling regulator_get_voltage() result
Date: Thu,  4 Jun 2020 11:18:28 +0800
Message-Id: <20200604031829.3254-15-wens@csie.org>
In-Reply-To: <20200604031829.3254-1-wens@csie.org>
References: <20200604031829.3254-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WwkwQmjpUTznjgpytMprJzxKx4520388AA=
Content-Type: multipart/mixed; boundary="1urGtHHULnOAaBxsvBfa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591271737;
 bh=wze6KnyLd05D8mft8sE2tRIex8bgtqviLHbFR6knY6g=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PBBAY9jroi6mcqT+LkwIGDHObAH74KQdrUdiTSH4Dzx7aF6Sicfx9KzUekJUrZPfF1O
 4sfIcU4syjflOpDT7tYnkoemE2MPup1/7ZX941rnkLSQIWFYg82lPqdue0PjzMid8HETx
 s6DG65dmnXgx/ciU37iJO64NKDXvu6vJGco=

--1urGtHHULnOAaBxsvBfa
Content-Transfer-Encoding: quoted-printable

From: Andrzej Hajda <a.hajda@samsung.com>

commit 929ca89c305a6ed7a4149115be99af6d73c36918 upstream.

The function can return negative values so it should be assigned
to signed type.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci.

Link: http://permalink.gmane.org/gmane.linux.kernel/2038576
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/cpufreq-dt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 1ceece9d67112..9bc37c437874a 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -50,7 +50,8 @@ static int set_target(struct cpufreq_policy *policy, un=
signed int index)
 	struct private_data *priv =3D policy->driver_data;
 	struct device *cpu_dev =3D priv->cpu_dev;
 	struct regulator *cpu_reg =3D priv->cpu_reg;
-	unsigned long volt =3D 0, volt_old =3D 0, tol =3D 0;
+	unsigned long volt =3D 0, tol =3D 0;
+	int volt_old =3D 0;
 	unsigned int old_freq, new_freq;
 	long freq_Hz, freq_exact;
 	int ret;
@@ -83,7 +84,7 @@ static int set_target(struct cpufreq_policy *policy, un=
signed int index)
 			opp_freq / 1000, volt);
 	}
=20
-	dev_dbg(cpu_dev, "%u MHz, %ld mV --> %u MHz, %ld mV\n",
+	dev_dbg(cpu_dev, "%u MHz, %d mV --> %u MHz, %ld mV\n",
 		old_freq / 1000, (volt_old > 0) ? volt_old / 1000 : -1,
 		new_freq / 1000, volt ? volt / 1000 : -1);
=20
--=20
2.27.0.rc0


--1urGtHHULnOAaBxsvBfa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4718): https://lists.cip-project.org/g/cip-dev/message=
/4718
Mute This Topic: https://lists.cip-project.org/mt/74669314/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--1urGtHHULnOAaBxsvBfa--
