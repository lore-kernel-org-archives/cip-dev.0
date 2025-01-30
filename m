Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA8AC0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 08:53:48 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.11618.1738227226591527538
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 00:53:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=A8SUa2F2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202501300853435f338054bcc9d28b9f-atnqjv@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202501300853435f338054bcc9d28b9f
        for <cip-dev@lists.cip-project.org>;
        Thu, 30 Jan 2025 09:53:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Y00mOmOpqvLUZPxxXuPDnO1P1M51i/pFWFAs6stQBU4=;
 b=A8SUa2F2ymNWblnBXTT5pxsxtNpkTelsruflXCp9L92f00jtHx3uL135jUKzuhytLgm3XE
 a8+VObYNfywtI9YrRSGWmvOA/sEtQU+0KQGyQMLgpEG3Bq+jqbdVsNFFMSC2oe4cjIYTsFB+
 xufHaJrRCRogKnhd4RPqbCd2SuIVHVKpXg6tK5Nf7BRVmd2WnSGKAwVKQ73/f3Az7puT5uG3
 yZY9c+tLXZTPAUXYI30GpHeTlkOEsRpxYyi4rlOXgM0PjyuoG8+Onl7aWNYPBW0YlSGHJvvF
 8HCnZV5eIuLM7LV+yzQeebph73Z5H8H02+imjR/0BOFvwNUpqoqu1TmQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	ludwig.nussel@siemens.com,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2] read-only-rootfs.bbclass: Exclude boot,home and var from the erofs and squashfs
Date: Thu, 30 Jan 2025 09:51:53 +0100
Message-ID: <20250130085342.2806658-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 08:53:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17691

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This excludes the content of boot,home and var from the root file
system. Home and var are stored in separate partitions and boot
is not necessary as we use a unified kernel image(UKI). This UKI
is stored twice in separate partitions.

It should fix issue #126.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - Also exclude /boot
 - define empty RO_ROOTFS_EXCLUDE_DIRS in read-only-rootfs
 - define excluded partitions in recipes-core/images/swupdate.inc
 - Update Copyrights
 - Add information to commit message

 classes/read-only-rootfs.bbclass | 6 +++++-
 recipes-core/images/swupdate.inc | 8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index 9ebcadc..35a3ab3 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2020-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -34,6 +34,10 @@ copy_dpkg_state() {
     sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
 }
 
+RO_ROOTFS_EXCLUDE_DIRS ??= ""
+EROFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
+SQUASHFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
+
 image_configure_fstab() {
     sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
 # Begin /etc/fstab
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 81c3365..07dbe97 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2023-2024
+# Copyright (c) Siemens AG, 2023-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -12,6 +12,12 @@
 inherit image_uuid
 inherit read-only-rootfs
 
+# read-only rootfs with /home and /var
+# as separate partitions is used
+# /boot is excluded as an unified kernel image
+# is used. This images are stored in seperate partitions.
+RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
+
 SWU_SIGNED ?= "1"
 SWU_HW_COMPAT ?= "cip-core-1.0"
 IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
-- 
2.47.0


