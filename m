Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E64C433FE
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 14:22:34 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.6571.1639750952650902090
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 06:22:33 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1BHEMTNL026702
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 15:22:30 +0100
Received: from md2dvrtc.fritz.box ([139.22.39.215])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1BHEMT11017301;
	Fri, 17 Dec 2021 15:22:29 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        srinuvasan.a@siemens.com
Subject: [cip-dev][isar-cip-core][RFC PATCH] kas/opt/ebg-secure-boot-*: Make
 Backports for OVMF version depended
Date: Fri, 17 Dec 2021 15:22:29 +0100
Message-Id: <20211217142229.1211986-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 14:22:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7181

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

For Debian Buster we need to backport a new version of the OVMF package
with contains the necessary option for secureboot with qemu.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/ebg-secure-boot-base.yml     | 6 ++++++
 kas/opt/ebg-secure-boot-snakeoil.yml | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kas/opt/ebg-secure-boot-base.yml b/kas/opt/ebg-secure-boot-base.yml
index 8f769b6..5a3d751 100644
--- a/kas/opt/ebg-secure-boot-base.yml
+++ b/kas/opt/ebg-secure-boot-base.yml
@@ -19,3 +19,9 @@ local_conf_header:
     IMAGE_INSTALL += "initramfs-abrootfs-secureboot"
     SWU_DESCRIPTION = "secureboot"
     SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG = "secureboot/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
+
+  ovmf: |
+    # snakeoil certs are only part of backports, for Debian 11 and later the are not necessary
+    OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
+    DISTRO_APT_SOURCES_append_buster = " conf/distro/debian-buster-backports.list"
+    DISTRO_APT_PREFERENCES_append_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 807b0d7..9a3ff94 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -32,7 +32,3 @@ local_conf_header:
     IMAGER_BUILD_DEPS += "ebg-secure-boot-snakeoil ovmf-binaries"
     IMAGER_INSTALL += "ebg-secure-boot-snakeoil"
 
-  ovmf: |
-    # snakeoil certs are only part of backports
-    DISTRO_APT_SOURCES_append = " conf/distro/debian-buster-backports.list"
-    DISTRO_APT_PREFERENCES_append = " conf/distro/preferences.ovmf-snakeoil.conf"
-- 
2.34.1


