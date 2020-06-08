Return-Path: <SRS0=fLJE=7V=lists.cip-project.org=bounce+64572+4739+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1C4C433E7
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 09:30:55 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1527206A4
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 09:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="GoRquOj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1527206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4739+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id askTYY4521723xqAIkWErivj; Mon, 08 Jun 2020 02:30:54 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web10.26292.1591608653817530537
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 02:30:54 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 44C8A60092; Mon,  8 Jun 2020 17:30:50 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v2 10/15] PM / OPP: Set cpu_dev->id in cpumask first
Date: Mon,  8 Jun 2020 17:30:23 +0800
Message-Id: <20200608093028.21612-11-wens@csie.org>
In-Reply-To: <20200608093028.21612-1-wens@csie.org>
References: <20200608093028.21612-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mqnDdNNPh19goKG83n0AIx6mx4520388AA=
Content-Type: multipart/mixed; boundary="03UBO0C1XSHp4F65DUSl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591608654;
 bh=yaGEMVeWLRoxNWIfVl2zet0TwnYfggW+d5LPV5hNFcc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=GoRquOj9ji8bZA7+VuSL9UoHR0B0uMjb2MksRBa41GVMM9OASneTJsCZXbD1BrUkgi9
 Dlp1/Bnv4zPjvk9H9W1cWXDU+DGp1xm4NA2sj+Lu/NXgi0LK35JZhWuacLfo/336Mft3/
 TEeaNI2F1luhVTLn7SEyKy1kCGgf4rsDZBY=

--03UBO0C1XSHp4F65DUSl
Content-Transfer-Encoding: quoted-printable

From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>

commit d9de19b1cc013433ad293365b5b3902ec73dfd60 upstream.

Set cpu_dev->id in cpumask first when setting up cpumask for CPUs that
share the same OPP table. This might be helpful when handling cpumask
without the original CPU bitfield set.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
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


--03UBO0C1XSHp4F65DUSl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4739): https://lists.cip-project.org/g/cip-dev/message=
/4739
Mute This Topic: https://lists.cip-project.org/mt/74748499/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--03UBO0C1XSHp4F65DUSl--
