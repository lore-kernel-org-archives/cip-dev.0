Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B720C79F99
	for <webhook@archiver.kernel.org>; Tue,  8 Sep 2026 14:03:57 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31552.1788775173092906715
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Sep 2026 02:59:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm2 header.b=CQSGCpTW;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1328765-20260907094924b8addf3bcd00020781-mqjvuv@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260907094924b8addf3bcd00020781
        for <cip-dev@lists.cip-project.org>;
        Mon, 07 Sep 2026 11:49:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Y7DvwcIDOKsmcSewgTa2cQmVlQ9wuPlJtMb+8h29k90=;
 b=CQSGCpTWQ9egxf2kiDRVTbJ4o2O+ouD+4z/ZzbSNJXy/LEuPwRR1rX4jtb7X0RZj9cs1TV
 4Et2oVvYnjqVpeQpgV/DQI4/iVhQteZrrPoZx7oxEbnxgtCIYbo8P3JNbbxRTULaWZPGhG9D
 QGUmjaqPP5tmQSlJS6pccy3AzUrwrsDJNVD42cE1OuOms7L/bXH7xsnUzl7s+Vj4Mj70Z+YO
 MQU4jvvciJe3vsbP1IKnMpCiZwvVpZZDOFh8Bb2LXbJFV9gWFvv0zoEorLEJL79tD0TGUPgd
 iYYwbBCO2R8AUPOdkX+iET86R+E1epTkUzd2flfsnOB3rfLIDi9vqFXg==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 6.12.108-cip31
Date: Mon,  7 Sep 2026 05:48:46 -0400
Message-ID: <20260907094846.359272-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Sep 2026 14:03:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24102

Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb             | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb             | 1 +
 ...{linux-cip_6.12.104-cip30.bb => linux-cip_6.12.108-cip31.bb} | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb
 rename recipes-kernel/linux/{linux-cip_6.12.104-cip30.bb => linux-cip_6.12.108-cip31.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb b/recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb
deleted file mode 120000
index e767cba..0000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.104-cip30.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb b/recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb
new file mode 120000
index 0000000..6b45063
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb
@@ -0,0 +1 @@
+linux-cip_6.12.108-cip31.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_6.12.104-cip30.bb b/recipes-kernel/linux/linux-cip_6.12.108-cip31.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.104-cip30.bb
rename to recipes-kernel/linux/linux-cip_6.12.108-cip31.bb
index 8b7671f..7373de3 100644
--- a/recipes-kernel/linux/linux-cip_6.12.104-cip30.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.108-cip31.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "d4fbae6f58c86c1a1da3c23e013eab54caf57aa11efb323b98150298cddcbb18"
+SRC_URI[sha256sum] = "baf5969362189174c1d0b3480bc33defd3b9ccb73af768b811c117c2e16f8244"
-- 
2.39.5


