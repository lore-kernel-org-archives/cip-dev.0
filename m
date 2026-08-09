Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950ACC5AC82
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 05:10:12 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6294.1786266188441019665
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Aug 2026 02:03:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm1 header.b=S7jIXBLu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1328765-2026080908525994514798c3000207d3-ihdbye@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026080908525994514798c3000207d3
        for <cip-dev@lists.cip-project.org>;
        Sun, 09 Aug 2026 10:53:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=e1dTunhelE7Sh3QswrbNsWOhNnQt/0OgC09Zb3wdt1Y=;
 b=S7jIXBLu7MEvV4cQm8oOpffJ4xgjO67M+7K1+gr5ZvGhKx8od9fWMN2MYW5u1V0yGFhC3r
 gtWN+NEq0Xo+FDP7NhttMPN/hjztVBK3kiIgzMceJZV/3KxNQeQSJ74m7Zyhr5iJ+dPwn4le
 Yzc4heNZWFe+bO/7/Vl6SRZ4zuuVG9kl36hNjYw9/cTOxA9YlE7wJr1Gztkzg4LBxjdppeuR
 sKowivIjaBbqeXTMaCzbPjOMhOr/KO7vp0Gi/PAYmFwSNZ4zAZGTQjwrANhrqieio+1Y4VZk
 PtO6afEI7+T9LD/bGIG2boczMTyP/6unVujYIJpUGjb2A4nrFcITp9fQ==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip113-rt62, 4.19.325-cip135, 5.10.263-cip76, 6.1.182-cip59, 6.12.101-cip29
Date: Sun,  9 Aug 2026 04:52:35 -0400
Message-ID: <20260809085235.525338-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Aug 2026 05:10:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23879

Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 ...4.302-cip111-rt61.bb => linux-cip-rt_4.4.302-cip113-rt62.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb             | 1 +
 recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb              | 1 -
 ...inux-cip_4.19.325-cip134.bb => linux-cip_4.19.325-cip135.bb} | 2 +-
 ...{linux-cip_5.10.260-cip75.bb => linux-cip_5.10.263-cip76.bb} | 2 +-
 .../{linux-cip_6.12.95-cip27.bb => linux-cip_6.1.182-cip59.bb}  | 2 +-
 .../{linux-cip_6.1.177-cip58.bb => linux-cip_6.12.101-cip29.bb} | 2 +-
 7 files changed, 6 insertions(+), 6 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip111-rt61.bb => linux-cip-rt_4.4.302-cip113-rt62.bb} (68%)
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip134.bb => linux-cip_4.19.325-cip135.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.260-cip75.bb => linux-cip_5.10.263-cip76.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.95-cip27.bb => linux-cip_6.1.182-cip59.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.1.177-cip58.bb => linux-cip_6.12.101-cip29.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip111-rt61.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip113-rt62.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip111-rt61.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip113-rt62.bb
index af553fd..039d5d0 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip111-rt61.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip113-rt62.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "d82994372165c85e4de9bd76b8d785beb9590c0f96404e47de92e917c408193e"
+SRC_URI[sha256sum] = "1e3e83a7dd31b9043849089e982f95a1158de530c31cb74b32c6362989fe0453"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb b/recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb
new file mode 120000
index 0000000..82a1b15
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb
@@ -0,0 +1 @@
+linux-cip_6.12.101-cip29.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb b/recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb
deleted file mode 120000
index 4280432..0000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.95-cip27.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip134.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip135.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip134.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip135.bb
index 0d60731..4ac075e 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip134.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip135.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "5a5a9570fb597f77229b7fc5ed0926e354cd0ed337bdf07099f53b8d71c31293"
+SRC_URI[sha256sum] = "6e3e5003854bd28e7f3b4880ab5f779e4e31ac7d4770f2fd1035a9b51c0d53e9"
diff --git a/recipes-kernel/linux/linux-cip_5.10.260-cip75.bb b/recipes-kernel/linux/linux-cip_5.10.263-cip76.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.260-cip75.bb
rename to recipes-kernel/linux/linux-cip_5.10.263-cip76.bb
index 45ae236..a5fd834 100644
--- a/recipes-kernel/linux/linux-cip_5.10.260-cip75.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.263-cip76.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "8b6200b2820ed0dee04bb3824b797e77e010f586fb3195cc5965b2b8316b6482"
+SRC_URI[sha256sum] = "bd235da3e82d643c4ef0bc71a6d21a11c6ad1c6e644ff625c72ba74daeeb96eb"
diff --git a/recipes-kernel/linux/linux-cip_6.12.95-cip27.bb b/recipes-kernel/linux/linux-cip_6.1.182-cip59.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.95-cip27.bb
rename to recipes-kernel/linux/linux-cip_6.1.182-cip59.bb
index e10e788..28391df 100644
--- a/recipes-kernel/linux/linux-cip_6.12.95-cip27.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.182-cip59.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "4b396f0d3505a3c119e16cc67d53f9c71d9da652b07ffe96a9c150c80aad783e"
+SRC_URI[sha256sum] = "d69fded945b0e9e905e3301918802ffbade6d8f3342c571accfe12a066370005"
diff --git a/recipes-kernel/linux/linux-cip_6.1.177-cip58.bb b/recipes-kernel/linux/linux-cip_6.12.101-cip29.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.177-cip58.bb
rename to recipes-kernel/linux/linux-cip_6.12.101-cip29.bb
index 3e1da8f..29268b0 100644
--- a/recipes-kernel/linux/linux-cip_6.1.177-cip58.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.101-cip29.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "6b22d939962adfe33a036016ea93089e4982d931c711109b1b1268ec2a59e03a"
+SRC_URI[sha256sum] = "b4f48eb4a0212bb308ac9e01f090c19ca3798281548d8778c4c9df80c18b7bed"
-- 
2.39.5


