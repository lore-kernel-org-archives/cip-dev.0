Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD17C352A8
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-64-227.flowmailer.net (mta-64-227.flowmailer.net
 [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web08.3507.1649834201494836727
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=VsTQYrMv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-202204130716439b756e8fe6add4f6f2-__ufpy@rts-flowmailer.siemens.com)
Received: by mta-64-227.flowmailer.net with ESMTPSA id
 202204130716439b756e8fe6add4f6f2
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zM6/ldiNw4HrtwyAHQUyCoJBTCPpCioGsttEv70Cxdo=;
 b=VsTQYrMvCJ/T230DKCEi6/AMhIzYC67V4duaSbcP83/fbNpQtTwupXSEiTZbecKrXTB57y
 8ENwnT+vvm7i9ID68quM6jniChuOM3z3GEH3B+qehpQLfUKZks15Y2at6H6c/hO6tsx/R2jN
 J3Bz58AhML6x6vPj330koPGDX2mzo=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 17/19] start-qemu.sh: Ensure that iTCO watchdog
 timeout triggers reset
Date: Wed, 13 Apr 2022 09:16:34 +0200
Message-Id: 
 <e016307ecff4852cde69a4c6e9fa17e08e8c9c40.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8064

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows full testing of the SWUpdate feature.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/start-qemu.sh b/start-qemu.sh
index c5cd9fa..fe08ebd 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -53,6 +53,7 @@ case "$1" in
 			-cpu qemu64 \
 			-smp 4 \
 			-machine q35,accel=kvm:tcg \
+			-global ICH9-LPC.noreboot=off \
 			-device virtio-net-pci,netdev=net"
 		if [ -n "${SECURE_BOOT}" ]; then
 			# set bootindex=0 to boot disk instead of EFI-shell
-- 
2.34.1


