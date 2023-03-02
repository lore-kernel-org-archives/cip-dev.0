Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA15C678D4
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 15:30:40 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.18925.1677770901011149565
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 07:28:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=N/HzA0ne;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-72506-20230302152817bc36b2ddf8111d2a91-_6hf6p@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230302152817bc36b2ddf8111d2a91
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Mar 2023 16:28:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=eM9gN3+g+p1B72Elx10b7yBrX/erGHYywBTPJTkOkME=;
 b=N/HzA0neqbbAE/y9KsFufzWUu6dlgqDTNUAVjbXqnzAtL82Vf7Av2FHFIqxVmmY2XfK6Fk
 KVwvnTaOnHNFghsbZ3mKjd4oy/aDvA3KYoguBNC5b0aFKI+NX5TvCAuR6FiOIEu48nFtTKro
 oNZsJcBayCBzGfksGDqbt/WfahhLw=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v3 9/9] start-qemu: add support for swupdate on RISC-V
Date: Thu,  2 Mar 2023 15:26:59 +0000
Message-Id: <20230302152659.2096307-10-felix.moessbauer@siemens.com>
In-Reply-To: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 15:30:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10874

This patch adds support to run swupdate images for RISC-V64 on qemu. As
firmware, we use OpenSBI with u-boot payload in s-mode.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 start-qemu.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/start-qemu.sh b/start-qemu.sh
index dd16aed..c4a8fe9 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -172,6 +172,14 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
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


