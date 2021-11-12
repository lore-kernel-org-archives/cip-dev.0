Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8572EC433F5
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 16:38:24 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.18286.1636735102979758790
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 08:38:23 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1ACGcLan021380
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 17:38:21 +0100
Received: from md2dvrtc.fritz.box ([167.87.35.150])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACGcKWW023679;
	Fri, 12 Nov 2021 17:38:21 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.kiszka@siemens.com
Subject: [cip-dev][cip-kernel-config][PATCH 2/2]
  x86/siemens_ipc227e_defconfig: Add options for read-only rootfs
Date: Fri, 12 Nov 2021 17:38:20 +0100
Message-Id: <20211112163820.1701453-3-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112163820.1701453-1-Quirin.Gylstorff@siemens.com>
References: <20211112163820.1701453-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 16:38:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6896

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add the necessary kernel option to support a read only rootfs
with dm-verity and overlay.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 4.19.y-cip/x86/siemens_ipc227e_defconfig | 5 ++++-
 5.10.y-cip/x86/siemens_ipc227e_defconfig | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/4.19.y-cip/x86/siemens_ipc227e_defconfig b/4.19.y-cip/x86/siemens_ipc227e_defconfig
index 3e1d305..0ad5b7a 100644
--- a/4.19.y-cip/x86/siemens_ipc227e_defconfig
+++ b/4.19.y-cip/x86/siemens_ipc227e_defconfig
@@ -378,7 +378,7 @@ CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
-CONFIG_OVERLAY_FS=m
+CONFIG_OVERLAY_FS=y
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_PROC_KCORE=y
@@ -449,3 +449,6 @@ CONFIG_MEMTEST=y
 # CONFIG_X86_VERBOSE_BOOTUP is not set
 CONFIG_EARLY_PRINTK_EFI=y
 CONFIG_OPTIMIZE_INLINING=y
+CONFIG_DM_VERITY=y
+CONFIG_DM_CRYPT=y
+CONFIG_SQUASHFS=y
diff --git a/5.10.y-cip/x86/siemens_ipc227e_defconfig b/5.10.y-cip/x86/siemens_ipc227e_defconfig
index 2ddf145..7f98e4b 100644
--- a/5.10.y-cip/x86/siemens_ipc227e_defconfig
+++ b/5.10.y-cip/x86/siemens_ipc227e_defconfig
@@ -362,7 +362,7 @@ CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
-CONFIG_OVERLAY_FS=m
+CONFIG_OVERLAY_FS=y
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_PROC_KCORE=y
@@ -428,3 +428,6 @@ CONFIG_BLK_DEV_IO_TRACE=y
 # CONFIG_X86_VERBOSE_BOOTUP is not set
 CONFIG_TEST_USER_COPY=m
 CONFIG_MEMTEST=y
+CONFIG_DM_VERITY=y
+CONFIG_DM_CRYPT=y
+CONFIG_SQUASHFS=y
-- 
2.30.2


