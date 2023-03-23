Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888B1C6FD1C
	for <webhook@archiver.kernel.org>; Thu, 23 Mar 2023 13:43:40 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.72964.1679579014161790171
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Mar 2023 06:43:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Kld57ADh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20230323134331fbd0bf9b900f431d36-5kfjh5@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230323134331fbd0bf9b900f431d36
        for <cip-dev@lists.cip-project.org>;
        Thu, 23 Mar 2023 14:43:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=OHn/cZADEtpo/nXOMZtSHpMI1Va33XpHv8PG3S09G70=;
 b=Kld57ADh5SQpopb4x8HFZ/EFyY/hrsU4ka+q/kcQLe7bxu/SUJBPiXkiJbIiuVJbLVDFli
 tl2O5HEbQpfNRSY8P6gdYjTkhNGijLWyJiKuNpbZyhW7sDFmUtm4wYW0WMOD2HqgJOpyuHTK
 3dopn/ujFRBySaZrPIa9+AVXANuvo=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 3/3] start-qemu: Add TPM support also for arm and arm64
Date: Thu, 23 Mar 2023 14:43:30 +0100
Message-Id: <719f6896dd7034cd0d1eabee4002eec7151b6624.1679579010.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1679579010.git.jan.kiszka@siemens.com>
References: <cover.1679579010.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Mar 2023 13:43:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11099

From: Jan Kiszka <jan.kiszka@siemens.com>

Just requires to use a different device model than on x86.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 9dce0183..88104742 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -156,10 +156,16 @@ if [ "$TPM2_ENCRYPTION" = "true" ] && [ -x /usr/bin/swtpm ]; then
 	if swtpm socket -d --tpmstate dir="${SWTPM_DIR}" \
 			 --ctrl type=unixio,path=/tmp/qemu-swtpm.sock \
 			 --tpm2; then
+		TPM_DEVICE=tpm-tis-device
+		case "${arch}" in
+			x86|x86_64|amd64)
+				TPM_DEVICE=tpm-tis
+				;;
+		esac
 		QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
 			 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock \
 			 -tpmdev emulator,id=tpm0,chardev=chrtpm \
-			 -device tpm-tis,tpmdev=tpm0"
+			 -device ${TPM_DEVICE},tpmdev=tpm0"
 	fi
 fi
 
-- 
2.35.3


