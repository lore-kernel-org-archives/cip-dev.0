Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF80C64EC4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 13:12:16 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.21965.1677847762584999702
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 04:49:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=K48Iu61G;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-72506-202303031249202b7e3f1298d20bb40d-widovr@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202303031249202b7e3f1298d20bb40d
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 Mar 2023 13:49:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DPmMC5dYh79dCdshKO/OSLLmF0Jd7hQtRXufqX/YqEU=;
 b=K48Iu61GvSa6vGlVGUrs5w7SrP+41SH2/UVYlHTMw6g9hPsKpPOGa1DOyEJjBwCOat7FmE
 jHLVYnQUMAUJLfAAwsNZ9dORltfe6kTAOae64hLjNz/VXs/BKI4vXpW+aUqODK7hXRzRA6lR
 nG5PSkDjYXRgaYA5Ffi70XVnpedQM=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v4 8/8] start-qemu: add support for swupdate on RISC-V
Date: Fri,  3 Mar 2023 12:48:20 +0000
Message-Id: <20230303124820.2209954-9-felix.moessbauer@siemens.com>
In-Reply-To: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
References: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 13:12:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10900

This patch adds support to run swupdate images for RISC-V64 on qemu. As
firmware, we use OpenSBI with u-boot payload in s-mode.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 start-qemu.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/start-qemu.sh b/start-qemu.sh
index cccc51e..fcfbc5b 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -176,6 +176,14 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 				-bios ${u_boot_bin} \
 				${QEMU_COMMON_OPTIONS} "$@"
 			;;
+		rv64|riscv64)
+			opensbi_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARCH}/fw_payload.bin}
+
+			${QEMU_PATH}${QEMU} \
+				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
+				-bios ${opensbi_bin} \
+				${QEMU_COMMON_OPTIONS} "$@"
+			;;
 		*)
 			echo "Unsupported architecture: ${arch}"
 			exit 1
-- 
2.34.1


