Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB30AC636D3
	for <webhook@archiver.kernel.org>; Sun, 12 Feb 2023 22:54:23 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.7533.1676190512775611233
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Feb 2023 00:28:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=amfaT6qm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-72506-20230212082830cc451d5a4318befe3a-uawc_c@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230212082830cc451d5a4318befe3a
        for <cip-dev@lists.cip-project.org>;
        Sun, 12 Feb 2023 09:28:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dq/SJtvA2ylObjmDy9EGH5ViaMQyt+HXYdQghKCUP8g=;
 b=amfaT6qmc+ffLZQEN8SDfuRXPiSwsFfroF1SaQKSqPZDKdWm1XUWpYOPqQFKEx1+P5tBKS
 3qxrvrHRo3rYGK+8l2rLcMtdbXgzJmnqrHnYpZ5fmm1aSTCGoiRd0/cLsi1qLlYq//0qL3aa
 S121xJyrc2fE9uKL8qffvwdd3gcWU=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v4 4/8] swupdate: only check partition uuids on swupdate
Date: Sun, 12 Feb 2023 08:27:54 +0000
Message-Id: <20230212082758.1166262-5-felix.moessbauer@siemens.com>
In-Reply-To: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
References: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Feb 2023 22:54:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10674

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
index 50a15e1..931ac30 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -103,3 +103,11 @@ IMAGE_CMD:swu() {
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


