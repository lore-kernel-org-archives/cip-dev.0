Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08494C83029
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 18:15:42 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.47808.1751307333212927381
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 11:15:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=Xwstfszn;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1330684-20250630181528eba722bcadfdd2a130-2ao5xk@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250630181528eba722bcadfdd2a130
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jun 2025 20:15:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=WkSRBnfvcJJTCy9QBesPitZHbnSmScxMXkq5T1wMl/0=;
 b=XwstfsznzsyxJ+HQDMle/gzsvjLxsUk+xihKRPr5V/PqyYevIpY6dw/cCyulOsM0JVOdRf
 Ki7ai2a5waPaKBWtxXo+eLq+l9nWF9Wq+BfsK0rab6qb3NQHJ3w7JfDNan3N9PE0zPAk4wDh
 B0bilVuUqxAzVYhQJ+kGWdGoyZz6HunQrWvGPD7aSYk6uZA54kbBYeIgSe06S6KusUDdX4+8
 XRGQX+k58WlNwBLV9DthcOkcJo86oQfH8kCvLOqBlQ93uk6T5TRwyskzGg5NVcWJUgbEfzL8
 R5tMNyKneS4LZlPo5drD7F07RWFbhUgU2UjLeee+ny6bLI+CQ+ZLZr5A==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	felix.moessbauer@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][RFC 6/7] wks: Partial revert of 1eb0748a to populate /var partition
Date: Mon, 30 Jun 2025 20:15:15 +0200
Message-Id: <20250630181516.1718712-7-alexander.heinisch@siemens.com>
In-Reply-To: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
References: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 18:15:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19264

From: Alexander Heinisch <alexander.heinisch@siemens.com>

For this patch series we rely on a link to /var/mutable/etc/machine-id
While it makes sense to have an empty /var to detect potential
update failures, I have to think about how to fix this in case of
data relying on specific content on /var like the "uninitialized"
in machine-id (prefilled as a ROOTFS_POSTPROCESS_COMMAND)

Options (non-exhaustive) may be:

1. just populate /var partition
2. special treatment in initramfs
   (create and prefill /var/mutable/etc/machine-id if not exists)

Since this series is RFC, I wanted to hear comments about the
whole strategy of having machine-id on /var before digging too
deep into this specific.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 wic/x86-uefi-efibootguard.wks.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
index 380e828..c4a8df5 100644
--- a/wic/x86-uefi-efibootguard.wks.in
+++ b/wic/x86-uefi-efibootguard.wks.in
@@ -9,6 +9,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "
-- 
2.39.5


