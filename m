Return-Path: <SRS0=UpXe=AT=lists.cip-project.org=bounce+64572+4906+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C410AC433DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926AC206DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wFXJ8o7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926AC206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4906+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Gj5iYY4521723x2o6KIZnKTo; Wed, 08 Jul 2020 08:46:41 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web10.13565.1594223184719123129
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:25 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id B7020608CF; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 21/23] cpufreq: dt: Drop stale comment
Date: Wed,  8 Jul 2020 23:45:52 +0800
Message-Id: <20200708154554.26450-22-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: H0AGFkKrT43mHL9F34tEcZ7zx4520388AA=
Content-Type: multipart/mixed; boundary="Y3RQiN6sxpOWskcowjRj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223201;
 bh=KpGbOoQRQhg4BpuBBRKysFhPmY0oyJBCuz7TS0499F0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wFXJ8o7HeDNH8UvPnIMo1OJdnLGuQFj0YZQ3Fr/mVT0fibRpSPHMYRPkUfBqQlKcmSJ
 01BHHTLNBWCjTANRqmUSthjHdm3KGe0eLkyNkrUCPb65k6xRQNSL8cOGrELbdRZUzU64W
 3eedupeaeAVgqQ/NhPuaweiMrUbdi9k+f8I=

--Y3RQiN6sxpOWskcowjRj
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit b318556479cc923970a79d6c2311138581c0db83 upstream.

The comment in file header doesn't hold true anymore, drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/cpufreq-dt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index f951f911786e0..5f8dbe640a202 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -4,9 +4,6 @@
  * Copyright (C) 2014 Linaro.
  * Viresh Kumar <viresh.kumar@linaro.org>
  *
- * The OPP code in function set_target() is reused from
- * drivers/cpufreq/omap-cpufreq.c
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
--=20
2.27.0


--Y3RQiN6sxpOWskcowjRj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4906): https://lists.cip-project.org/g/cip-dev/message=
/4906
Mute This Topic: https://lists.cip-project.org/mt/75379098/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Y3RQiN6sxpOWskcowjRj--
