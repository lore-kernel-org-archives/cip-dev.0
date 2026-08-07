Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5643DC5AC7A
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 14:39:05 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43814.1786113541388015408
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Aug 2026 07:39:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=YKfhNvCk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1330684-20260807143858783a35518b000207fa-juffeq@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260807143858783a35518b000207fa
        for <cip-dev@lists.cip-project.org>;
        Fri, 07 Aug 2026 16:38:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=6vfUx/bMXwid6uLCuzhEJeMwkNbiw0djWWDgJMS0lEE=;
 b=YKfhNvCkKdjzEntkSTByn7DVAAa7rbiAa74iI9Shd5gpPFnqgOAiBI1Zuy3nwdXwL3aoH/
 CkxELwmh2JNVqI0EWDf+Uu3BxR/zefBlsgMKKO+lW4awpUG531Ql7h19gQ9WPJITtL0LatYr
 ERlyqG5pBk0YCCpQXdJa9xqXTTzVPZ1JYwIM9VTHGM5u16iCYQcJgL4scXuwY8EmDkggz+j/
 Zs+CxL6pCH18HKrozEUXu7POH29H6V+zxE+OaDzepNCznKQdo6o5dHfzWA8bQEDzEnx76gNT
 pmlsvAXtejYYPk7/8Wd+ErjrpHpU3A/RQQIOpvMQaTVxj55t/IbnDlhw==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: Fixing comment on prereqs.
Date: Fri,  7 Aug 2026 16:38:55 +0200
Message-ID: <20260807143855.324433-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Aug 2026 14:39:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23874

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 .../initramfs-crypt-hook/files/local-top-complete           | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 recipes-initramfs/initramfs-crypt-hook/files/local-top-complete

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
old mode 100644
new mode 100755
index 1044f2a..963f82f
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -12,13 +12,13 @@
 prereqs()
 {
 	# Make sure that this script is run last in local-top
-	# If the abroofs or verity hooks are installed, this script
-	# should still come after them.
+	# but before abrootfs, verity and cryptroot
 	local req
 	for req in "${0%/*}"/*; do
 		script="${req##*/}"
 		if [ "$script" != "${0##*/}" ] &&
-		   [ "$script" != "abrootfs" ] && [ "$script" != "verity" ] &&
+		   [ "$script" != "abrootfs" ] &&
+		   [ "$script" != "verity" ] &&
 		   [ "$script" != "cryptroot" ]; then
 			printf '%s\n' "$script"
 		fi
-- 
2.47.3


