Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C38C433F5
	for <webhook@archiver.kernel.org>; Fri, 29 Oct 2021 05:40:09 +0000 (UTC)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web11.1695.1635486008179360772
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Oct 2021 22:40:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.129.153, mailfrom: srinuvasan_a@mentor.com)
IronPort-SDR: 
 b88499HEAMcxRGNrvRAd1z3JKXHPWRkk1RCG/o67DKmdInUYeGGSyW590GkDFPmTvBMsWdWDy3
 pBw32SFAdHcslENBqAUTdG9VKKiEoxbwYkUmObYFhqQUk8cmbgOAifwPMhtIM+rwbchfZ1DqT+
 NK84sUhIpFpiFea2yWZilJqHG8s1R0o3YLANciY3iMq52reHoMkL8cimcNXwqzBrW+ten68IpG
 T8IFlBc8a1O8NzScBvcE11JciDRMx7Sqg38sGxvE0MGo7ko+qlfcjA/z6UCCwnp1shX4xzyAGj
 2/3ZIioDRQgICBcNzo5+L7No
X-IronPort-AV: E=Sophos;i="5.87,191,1631606400";
   d="scan'208";a="70250821"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 28 Oct 2021 21:40:08 -0800
IronPort-SDR: 
 IzjVziKfCLWb99iK5QVSrWlydFtNjolMuK7YmdUpycPFDGszHmuDN1WGOuItVQR9v69g4eySV/
 wyuouo4wgyNyWtpxj+PCDCz5IJKUKX/DMVAfcst74waKrACOcNGfRECzfhFhgeXPdvZNJsVytL
 5RBFIrOT4R7Y4uUAMQFzBb3AsiQ5bLS3u0mystduy7yOR6nt2JWVDVuZlxEb/8W4Bg0me85/UX
 blwE1JVeIQAx4LyM0yM4NOYlclgVvSnnMOZ7AsxygPeBM+3TcwHaB8j1/SkYVHFR9OoiCILG6m
 6n8=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-dev] [PATCH] recipes-core/swupdate: Update the SRC_URI and
 SWUPDATE_BUILD_PROFILES append for buster
Date: Fri, 29 Oct 2021 11:09:40 +0530
Message-ID: <20211029053940.625034-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f1d37383-5262-910f-4791-f42a8f16cb66@siemens.com>
References: <f1d37383-5262-910f-4791-f42a8f16cb66@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Oct 2021 05:40:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6849

From: Srinuvasan A <srinuvasan_a@mentor.com>

When we build the swupdate debian package for buster some build
dependency packages are not available in stable buster repo, hence we created a
patch in cip-core upstream for buster build, here we hardcoded the distro
for buster build hence it is building fine in cip-core not the
downstream layer, added the "BASE_DISTRO_CODENAME" variable to pick the proper base distro.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
index a451b55..e6526ba 100644
--- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
@@ -35,14 +35,14 @@ SWUPDATE_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
 # SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
 
 # modify for debian buster build
-SRC_URI_append_cip-core-buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
+SRC_URI_append_${BASE_DISTRO_CODENAME} = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
 
 # disable documentation due to missing packages in debian buster
 # disable create filesystem due to missing symbols in debian buster
 # disable webserver due to missing symbols in debian buster
-SWUPDATE_BUILD_PROFILES_append_cip-core-buster = " nodoc \
-                                                   pkg.swupdate.nocreatefs \
-                                                   pkg.swupdate.nowebserver "
+SWUPDATE_BUILD_PROFILES_append_${BASE_DISTRO_CODENAME} = " nodoc \
+                                                           pkg.swupdate.nocreatefs \
+                                                           pkg.swupdate.nowebserver "
 # In debian buster the git-compression defaults to gz and does not detect other
 # compression formats.
 GBP_EXTRA_OPTIONS += "--git-compression=xz"
-- 
2.25.1


