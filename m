Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6356AC44501
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 13:09:25 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12540.1784207358287663052
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 06:09:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=KG+Fu4y5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20260716130914980473ce5500020779-yfervi@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260716130914980473ce5500020779
        for <cip-dev@lists.cip-project.org>;
        Thu, 16 Jul 2026 15:09:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=KTQnkpRrKLKMPBdB35+QCEcLGFp9fa67IjOW5zRYL5c=;
 b=KG+Fu4y5r+5mRRL58C6nz8o98sMnIQqdyrA7hjXWqbX1zR6sg4HtNhm7cTXZ/8EVtmJNOy
 0rKCdCxbC3I7d1qRPTFPM2ngdNHzpuhHxESkusMG7xMbhT1b4jVcw8CpU0zq7Ic2OjzX2Aad
 x8sslE8CGDe2la7hmeeROKNu1tvx/nofLCW+W8rlx7zyssKkDQm/ekDC1+nTTA4apcoqhS4X
 r0GM9oMilZAkReHDk8eFTZrmKL7L4QyntThj5g7ca9KLdsU2X/rkuvZripAjN7yrfjLKRXVg
 3iMslCZnJlJlnfhB7X+XWEzT6Cec/yZVBN+UEgq2o9aLvOwo7XqKJFVg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 1/3] initramfs-crypt-hook: suppress stderr output from stopping watchdog
Date: Thu, 16 Jul 2026 15:07:42 +0200
Message-ID: <20260716130816.1095792-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 13:09:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23622

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

In case the watchdog timeout is set to 0, the function immediately
returns and the process with the watchdog pid will be stopped,
this will lead to the following error message:

```
resize2fs 1.47.2 (1-Jan-2025)
Resizing the filesystem on /dev/mapper/encrypted_userdata to 2043904 (4k) blocks.
The filesystem on /dev/mapper/encrypted_userdata is now 2043904 (4k) blocks long.
Wiped slot 0.
sh: can't kill pid 302: No such process
```

Reported-by: Stefan, Koch <stefan-koch@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index b033597..397b315 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -371,5 +371,5 @@ if [ -x /usr/bin/tpm2_shutdown ]; then
 fi
 
 if [ -n "$watchdog_pid" ]; then
-	kill "$watchdog_pid"
+	kill "$watchdog_pid"  > /dev/null 2>&1
 fi
-- 
2.53.0


