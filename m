Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD388C76186
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 08:53:29 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.8813.1678352005576604057
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Mar 2023 00:53:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=X7Su+TPG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20230309085323ab0b3cf62ba6761a17-clvzw2@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230309085323ab0b3cf62ba6761a17
        for <cip-dev@lists.cip-project.org>;
        Thu, 09 Mar 2023 09:53:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=iUl3uG4wAcbWEo35ImpMpdX/5oMFCFFhe4h+yFXYhJ4=;
 b=X7Su+TPGd3+rDk/A13T/mHuZ34uKIu4QCQjKyQ6Ip7Z38jymvZsVKx1VHs50oJj/23OVaZ
 0kzwjlbZZ+yVEbsQrjcEeTSLOjqxn1UwG9a3OqUYnJ8eATkiBXwi2o/Ccj1OecO33lnNN8To
 n0NGEZRgjFjLe+KfgfYG0hQzgI5/A=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 2/6] start-qemu.sh: Create a tpm2 device
Date: Thu,  9 Mar 2023 09:53:17 +0100
Message-Id: <20230309085321.17167-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230309085321.17167-1-Quirin.Gylstorff@siemens.com>
References: <20230309085321.17167-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Mar 2023 08:53:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10959

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows testing the partition encryption with qemu.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 start-qemu.sh | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index fcfbc5b..7436636 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -28,6 +28,9 @@ if grep -s -q "IMAGE_SECURE_BOOT: true" .config.yaml; then
 elif grep -s -q "IMAGE_SWUPDATE: true" .config.yaml; then
 	SWUPDATE_BOOT="true"
 fi
+if grep -s -q "IMAGE_TPM2_ENCRYPTION: true" .config.yaml; then
+	TPM2_ENCRYPTION="true"
+fi
 
 if [ -n "${QEMU_PATH}" ]; then
 	QEMU_PATH="${QEMU_PATH}/"
@@ -143,7 +146,21 @@ QEMU_COMMON_OPTIONS=" \
 	-m 1G \
 	-serial mon:stdio \
 	-netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
-	${QEMU_EXTRA_ARGS}"
+	"
+
+if [ "$TPM2_ENCRYPTION" = "true" ] && [ -x /usr/bin/swtpm ]; then
+	swtpm_dir="/tmp/qemu-swtpm"
+	mkdir -p "${swtpm_dir}"
+	rm "${swtpm_dir}"/*
+	if swtpm socket -d --tpmstate dir="${swtpm_dir}" \
+			 --ctrl type=unixio,path="${swtpm_dir}"/sock \
+			 --tpm2; then
+		QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
+			 -chardev socket,id=chrtpm,path=${swtpm_dir}/sock \
+			 -tpmdev emulator,id=tpm0,chardev=chrtpm \
+			 -device tpm-tis,tpmdev=tpm0"
+	fi
+fi
 
 if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 	case "${arch}" in
@@ -158,14 +175,14 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
 					-drive if=pflash,format=raw,file=${ovmf_vars} \
 					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
-					${QEMU_COMMON_OPTIONS} "$@"
+					${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
 			else
 				ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.fd}
 
 				${QEMU_PATH}${QEMU} \
 					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
-					${QEMU_COMMON_OPTIONS} "$@"
+					${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
 			fi
 			;;
 		arm64|aarch64|arm|armhf)
@@ -174,7 +191,7 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 			${QEMU_PATH}${QEMU} \
 				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 				-bios ${u_boot_bin} \
-				${QEMU_COMMON_OPTIONS} "$@"
+				${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
 			;;
 		rv64|riscv64)
 			opensbi_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARCH}/fw_payload.bin}
@@ -199,5 +216,5 @@ else
 			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
 			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
 			-initrd ${INITRD_FILE} \
-			${QEMU_COMMON_OPTIONS} "$@"
+			${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
 fi
-- 
2.39.2


