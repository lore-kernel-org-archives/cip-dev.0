Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61603CCA47C
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 13:51:01 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web12.12755.1654609849668491510
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 06:50:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: vijaikumar_kanagarajan@mentor.com)
X-IronPort-AV: E=Sophos;i="5.91,284,1647331200";
   d="scan'208";a="76783583"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 07 Jun 2022 05:50:57 -0800
IronPort-SDR: 
 VzI13qJhEKDAn726A//n9gkBSG5Wx+2piLT/j5p5V6IyX23flfeFqWoUgatcVZnJsEO2k+B7Bx
 cHjefT9QAPAoP/ULioEgYsesFABEICE3qyQ5g4UBhi5ZF9M8o0yJ7tPb2L3OieZHYAheCHtZ7F
 Ylqfa3/mznv/5ng/SRocNuR0LaTkb8oq+p4IwEO9s/FyTwCVx2+CQonyY7RMAPmt96MSLmo2Vh
 AkSrVy6v4QdzO2M4cXRGEUZkGq0LpCftfetFy+Bkl+0Mv5RFO9tO2qk1+ls+RcqVcwWV8MuwoM
 9Oo=
From: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
To: <jan.kiszka@siemens.com>, <quirin.gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
CC: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [isar-cip-core][PATCH 3/3] recipes-core/ltp: Disable autotest
Date: Tue, 7 Jun 2022 19:20:16 +0530
Message-ID: <20220607135016.1856603-4-Vijaikumar_Kanagarajan@mentor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607135016.1856603-1-Vijaikumar_Kanagarajan@mentor.com>
References: <20220607135016.1856603-1-Vijaikumar_Kanagarajan@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-15.mgc.mentorg.com (147.34.90.215) To
 svr-orw-mbx-12.mgc.mentorg.com (147.34.90.212)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 13:51:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8511

Fixes the following error during cross-build.

Makefile:207: *** running tests on cross-compile build not supported.  Stop.

Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
---
 recipes-core/ltp/files/debian/rules | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-core/ltp/files/debian/rules b/recipes-core/ltp/files/debian/rules
index a485615..06b9070 100755
--- a/recipes-core/ltp/files/debian/rules
+++ b/recipes-core/ltp/files/debian/rules
@@ -8,3 +8,5 @@ LTP_CONFIGURE_FLAGS = --prefix=/opt/ltp
 
 override_dh_auto_configure:
 	dh_auto_configure -- $(LTP_CONFIGURE_FLAGS)
+
+override_dh_auto_test:
-- 
2.25.1


