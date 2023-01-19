Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D657DC00A5A
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 11:59:50 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.43602.1674129581135757134
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jan 2023 03:59:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=QSmMP0ld;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20230119115937ab0e4fdb6c12b65365-bwv2mo@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230119115937ab0e4fdb6c12b65365
        for <cip-dev@lists.cip-project.org>;
        Thu, 19 Jan 2023 12:59:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=/EJDFTBas1pt79ZG3RB3WR/LNvc+K5tXYsPpZCgAPr0=;
 b=QSmMP0ld+zk6Eb16k5R3uYZy6xYPCLzGNg9b6xSUnb8DF3eUtYl3GeR3/R/zoHA+IzutdN
 LuoYmFo0W/8bpzcBqzsdxZVOAc7nQT5YlG2urbt8ug2p8qSL/0VCak8C/QYEXiVoqVjTcOZe
 WW7XkX7S0iZYpFokxh/rifnuGe1mo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] fixup! only copy "A" version of rootfs part for ab-rootfs
Date: Thu, 19 Jan 2023 12:59:36 +0100
Message-Id: <20230119115936.528466-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 11:59:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10436

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes a typo introduced in 231ccb71878e8b2a2fd64b31f4b522c155930147.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 wic/x86-efibootguard.wks.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
index b4a320e..e48ba01 100644
--- a/wic/x86-efibootguard.wks.in
+++ b/wic/x86-efibootguard.wks.in
@@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
 part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home1 --align 1024  --size 1G
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
 part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G
 part /crypt --label crypt-data --align 1024 --fstype=ext4 --size 2G
 
-- 
2.39.0


