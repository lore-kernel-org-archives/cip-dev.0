Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F915CA5FA5
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 04:40:50 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1004.1790657644095273467
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Sep 2026 21:54:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm1 header.b=aDwe01F1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1328765-202609290443563da3797c8e00020731-jjd_lf@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202609290443563da3797c8e00020731
        for <cip-dev@lists.cip-project.org>;
        Tue, 29 Sep 2026 06:43:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=x8th5KfnxCAjZEHm1OEXvQ2+45bFRVNl7eCq+8VKCOw=;
 b=aDwe01F1qSZwvO/4n+6ETW+v8/jxtAj73/n0VX22o2E1e5f0QMPFYPYu135bDgt2loQL0h
 KFgtxP/S6VvAuKK3xBsEjE9atOM5GhfGmhffFg6y46bsf0DoLAcOc/Igk2iWIRWZUDnbsNyG
 9QsHHTY88m98NsA3C0w538bR8Lzu1EOBTeP1cZxZ7xcBrUtlRCzV2rFIhwTO9E0u8O5zLpqe
 FHUBObcq6ud5VTIMk+JkNBEeZls6sQZEKk4QERzgHozvBPa0I4aXv0q8VN4ryt7GxRc7Y1CV
 8yY5Rv4QIgGq40l56k43uTXmEz4jxPiM/yOaX8goqB6QBkt9Vv/5qZ1g==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 6.12.111-cip32
Date: Tue, 29 Sep 2026 00:43:13 -0400
Message-ID: <20260929044313.144425-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Oct 2026 04:40:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24391

Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb             | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb             | 1 +
 ...{linux-cip_6.12.108-cip31.bb => linux-cip_6.12.111-cip32.bb} | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb
 rename recipes-kernel/linux/{linux-cip_6.12.108-cip31.bb => linux-cip_6.12.111-cip32.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb b/recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb
deleted file mode 120000
index 6b45063..0000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.108-cip31.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb b/recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb
new file mode 120000
index 0000000..8003b24
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb
@@ -0,0 +1 @@
+linux-cip_6.12.111-cip32.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_6.12.108-cip31.bb b/recipes-kernel/linux/linux-cip_6.12.111-cip32.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.108-cip31.bb
rename to recipes-kernel/linux/linux-cip_6.12.111-cip32.bb
index 7373de3..5a225b4 100644
--- a/recipes-kernel/linux/linux-cip_6.12.108-cip31.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.111-cip32.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "baf5969362189174c1d0b3480bc33defd3b9ccb73af768b811c117c2e16f8244"
+SRC_URI[sha256sum] = "879b45f18c1bd8322b2026f72642faedcb77242418cb10a5aa56f5404f647059"
-- 
2.39.5


