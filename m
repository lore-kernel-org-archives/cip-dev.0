Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67454D767C3
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 10:29:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14156.1766140186509550508
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 02:29:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5BJATiqI3036588; Fri, 19 Dec 2025 19:29:44 +0900
X-Iguazu-Qid: 2yAakGMokhTRWwLSxE
X-Iguazu-QSIG: v=2; s=0; t=1766140184; q=2yAakGMokhTRWwLSxE; m=gAYT6Mn9QmALQOYDnQG/4t61HVj5kP3YZljavzx84Nk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dXkLJ0hjBz1xnc; Fri, 19 Dec 2025 19:29:43 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v1] start-qemu.sh: Check FTPM_STMM instead of TPM2_DEVICE before setting RPMB options for arm64
Date: Fri, 19 Dec 2025 05:44:03 -0500
X-TSB-HOP2: ON
Message-Id: <20251219104403.191807-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Dec 2025 10:29:42.0481 (UTC) FILETIME=[633F5410:01DC70D2]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 10:29:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21165

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Current script checks for the absence of TPM2_DEVICE to set RPMB options
for QEMU arm64. TPM2_DEVICE may not be set for a SWUPDATE only boot as well and
the script looks for the RPMB image even if FTPM_STMM is not set.

Instead, let's check if FTPM_STMM is set.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 start-qemu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 0eb306a..7ccbefe 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -124,7 +124,7 @@ case "${arch}" in
 			-device virtio-serial-device \
 			-device virtconsole,chardev=con -chardev vc,id=con \
 			-device virtio-net-device,netdev=net"
-		if [ -z "${TPM2_DEVICE}" ]; then
+		if grep -s -q "FTPM_STMM: true" .config.yaml; then
 			QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
 				-machine virt,secure=on \
 				-device sdhci-pci -device emmc,drive=disk,rpmb-partition-size=2097152 \
-- 
2.39.5



