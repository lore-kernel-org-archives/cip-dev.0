Return-Path: <SRS0=FsgA=AT=lists.cip-project.org=bounce+64572+4896+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD14CC433E0
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3CF206DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="J9YK7Xok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3CF206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4896+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wqePYY4521723x5cGO5XK7nW; Wed, 08 Jul 2020 08:46:34 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web11.13703.1594223182933119721
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:23 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 5C6B35FE3B; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 10/23] cpufreq: dt: OPP layers handles clock-latency for V1 bindings as well
Date: Wed,  8 Jul 2020 23:45:41 +0800
Message-Id: <20200708154554.26450-11-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DAmoW9nr8bXlSRKdyPK5Xyfex4520388AA=
Content-Type: multipart/mixed; boundary="fMPJzzCMRLhdBVnKm3OL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223194;
 bh=VlDCGA+1vJ0YUlyLhmZBZejsW6Y22UrGWeix/w6x63o=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=J9YK7XokHYE8E3ZdRKP5Ctz7kZOH5mhixUNkYAYjuKEFfGYQ2ztyhjHoCYImsdrGKIv
 41IXNsI5wXSJjVXJREI3xYL+tDVmgdygdJkUQlR17ArpRqq26UmeIVybUJb0HJhHha44x
 LriQsuugABplE8/7ciZ0aZlyQtXMT3yQwe4=

--fMPJzzCMRLhdBVnKm3OL
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 391d9aef8145204e0a5d67be3bd1fc45c5396dae upstream.

"clock-latency" is handled by OPP layer for all bindings and so there is
no need to make special calls for V1 bindings. Use
dev_pm_opp_get_max_clock_latency() for both the cases.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/cpufreq-dt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 0047d20803db7..4c9f8a828f6f1 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -265,10 +265,6 @@ static int cpufreq_init(struct cpufreq_policy *polic=
y)
 		if (ret)
 			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
 				__func__, ret);
-
-		of_property_read_u32(np, "clock-latency", &transition_latency);
-	} else {
-		transition_latency =3D dev_pm_opp_get_max_clock_latency(cpu_dev);
 	}
=20
 	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -279,6 +275,7 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
=20
 	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance)=
;
=20
+	transition_latency =3D dev_pm_opp_get_max_clock_latency(cpu_dev);
 	if (!transition_latency)
 		transition_latency =3D CPUFREQ_ETERNAL;
=20
--=20
2.27.0


--fMPJzzCMRLhdBVnKm3OL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4896): https://lists.cip-project.org/g/cip-dev/message=
/4896
Mute This Topic: https://lists.cip-project.org/mt/75379088/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--fMPJzzCMRLhdBVnKm3OL--
