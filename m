Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933EFEE7FE3
	for <webhook@archiver.kernel.org>; Fri,  8 Sep 2023 12:12:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.37272.1694175118088599788
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Sep 2023 05:11:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 388CBtQ8669534; Fri, 8 Sep 2023 21:11:55 +0900
X-Iguazu-Qid: 2yAaEO0URXtD2aL2zR
X-Iguazu-QSIG: v=2; s=0; t=1694175115; q=2yAaEO0URXtD2aL2zR; m=uZfio+E+6QkTLpCHFTLFOW/Ofy+TvmDWLDGE7zkCKTA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 388CBso13197607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 8 Sep 2023 21:11:54 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-kernel-config 2/2] 6.1.y-cip/arm/qemu_arm_defconfig: Enable TPM-based LUKS partitions
Date: Fri,  8 Sep 2023 17:41:52 +0530
X-TSB-HOP2: ON
Message-Id: <20230908121152.502670-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230908121152.502670-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20230908121152.502670-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Sep 2023 12:11:52.0200 (UTC) FILETIME=[A6BE7880:01D9E24D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Sep 2023 12:12:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13005

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

These configs allow to use LUKS encrypted partitions with
the passphrase stored in TPM2.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 6.1.y-cip/arm/qemu_arm_defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/6.1.y-cip/arm/qemu_arm_defconfig b/6.1.y-cip/arm/qemu_arm_defconfig
index 811978a..eb8cedc 100644
--- a/6.1.y-cip/arm/qemu_arm_defconfig
+++ b/6.1.y-cip/arm/qemu_arm_defconfig
@@ -186,3 +186,17 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_RCU_TRACE is not set
 CONFIG_FUNCTION_TRACER=y
 CONFIG_DEBUG_USER=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_ARM_CRYPTO=y
+CONFIG_CRYPTO_SHA256_ARM=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_DRBG_MENU=y
+CONFIG_CRYPTO_DRBG_HMAC=y
+CONFIG_CRYPTO_LIB_SHA256=y
+CONFIG_CRYPTO_XTS=y
+CONFIG_CRYPTO_AES=y
+CONFIG_SECURITYFS=y
+CONFIG_TCG_TPM=y
+CONFIG_TCG_TIS_CORE=y
+CONFIG_TCG_TIS=y
+CONFIG_TCG_TIS_SPI=y
-- 
2.30.2



