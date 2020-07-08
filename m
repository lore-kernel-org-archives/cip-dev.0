Return-Path: <SRS0=W8Pd=AT=lists.cip-project.org=bounce+64572+4888+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAED8C433DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:27 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F9E20786
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hjf9DjdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F9E20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4888+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HkOyYY4521723xc3yWHOIHIB; Wed, 08 Jul 2020 08:46:25 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13598.1594223180608141518
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:21 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 29A6C5FDAF; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 04/23] PM / OPP: Introduce dev_pm_opp_get_max_transition_latency()
Date: Wed,  8 Jul 2020 23:45:35 +0800
Message-Id: <20200708154554.26450-5-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XpQKrmRgk8pRx269ZTLsjtMIx4520388AA=
Content-Type: multipart/mixed; boundary="NJ20cz2pJsNkfMt7EOXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223185;
 bh=+jMD3jSPrQBEgiRu/Yoqh3snd8ZVKfHrxGneQcc5uT0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=hjf9DjdL4Fx2VvOXTGm2HJJNvBYV7CMC01d8u0AFVQb/9vYEQxZm8Vg1vYf4qJbfvOr
 6JR57NsD0qVuQ/ceMxKCgBV2H1inSxaCXqQuNY/2DNL2MphpGe7D6TGsGER9oteIl2E9o
 TkuMqpBIVOykLkRjz3dod2CS1XYdlmTmnQw=

--NJ20cz2pJsNkfMt7EOXa
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 2174344765f472895c076d703c9cdc58215e1393 upstream.

In few use cases (like: cpufreq), it is desired to get the maximum
latency for changing OPPs. Add support for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 17 +++++++++++++++++
 include/linux/pm_opp.h        |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index 09165fbef84ed..d51ddcebcca00 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -289,6 +289,23 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct=
 device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_volt_latency);
=20
+/**
+ * dev_pm_opp_get_max_transition_latency() - Get max transition latency =
in
+ *					     nanoseconds
+ * @dev: device for which we do this operation
+ *
+ * Return: This function returns the max transition latency, in nanoseco=
nds, to
+ * switch from one OPP to other.
+ *
+ * Locking: This function takes rcu_read_lock().
+ */
+unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev)
+{
+	return dev_pm_opp_get_max_volt_latency(dev) +
+		dev_pm_opp_get_max_clock_latency(dev);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_transition_latency);
+
 /**
  * dev_pm_opp_get_suspend_opp() - Get suspend opp
  * @dev:	device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5daa43058ac10..59da3d9e11ea3 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -35,6 +35,7 @@ bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
 int dev_pm_opp_get_opp_count(struct device *dev);
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
+unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev);
 struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev);
=20
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
@@ -94,6 +95,11 @@ static inline unsigned long dev_pm_opp_get_max_volt_la=
tency(struct device *dev)
 	return 0;
 }
=20
+static inline unsigned long dev_pm_opp_get_max_transition_latency(struct=
 device *dev)
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


--NJ20cz2pJsNkfMt7EOXa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4888): https://lists.cip-project.org/g/cip-dev/message=
/4888
Mute This Topic: https://lists.cip-project.org/mt/75379080/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--NJ20cz2pJsNkfMt7EOXa--
