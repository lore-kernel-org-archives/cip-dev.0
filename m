Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4507EC4332F
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 14:31:36 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web12.6861.1637764294978170103
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 06:31:35 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AOEVXTm017735
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 15:31:33 +0100
Received: from md2dvrtc.fritz.box ([139.22.38.174])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOEVVLS022964;
	Wed, 24 Nov 2021 15:31:32 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [PATCH v2 3/3] start-qemu.sh: Simplify qemu call
Date: Wed, 24 Nov 2021 15:31:31 +0100
Message-Id: <20211124143131.939349-4-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124143131.939349-1-Quirin.Gylstorff@siemens.com>
References: <20211124143131.939349-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 14:31:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7002

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Move qemu call out of if clause to avoid code duplications and
use the same behavior for secure boot and non secure boot images.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 start-qemu.sh | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 94c3611..a92e9f4 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -123,18 +123,16 @@ if [ -n "${SECURE_BOOT}" ]; then
 		BOOT_FILES="-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
 			-drive if=pflash,format=raw,file=${ovmf_vars} \
 			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw"
-		${QEMU_PATH}${QEMU} \
-			-m 1G -serial mon:stdio -netdev user,id=net \
-			${BOOT_FILES} ${QEMU_EXTRA_ARGS} "$@"
 else
 		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
 
 		KERNEL_FILE=$(ls ${IMAGE_PREFIX}-vmlinu* | tail -1)
 		INITRD_FILE=$(ls ${IMAGE_PREFIX}-initrd.img* | tail -1)
 
-		${QEMU_PATH}${QEMU} \
-			-m 1G -serial mon:stdio -netdev user,id=net \
-			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
+		BOOT_FILES="-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
 			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
-			-initrd ${INITRD_FILE} ${QEMU_EXTRA_ARGS} "$@"
+			-initrd ${INITRD_FILE}"
 fi
+${QEMU_PATH}${QEMU} \
+			-m 1G -serial mon:stdio -netdev user,id=net \
+			${BOOT_FILES} ${QEMU_EXTRA_ARGS} "$@"
-- 
2.30.2


