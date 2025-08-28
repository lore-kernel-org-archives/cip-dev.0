Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE50CA1000
	for <webhook@archiver.kernel.org>; Thu, 28 Aug 2025 11:07:24 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.18178.1756379236737180405
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Aug 2025 04:07:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=tZFHQ9Ya;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20250828110714632cbdd638000207cc-03vgjt@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250828110714632cbdd638000207cc
        for <cip-dev@lists.cip-project.org>;
        Thu, 28 Aug 2025 13:07:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hlVdyd4OIdKlspI+Rx376VLZcJdgxlZskYKfWjmAzDM=;
 b=tZFHQ9YaFFdu7xn/R+xJlHF7qMAaRFb8n6Oc0pQOeiq9JemHcChUxq6nwbROh5YH3ZJwC6
 B6vnLO6gHhD1vAHwOgMgltmQBy7vMqrl4QAThEFQqhFbDrDZ1hkVoQsQkLFGRKSFt48ySHR7
 P8sw1G9yAPVOZbH2Dk30+XEHLO7F/Wx0d0tTz3785BgBinuDtKo9R0Bzu7yseFJytpNcqyG3
 evk7HiTgiF11znpSmFZTIHV+yyazwM2nStEKSGphLhq2SEN8UYOpqchEq7g2pHzflTZAt590
 IvHQ1Sw2AMf0gBs1VNDt4E2oHrDEAM0JaH6Q7rXlqleXAylYpEY7Ww3g==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 6/7] Add factory-reset option to ebg-swu
Date: Thu, 28 Aug 2025 13:06:53 +0200
Message-ID: <20250828110712.392641-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250828110712.392641-1-Quirin.Gylstorff@siemens.com>
References: <20250828110712.392641-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Aug 2025 11:07:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19982

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

A full disk image is necessary to provide the necessary infrastructure
(bootloader or boot partition) to execute a factory-reset. In isar-cip-core
this is only possible with the efibootguard based images.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/ebg-swu.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 5066040..e68e0b5 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -38,3 +38,7 @@ local_conf_header:
     IMAGE_FSTYPES:remove:qemu-arm64 = "ext4"
     IMAGE_FSTYPES:remove:qemu-arm = "ext4"
     IMAGE_FSTYPES:remove:qemu-riscv64= "ext4"
+  factory-reset: |
+    # factory reset only works with full images, e.g. wic based
+    INITRAMFS_INSTALL += "initramfs-factory-reset-hook"
+    IMAGE_INSTALL += "factory-reset-helper"
-- 
2.50.1


