Return-Path: <SRS0=j1tL=CS=lists.cip-project.org=bounce+64572+5427+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B5CC433E2
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575E821D40
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="t2b8Rb+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575E821D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5427+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id f362YY4521723xc5fKntLgxh; Tue, 08 Sep 2020 21:44:47 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web10.6634.1599626683688964175
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 21:44:44 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id F1BB95FD69; Wed,  9 Sep 2020 12:44:32 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com,
	wens@csie.org
Subject: [cip-dev] [PATCH 4.4.y-cip 05/11] cpufreq: ti: Fix 'of_node_put' being called twice in error handling path
Date: Wed,  9 Sep 2020 12:42:27 +0800
Message-Id: <20200909044233.4115-6-wens@csie.org>
In-Reply-To: <20200909044233.4115-1-wens@csie.org>
References: <20200909044233.4115-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QVgRxjJGGAYakoLcAWlqrvs5x4520388AA=
Content-Type: multipart/mixed; boundary="nFzAVTRzLa67X5KIf0EX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599626687;
 bh=xzrmBB9aJYPQAO+zJdt49Q469VvBIcGnFbTkmI3IL+U=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=t2b8Rb+Xrm3eBJazSPayl8v8KrbViwnZruc6Hy+KA1iBTyq1Ea9VKHhpV+A7LB5GNII
 ZeKzQ23+JYFtkRp/+xjzLAWvfbYlgqUkhlOXq8JgOQeF4xNePujETKaGXtiHtK19BLfm3
 FoU0g59d80OaLIE7J06XDIm7Hq4ff945n8g=

--nFzAVTRzLa67X5KIf0EX
Content-Transfer-Encoding: quoted-printable

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

commit 9a6e91d08e7707baa2f824257342ca7efcb199bc upstream.

If 'dev_pm_opp_set_supported_hw()' fails, 'opp_data->opp_node' refcount
will be decremented 2 times.
One, just a few lines above, and another one in the error handling path.

Fix it by simply moving the 'of_node_put' call of the normal path.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/ti-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 7ff7ae3c3911c..1c63e96cba1f2 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -245,8 +245,6 @@ static int ti_cpufreq_init(void)
 	if (ret)
 		goto fail_put_node;
=20
-	of_node_put(opp_data->opp_node);
-
 	ret =3D PTR_ERR_OR_ZERO(dev_pm_opp_set_supported_hw(opp_data->cpu_dev,
 							  version, VERSION_COUNT));
 	if (ret) {
@@ -255,6 +253,8 @@ static int ti_cpufreq_init(void)
 		goto fail_put_node;
 	}
=20
+	of_node_put(opp_data->opp_node);
+
 register_cpufreq_dt:
 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
=20
--=20
2.28.0


--nFzAVTRzLa67X5KIf0EX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5427): https://lists.cip-project.org/g/cip-dev/message=
/5427
Mute This Topic: https://lists.cip-project.org/mt/76726431/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--nFzAVTRzLa67X5KIf0EX--
