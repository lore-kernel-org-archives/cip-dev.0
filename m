Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B86C636F4
	for <webhook@archiver.kernel.org>; Mon, 25 Apr 2022 19:26:14 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web08.28336.1650887389129579320
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Apr 2022 04:49:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Oc3Fg5E3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-294854-20220425114946abd56f9afbd48bc7f8-oprf91@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20220425114946abd56f9afbd48bc7f8
        for <cip-dev@lists.cip-project.org>;
        Mon, 25 Apr 2022 13:49:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nPBmrPzVMyTr6boRCSntnu80dM+yMWmD/XIp2eLUwn0=;
 b=Oc3Fg5E37bIPWFcy2cQnJsoHUlto//9IpW+X1NA6JZ1Dh7GFzHEfkTrvNV4LqNjZE1ONK0
 XSHa3VGcSFOHgAYI66Yv7hINfhy/Uzfxy8xnVgfNoXxLWr98t5E0Dv6CHHCcv63wcH73lw77
 KN+3yOzuDV81LsJsid1+mAcVEjxdc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v3 1/7] wic: Align kernel command line of
 qemu-amd64-efibootguard*
Date: Mon, 25 Apr 2022 13:49:38 +0200
Message-Id: 
 <1ba65d6e7025cd1d6ed872d4279707d5fe792084.1650887383.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1650887383.git.jan.kiszka@siemens.com>
References: <cover.1650887383.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Apr 2022 19:26:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8195

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


