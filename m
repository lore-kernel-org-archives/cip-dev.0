Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD43C352A1
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.3440.1649834201790323295
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Ji3D4ild;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-294854-2022041307164288fcf5a39b400db915-hwbedz@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2022041307164288fcf5a39b400db915
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6goxvXHlyZzvrSb4uGCMup++ZyGQ5feD37PjerDN3Bs=;
 b=Ji3D4ildxd4FgP0rMnU9SpF7u8FJVBSye/hO5kQ9AAql+s8Dkrw75kq+2idt3hiR7DmWZc
 hpngVIM0C2lXpHCcvEb4B7rMtwU5SFc+u7h0N0Cw5EPLCalNrMc75XfxYfFTz8+YP/F2YkAF
 UCEeBK+WGpQZ4QUglyNc/2FUV6mXs=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 15/19] customizations: Enable systemd watchdog
Date: Wed, 13 Apr 2022 09:16:32 +0200
Message-Id: 
 <89ec2cb2d8709419c8adffdc071242c69e50266a.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8063

From: Jan Kiszka <jan.kiszka@siemens.com>

This is needed for proper SWUpdate processing and does not harm in other
cases, even if the platform has no watchdog.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/customizations/common.inc             | 6 +++++-
 recipes-core/customizations/files/99-watchdog.conf | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/customizations/files/99-watchdog.conf

diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
index d3eb7b8..1124ff2 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -16,7 +16,8 @@ FILESPATH_append := ":${FILE_DIRNAME}/files"
 SRC_URI = " \
     file://postinst \
     file://ethernet \
-    file://99-silent-printk.conf"
+    file://99-silent-printk.conf \
+    file://99-watchdog.conf"
 
 WIRELESS_FIRMWARE_PACKAGE ?= ""
 INSTALL_WIRELESS_TOOLS ??= "0"
@@ -34,4 +35,7 @@ do_install() {
 
 	install -v -d ${D}/etc/sysctl.d
 	install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
+
+	install -v -d ${D}/etc/systemd/system.conf.d
+	install -v -m 644 ${WORKDIR}/99-watchdog.conf ${D}/etc/systemd/system.conf.d/
 }
diff --git a/recipes-core/customizations/files/99-watchdog.conf b/recipes-core/customizations/files/99-watchdog.conf
new file mode 100644
index 0000000..c02756d
--- /dev/null
+++ b/recipes-core/customizations/files/99-watchdog.conf
@@ -0,0 +1,3 @@
+[Manager]
+RuntimeWatchdogSec=60s
+ShutdownWatchdogSec=60s
-- 
2.34.1


