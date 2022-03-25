Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BE9C433F5
	for <webhook@archiver.kernel.org>; Fri, 25 Mar 2022 08:34:31 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web12.2856.1648197269674757719
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Mar 2022 01:34:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400";
   d="scan'208";a="73584237"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 25 Mar 2022 00:34:29 -0800
IronPort-SDR: 
 HV9Rt5eeJeRsVlgcnUHlN0DdoaApiGLyWlAyn6VZ9U6fZ8wO+tN23Obe2Nk7CPbr2MbtU8a6qs
 2rHV643MX1VVW9/g6OZHrvI84qZXh3rF091bHsO9FT9dbIXjYIVOUchiJbNuAp/qshAMa0tTPI
 +lgvbitH+k26JOYN54YEes/taplEDLEjLR+2/XtXU55ddVDme4FrNX/of1tsq14nr1PH/WQ6aP
 RZ5/ONm5g/kr67aH+5v8uJVmGw9kZW/uqByXqWJSBBp5f4iNNAZvFyUyvm8z6Y9ju898gkcfaN
 ZHc=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [cip-dev][isar-cip-core][PATCH] python3-shtab: add export to the
 DEB_BUILD_PROFILES
Date: Fri, 25 Mar 2022 14:04:08 +0530
Message-ID: <20220325083408.4080473-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Mar 2022 08:34:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7822

From: Srinuvasan A <srinuvasan_a@mentor.com>

When we build this recipes in downstream layer the DEB_BUILD_PROFILES not
able to find by rule file hence it is not set the required build
profiles.

Here we disable the tests `PYBUILD_DISABLE=test`, but due to this
unavailability of DEB_BUILD_PROFILES in rule file it is building along
with the test hence it's getting failed like "Not able to import module
pytest"

Exported this one to access from rule file.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 recipes-python/shtab/python3-shtab_1.4.2.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-python/shtab/python3-shtab_1.4.2.bb b/recipes-python/shtab/python3-shtab_1.4.2.bb
index ce83d6b..554afd3 100644
--- a/recipes-python/shtab/python3-shtab_1.4.2.bb
+++ b/recipes-python/shtab/python3-shtab_1.4.2.bb
@@ -27,7 +27,7 @@ DEBIAN_BUILD_DEPENDS = " \
     python3-setuptools-scm:native, \
     "
 
-DEB_BUILD_PROFILES = "nocheck"
+export DEB_BUILD_PROFILES = "nocheck"
 
 do_prepare_build[cleandirs] += "${S}/debian"
 do_prepare_build() {
-- 
2.25.1


