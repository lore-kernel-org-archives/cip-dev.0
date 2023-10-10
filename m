Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C23CD68FB
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 08:03:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.86103.1696925001874644718
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 01:03:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 39A83J8D2897960; Tue, 10 Oct 2023 17:03:20 +0900
X-Iguazu-Qid: 2yAbIh4tarBshZ7TOc
X-Iguazu-QSIG: v=2; s=0; t=1696924999; q=2yAbIh4tarBshZ7TOc; m=Sir5Gp5TPZaaUTdbx9q2OXH0LRqNWAa5xQz+fd+iyzA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 39A83IoB2077692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 10 Oct 2023 17:03:18 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH v2] wic: Rename wic/simatic-ipc227e.wks to wic/x86_64-generic.wks
Date: Tue, 10 Oct 2023 17:03:05 +0900
X-TSB-HOP2: ON
Message-Id: <20231010080305.3762206-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 08:03:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13343

Currently wic/simatic-ipc227e.wks has generic settings for x86_64. It is
also available for other x86_64 reference HWs.
Therefore, change this to wic/x86_64-generic.wks as the generic file name.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
v2: Merge patch:'simatic-ipc227e: conf: Add WKS_FILE as x86_64-generic.wks'

---
 conf/machine/simatic-ipc227e.conf               | 1 +
 wic/{simatic-ipc227e.wks => x86_64-generic.wks} | 0
 2 files changed, 1 insertion(+)
 rename wic/{simatic-ipc227e.wks => x86_64-generic.wks} (100%)

diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
index a624fcd..8bb3e80 100644
--- a/conf/machine/simatic-ipc227e.conf
+++ b/conf/machine/simatic-ipc227e.conf
@@ -9,6 +9,7 @@
 DISTRO_ARCH = "amd64"
 
 IMAGE_FSTYPES ?= "wic"
+WKS_FILE ?= "x86_64-generic.wks"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
diff --git a/wic/simatic-ipc227e.wks b/wic/x86_64-generic.wks
similarity index 100%
rename from wic/simatic-ipc227e.wks
rename to wic/x86_64-generic.wks
-- 
2.42.0



