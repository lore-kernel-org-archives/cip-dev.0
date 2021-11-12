Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692CAC433EF
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 11:50:23 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web09.14720.1636717821491513940
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 03:50:22 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1ACBoJO6004116
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 12:50:19 +0100
Received: from md2dvrtc.fritz.box ([167.87.35.150])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACBoHAj023845;
	Fri, 12 Nov 2021 12:50:18 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 3/8] linux-cip-common: Add options
 necessary for dm-verity
Date: Fri, 12 Nov 2021 12:50:12 +0100
Message-Id: <20211112115017.401779-5-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
References: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 11:50:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6883

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

CIP Kernel Config does not contain support for dm-verity
squashfs. Overlay_FS support is added for etc-overlay.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/files/verity.cfg     | 5 +++++
 recipes-kernel/linux/linux-cip-common.inc | 6 ++++++
 2 files changed, 11 insertions(+)
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
index 1afec88..0792371 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -28,3 +28,9 @@ SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
 SRCREV_cip-kernel-config ?= "cd5d43e99f4d5f20707d7ac1e721bb22d4c9e16e"
 
 S = "${WORKDIR}/linux-cip-v${PV}"
+
+SRC_URI += "file://verity.cfg"
+
+do_prepare_build_prepend() {
+    cat ${WORKDIR}/verity.cfg >> ${WORKDIR}/${KERNEL_DEFCONFIG}
+}
-- 
2.30.2


