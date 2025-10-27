Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A975CCF9F7
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:02 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.26596.1761549713275982022
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=MuG49sTf;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20251027072151ab6365d0d2000207b9-7tknrd@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251027072151ab6365d0d2000207b9
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=k6OWcBCHqXBnl4y/csKiVZ5JAywEz8MmZb7oUzIzNZM=;
 b=MuG49sTfYZea73HRCJ1bLgPKzO+gpUk+Okv41DI1O9QAi6NEhbCkASkX5spQt1bluwPLXT
 WIdkjRk60Kz9CCoFq+rIqgirgNO98fPHwarpFBriIYQUJt8AdEGTrRRYhJbKRPumw5JZmMPY
 gHMNUTMYie31aks5PV6/DWiUKylSpiHG0EpajcHT1dc4CzYKbqdBoaml+MdzWr1MznR0LJyT
 omyIeA13rKp/4+tzBWX2xYfZ3xxBD+ECD6dvToaN98JnecbBbpbcx7Iu25Y/XyEVWrZ2sG6P
 y35vznOMNCpn84LPS2YZvAm+LTK+peKVl5kT6fWm8NFvUz5tes5M0kTw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 17/19] start-qemu: Factor out -drive parameter in UEFI boot mode
Date: Mon, 27 Oct 2025 08:21:46 +0100
Message-ID: <78eac6db7c03b877688d65d3b8173ea32c49fef9.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20231

From: Jan Kiszka <jan.kiszka@siemens.com>

No need to define this identically multiple times.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 745c7f56..d1154f54 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -188,6 +188,10 @@ QEMU_COMMON_OPTIONS=" \
 	"
 
 if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
+	QEMU_COMMON_OPTIONS=" \
+		-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
+		${QEMU_COMMON_OPTIONS} \
+		"
 	case "${arch}" in
 		x86|x86_64|amd64)
 			if [ -n "${SECURE_BOOT}" ]; then
@@ -199,13 +203,11 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 					-global isa-fdc.driveA= \
 					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
 					-drive if=pflash,format=raw,file=${ovmf_vars} \
-					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 					${QEMU_COMMON_OPTIONS} "$@"
 			else
 				ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.fd}
 
 				${QEMU_PATH}${QEMU} \
-					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
 					${QEMU_COMMON_OPTIONS} "$@"
 			fi
@@ -214,7 +216,6 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 			u_boot_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARCH}/firmware.bin}
 
 			${QEMU_PATH}${QEMU} \
-				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 				-bios ${u_boot_bin} \
 				${QEMU_COMMON_OPTIONS} "$@"
 			;;
@@ -222,7 +223,6 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 			opensbi_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARCH}/fw_payload.bin}
 
 			${QEMU_PATH}${QEMU} \
-				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 				-bios ${opensbi_bin} \
 				${QEMU_COMMON_OPTIONS} "$@"
 			;;
-- 
2.51.0


