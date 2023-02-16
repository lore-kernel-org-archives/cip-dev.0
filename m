Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE3BC61DA4
	for <webhook@archiver.kernel.org>; Thu, 16 Feb 2023 04:37:27 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.3481.1676522241257402642
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Feb 2023 20:37:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=hTv/Mu3K;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-20230216043718fd2bcff6e0c9d66860-m3tv6k@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230216043718fd2bcff6e0c9d66860
        for <cip-dev@lists.cip-project.org>;
        Thu, 16 Feb 2023 05:37:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=LZ7mcJEPXQ4qu50W721/LfSlOjkm5gQ4YwI2psH5jZk=;
 b=hTv/Mu3KqX9njekvvmOuSzShXdks3HKiJIEYhhzLC9HKD+dR2IVh4ml+MFtKlUiwKJehYM
 FxGa7BzDvDAdOgJYWUURTCngxNacAMRjTqRg4L6su7Af9ct63WIUKmT8VrCEzFEvayr6M6je
 /ynMmthkn9QAaKYoEp0D2oi7kU0bI=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v5 4/8] swupdate: only check partition uuids on swupdate
Date: Thu, 16 Feb 2023 04:37:06 +0000
Message-Id: <20230216043706.2003663-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Feb 2023 04:37:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10709

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
index bb648c2..2a497fb 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -104,3 +104,11 @@ IMAGE_CMD:swu() {
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
index f4f5c42..08867cd 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -14,9 +14,3 @@ inherit read-only-rootfs
 
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


