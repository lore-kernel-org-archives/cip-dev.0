Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9486DEE7FE1
	for <webhook@archiver.kernel.org>; Fri,  8 Sep 2023 12:12:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.37474.1694175116381989068
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Sep 2023 05:11:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 388CBss22954357; Fri, 8 Sep 2023 21:11:54 +0900
X-Iguazu-Qid: 2yAasULiHY0IIJO6DI
X-Iguazu-QSIG: v=2; s=0; t=1694175114; q=2yAasULiHY0IIJO6DI; m=3DWG3HqW73NGc2OnAi4ikXFVV7JDP5End4aZK4mCvT4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 388CBrUR3197593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 8 Sep 2023 21:11:54 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-kernel-config 1/2] 6.1.y-cip/arm64/qemu_arm64_defconfig: Enable TPM-based LUKS partitions
Date: Fri,  8 Sep 2023 17:41:51 +0530
X-TSB-HOP2: ON
Message-Id: <20230908121152.502670-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Sep 2023 12:11:52.0121 (UTC) FILETIME=[A6B26A90:01D9E24D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Sep 2023 12:12:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13004

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

These configs allow to use LUKS encrypted partitions with
the passphrase stored in TPM2.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 6.1.y-cip/arm64/qemu_arm64_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/6.1.y-cip/arm64/qemu_arm64_defconfig b/6.1.y-cip/arm64/qemu_arm64_defconfig
index 087dd34..04a6614 100644
--- a/6.1.y-cip/arm64/qemu_arm64_defconfig
+++ b/6.1.y-cip/arm64/qemu_arm64_defconfig
@@ -414,3 +414,14 @@ CONFIG_DEBUG_FS=y
 # CONFIG_FTRACE is not set
 CONFIG_TEST_USER_COPY=m
 CONFIG_MEMTEST=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_ARM64_CRYPTO=y
+CONFIG_CRYPTO_SHA256_ARM64=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_DRBG_HMAC=y
+CONFIG_CRYPTO_LIB_SHA256=y
+CONFIG_CRYPTO_XTS=y
+CONFIG_SECURITYFS=y
+CONFIG_TCG_TIS_CORE=y
+CONFIG_TCG_TIS=y
+CONFIG_TCG_TIS_SPI=y
-- 
2.30.2



