Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDB6C4167E
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 16:48:28 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web09.13319.1664902101900182118
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 09:48:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=KZEW9JLa;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-20221004164822214635d23f0d4b8498-epqcfc@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20221004164822214635d23f0d4b8498
        for <cip-dev@lists.cip-project.org>;
        Tue, 04 Oct 2022 18:48:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/p1dnJrLXK1DI3YQ/0jze4pNUnCuOqZr+U55aj1g6is=;
 b=KZEW9JLaGnxd/FsaDhiNZ3a7dmQswkbPgj4ef76tf0JuQwTyMsPpYi6o8E3fMWQYnw4b9i
 ZsGWtuU+iRdQ3yVQnRoP8bPTGZsQe60MOirxqNR/Ruz+Yl+rkE95Zy9ZozUn2I9PzoXqhdPq
 +7C042+5B2YSs9K7RkaTDvLIArE68=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 12/12] start-qemu: Add support for RISC-V
Date: Tue,  4 Oct 2022 18:48:18 +0200
Message-Id: 
 <698957d5f6c859a353620325fc53a8415370105f.1664902098.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1664902098.git.jan.kiszka@siemens.com>
References: <cover.1664902098.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 16:48:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9629

From: Jan Kiszka <jan.kiszka@siemens.com>

Basically like ARM/ARM64. We just need to list the second console via
virtio explicitly as the system will not pick it up automatically.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index c8d4f47c..68c0414a 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -34,7 +34,9 @@ if [ -n "${QEMU_PATH}" ]; then
 fi
 
 if [ -z "${DISTRO_RELEASE}" ]; then
-	if grep -s -q "DEBIAN_BULLSEYE: true" .config.yaml; then
+	if grep -s -q "DEBIAN_SID_PORTS: true" .config.yaml; then
+		DISTRO_RELEASE="sid-ports"
+	elif grep -s -q "DEBIAN_BULLSEYE: true" .config.yaml; then
 		DISTRO_RELEASE="bullseye"
 	else
 		DISTRO_RELEASE="buster"
@@ -100,6 +102,20 @@ case "${arch}" in
 		KERNEL_CMDLINE=" \
 			root=/dev/vda rw"
 		;;
+	rv64|riscv64)
+		QEMU_ARCH=riscv64
+		QEMU=qemu-system-riscv64
+		QEMU_EXTRA_ARGS=" \
+			-cpu rv64 \
+			-smp 4 \
+			-machine virt \
+			-device virtio-serial-device \
+			-device virtconsole,chardev=con -chardev vc,id=con \
+			-device virtio-blk-device,drive=disk \
+			-device virtio-net-device,netdev=net"
+		KERNEL_CMDLINE=" \
+			console=hvc1 console=ttyS0 root=/dev/vda rw"
+		;;
 	""|--help)
 		usage
 		;;
-- 
2.35.3


