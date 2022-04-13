Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E130DC35296
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web09.3448.1649834203249368757
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=i/NW8ToZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-294854-202204130716411568aed146e5ada199-j4yfjn@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 202204130716411568aed146e5ada199
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NerAL1RtRUBoGMEUAFjz+Mc0ZfWzzzTSI/DNoJvnO6A=;
 b=i/NW8ToZuQztZHy6HBen9LWGcM2kPbhEL4zlUhHCB2aW13XFQUDKw1Xk7G59rvp4sYN2Wz
 ZkIwQKaLBIqsnzVNIDPV325bI80wG8WisXrgYTjlEi+GN8PJ5cZSp7e7EGlO/zwjtAWTWbB9
 vIIr6XG7ZECNa9TouXoGckftij2oQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 12/19] cip-core-image: Make image-uuid an image
 option
Date: Wed, 13 Apr 2022 09:16:29 +0200
Message-Id: 
 <51a923c07081a08eff871979a91aae7926df5e3c.1649834193.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8060

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to avoid running this needless task for the secure image
where we use the dm-verity hash as image identification.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/ebg-swu.yml                   |  3 +++
 recipes-core/images/cip-core-image.bb |  1 -
 recipes-core/images/image-uuid.inc    | 12 ++++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/images/image-uuid.inc

diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index a58f0ed..d811929 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -18,3 +18,6 @@ header:
 local_conf_header:
   initramfs: |
     IMAGE_INSTALL += "initramfs-abrootfs-hook"
+
+  image-option-uuid: |
+    CIP_IMAGE_OPTIONS_append = " image-uuid.inc"
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index ecba06d..3f8c320 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -10,7 +10,6 @@
 #
 
 inherit image
-inherit image_uuid
 
 ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
 DESCRIPTION = "CIP Core image"
diff --git a/recipes-core/images/image-uuid.inc b/recipes-core/images/image-uuid.inc
new file mode 100644
index 0000000..5e5a727
--- /dev/null
+++ b/recipes-core/images/image-uuid.inc
@@ -0,0 +1,12 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit image_uuid
-- 
2.34.1


