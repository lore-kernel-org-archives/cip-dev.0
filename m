Return-Path: <SRS0=IVil=CS=lists.cip-project.org=bounce+64572+5426+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24315C31E40
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:48 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C895D21D40
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jlfXpOWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C895D21D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5426+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Q9BvYY4521723x7ikiit3w0c; Tue, 08 Sep 2020 21:44:47 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.6688.1599626683683137977
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 21:44:44 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 103C760193; Wed,  9 Sep 2020 12:44:33 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com,
	wens@csie.org
Subject: [cip-dev] [PATCH 4.4.y-cip 08/11] cpufreq: ti-cpufreq: Fix an incorrect error return value
Date: Wed,  9 Sep 2020 12:42:30 +0800
Message-Id: <20200909044233.4115-9-wens@csie.org>
In-Reply-To: <20200909044233.4115-1-wens@csie.org>
References: <20200909044233.4115-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dNS6kbJ5aJDcEWsuIm5HdAC6x4520388AA=
Content-Type: multipart/mixed; boundary="zrNtTjQjy7vFXNgxajUG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599626687;
 bh=XuJEhPJU6gzoJMpDKTmpC3dSnR3w4aDegapRdE9c/+M=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jlfXpOWsVeJx0SBUq/1RgdkB/HEshMmAJ9/iNFZJEPG5JL+hx9eR7RQDMvw2s1wHtak
 qlekZZYvTDKrrS/JIh7rPWCfrvXcj+TPDAVT4zMt3fzguOgXklGdJZujmPmAcIuvRRxyz
 r8WQZ/EcnaZ9LE7VeOYUzUCSZ8LhKd3aodM=

--zrNtTjQjy7vFXNgxajUG
Content-Transfer-Encoding: quoted-printable

From: Suman Anna <s-anna@ti.com>

commit e5d295b06d69a1924665a16a4987be475addd00f upstream.

Commit 05829d9431df ("cpufreq: ti-cpufreq: kfree opp_data when
failure") has fixed a memory leak in the failure path, however
the patch returned a positive value on get_cpu_device() failure
instead of the previous negative value. Fix this incorrect error
return value properly.

Fixes: 05829d9431df ("cpufreq: ti-cpufreq: kfree opp_data when failure")
Cc: 4.14+ <stable@vger.kernel.org> # v4.14+
Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[wens@csie.org: Fix commit reference format in commit log]
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/ti-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index afbe9db29992d..59777685114d9 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -218,7 +218,7 @@ static int ti_cpufreq_init(void)
 	opp_data->cpu_dev =3D get_cpu_device(0);
 	if (!opp_data->cpu_dev) {
 		pr_err("%s: Failed to get device for CPU0\n", __func__);
-		ret =3D ENODEV;
+		ret =3D -ENODEV;
 		goto free_opp_data;
 	}
=20
--=20
2.28.0


--zrNtTjQjy7vFXNgxajUG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5426): https://lists.cip-project.org/g/cip-dev/message=
/5426
Mute This Topic: https://lists.cip-project.org/mt/76726430/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--zrNtTjQjy7vFXNgxajUG--
