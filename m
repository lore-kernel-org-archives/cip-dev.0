Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE10C77B7D
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 12:13:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.133])
 by mx.groups.io with SMTP id smtpd.web11.86588.1684152785451179118
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 05:13:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.133, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 34FCD2hr029929; Mon, 15 May 2023 21:13:03 +0900
X-Iguazu-Qid: 2wHHvlq321lH3wcAGe
X-Iguazu-QSIG: v=2; s=0; t=1684152782; q=2wHHvlq321lH3wcAGe; m=yFe/ke7V4ZicG6KDh5WRFZVUPihS25adStNsJvcU1XI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1113) id 34FCD0S7028844
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 May 2023 21:13:02 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com
Subject: [cip-kernel-config] 5.10.y-cip/arm : Add support for access control lists.
Date: Mon, 15 May 2023 17:42:56 +0530
X-TSB-HOP2: ON
Message-Id: <20230515121256.14413-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 May 2023 12:12:59.0474 (UTC) FILETIME=[96ECAB20:01D98726]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 12:13:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11454

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

These configs are required for acl package to work
which is used for IEC-62443-4-2 evaluation.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 5.10.y-cip/arm/qemu_arm_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/5.10.y-cip/arm/qemu_arm_defconfig b/5.10.y-cip/arm/qemu_arm_defconfig
index 58ca273..2992fea 100644
--- a/5.10.y-cip/arm/qemu_arm_defconfig
+++ b/5.10.y-cip/arm/qemu_arm_defconfig
@@ -149,6 +149,8 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
-- 
2.20.1



