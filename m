Return-Path: <benedikt.niedermayr@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455B6108B8EA
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 10:10:27 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9377.1774001425551475518
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Mar 2026 03:10:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=benedikt.niedermayr@siemens.com header.s=fm1 header.b=Q7W5+HZP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1323861-2026032010102265c2d56439000207b8-uzpmw0@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026032010102265c2d56439000207b8
        for <cip-dev@lists.cip-project.org>;
        Fri, 20 Mar 2026 11:10:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=benedikt.niedermayr@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=h1IIubFH+XktdFvatXiKdyQ+hKz8z6Oiojb1LHG0R2I=;
 b=Q7W5+HZPi74gAlZdIPBPXiDtLBgXsEVtF7IMj9Y1D4OXdUJG177hH4kG6rKL/WvTfCwldj
 TwLSVTgQR+RMfghfAid1AKqSYDBNnqSMZyYX8JKopieaoRuMEVHtavs71vvqurqNwl3xGbpr
 Ik5imOlFL4BOoqskoiq7bXBQaxttx1ZBe3nyPZF+TldG42Q8boROAtf40NSHYjhCxLf4de+F
 nRq+rIDCVBO0ZgSoJDCxuRwuA5IJuSa8gsdxB+Md+olLqHpB6ZQ+qWtaW24T2sv6LvLB+qoO
 f+SIysMwj441+DLH1CDYEOS4u7JcLfyA4Q+6iRX4K7nG2h8iux+xcIDg==;
From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH] start-qemu: allow more variable injections
Date: Fri, 20 Mar 2026 11:10:18 +0100
Message-ID: <20260320101020.2534001-1-benedikt.niedermayr@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1323861:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2026 10:10:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22516

This allows to inject specific variables into the script so a local kas
menu run isn't mandatory anymore and thus it could be reused in
different environments by adjusting related environment variables only.

Currently the script parses the .config.yaml which is only available
after running kas menu locally. In cases the isar-cip-core is included into
custom layers where it mostly happens that the kas menu of the
including custom layer is called rather than kas menu of isar-cip-core,
(in some cases the including custom layer doesn't use kas menu at all)
one might still want to reuse the start-qemu.sh script.

This patch specifically allows to inject the BASE_DIR and FTPM_STMM variables
via environment variables from now on.

Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
---
 start-qemu.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 7ccbefeb5f47..5a0924257b37 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -80,8 +80,12 @@ else
 	fi
 fi
 
+if grep -s -q "FTPM_STMM: true" .config.yaml; then
+	FTPM_STMM="true"
+fi
+
 if grep -s -q "IMAGE_DATA_ENCRYPTION: true" .config.yaml && \
-   ! grep -s -q "FTPM_STMM: true" .config.yaml; then
+   [ -z "${FTPM_STMM}" ] ; then
 	case "${arch}" in
 		x86|x86_64|amd64)
 			TPM2_DEVICE="tpm-tis"
@@ -124,7 +128,7 @@ case "${arch}" in
 			-device virtio-serial-device \
 			-device virtconsole,chardev=con -chardev vc,id=con \
 			-device virtio-net-device,netdev=net"
-		if grep -s -q "FTPM_STMM: true" .config.yaml; then
+		if [ -n "${FTPM_STMM}" ]; then
 			QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
 				-machine virt,secure=on \
 				-device sdhci-pci -device emmc,drive=disk,rpmb-partition-size=2097152 \
@@ -175,7 +179,8 @@ case "${arch}" in
 		;;
 esac
 
-BASE_DIR=$(readlink -f $(dirname $0))
+BASE_DIR_DEFAULT=$(readlink -f $(dirname $0))
+BASE_DIR=${BASE_DIR:-$BASE_DIR_DEFAULT}
 IMAGE_PREFIX="${BASE_DIR}/build/tmp/deploy/images/qemu-${QEMU_ARCH}/${TARGET_IMAGE}-cip-core-${DISTRO_RELEASE}-qemu-${QEMU_ARCH}${TEST_IMAGE}"
 
 if [ -z "${DISPLAY}" ]; then
-- 
2.43.0


