Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640BBCAC582
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 09:52:39 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.35377.1756979555205251647
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Sep 2025 02:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=kh2/WJ72;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20250904095233b3685150b1000207bc-gq_5pu@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250904095233b3685150b1000207bc
        for <cip-dev@lists.cip-project.org>;
        Thu, 04 Sep 2025 11:52:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hlVdyd4OIdKlspI+Rx376VLZcJdgxlZskYKfWjmAzDM=;
 b=kh2/WJ721wWZAEW61kj6ZDCJg3jxK89Y5SCrXWCqJ/D7tohETqkbt6AHOgZH+n9LwIYtRh
 /cSbmg85mH4BSpHU+KIcMxmZT3eUFfvBmuZ6pMl9nkbRkopkgDptVxqexyytPO6MUcsIBEri
 c4aXC7+30KnWMv2EP8hdug9aBm0DHqwA2p8Hi/UtXV4n8asRD9YqC+WmCUBe8jeyk0ZMK8Ch
 UYCEjEMHz9jNt9Y90l6yIVv+pdDRxmwhkLaLtFbsZMbyHVq5rx9dPnXIjxjTqEf6fVDCKqXz
 JV+wZ8GrMRibBqQ7CSrw5iVUdWyU2khWrRvgCclHLMsvF/hObIaCCILw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v5 6/7] Add factory-reset option to ebg-swu
Date: Thu,  4 Sep 2025 11:39:29 +0200
Message-ID: <20250904095231.2039819-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
References: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 09:52:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20009

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


