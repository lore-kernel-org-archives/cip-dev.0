Return-Path: <SRS0=LWus=CS=lists.cip-project.org=bounce+64572+5430+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A953C31E5C
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:48 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFD621D46
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="uRtBL3Pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFD621D46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5430+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id y8YmYY4521723x8wk8LPUGso; Tue, 08 Sep 2020 21:44:48 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web11.6578.1599626683840206784
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 21:44:44 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 0201B5FDD7; Wed,  9 Sep 2020 12:44:32 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com,
	wens@csie.org
Subject: [cip-dev] [PATCH 4.4.y-cip 06/11] cpufreq: ti-cpufreq: kfree opp_data when failure
Date: Wed,  9 Sep 2020 12:42:28 +0800
Message-Id: <20200909044233.4115-7-wens@csie.org>
In-Reply-To: <20200909044233.4115-1-wens@csie.org>
References: <20200909044233.4115-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3FHFGQO4VwP6vDsAwnwqy2CKx4520388AA=
Content-Type: multipart/mixed; boundary="fUHp5WrLjsAGycmKYbtz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599626688;
 bh=8JwoUR7t1SS/mocIVGT2M9TQkyDCh/jlqonuJE1mA2Q=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=uRtBL3PgkegeggmUTQjoHPvTWjQsBPco8tG7RAZ97VLMG1cRAUDBMKWK1HE6djWD0JC
 ToY3xq7Li8LoO3KANTf5gjW62s/ddjpNm5IdCF3/U+jQvaDknewoiShLXf9pqdbNwLsGg
 FuKTHdf/7+b3/t7agle6vK4QSJfJ/7I4XsE=

--fUHp5WrLjsAGycmKYbtz
Content-Transfer-Encoding: quoted-printable

From: Zumeng Chen <zumeng.chen@gmail.com>

commit 05829d9431df1bf6de98679fbcfbad282c1c55a4 upstream.

memory leakage was found by kmemleak. opp_data needs to be freed
when failure, including fail_put_node.

unreferenced object 0xccdd4c40 (size 64):
  comm "swapper", pid 1, jiffies 4294938465 (age 888.520s)
  hex dump (first 32 bytes):
    00 7c 00 c1 98 69 d8 ce 00 24 03 ce 00 24 03 ce  .|...i...$...$..
    20 35 23 c1 00 00 00 00 00 00 00 00 00 00 00 00   5#.............
  backtrace:
    [<c028fb64>] kmem_cache_alloc_trace+0x2c4/0x3cc
    [<c076d5f0>] ti_cpufreq_probe+0x6c/0x334
    [<c068d6e4>] platform_drv_probe+0x60/0xc0
    [<c068b384>] driver_probe_device+0x218/0x2c4
    [<c068b5a4>] __device_attach_driver+0xa8/0xdc
    [<c0689340>] bus_for_each_drv+0x70/0xa4
    [<c068b020>] __device_attach+0xc0/0x124
    [<c068b634>] device_initial_probe+0x1c/0x20
    [<c068a3b8>] bus_probe_device+0x94/0x9c
    [<c0688300>] device_add+0x404/0x590
    [<c068d408>] platform_device_add+0x11c/0x230
    [<c068df40>] platform_device_register_full+0x10c/0x128
    [<c076d578>] ti_cpufreq_init+0x44/0x50
    [<c01017c4>] do_one_initcall+0x54/0x180
    [<c0e00fe0>] kernel_init_freeable+0x270/0x33c
    [<c093f2bc>] kernel_init+0x18/0x124

Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/ti-cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 1c63e96cba1f2..36627b2b256f8 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -217,7 +217,8 @@ static int ti_cpufreq_init(void)
 	opp_data->cpu_dev =3D get_cpu_device(0);
 	if (!opp_data->cpu_dev) {
 		pr_err("%s: Failed to get device for CPU0\n", __func__);
-		return -ENODEV;
+		ret =3D ENODEV;
+		goto free_opp_data;
 	}
=20
 	opp_data->opp_node =3D dev_pm_opp_of_get_opp_desc_node(opp_data->cpu_de=
v);
@@ -262,6 +263,8 @@ register_cpufreq_dt:
=20
 fail_put_node:
 	of_node_put(opp_data->opp_node);
+free_opp_data:
+	kfree(opp_data);
=20
 	return ret;
 }
--=20
2.28.0


--fUHp5WrLjsAGycmKYbtz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5430): https://lists.cip-project.org/g/cip-dev/message=
/5430
Mute This Topic: https://lists.cip-project.org/mt/76726434/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--fUHp5WrLjsAGycmKYbtz--
