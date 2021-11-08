Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAB6C433EF
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 09:33:22 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web08.42769.1636364001609998947
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Nov 2021 01:33:21 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: vijaikumar_kanagarajan@mentor.com)
IronPort-SDR: 
 ORwzCnyRddeCBmkCbGWj9l3w4JEATPMeFxksQ+wsrWb/bLrSGi/iFHa058ka/P/fclXzbaSdEG
 ZLkvqPcHtmvC+KqCKCofeAIBgd9M/mytO3ONYMDlpIkjkZ9mzYryANZhu03pxRk/p6OodMTmyb
 k4gj/l4anIt+l2/bR0QsFqV8sSfHrNL4e7epA7CpD4QKJv/Y1uIGNcw1RL6FyxPWWwjhayuBn4
 qWEqlnw826lvCXLDz/AqdPvnKL0QQz5BAyaA7TZeOenCx1lH+6+CHQRHT9XwoQTOotdpvJ9JSd
 Lku9m4jULnSOfddWvx37sMP0
X-IronPort-AV: E=Sophos;i="5.87,218,1631606400";
   d="scan'208";a="68020319"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 08 Nov 2021 01:33:20 -0800
IronPort-SDR: 
 ZN1+Ti1WWzARntFGATLP9SrqphisgschS/CI2rqhcmZTS1YBd+pwn5bZy0pYZC0+OfzRCPOTti
 eB11HrD0atvGwY93/Pe+1wYUb7poFfStc7PZrqhM/9MnHn4SDCfAVpx98wmctVRc9Mj5ztPHt0
 BVDslBsouRcBDFeT1a2vv8SUIpTLsygC21aAtdDUyinjkZd8oRJPmhhfr4pfMsC8hNe03ZcxMw
 d89TMny//D8FwQV+y5A3pyrOt60WBed3ELBPIKs7gwqHX+6DZgbqB3UxOxgqx854hH2QfiD+0X
 ldw=
From: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [isar-cip-core][PATCH] swupdate: Remove superflous patch
Date: Mon, 8 Nov 2021 15:02:59 +0530
Message-ID: <20211108093259.3309527-1-Vijaikumar_Kanagarajan@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Nov 2021 09:33:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6863

Same as 0008-debian-rules-Add-Embedded-Lua-handler-option.patch.

Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
---
 ...ules-Add-Embedded-Lua-handler-option.patch | 30 -------------------
 1 file changed, 30 deletions(-)
 delete mode 100644 recipes-core/swupdate/files/0005-debian-rules-Add-Embedded-Lua-handler-option.patch

diff --git a/recipes-core/swupdate/files/0005-debian-rules-Add-Embedded-Lua-handler-option.patch b/recipes-core/swupdate/files/0005-debian-rules-Add-Embedded-Lua-handler-option.patch
deleted file mode 100644
index 84665cd..0000000
--- a/recipes-core/swupdate/files/0005-debian-rules-Add-Embedded-Lua-handler-option.patch
+++ /dev/null
@@ -1,30 +0,0 @@
-From 0200687ad67d6e5a0e9bbdf2e8c86e3f8e717c5e Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Wed, 29 Sep 2021 11:32:41 +0200
-Subject: [PATCH 5/6] debian/rules: Add Embedded Lua handler option
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- debian/rules | 5 +++++
- 1 file changed, 5 insertions(+)
-
-diff --git a/debian/rules b/debian/rules
-index 69fd790..9ace348 100755
---- a/debian/rules
-+++ b/debian/rules
-@@ -52,7 +52,12 @@ ifneq (,$(LUA_VERSION))
- 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
- 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
- 	echo CONFIG_HANDLER_IN_LUA=y             >> configs/debian_defconfig
-+ifneq (,$(filter pkg.swupdate.embeddedlua,$(DEB_BUILD_PROFILES)))
-+	echo CONFIG_EMBEDDED_LUA_HANDLER=y                              >> configs/debian_defconfig
-+	echo CONFIG_EMBEDDED_LUA_HANDLER_SOURCE=\"/usr/share/lua/$(LUA_VERSION)/swupdate_handlers.lua\" >> configs/debian_defconfig
- endif
-+endif
-+
- 	echo CONFIG_EXTRA_CFLAGS=\"$(CFLAGS) $(CPPFLAGS)\" >> configs/debian_defconfig
- 	echo CONFIG_EXTRA_LDFLAGS=\"$(LDFLAGS)\"           >> configs/debian_defconfig
- 	echo CONFIG_EXTRA_LDLIBS=\"$(LDLIBS)\"             >> configs/debian_defconfig
--- 
-2.30.2
-
-- 
2.25.1


