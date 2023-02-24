Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4A5C7EE2E
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 16:28:41 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.22283.1677256117994463321
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Feb 2023 08:28:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=inPP3FyK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202302241628355e5d31bd3016bf9d91-gtcuvg@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202302241628355e5d31bd3016bf9d91
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Feb 2023 17:28:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ymyEsNn12C7PdtQ0I6+QF4YJZdrY77TkelbzuByNVM8=;
 b=inPP3FyKQg0g6Fjk5dmRP7OUnyQi38pLl9xl4V9w30YLd+7nlri1ncV5dnfF8yUFpm9nLr
 7PsAHHxHRQvAhbCd2XJSaSTDTNbsGrj/FYwOovgdohZsjy+tM42BrYWCEf/T4RXYV3sirsyP
 qBzBrBHhJscubzoRU1ayo2W3lV0z4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 4/8] start-qemu.sh: Create a tpm2 device
Date: Fri, 24 Feb 2023 17:28:28 +0100
Message-Id: <20230224162832.327030-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
References: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 16:28:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10820

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows testing the tpm2 encryption with qemu.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 start-qemu.sh | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index dd16aed..c06d21e 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -28,6 +28,9 @@ if grep -s -q "IMAGE_SECURE_BOOT: true" .config.yaml; then
 elif grep -s -q "IMAGE_SWUPDATE: true" .config.yaml; then
 	SWUPDATE_BOOT="true"
 fi
+if grep -s -q "IMAGE_TPM2_ENCRYPTION: true" .config.yaml; then
+    TPM2_ENCRYPTION="true"
+fi
 
 if [ -n "${QEMU_PATH}" ]; then
 	QEMU_PATH="${QEMU_PATH}/"
@@ -139,7 +142,21 @@ QEMU_COMMON_OPTIONS=" \
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
+					 		-chardev socket,id=chrtpm,path=${swtpm_dir}/sock \
+					 		-tpmdev emulator,id=tpm0,chardev=chrtpm \
+					 		-device tpm-tis,tpmdev=tpm0"
+	fi
+fi
 
 if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 	case "${arch}" in
@@ -154,14 +171,14 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
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
@@ -170,7 +187,7 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 			${QEMU_PATH}${QEMU} \
 				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 				-bios ${u_boot_bin} \
-				${QEMU_COMMON_OPTIONS} "$@"
+				${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
 			;;
 		*)
 			echo "Unsupported architecture: ${arch}"
@@ -187,5 +204,5 @@ else
 			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
 			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
 			-initrd ${INITRD_FILE} \
-			${QEMU_COMMON_OPTIONS} "$@"
+			${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
 fi
-- 
2.39.1


