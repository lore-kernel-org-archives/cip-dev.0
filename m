Return-Path: <SRS0=L/8z=7R=lists.cip-project.org=bounce+64572+4712+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AC1C433E7
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571E620663
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="f/gPh5dI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571E620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4712+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RaqyYY4521723xxfXPPGnk6Q; Thu, 04 Jun 2020 04:55:36 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web12.6393.1591240765983724229
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 20:19:26 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 1AFCE60089; Thu,  4 Jun 2020 11:19:20 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: Pi-Cheng Chen <pi-cheng.chen@linaro.org>,
	cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [cip-dev] [4.4.y-cip 10/15] PM / OPP: Set cpu_dev->id in cpumask first
Date: Thu,  4 Jun 2020 11:18:24 +0800
Message-Id: <20200604031829.3254-11-wens@csie.org>
In-Reply-To: <20200604031829.3254-1-wens@csie.org>
References: <20200604031829.3254-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: IlOcFn9QjstREN0aWWPFdSsAx4520388AA=
Content-Type: multipart/mixed; boundary="P4IGvCtekCdtBa4tUpSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591271736;
 bh=aIFsQTnELn05XqvRmJYiD2j0Me03otn7mFpxzEaopNI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=f/gPh5dItfNrqDKwYU7mNMI7I0z2YrpY+QRrYU21/ZJViWlJnBhtZlZHyVGVG0kZANe
 jYLq/Iv+mK4YCj/U9EK0Yi5Uzom6MaWo+a/bRlFx5a6LXWPZgKN9tpb5dM8AKL6qZuhKY
 WZQPcWabvpoF+oEqlyS95RF5OUijTgiLpII=

--P4IGvCtekCdtBa4tUpSK
Content-Transfer-Encoding: quoted-printable

From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>

Set cpu_dev->id in cpumask first when setting up cpumask for CPUs that
share the same OPP table. This might be helpful when handling cpumask
without the original CPU bitfield set.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/opp/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 1a2e8f260b060..a0db8b3575f38 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -218,7 +218,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
 /*
  * Works only for OPP v2 bindings.
  *
- * cpumask should be already set to mask of cpu_dev->id.
  * Returns -ENOENT if operating-points-v2 bindings aren't supported.
  */
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t=
 cpumask)
@@ -234,6 +233,8 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu=
_dev, cpumask_var_t cpumask
 		return -ENOENT;
 	}
=20
+	cpumask_set_cpu(cpu_dev->id, cpumask);
+
 	/* OPPs are shared ? */
 	if (!of_property_read_bool(np, "opp-shared"))
 		goto put_cpu_node;
--=20
2.27.0.rc0


--P4IGvCtekCdtBa4tUpSK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4712): https://lists.cip-project.org/g/cip-dev/message=
/4712
Mute This Topic: https://lists.cip-project.org/mt/74669308/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--P4IGvCtekCdtBa4tUpSK--
