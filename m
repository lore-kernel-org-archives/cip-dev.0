Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C5AC433F5
	for <webhook@archiver.kernel.org>; Wed,  4 May 2022 19:46:09 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.2075.1651693567778213038
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 May 2022 12:46:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=VRNBDvVJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-294854-20220504194605fff2e700b280273606-_7j7tu@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20220504194605fff2e700b280273606
        for <cip-dev@lists.cip-project.org>;
        Wed, 04 May 2022 21:46:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rG5xDmnDBa7deYwip/ylz/on0rCvU7M57dqk/4nR6Tk=;
 b=VRNBDvVJNvGQN29a1+913fVceytw47KBDwMLekSDP/Okl1rVs0rtOD5yUGS85jw64VGjXn
 NCr7xQV8tUoAFXFwVwhTcWON57URpHN0bYA91zcILNhnLQNdgdc4Sa1PePCaTUcEQUvI3Twf
 XYLBnY2Oyf2DGhxxyzs7M3oAwZHbQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 12/12] start-qemu.sh: Add support for SWUpdate
 and secure boot mode to arm64
Date: Wed,  4 May 2022 21:46:00 +0200
Message-Id: 
 <7091df13d797c9ed013c8d189c9f1d888f384680.1651693560.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651693560.git.jan.kiszka@siemens.com>
References: <cover.1651693560.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 May 2022 19:46:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8251

From: Jan Kiszka <jan.kiszka@siemens.com>

We just need to pick up the newly deployed firmware.bin as -bios,
analogously to the x86's OVMF, and switch to a disk image. A separate
key storage is not yet used, thus there is no difference between normal
and secure mode for arm64 so far.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 67 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index fe08ebd..ad4fca5 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -45,7 +45,10 @@ if [ -z "${TARGET_IMAGE}" ];then
 	fi
 fi
 
-case "$1" in
+arch="$1"
+shift 1
+
+case "${arch}" in
 	x86|x86_64|amd64)
 		DISTRO_ARCH=amd64
 		QEMU=qemu-system-x86_64
@@ -98,7 +101,7 @@ case "$1" in
 		usage
 		;;
 	*)
-		echo "Unsupported architecture: $1"
+		echo "Unsupported architecture: ${arch}"
 		exit 1
 		;;
 esac
@@ -107,40 +110,54 @@ IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${DISTRO_ARCH}/${TARGET
 
 if [ -z "${DISPLAY}" ]; then
 	QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} -nographic"
-	case "$1" in
+	case "${arch}" in
 		x86|x86_64|amd64)
 			KERNEL_CMDLINE="${KERNEL_CMDLINE} console=ttyS0"
 	esac
 fi
 
-shift 1
-
 QEMU_COMMON_OPTIONS=" \
 	-m 1G \
 	-serial mon:stdio \
 	-netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
 	${QEMU_EXTRA_ARGS}"
 
-if [ -n "${SECURE_BOOT}" ]; then
-		ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secboot.fd}
-		ovmf_vars=${OVMF_VARS:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_VARS_4M.snakeoil.fd}
-
-		${QEMU_PATH}${QEMU} \
-			-global ICH9-LPC.disable_s3=1 \
-			-global isa-fdc.driveA= \
-			-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
-			-drive if=pflash,format=raw,file=${ovmf_vars} \
-			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
-			${QEMU_COMMON_OPTIONS} "$@"
-
-elif [ -n "${SWUPDATE_BOOT}" ]; then
-		ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.fd}
-
-		${QEMU_PATH}${QEMU} \
-			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
-			-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
-			${QEMU_COMMON_OPTIONS} "$@"
-
+if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
+	case "${arch}" in
+		x86|x86_64|amd64)
+			if [ -n "${SECURE_BOOT}" ]; then
+				ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secboot.fd}
+				ovmf_vars=${OVMF_VARS:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_VARS_4M.snakeoil.fd}
+
+				${QEMU_PATH}${QEMU} \
+					-global ICH9-LPC.disable_s3=1 \
+					-global isa-fdc.driveA= \
+					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
+					-drive if=pflash,format=raw,file=${ovmf_vars} \
+					-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
+					${QEMU_COMMON_OPTIONS} "$@"
+			else
+				ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.fd}
+
+				${QEMU_PATH}${QEMU} \
+					-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
+					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
+					${QEMU_COMMON_OPTIONS} "$@"
+			fi
+			;;
+		arm64|aarch64)
+			u_boot_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-arm64/firmware.bin}
+
+			${QEMU_PATH}${QEMU} \
+				-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
+				-bios ${u_boot_bin} \
+				${QEMU_COMMON_OPTIONS} "$@"
+			;;
+		*)
+			echo "Unsupported architecture: ${arch}"
+			exit 1
+			;;
+	esac
 else
 		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
 
-- 
2.34.1


