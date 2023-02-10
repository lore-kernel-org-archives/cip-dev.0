Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FED6C636CD
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 12:08:15 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.8330.1676011537591896575
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Feb 2023 22:45:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=DmC2Glpc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-2023021006453578e2d3cceb2f7719a8-v554pv@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023021006453578e2d3cceb2f7719a8
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Feb 2023 07:45:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tRS8UefPwOXp1o9uqnB6B1v6Zxcqc/IJy/1vXcoWJUs=;
 b=DmC2Glpc7oxeRNUD9IDJ11uQrd5TK4OdmHIGUZ6FIFGElYaDqjmIfn9ezKfifMLYtDgt1k
 F/M06eaq5TSIeIz6hNjVp7gNXtRV521/CjEnf8rSh99MsP5UVJJ7CWBAEMVA9w1kyXAxMmck
 x+auWYgiXjpI0y5ypmoyDG+TYnXGU=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2 4/5] swupdate: only check partition uuids on swupdate
Date: Fri, 10 Feb 2023 06:45:02 +0000
Message-Id: <20230210064503.706699-5-felix.moessbauer@siemens.com>
In-Reply-To: <20230210064503.706699-1-felix.moessbauer@siemens.com>
References: <20230210064503.706699-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 12:08:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10660

This patch moves the partition uuid check into a task to only execute
the logic in case an swu image is built. Previously this was checked at
parse time, leading to errors when not setting these variables and
building an image without swupdate support from an layer that also
provides images with swupdate support.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/swupdate.bbclass         | 8 ++++++++
 recipes-core/images/swupdate.inc | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 451dee6..6e117bd 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -99,3 +99,11 @@ IMAGE_CMD:swu() {
            fi
         done | cpio -ovL -H crc > "${BUILDCHROOT_IMAGE_FILE}"'
 }
+
+python do_check_swu_partition_uuids() {
+    for u in ['A', 'B']:
+        if not d.getVar('ABROOTFS_PART_UUID_' + u):
+            bb.fatal('ABROOTFS_PART_UUID_' + u + ' not set')
+}
+
+addtask check_swu_partition_uuids before do_image_swu
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 20ed600..3ec7767 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -15,9 +15,3 @@ inherit read-only-rootfs
 
 IMAGE_INSTALL += " swupdate"
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
-
-python() {
-    for u in ['A', 'B']:
-        if not d.getVar('ABROOTFS_PART_UUID_' + u):
-            bb.fatal('ABROOTFS_PART_UUID_' + u + ' not set')
-}
-- 
2.34.1


