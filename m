Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B75FC433EF
	for <webhook@archiver.kernel.org>; Fri,  4 Mar 2022 08:04:16 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web09.4816.1646381055661026968
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Mar 2022 00:04:15 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400";
   d="scan'208";a="72732992"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 04 Mar 2022 00:04:14 -0800
IronPort-SDR: 
 FCI2Pti3X/ARKyrHwm/TGJSe2QjtXIcTQqqwO7Co8w2gMtfLU5nQCeu9BMoUXQqpVgOKPJLrXa
 AH/UaEpkHoXPTAILazy0Mr7IOOjTZubMHbH4U0yyY2LOMfDqHCH4PHRosjwDBryO5n+yy5MU2I
 yhT1vduKwfLJuar3KyZBDaDWpWMLqTjdwzqfisNSjvK9d+U4G7I8guKhUOXUuipi9SJiICJGN1
 W+AcQOJvRxHRV6QbN2HDF2SCGX2uSOEtw/dJXAd6EMGEtRzUoo/8zqt3O9QIRT02/SRMdlepJ+
 DA8=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [cip-dev][PATCH v2] start-qemu.sh: Remove BOOT_FILES variable and
 call qemu directly in secure,swupdate and normal path
Date: Fri, 4 Mar 2022 13:33:49 +0530
Message-ID: <20220304080349.4186067-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b2fe71e9-c323-8dde-d9b0-d1d2a503d4d8@siemens.com>
References: <b2fe71e9-c323-8dde-d9b0-d1d2a503d4d8@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Mar 2022 08:04:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7658

From: Srinuvasan A <srinuvasan_a@mentor.com>

Broke the normal boot part.
Fixed them.

-append takes arguments inside double quotes(""). If we escape
and pass the " along with the value the final command would form
like what we would expect.

qemu-system-x86_64 .... -append " root=/dev/sda console=ttyS0"

But when the shell parses it, due to how whitespace splitting works
for arguments passed via a variable, it parses the first quote(")
as argument 1 and root=dev/sda as argument 2 and messing up the
command.
It should ideally treat the whole " root=/dev/sda console=ttyS0" as
a single argument.

Hence Maintaining argument splitting is complex. A simpler one for here is to
avoid BOOT_FILES and unrole the actual qemu call with its different
kernels into the secure, swupdate and normal path.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 start-qemu.sh | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index a7e0588..4105d4e 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -114,6 +114,11 @@ fi
 
 shift 1
 
+QEMU_COMMON_OPTIONS=" \
+	-m 1G \
+	-serial mon:stdio \
+	-netdev user,id=net"
+
 if [ -n "${SECURE_BOOT}" ]; then
 		ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secboot.fd}
 		ovmf_vars=${OVMF_VARS:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_VARS_4M.snakeoil.fd}
@@ -121,22 +126,24 @@ if [ -n "${SECURE_BOOT}" ]; then
 			-global ICH9-LPC.disable_s3=1 \
 			-global isa-fdc.driveA= "
 
-		BOOT_FILES="-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
+		${QEMU_PATH}${QEMU} \
+			-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
 			-drive if=pflash,format=raw,file=${ovmf_vars} \
-			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw"
+			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw ${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
+
 elif [ -n "${SWUPDATE_BOOT}" ]; then
-		BOOT_FILES="-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
-			-bios OVMF.fd "
+		${QEMU_PATH}${QEMU} \
+			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
+			-bios OVMF.fd ${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
+
 else
 		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
 
 		KERNEL_FILE=$(ls ${IMAGE_PREFIX}-vmlinu* | tail -1)
 		INITRD_FILE=$(ls ${IMAGE_PREFIX}-initrd.img* | tail -1)
 
-		BOOT_FILES="-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
+		${QEMU_PATH}${QEMU} \
+			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
 			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
-			-initrd ${INITRD_FILE}"
+			-initrd ${INITRD_FILE} ${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
 fi
-${QEMU_PATH}${QEMU} \
-			-m 1G -serial mon:stdio -netdev user,id=net \
-			${BOOT_FILES} ${QEMU_EXTRA_ARGS} "$@"
-- 
2.25.1


