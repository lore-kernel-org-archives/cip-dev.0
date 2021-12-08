Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CA6C433F5
	for <webhook@archiver.kernel.org>; Wed,  8 Dec 2021 16:09:40 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.15080.1638979778929199393
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Dec 2021 08:09:39 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1B8G9aYc031057
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 8 Dec 2021 17:09:36 +0100
Received: from md2dvrtc.fritz.box ([167.87.33.37])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1B8G9ZPG024230;
	Wed, 8 Dec 2021 17:09:35 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] start-qemu.sh: Add option to start a
 wic.img
Date: Wed,  8 Dec 2021 17:09:35 +0100
Message-Id: <20211208160935.157897-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Dec 2021 16:09:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7075

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

To test image created for swupdate the resulting wic image needs
to be boot by qemu.

Also fix indentation.

This fixes issue [18]:

[18]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/18

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 start-qemu.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index c700974..4ab3861 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -22,6 +22,8 @@ usage()
 
 if grep -s -q "IMAGE_SECURE_BOOT: true" .config.yaml; then
 	SECURE_BOOT="true"
+elif grep -s -q "IMAGE_SWUPDATE: true" .config.yaml; then
+	SWUPDATE_BOOT="true"
 fi
 
 if [ -n "${QEMU_PATH}" ]; then
@@ -42,7 +44,7 @@ if [ -z "${TARGET_IMAGE}" ];then
 	TARGET_IMAGE="cip-core-image"
 	if grep -s -q "IMAGE_SECURITY: true" .config.yaml; then
 		TARGET_IMAGE="cip-core-image-security"
-    fi
+	fi
 	if [ -n "${SECURE_BOOT}" ]; then
 		TARGET_IMAGE="cip-core-image-read-only"
 	fi
@@ -58,7 +60,7 @@ case "$1" in
 			-machine q35,accel=kvm:tcg \
 			-device virtio-net-pci,netdev=net"
 		if [ -n "${SECURE_BOOT}" ]; then
-            # set bootindex=0 to boot disk instead of EFI-shell
+			# set bootindex=0 to boot disk instead of EFI-shell
 			QEMU_EXTRA_ARGS=" \
 			${QEMU_EXTRA_ARGS} -device ide-hd,drive=disk,bootindex=0"
 		else
@@ -127,6 +129,9 @@ if [ -n "${SECURE_BOOT}" ]; then
 		BOOT_FILES="-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
 			-drive if=pflash,format=raw,file=${ovmf_vars} \
 			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw"
+elif [ -n "${SWUPDATE_BOOT}" ]; then
+		BOOT_FILES="-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
+			-bios OVMF.fd "
 else
 		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
 
-- 
2.30.2


