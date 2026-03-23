Return-Path: <benedikt.niedermayr@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9E1EC01C1
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 10:16:01 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13817.1774260951479171810
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Mar 2026 03:15:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=benedikt.niedermayr@siemens.com header.s=fm1 header.b=O168BtWU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1323861-20260323101548842c4133280002071f-wsprmm@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260323101548842c4133280002071f
        for <cip-dev@lists.cip-project.org>;
        Mon, 23 Mar 2026 11:15:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=benedikt.niedermayr@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=pMV0uVGaFjOaNoI9LBW4pccdsIX9MCOw1P/Uvj/mPsI=;
 b=O168BtWU6KKu2JXEcC2FBrjJoyADH8nQF64G2IxjyBmOIPgZyyjV/7bAEoZTVkNGbcIcKe
 tQUoNBEpKW9dcUpPYagYMg9mT6Jbo4WwMP65J/pOawoksB1wMeF/MtYiRnVEhrvRd/iKAwKr
 X72LR4zk6pMiqgNtTgS5aqU2TGS7qMFxR5zr7FLXghZhE8ZLQF52+IngCRfsVF8+efKRjUTY
 xTRtj/uOdotJfDVuOCyTshJcQ8dtTkToKT+xXCb0LR1rtGpTy8YRBAKSScihl//aszZwylHi
 kflVtkXjnoUVeL8jTR/swHZMJjul7+9ugYRE1gqzqEYGZsWSgzrCWDHQ==;
From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v3 1/1] start-qemu: allow more variable injections
Date: Mon, 23 Mar 2026 11:15:45 +0100
Message-ID: <20260323101546.3273376-2-benedikt.niedermayr@siemens.com>
In-Reply-To: <20260323101546.3273376-1-benedikt.niedermayr@siemens.com>
References: <20260323101546.3273376-1-benedikt.niedermayr@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1323861:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2026 10:16:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22527

This allows to inject more variables into the script so that a local
"kas menu" run isn't mandatory anymore and thus it could be reused in
different environments by adjusting related environment variables only.

Currently the script requires parsing the .config.yaml which is only available
after running "kas menu" locally. In cases the isar-cip-core is included into
custom layers where it mostly happens that the "kas menu" of the
including custom layer is called rather than "kas menu" of isar-cip-core,
(in some cases the including custom layer doesn't use kas menu at all)
one might still want to reuse the start-qemu.sh script.

This patch specifically allows to inject the BASE_DIR, IMAGE_PREFIX, FTPM_STMM
and IMAGE_DATA_ENCRYPTION via environment variables from now on.

Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
---
 start-qemu.sh | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 7ccbefeb5f47..3ec121ed3a93 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -18,11 +18,15 @@ usage()
 	echo "if the built was done via \"kas-container menu\"."
 	echo
 	echo "Environment variables (default to settings in .config.yaml):"
-	echo "  QEMU_PATH         use a locally built QEMU version"
-	echo "  SWUPDATE_BOOT     boot swupdate image"
-	echo "  SECURE_BOOT       start a secure boot environment"
-	echo "  DISTRO_RELEASE    select a specific Debian release"
-	echo "  TARGET_IMAGE      select a specific image type"
+	echo "  QEMU_PATH             use a locally built QEMU version"
+	echo "  SWUPDATE_BOOT         boot swupdate image"
+	echo "  SECURE_BOOT           start a secure boot environment"
+	echo "  DISTRO_RELEASE        select a specific Debian release"
+	echo "  TARGET_IMAGE          select a specific image type"
+	echo "  FTPM_STMM             use fTPM with STMM support"
+	echo "  IMAGE_DATA_ENCRYPTION use data encryption"
+	echo "  BASE_DIR              base directory where the build folder is located"
+	echo "  IMAGE_PREFIX          prefix of the produced image files"
 	exit 1
 }
 
@@ -80,8 +84,15 @@ else
 	fi
 fi
 
-if grep -s -q "IMAGE_DATA_ENCRYPTION: true" .config.yaml && \
-   ! grep -s -q "FTPM_STMM: true" .config.yaml; then
+if grep -s -q "FTPM_STMM: true" .config.yaml; then
+	FTPM_STMM="true"
+fi
+
+if grep -s -q "IMAGE_DATA_ENCRYPTION: true" .config.yaml; then
+	IMAGE_DATA_ENCRYPTION="true"
+fi
+
+if [ -n "${IMAGE_DATA_ENCRYPTION}" ] && [ -z "${FTPM_STMM}" ] ; then
 	case "${arch}" in
 		x86|x86_64|amd64)
 			TPM2_DEVICE="tpm-tis"
@@ -124,7 +135,7 @@ case "${arch}" in
 			-device virtio-serial-device \
 			-device virtconsole,chardev=con -chardev vc,id=con \
 			-device virtio-net-device,netdev=net"
-		if grep -s -q "FTPM_STMM: true" .config.yaml; then
+		if [ -n "${FTPM_STMM}" ]; then
 			QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
 				-machine virt,secure=on \
 				-device sdhci-pci -device emmc,drive=disk,rpmb-partition-size=2097152 \
@@ -175,8 +186,11 @@ case "${arch}" in
 		;;
 esac
 
-BASE_DIR=$(readlink -f $(dirname $0))
-IMAGE_PREFIX="${BASE_DIR}/build/tmp/deploy/images/qemu-${QEMU_ARCH}/${TARGET_IMAGE}-cip-core-${DISTRO_RELEASE}-qemu-${QEMU_ARCH}${TEST_IMAGE}"
+BASE_DIR_DEFAULT="$(readlink -f "$(dirname "$0")")"
+BASE_DIR="${BASE_DIR:-$BASE_DIR_DEFAULT}"
+IMAGE_PREFIX_DEFAULT="${BASE_DIR}/build/tmp/deploy/images/qemu-${QEMU_ARCH}/${TARGET_IMAGE}-cip-core-${DISTRO_RELEASE}-qemu-${QEMU_ARCH}${TEST_IMAGE}"
+IMAGE_PREFIX="${IMAGE_PREFIX:-$IMAGE_PREFIX_DEFAULT}"
+
 
 if [ -z "${DISPLAY}" ]; then
 	QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} -nographic"
-- 
2.43.0


