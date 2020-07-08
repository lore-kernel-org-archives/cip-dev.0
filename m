Return-Path: <SRS0=yKhE=AT=lists.cip-project.org=bounce+64572+4904+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A374C433E1
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11B720720
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="eVUkdQ6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11B720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4904+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DiPpYY4521723xGch1IfNmgu; Wed, 08 Jul 2020 08:46:44 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web10.13564.1594223184678863625
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:25 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id A7C5F60841; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 19/23] PM / OPP: Fix incorrect comments
Date: Wed,  8 Jul 2020 23:45:50 +0800
Message-Id: <20200708154554.26450-20-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZIxw30vx1fR3pRrweW8ke96Hx4520388AA=
Content-Type: multipart/mixed; boundary="T6IFZH95i8Um8HBAKCCi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223204;
 bh=iE+3DKobSt0xczsLKJMFDKP2PfP6tXRATw3d6wjn6ts=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=eVUkdQ6t2SO3+365cJdUqPG2LiFOt4ayPj4k83tkz3APXKmW7tBD9qd1KCz1sl3fvwS
 7P9N6Kt31TUQ85LQ76uRt7fpLv14k+uI8NnwKrlizNtyQBMMa1/CuHWjw/8RtwXyYvXCR
 2WlJDA25H7su19KOmH7/Km9eGbjyVE86Erw=

--T6IFZH95i8Um8HBAKCCi
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit a5da64477ee79efa748df256928ec8840a2a7986 upstream.

Some comments were just copy/pasted from other sections and don't match
to the routines they were added for. Fix them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index 72df25fae3864..ba574b814e30f 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1254,7 +1254,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_supported_hw);
=20
 /**
  * dev_pm_opp_put_supported_hw() - Releases resources blocked for suppor=
ted hw
- * @dev: Device for which supported-hw has to be set.
+ * @dev: Device for which supported-hw has to be put.
  *
  * This is required only for the V2 bindings, and is called for a matchi=
ng
  * dev_pm_opp_set_supported_hw(). Until this is called, the device_opp s=
tructure
@@ -1303,7 +1303,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
=20
 /**
  * dev_pm_opp_set_prop_name() - Set prop-extn name
- * @dev: Device for which the regulator has to be set.
+ * @dev: Device for which the prop-name has to be set.
  * @name: name to postfix to properties.
  *
  * This is required only for the V2 bindings, and it enables a platform =
to
@@ -1362,7 +1362,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
=20
 /**
  * dev_pm_opp_put_prop_name() - Releases resources blocked for prop-name
- * @dev: Device for which the regulator has to be set.
+ * @dev: Device for which the prop-name has to be put.
  *
  * This is required only for the V2 bindings, and is called for a matchi=
ng
  * dev_pm_opp_set_prop_name(). Until this is called, the device_opp stru=
cture
--=20
2.27.0


--T6IFZH95i8Um8HBAKCCi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4904): https://lists.cip-project.org/g/cip-dev/message=
/4904
Mute This Topic: https://lists.cip-project.org/mt/75379096/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--T6IFZH95i8Um8HBAKCCi--
