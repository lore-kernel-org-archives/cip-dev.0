Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B91EB64D9
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 06:02:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.33630.1688968923103106536
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Jul 2023 23:02:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 36A621a21704231; Mon, 10 Jul 2023 15:02:01 +0900
X-Iguazu-Qid: 2yAbeDFf7vwHCnWgAf
X-Iguazu-QSIG: v=2; s=0; t=1688968920; q=2yAbeDFf7vwHCnWgAf; m=9ZKuZeTU/u8IOqmhFw1MiMy2comoFJitBehbEpDYRaY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 36A620AM220459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Jul 2023 15:02:00 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-kernel-config] 6.1.y-cip/arm/qemu_arm_defconfig: Add support for access control lists
Date: Mon, 10 Jul 2023 11:31:56 +0530
X-TSB-HOP2: ON
Message-Id: <20230710060156.10348-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Jul 2023 06:01:58.0853 (UTC) FILETIME=[09B17750:01D9B2F4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 06:02:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12288

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

This config is required for acl package to work which is
used for IEC-62443-4-2 evaluation.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 6.1.y-cip/arm/qemu_arm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/6.1.y-cip/arm/qemu_arm_defconfig b/6.1.y-cip/arm/qemu_arm_defconfig
index ad11ce6..811978a 100644
--- a/6.1.y-cip/arm/qemu_arm_defconfig
+++ b/6.1.y-cip/arm/qemu_arm_defconfig
@@ -159,6 +159,7 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
-- 
2.20.1



