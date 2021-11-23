Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40700C43219
	for <webhook@archiver.kernel.org>; Tue, 23 Nov 2021 14:57:53 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web09.12287.1637679471205781441
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Nov 2021 06:57:51 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1ANEvnrs015802
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 23 Nov 2021 15:57:49 +0100
Received: from md2dvrtc.fritz.box ([167.87.35.152])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ANEvlcw005894;
	Tue, 23 Nov 2021 15:57:49 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        christian.storm@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v3 3/9] linux-cip-common: Add options
 necessary for dm-verity
Date: Tue, 23 Nov 2021 15:57:41 +0100
Message-Id: <20211123145747.101549-4-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123145747.101549-1-Quirin.Gylstorff@siemens.com>
References: <20211123145747.101549-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Nov 2021 14:57:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6970

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

CIP Kernel Config does not contain support for dm-verity
squashfs. Overlay_FS support is added for etc-overlay.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/files/verity.cfg     | 5 +++++
 recipes-kernel/linux/linux-cip-common.inc | 4 ++++
 2 files changed, 9 insertions(+)
 create mode 100644 recipes-kernel/linux/files/verity.cfg

diff --git a/recipes-kernel/linux/files/verity.cfg b/recipes-kernel/linux/files/verity.cfg
new file mode 100644
index 0000000..35d8208
--- /dev/null
+++ b/recipes-kernel/linux/files/verity.cfg
@@ -0,0 +1,5 @@
+CONFIG_BLK_DEV_DM=y
+CONFIG_DM_VERITY=y
+CONFIG_DM_CRYPT=y
+CONFIG_SQUASHFS=y
+CONFIG_OVERLAY_FS=y
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 1afec88..bbbf812 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -28,3 +28,7 @@ SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
 SRCREV_cip-kernel-config ?= "cd5d43e99f4d5f20707d7ac1e721bb22d4c9e16e"
 
 S = "${WORKDIR}/linux-cip-v${PV}"
+
+SECURE_BOOT_KERNEL ?= "0"
+
+SRC_URI += "${@'file://verity.cfg' if d.getVar('SECURE_BOOT_KERNEL') == '1' else ''}"
-- 
2.30.2


