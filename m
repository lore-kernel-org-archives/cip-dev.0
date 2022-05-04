Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADCFC4167B
	for <webhook@archiver.kernel.org>; Wed,  4 May 2022 19:46:09 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web12.2022.1651693566103008307
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 May 2022 12:46:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=HMgGcobO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-2022050419460361ecea6113f5d87df0-013nqa@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2022050419460361ecea6113f5d87df0
        for <cip-dev@lists.cip-project.org>;
        Wed, 04 May 2022 21:46:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=G9aKQFx8ntImR9N6X5/xxkPPrbkwco2j7xI9zrOZtR8=;
 b=HMgGcobOooGyCofzVFospb1jXuNAnyl/3MO/36JUoR8BGKQUtzBsEW/fi/f5YuVckvhEap
 PkKGGNIMZSjS/WoqNAMncd9eZ7FztDH1d6y5Y49I4WwT86HbDO9OxrAbQ1wejpSxWCzr2vFJ
 JSRmRnnGljUnS16gFeFaRNzmFBsFI=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 05/12] linux-cip: Update cip-kernel-config for
 QEMU and ipc227e
Date: Wed,  4 May 2022 21:45:53 +0200
Message-Id: 
 <22c861c4d823261c7b37637d1cd9d8578ea0ae98.1651693560.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651693560.git.jan.kiszka@siemens.com>
References: <cover.1651693560.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 May 2022 19:46:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8244

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


