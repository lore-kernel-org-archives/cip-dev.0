Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F491C433EF
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 16:38:24 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web08.18359.1636735103329557589
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 08:38:24 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1ACGcLRK030185
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 17:38:21 +0100
Received: from md2dvrtc.fritz.box ([167.87.35.150])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACGcKWV023679;
	Fri, 12 Nov 2021 17:38:20 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.kiszka@siemens.com
Subject: [cip-dev][cip-kernel-config][PATCH 1/2] x86/cip_qemu_defconfig: Add
 options for read-only rootfs
Date: Fri, 12 Nov 2021 17:38:19 +0100
Message-Id: <20211112163820.1701453-2-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112163820.1701453-1-Quirin.Gylstorff@siemens.com>
References: <20211112163820.1701453-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 16:38:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6898

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add the necessary kernel option to support a read only rootfs
with dm-verity and overlay.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 4.19.y-cip/x86/cip_qemu_defconfig | 4 ++++
 5.10.y-cip/x86/cip_qemu_defconfig | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/4.19.y-cip/x86/cip_qemu_defconfig b/4.19.y-cip/x86/cip_qemu_defconfig
index 4d29397..521fa52 100644
--- a/4.19.y-cip/x86/cip_qemu_defconfig
+++ b/4.19.y-cip/x86/cip_qemu_defconfig
@@ -302,3 +302,7 @@ CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
 CONFIG_OPTIMIZE_INLINING=y
+CONFIG_DM_VERITY=y
+CONFIG_DM_CRYPT=y
+CONFIG_SQUASHFS=y
+CONFIG_OVERLAY_FS=y
diff --git a/5.10.y-cip/x86/cip_qemu_defconfig b/5.10.y-cip/x86/cip_qemu_defconfig
index 899eab4..42199ca 100644
--- a/5.10.y-cip/x86/cip_qemu_defconfig
+++ b/5.10.y-cip/x86/cip_qemu_defconfig
@@ -286,3 +286,7 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
+CONFIG_DM_VERITY=y
+CONFIG_DM_CRYPT=y
+CONFIG_SQUASHFS=y
+CONFIG_OVERLAY_FS=y
-- 
2.30.2


