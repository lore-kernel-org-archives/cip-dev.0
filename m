Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32FCC43217
	for <webhook@archiver.kernel.org>; Thu,  5 May 2022 16:43:38 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web12.13765.1651769015105679621
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 May 2022 09:43:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=lTwOeNbX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-294854-2022050516433231b3cec025bb2ccd15-scuyfj@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2022050516433231b3cec025bb2ccd15
        for <cip-dev@lists.cip-project.org>;
        Thu, 05 May 2022 18:43:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=G9aKQFx8ntImR9N6X5/xxkPPrbkwco2j7xI9zrOZtR8=;
 b=lTwOeNbXxE+eFb1QqHW978RXSLyHihlVfcWKE/Mz0byPZiCufLWuueZd/+m+eA5fm4lfg2
 IIb3aSNKGZ2dinyXoaSXTI0Zj2j0zTOvQ2CG1tzeyquzp/okbBcdP96rzJVwKodPW/H5F5vF
 NuLodA9KrWn6xyRKGbCoEzDzzAe6s=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v2 05/13] linux-cip: Update cip-kernel-config
 for QEMU and ipc227e
Date: Thu,  5 May 2022 18:43:21 +0200
Message-Id: 
 <22c861c4d823261c7b37637d1cd9d8578ea0ae98.1651769009.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651769009.git.jan.kiszka@siemens.com>
References: <cover.1651769009.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 May 2022 16:43:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8258

From: Jan Kiszka <jan.kiszka@siemens.com>

Needed for iTCO under -rt kernels, swupdate support on arm64 and xattr
for squashfs in swupudate scenarios.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 238e5b0..0e36bd5 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
 
 SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
 
-SRCREV_cip-kernel-config ?= "0150b63d0e74d64cc0d5baa9b9440cc148abad8b"
+SRCREV_cip-kernel-config ?= "a8d04df6595344091eee2b242c3a0f5e108f966c"
 
 S = "${WORKDIR}/linux-cip-v${PV}"
-- 
2.34.1


