Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3A4C77B75
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 14:07:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.22860.1684246052175353520
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 May 2023 07:07:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.156, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 34GE7Td5023138; Tue, 16 May 2023 23:07:30 +0900
X-Iguazu-Qid: 2wHHaIQrAXaYByp4RV
X-Iguazu-QSIG: v=2; s=0; t=1684246049; q=2wHHaIQrAXaYByp4RV; m=0EUZTuihiplkFeu9yn7VDjTU2hVAdNU1w4l3B7uEeXM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1110) id 34GE7SBF019367
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 May 2023 23:07:29 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com
Subject: [cip-kernel-config] 5.10.y-cip/arm : Add support for access control lists.
Date: Tue, 16 May 2023 19:37:24 +0530
X-TSB-HOP2: ON
Message-Id: <20230516140724.8995-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 May 2023 14:07:27.0054 (UTC) FILETIME=[BEBBF6E0:01D987FF]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 14:07:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11469

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

This config is required for acl package to work
which is used for IEC-62443-4-2 evaluation.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 5.10.y-cip/arm/qemu_arm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/5.10.y-cip/arm/qemu_arm_defconfig b/5.10.y-cip/arm/qemu_arm_defconfig
index 58ca273..b8f4e88 100644
--- a/5.10.y-cip/arm/qemu_arm_defconfig
+++ b/5.10.y-cip/arm/qemu_arm_defconfig
@@ -149,6 +149,7 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
-- 
2.20.1



