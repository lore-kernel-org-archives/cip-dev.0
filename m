Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5D0C433EF
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 13:50:51 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web12.12755.1654609849668491510
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 06:50:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: vijaikumar_kanagarajan@mentor.com)
X-IronPort-AV: E=Sophos;i="5.91,284,1647331200";
   d="scan'208";a="76783571"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 07 Jun 2022 05:50:50 -0800
IronPort-SDR: 
 zg5nLtZpA/E7HJiaRiUMWXocVTg5fxoMw5NNvpFvagnLpbUd6YG38mTmvSl0sTiXVVSOtILYvx
 xLI7Teg1xIttJyq7i8pvvZ7jqAmUUINtEZryNpqwUwr/AwUwM0wyGUFRLqYSWtAhp6XrNCLwIZ
 GaKqUoJyN/+EwOI6Z8jJVNa9DDst8xxIvLEhV7SPA4lvBEjSBXYIwt387O5IACny7sMvmb0ynp
 HEZaf4nJlKPV7m5BqejdzKk4l8dIvSR1Elqw+EqE8r5ayUEZBU0smqI2TKgJYzonUrJqvmP1qK
 WU4=
From: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
To: <jan.kiszka@siemens.com>, <quirin.gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
CC: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [isar-cip-core][PATCH 1/3] recipes-core/ltp: Update to the latest ltp
 version
Date: Tue, 7 Jun 2022 19:20:14 +0530
Message-ID: <20220607135016.1856603-2-Vijaikumar_Kanagarajan@mentor.com>
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
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 13:50:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8509

Update to the latest ltp version. The latest ltp version depends on
pkg-config.

Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
---
 recipes-core/ltp/files/debian/control                         | 2 +-
 .../ltp/{ltp-full_20190930.bb => ltp-full_20220527.bb}        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-core/ltp/{ltp-full_20190930.bb => ltp-full_20220527.bb} (67%)

diff --git a/recipes-core/ltp/files/debian/control b/recipes-core/ltp/files/debian/control
index 5ec4b9d..9caaf38 100644
--- a/recipes-core/ltp/files/debian/control
+++ b/recipes-core/ltp/files/debian/control
@@ -2,7 +2,7 @@ Source: ltp-full
 Section: embedded
 Priority: optional
 Maintainer: Gylstorff Quirin <quirin.gylstorff@siemens.com>
-Build-Depends: debhelper (>= 11), autotools-dev
+Build-Depends: debhelper (>= 11), autotools-dev, pkg-config
 Standards-Version: 4.1.3
 Homepage: https://linux-test-project.github.io/
 
diff --git a/recipes-core/ltp/ltp-full_20190930.bb b/recipes-core/ltp/ltp-full_20220527.bb
similarity index 67%
rename from recipes-core/ltp/ltp-full_20190930.bb
rename to recipes-core/ltp/ltp-full_20220527.bb
index fc35f5e..5b40df1 100644
--- a/recipes-core/ltp/ltp-full_20190930.bb
+++ b/recipes-core/ltp/ltp-full_20220527.bb
@@ -14,10 +14,10 @@ inherit dpkg
 DESCRIPTION = "Linux Test project for CIP"
 
 SRC_URI = " \
-   https://github.com/linux-test-project/ltp/releases/download/20190930/ltp-full-${PV}.tar.xz \
+   https://github.com/linux-test-project/ltp/releases/download/${PV}/ltp-full-${PV}.tar.xz \
    file://debian \
    "
-SRC_URI[sha256sum] = "c7049590df2da3135030db5ef4c0076b76c789724a752b1102b4a01db0189f9a"
+SRC_URI[sha256sum] = "d635afb5ec7b0de763ab50713baf9fbf65cf089da6e6768f816e4a166cbd17c4"
 
 
 do_prepare_build() {
-- 
2.25.1


