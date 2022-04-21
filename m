Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D43C47086
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:06 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web09.20364.1650541967556402956
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 04:52:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=G4MooJ/4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-294854-2022042111524480f1dd6a182fa76869-tne6in@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2022042111524480f1dd6a182fa76869
        for <cip-dev@lists.cip-project.org>;
        Thu, 21 Apr 2022 13:52:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nPBmrPzVMyTr6boRCSntnu80dM+yMWmD/XIp2eLUwn0=;
 b=G4MooJ/4k6beSkByiYqVQ18/4MJy1f/RSbHBhZJvJZrVmdT8MKilw7jb+6NUCnsap7Kemp
 TMc9sS/9HozjdRfYNN+DCJtw6nW+5NS5V5UIjOpzse2iDoOQ4SMOLA4yq/r/HhlqZlHj21/0
 zJRoUJfdmdn1U1dTyQVI0U0JZ9XUE=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 1/3] wic: Align kernel command line of
 qemu-amd64-efibootguard*
Date: Thu, 21 Apr 2022 13:52:41 +0200
Message-Id: 
 <1ba65d6e7025cd1d6ed872d4279707d5fe792084.1650541963.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1650541963.git.jan.kiszka@siemens.com>
References: <cover.1650541963.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8165

From: Jan Kiszka <jan.kiszka@siemens.com>

"rw" is meaningless and misleading for the read-only rootfs we have.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index 54f7143..affa299 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -12,4 +12,4 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
 part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G
 
-bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait rw earlyprintk"
+bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"
-- 
2.34.1


