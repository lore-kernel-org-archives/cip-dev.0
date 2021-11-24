Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51968C43217
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 14:31:36 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.6781.1637764294981170814
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 06:31:35 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AOEVWqn026478
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 15:31:32 +0100
Received: from md2dvrtc.fritz.box ([139.22.38.174])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOEVVLQ022964;
	Wed, 24 Nov 2021 15:31:32 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [PATCH v2 1/3] start-qemu.sh: set bootindex for SECURE_BOOT
Date: Wed, 24 Nov 2021 15:31:29 +0100
Message-Id: <20211124143131.939349-2-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124143131.939349-1-Quirin.Gylstorff@siemens.com>
References: <20211124143131.939349-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 14:31:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7001

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Set the bootindex to avoid booting into the default uefi shell.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 start-qemu.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 3f62257..2c0a751 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -39,8 +39,14 @@ case "$1" in
 			-cpu qemu64 \
 			-smp 4 \
 			-machine q35,accel=kvm:tcg \
-			-device ide-hd,drive=disk \
 			-device virtio-net-pci,netdev=net"
+		if [ -n "${SECURE_BOOT}" ]; then
+			QEMU_EXTRA_ARGS=" \
+			${QEMU_EXTRA_ARGS} -device ide-hd,drive=disk,bootindex=0"
+		else
+			QEMU_EXTRA_ARGS=" \
+			${QEMU_EXTRA_ARGS} -device ide-hd,drive=disk"
+		fi
 		KERNEL_CMDLINE=" \
 			root=/dev/sda"
 		;;
-- 
2.30.2


