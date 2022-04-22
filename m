Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC90C38A2C
	for <webhook@archiver.kernel.org>; Fri, 22 Apr 2022 16:52:00 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web08.5728.1650613666601168311
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Apr 2022 00:47:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Ljr/oTW7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-294854-202204220747438d481dbb66b8a65f86-bncd1_@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202204220747438d481dbb66b8a65f86
        for <cip-dev@lists.cip-project.org>;
        Fri, 22 Apr 2022 09:47:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=H8kEbZ78u/f+yJBc1dE3noMKDB6FhfPt1bKe9k9DbdM=;
 b=Ljr/oTW7v45oNgODzDhlen8h64TH87dYkCz8o/tYAIUt2mMWC7jzmpEs99+YbEikeOuWWh
 Sk2QrmQ0Czqb4M5AP1pX0fHJcM4U4oM/rfn8ebbs42OYgPigR5NvQSx8CxSSWWLBGsvqrJCG
 pGdvKAkAAFE492v5HkvhBTLj0AWAM=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v2 6/6] secureboot: Prevent getting shell on
 panic
Date: Fri, 22 Apr 2022 09:47:38 +0200
Message-Id: 
 <4eaa5df2b217c0afa9e21c1f7adb4f189f54e4fc.1650613658.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1650613658.git.jan.kiszka@siemens.com>
References: <cover.1650613658.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Apr 2022 16:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8181

From: Jan Kiszka <jan.kiszka@siemens.com>

On panic, initramfs-tools opens up a shell unless panic=X is set on the
kernel command line. Fix that because such a shell could break the chain
of trust.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index affa299..4a0e987 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -12,4 +12,4 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
 part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G
 
-bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"
+bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk panic=5"
-- 
2.34.1


