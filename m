Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA32CC35294
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.3440.1649834201790323295
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=S6ca5VGw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-294854-20220413071639b5fda85eae376d18cc-p0eqdv@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20220413071639b5fda85eae376d18cc
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/neP2DqsRB7QLYgyJtwGqJQtHfGAwDI9gfMwR3+6rno=;
 b=S6ca5VGwEr1qDQ8j+4mdZDszRANYemNx9LJNDTTNFVDm5xVwfNxvJe9MY2PqttikhBPqF5
 wpDYhdA1A9hba5fvyl/7bRzIPMST4CqWVCj7NNbofC3KheIuV11C7T0wDbIizKLMFhFcVA0V
 pmZP7TebO9zvoK0vUep8FY61FUD30=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 06/19] Rename initramfs-abrootfs-secureboot to
 initramfs-abrootfs-hook
Date: Wed, 13 Apr 2022 09:16:23 +0200
Message-Id: 
 <97078215b7c27cc404046015b84da6422ecd5a35.1649834193.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8053

From: Jan Kiszka <jan.kiszka@siemens.com>

It had nothing to do with secure boot at all, only with selecting the
rootfs from the initramfs via a uuid match.

Relocate to recipes-initramfs as well at this chance as this is more
logical, even if initramfs-abrootfs-hook is not using the initramfs
image class yet.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-abrootfs-hook/files/debian-local-patch      | 0
 .../files/initramfs.image_uuid.hook                       | 0
 .../initramfs-abrootfs-hook}/files/initramfs.lsblk.hook   | 0
 .../initramfs-abrootfs-hook}/files/postinst               | 2 +-
 .../initramfs-abrootfs-hook_0.1.bb                        | 8 ++++----
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename recipes-support/initramfs-config/files/secure-boot-debian-local-patch => recipes-initramfs/initramfs-abrootfs-hook/files/debian-local-patch (100%)
 rename {recipes-support/initramfs-config => recipes-initramfs/initramfs-abrootfs-hook}/files/initramfs.image_uuid.hook (100%)
 rename {recipes-support/initramfs-config => recipes-initramfs/initramfs-abrootfs-hook}/files/initramfs.lsblk.hook (100%)
 rename {recipes-support/initramfs-config => recipes-initramfs/initramfs-abrootfs-hook}/files/postinst (73%)
 rename recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb => recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb (74%)

diff --git a/recipes-support/initramfs-config/files/secure-boot-debian-local-patch b/recipes-initramfs/initramfs-abrootfs-hook/files/debian-local-patch
similarity index 100%
rename from recipes-support/initramfs-config/files/secure-boot-debian-local-patch
rename to recipes-initramfs/initramfs-abrootfs-hook/files/debian-local-patch
diff --git a/recipes-support/initramfs-config/files/initramfs.image_uuid.hook b/recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.image_uuid.hook
similarity index 100%
rename from recipes-support/initramfs-config/files/initramfs.image_uuid.hook
rename to recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.image_uuid.hook
diff --git a/recipes-support/initramfs-config/files/initramfs.lsblk.hook b/recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.lsblk.hook
similarity index 100%
rename from recipes-support/initramfs-config/files/initramfs.lsblk.hook
rename to recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.lsblk.hook
diff --git a/recipes-support/initramfs-config/files/postinst b/recipes-initramfs/initramfs-abrootfs-hook/files/postinst
similarity index 73%
rename from recipes-support/initramfs-config/files/postinst
rename to recipes-initramfs/initramfs-abrootfs-hook/files/postinst
index 2d4256d..e065524 100644
--- a/recipes-support/initramfs-config/files/postinst
+++ b/recipes-initramfs/initramfs-abrootfs-hook/files/postinst
@@ -1,6 +1,6 @@
 #!/bin/sh
 
 # patch local script
-patch -s -p0 /usr/share/initramfs-tools/scripts/local /usr/share/secureboot/secure-boot-debian-local.patch
+patch -s -p0 /usr/share/initramfs-tools/scripts/local /usr/share/initramfs-abrootfs-hook/debian-local.patch
 
 update-initramfs -v -u
diff --git a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
similarity index 74%
rename from recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
rename to recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
index 4b257fa..9c1776a 100644
--- a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
+++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
@@ -16,13 +16,13 @@ DEBIAN_DEPENDS += ", busybox, patch"
 SRC_URI += "file://postinst \
             file://initramfs.lsblk.hook \
             file://initramfs.image_uuid.hook \
-            file://secure-boot-debian-local-patch"
+            file://debian-local-patch"
 
 do_install() {
-    # add patch for local to /usr/share/secure boot
-    TARGET=${D}/usr/share/secureboot
+    # add patch for local to /usr/share/initramfs-abrootfs-hook
+    TARGET=${D}/usr/share/initramfs-abrootfs-hook
     install -m 0755 -d ${TARGET}
-    install -m 0644 ${WORKDIR}/secure-boot-debian-local-patch ${TARGET}/secure-boot-debian-local.patch
+    install -m 0644 ${WORKDIR}/debian-local-patch ${TARGET}/debian-local.patch
 
     # add hooks for secure boot
     HOOKS=${D}/etc/initramfs-tools/hooks
-- 
2.34.1


