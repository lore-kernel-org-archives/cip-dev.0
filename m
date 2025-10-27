Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C11CCF9ED
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:01 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.26597.1761549713601864168
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=JyK1wcry;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-202510270721514ecbd0283d0002071f-uukcla@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202510270721514ecbd0283d0002071f
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=25mLtYF7tlURDE1U9jceGAsovzmZZf/TYPzxpc/DOSg=;
 b=JyK1wcryZAj+2bII1MR8Y06x2KBvJnD4+V3yGF4FFVJNnDJjmMhQWIEt0z5oyDF6JfjEtE
 g4ANto071XyeKe2oN41X5QqAE+jXzo6H7Ymz1hMBdupQJjGAkCK2lRmro6v+sI9n2Wdo8Wp3
 9BgI9hajIGrOL8o93KkHyoybbs1Zc46InGBlR+BZR2+kBHo8yaa37NIGmcsmuy0N2NDl1qmW
 IIoEDy8UjPyJAyEaZi/BTIeerw7cwoF4CHBKeQRiC4819R3d1BzD2wgaNUOJzJA2Ng50VrS3
 4zray3bY52i3mo+nARrWqNgPNxw0rpESuvcqCQtD+My5ZzDKJTUTU1Tw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 18/19] start-qemu: Add support for qemu-arm64 fTPM/StMM mode
Date: Mon, 27 Oct 2025 08:21:47 +0100
Message-ID: <41f535581bbabc8627a495387f029b68403a4987.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20238

From: Jan Kiszka <jan.kiszka@siemens.com>

This means we no longer provide a virtual discrete TPM. Instead, we need
to switch to a PCI-attached eMMC with a 2 MB RPMB partition.

OP-TEE is using a secondary UART for output, so create one.

Currently requires a downstream QEMU version until [1] is merged.

[1] https://patchwork.kernel.org/project/qemu-devel/list/?series=1012864

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index d1154f54..2426c986 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -31,9 +31,6 @@ if grep -s -q "IMAGE_SECURE_BOOT: true" .config.yaml; then
 elif grep -s -q "IMAGE_SWUPDATE: true" .config.yaml; then
 	SWUPDATE_BOOT="true"
 fi
-if grep -s -q "IMAGE_DATA_ENCRYPTION: true" .config.yaml; then
-	TPM2_ENCRYPTION="true"
-fi
 
 if [ -n "${QEMU_PATH}" ]; then
 	QEMU_PATH="${QEMU_PATH}/"
@@ -77,6 +74,20 @@ else
 	fi
 fi
 
+if grep -s -q "IMAGE_DATA_ENCRYPTION: true" .config.yaml && \
+   ! grep -s -q "FTPM_STMM: true" .config.yaml; then
+	case "${arch}" in
+		x86|x86_64|amd64)
+			TPM2_DEVICE="tpm-tis"
+			;;
+		arm|armhf|arm64|aarch64)
+			TPM2_DEVICE="tpm-tis-device"
+			;;
+	esac
+fi
+
+IMAGE_EXT="wic"
+
 case "${arch}" in
 	x86|x86_64|amd64)
 		QEMU_ARCH=amd64
@@ -104,11 +115,20 @@ case "${arch}" in
 		QEMU_EXTRA_ARGS=" \
 			-cpu cortex-a57 \
 			-smp 4 \
-			-machine virt \
 			-device virtio-serial-device \
 			-device virtconsole,chardev=con -chardev vc,id=con \
-			-device virtio-blk-device,drive=disk \
 			-device virtio-net-device,netdev=net"
+		if [ -z "${TPM2_DEVICE}" ]; then
+			QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
+				-machine virt,secure=on \
+				-device sdhci-pci -device emmc,drive=disk,rpmb-partition-size=2097152 \
+				-serial vc"
+			IMAGE_EXT="qemu-emmc"
+		else
+			QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
+				-machine virt \
+				-device virtio-blk-device,drive=disk"
+		fi
 		KERNEL_CMDLINE=" \
 			root=/dev/vda rw"
 		;;
@@ -161,18 +181,12 @@ if [ -z "${DISPLAY}" ]; then
 	esac
 fi
 
-if [ "$TPM2_ENCRYPTION" = "true" ] && [ -x /usr/bin/swtpm ]; then
+if [ -n "$TPM2_DEVICE" ] && [ -x /usr/bin/swtpm ]; then
 	SWTPM_DIR="${IMAGE_PREFIX}.swtpm"
 	mkdir -p "${SWTPM_DIR}"
 	if swtpm socket -d --tpmstate dir="${SWTPM_DIR}" \
-			 --ctrl type=unixio,path=/tmp/qemu-swtpm.sock \
-			 --tpm2; then
-		TPM_DEVICE=tpm-tis-device
-		case "${arch}" in
-			x86|x86_64|amd64)
-				TPM_DEVICE=tpm-tis
-				;;
-		esac
+			--ctrl type=unixio,path=/tmp/qemu-swtpm.sock \
+			--tpm2; then
 		QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
 			-chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock \
 			-tpmdev emulator,id=tpm0,chardev=chrtpm \
@@ -189,7 +203,7 @@ QEMU_COMMON_OPTIONS=" \
 
 if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 	QEMU_COMMON_OPTIONS=" \
-		-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
+		-drive file=${IMAGE_PREFIX}.${IMAGE_EXT},discard=unmap,if=none,id=disk,format=raw \
 		${QEMU_COMMON_OPTIONS} \
 		"
 	case "${arch}" in
@@ -213,10 +227,10 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 			fi
 			;;
 		arm64|aarch64|arm|armhf)
-			u_boot_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARCH}/firmware.bin}
+			firmware_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARCH}/firmware.bin}
 
 			${QEMU_PATH}${QEMU} \
-				-bios ${u_boot_bin} \
+				-bios ${firmware_bin} \
 				${QEMU_COMMON_OPTIONS} "$@"
 			;;
 		rv64|riscv64)
-- 
2.51.0


